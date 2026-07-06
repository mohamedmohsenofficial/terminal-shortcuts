#!/bin/bash

# =========================================================
# ===    سكريبت إصلاح GRUB الخاص بفيدورا (لجهازك)     ===
# === بناءً على: Root=/dev/nvme0n1p1 | EFI=/dev/nvme0n1p2 ===
# =========================================================

# التأكد من أن السكريبت يعمل بصلاحيات root
if [ "$EUID" -ne 0 ]; then
  echo "!!! خطأ: يجب تشغيل هذا السكريبت بصلاحيات root"
  echo "!!! استخدم الأمر: sudo ./repair.sh"
  exit 1
fi

# --- 1. تعريف البارتشنات (بناءً على جهازك) ---
ROOT_PART="/dev/nvme0n1p1"
EFI_PART="/dev/nvme0n1p2"
MNT_DIR="/mnt/fedora_rescue"

echo "--- بدء عملية الإصلاح ---"

# --- 2. تجهيز بيئة الماونت ---
echo "1. تجهيز نقطة الماونت في: $MNT_DIR"
mkdir -p $MNT_DIR
umount -R $MNT_DIR 2>/dev/null # لضمان أنه غير مستخدم

# --- 3. عمل ماونت للبارتشنات ---
echo "2. عمل ماونت لبارتشن الـ Root ($ROOT_PART)..."
# أنت تستخدم ext4 وليس btrfs
mount $ROOT_PART $MNT_DIR
if [ $? -ne 0 ]; then
    echo "!!! فشل ماونت الـ Root. جارِ الخروج."
    exit 1
fi

echo "3. عمل ماونت لبارتشن الـ EFI ($EFI_PART)..."
mount $EFI_PART $MNT_DIR/boot/efi
if [ $? -ne 0 ]; then
    echo "!!! فشل ماونت الـ EFI. جارِ الخروج."
    umount -R $MNT_DIR
    exit 1
fi

# --- 4. ربط أنظمة اللايف ---
echo "4. ربط أنظمة اللايف ببيئة الـ chroot..."
mount --bind /dev $MNT_DIR/dev
mount --bind /dev/pts $MNT_DIR/dev/pts
mount --bind /proc $MNT_DIR/proc
mount --bind /sys $MNT_DIR/sys

# --- 5. الدخول والإصلاح الفعلي ---
echo "5. الدخول لـ chroot وتنفيذ أوامر الإصلاح..."
chroot $MNT_DIR /bin/bash -c "
    echo '    [داخل الـ chroot]: جاري إعادة تثبيت حزم البوت...'
    dnf reinstall -y shim-* grub2-efi-* grub2-common
    
    echo '    [داخل الـ chroot]: جاري تحديث قائمة GRUB للبحث عن ويندوز...'
    grub2-mkconfig -o /boot/grub2/grub.cfg
    
    echo '    [داخل الـ chroot]: ... اكتمل الإصلاح. جاري الخروج.'
"
echo "6. اكتمل الإصلاح."

# --- 6. التنظيف والخروج ---
echo "7. فصل الأقراص وتنظيف البيئة..."
umount -R $MNT_DIR
rmdir $MNT_DIR

echo "---"
echo "✅ تم كل شيء بنجاح!"

# 1. الأمر اللي كان بيفشل (هيشتغل المرة دي)
dnf reinstall -y grub2-efi-x64 shim-*

# 2. بناء قايمة البوت (عشان يشوف ويندوز)
grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg

# 3. الخروج من الـ chroot
exit

echo "يمكنك الآن عمل ريستارت وإزالة الفلاشة."
echo "---"
