#!/bin/bash

# 1. التثبيت (هيطلب الباسورد مرة واحدة في الأول)
echo "🚀 1. هنبدأ تثبيت الأدوات... لو طلب الباسورد، اكتبه"
sudo dnf install starship eza git curl fzf gnupg2 -y

# نتأكد إن التثبيت نجح
if [ $? -ne 0 ]; then
    echo "❌ حصلت مشكلة وقت التثبيت. وقفنا."
    exit 1
fi

echo "✅ 2. البرامج الأساسية اتثبتت."
echo "🛠️ 3. بنظبط إعدادات التفعيل (Starship, FZF, EZA aliases)..."

# ----------------------------------------------------
# تعريف الإعدادات اللي هتتكتب
# ----------------------------------------------------

# --- اختصارات EZA ---
EZA_ALIASES="
# EZA Aliases (ls -> eza)
alias ls='eza --icons'
alias ll='eza -l --icons'
alias la='eza -la --icons'
alias l='eza -l --icons'
"

# --- تفعيل FZF ---
FZF_BASH_LINE='[ -f /usr/share/fzf/shell.bash ] && source /usr/share/fzf/shell.bash'
FZF_ZSH_LINE='[ -f /usr/share/fzf/shell.zsh ] && source /usr/share/fzf/shell.zsh'

# --- تفعيل Starship ---
STARSHIP_BASH_LINE='eval "$(starship init bash)"'
STARSHIP_ZSH_LINE='eval "$(starship init zsh)"'

# ----------------------------------------------------
# التنفيذ على الملفات
# ----------------------------------------------------

# تعريف أماكن الملفات
BASH_CONFIG="$HOME/.bashrc"
ZSH_CONFIG="$HOME/.zshrc"

# --- نكتب الإعدادات في ملف .bashrc لو موجود ---
if [ -f "$BASH_CONFIG" ]; then
    echo "... بنظبط ملف $BASH_CONFIG"
    
    # Add EZA if not present
    if ! grep -q "# EZA Aliases" "$BASH_CONFIG"; then
        echo "$EZA_ALIASES" >> "$BASH_CONFIG"
    fi
    # Add FZF if not present
    if ! grep -q "fzf/shell.bash" "$BASH_CONFIG"; then
        echo "$FZF_BASH_LINE" >> "$BASH_CONFIG"
    fi
    # Add Starship if not present
    if ! grep -q "starship init bash" "$BASH_CONFIG"; then
        echo "$STARSHIP_BASH_LINE" >> "$BASH_CONFIG"
    fi
fi

# --- نكتب الإعدادات في ملف .zshrc لو موجود ---
if [ -f "$ZSH_CONFIG" ]; then
    echo "... بنظبط ملف $ZSH_CONFIG"
    
    # Add EZA if not present
    if ! grep -q "# EZA Aliases" "$ZSH_CONFIG"; then
        echo "$EZA_ALIASES" >> "$ZSH_CONFIG"
    fi
    # Add FZF if not present
    if ! grep -q "fzf/shell.zsh" "$ZSH_CONFIG"; then
        echo "$FZF_ZSH_LINE" >> "$ZSH_CONFIG"
    fi
    # Add Starship if not present
    if ! grep -q "starship init zsh" "$ZSH_CONFIG"; then
        echo "$STARSHIP_ZSH_LINE" >> "$ZSH_CONFIG"
    fi
fi

echo "🎉 4. كله تمام!"
echo "🚨 مهم جداً: اقفل الـ Terminal ده وافتحه تاني عشان تشوف التغييرات."
