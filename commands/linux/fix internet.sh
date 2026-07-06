# 1. ادخل كـ Root
sudo su

# 2. جهز البارتيشنات (بناءً على صورة GParted بتاعتك)
mount /dev/nvme0n1p1 /mnt
mount /dev/nvme0n1p2 /mnt/boot/efi

# 3. اربط ملفات النظام
mount --bind /dev /mnt/dev
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys

# 4. ادخل للنظام اللي على الهارد
chroot /mnt

# --- (أنت الآن داخل الـ chroot) ---

# 5. امسح ملف النت البايظ
rm -f /etc/resolv.conf

# 6. اعمل ملف نت جديد واكتب فيه DNS جوجل
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# 7. اختبر النت
ping -c 3 fedoraproject.org
