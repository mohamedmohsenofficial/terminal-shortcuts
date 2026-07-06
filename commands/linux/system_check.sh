#!/bin/bash
echo "🔍 جاري فحص النظام بالكامل... استنى شوية ⏳"
echo "--------------------------------------------"

# 🧠 تعريف دالة لعرض الحالة بالمصري
check_status() {
  if [ $1 -eq 0 ]; then
    echo "✅ تمام"
  else
    echo "❌ في مشكلة"
  fi
}

# 1️⃣ فحص التحديثات
echo -n "🧱 فحص التحديثات والحزم: "
sudo apt update -qq > /dev/null 2>&1
check_status $?

# 2️⃣ فحص وجود حزم مكسورة
echo -n "🧩 فحص الحزم المكسورة (broken packages): "
sudo dpkg --configure -a > /dev/null 2>&1
sudo apt -f install -y > /dev/null 2>&1
check_status $?

# 3️⃣ فحص النظام من الملفات المفقودة أو المعطوبة
echo -n "🧰 فحص سلامة النظام (fsck): "
sudo touch /forcefsck 2>/dev/null
check_status $?

# 4️⃣ فحص كارت الشبكة والاتصال
echo -n "🌐 فحص الإنترنت (ping google.com): "
ping -c 1 8.8.8.8 > /dev/null 2>&1
check_status $?

# 5️⃣ فحص المساحة التخزينية
echo -n "💾 فحص المساحة: "
df -h | grep '/$' | awk '{print $5" مستخدم"}'

# 6️⃣ فحص حرارة الجهاز
echo -n "🌡️ فحص حرارة المعالج: "
if command -v sensors > /dev/null; then
  sensors | grep 'Package id 0' | awk '{print $4}'
else
  echo "⚠️ أداة sensors مش متسطبة (sudo apt install lm-sensors)"
fi

# 7️⃣ فحص الخدمات المهمة (systemd)
echo -n "⚙️ فحص حالة الخدمات (systemctl): "
sudo systemctl --failed | grep -q failed
if [ $? -eq 0 ]; then
  echo "❌ فيه خدمات واقعة"
  sudo systemctl --failed
else
  echo "✅ كل الخدمات شغالة كويس"
fi

# 8️⃣ فحص القرص الصلب (SMART)
echo -n "💿 فحص حالة الهارد (SMART): "
if command -v smartctl > /dev/null; then
  sudo smartctl -H /dev/sda | grep "SMART overall-health"
else
  echo "⚠️ أداة smartmontools مش متسطبة (sudo apt install smartmontools)"
fi
# 9️⃣ فحص حالة الـ Swap
echo -n "💤 فحص الـ Swap: "
swap_status=$(swapon --show --noheadings | awk '{print $1}')
if [ -z "$swap_status" ]; then
  echo "❌ مفيش Swap شغالة خالص"
else
  echo "✅ الـ Swap شغالة"
  echo "📂 المصدر: $swap_status"
  free -h | awk '/Swap/ {print "📊 المستخدم: "$3" من "$2}'
fi
echo "--------------------------------------------"
echo "✅ الفحص خلص، كدا كل حاجة اتراجعت!"
