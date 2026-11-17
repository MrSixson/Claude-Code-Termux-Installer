#!/data/data/com.termux/files/usr/bin/bash
# Claude Code 2.1.112 + OpenRouter installer for Termux.
# Set your own OpenRouter key and compatible model ID below before running.

set -e

# ===================== EDIT THESE SETTINGS =====================
OPENROUTER_API_KEY="PASTE_YOUR_OPENROUTER_API_KEY_HERE"
OPENROUTER_MODEL="PASTE_A_SUPPORTED_MODEL_ID_HERE"
# ===============================================================

CLAUDE_VERSION="2.1.112"
BASE_URL="https://openrouter.ai/api"
MAX_OUTPUT_TOKENS="2048"

say() { printf '\n\033[1;36m[Claude-Termux]\033[0m %s\n' "$1"; }
fail() { printf '\n\033[1;31m[ERROR]\033[0m %s\n' "$1" >&2; exit 1; }

[ -n "${PREFIX:-}" ] && [ -d "$PREFIX" ] || fail "این فایل باید داخل Termux اجرا شود."

if [ "$(uname -m)" != "aarch64" ]; then
  say "هشدار: معماری دستگاه aarch64 نیست؛ سازگاری تضمین نمی‌شود."
fi

if [ "$OPENROUTER_API_KEY" = "PASTE_YOUR_OPENROUTER_API_KEY_HERE" ] || [ -z "$OPENROUTER_API_KEY" ]; then
  fail "ابتدا OPENROUTER_API_KEY را در ابتدای فایل با کلید شخصی خودت جایگزین کن."
fi

if [ "$OPENROUTER_MODEL" = "PASTE_A_SUPPORTED_MODEL_ID_HERE" ] || [ -z "$OPENROUTER_MODEL" ]; then
  fail "ابتدا OPENROUTER_MODEL را با شناسه یک مدل سازگار جایگزین کن."
fi

say "به‌روزرسانی مخازن Termux..."
pkg update -y

say "نصب Node.js و Git..."
pkg install -y nodejs git

say "بررسی نسخه‌های Node.js و npm..."
node --version
npm --version

say "نصب Claude Code نسخه ${CLAUDE_VERSION}..."
npm install -g "@anthropic-ai/claude-code@${CLAUDE_VERSION}" --ignore-scripts

CONFIG_FILE="$HOME/.claude-openrouter.sh"
cat > "$CONFIG_FILE" <<EOF
# OpenRouter configuration for Claude Code
export ANTHROPIC_BASE_URL="${BASE_URL}"
export ANTHROPIC_AUTH_TOKEN="${OPENROUTER_API_KEY}"
export ANTHROPIC_API_KEY=""
export ANTHROPIC_MODEL="${OPENROUTER_MODEL}"
export CLAUDE_CODE_MAX_OUTPUT_TOKENS="${MAX_OUTPUT_TOKENS}"
EOF
chmod 600 "$CONFIG_FILE"

touch "$HOME/.bashrc"
SOURCE_LINE='[ -f "$HOME/.claude-openrouter.sh" ] && source "$HOME/.claude-openrouter.sh"'
if ! grep -Fqx "$SOURCE_LINE" "$HOME/.bashrc"; then
  printf '\n%s\n' "$SOURCE_LINE" >> "$HOME/.bashrc"
fi

. "$CONFIG_FILE"

say "بررسی نصب Claude Code..."
claude --version

say "نصب و تنظیمات تمام شد. Claude Code اجرا می‌شود."
exec claude
