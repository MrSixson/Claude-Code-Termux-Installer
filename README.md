# Claude Code Termux Installer

اسکریپت نصب **Claude Code** روی Android با استفاده از **Termux** و اتصال به **OpenRouter**.

This repository provides an installer for running Claude Code in Termux on Android, configured to use OpenRouter.

## وضعیت و سازگاری | Status

- نسخه نصب‌شده Claude Code: `2.1.112`
- محیط هدف: Termux روی Android
- معماری تست‌شده: `aarch64` (ARM64)
- نیازمندی‌ها: اتصال اینترنت و یک API Key از OpenRouter
- این روش غیررسمی است و از سوی Anthropic یا OpenRouter پشتیبانی رسمی نمی‌شود.

The installer pins Claude Code to version `2.1.112`. Newer releases may depend on native Linux binaries that are not compatible with Android's Bionic environment. Compatibility is not guaranteed on other architectures or future package versions.

## پیش‌نیازها | Requirements

1. نصب نسخه به‌روز Termux از یک منبع معتبر.
2. باز کردن Termux و دسترسی به اینترنت.
3. ساخت API Key در حساب OpenRouter.
4. انتخاب شناسه مدلی که با API سازگار با Anthropic Messages و Claude Code کار کند.

## نصب | Installation

ابتدا مخزن را دریافت کن:

```bash
pkg update -y
pkg install -y git
git clone https://github.com/MrSixson/Claude-Code-Termux-Installer.git
cd Claude-Code-Termux-Installer
```

فایل `claude_termux_installer.sh` را با ویرایشگر دلخواه باز کن. برای نمونه:

```bash
pkg install -y nano
nano claude_termux_installer.sh
```

در ابتدای فایل، این دو مقدار را با اطلاعات حساب خودت جایگزین کن:

```bash
OPENROUTER_API_KEY="YOUR_OWN_OPENROUTER_API_KEY"
OPENROUTER_MODEL="YOUR_SUPPORTED_MODEL_ID"
```

فایل را ذخیره کن و نصب‌کننده را اجرا کن:

```bash
bash claude_termux_installer.sh
```

اسکریپت Node.js و Git را نصب می‌کند، Claude Code نسخه مشخص‌شده را نصب می‌کند، تنظیمات OpenRouter را در فایل خصوصی `~/.claude-openrouter.sh` ذخیره می‌کند و در پایان Claude Code را اجرا می‌کند.

## امنیت کلید API | API Key Security

- کلید واقعی خودت را **هرگز** در GitHub، مخزن عمومی، اسکرین‌شات یا پیام عمومی قرار نده.
- فقط placeholderهای داخل نسخه مخزن را نگه دار؛ کلید را بعد از کلون‌کردن، روی دستگاه خودت وارد کن.
- فایل تنظیمات محلی با مجوز محدود `600` ذخیره می‌شود.
- اگر کلیدت منتشر شد، آن را فوراً از OpenRouter باطل کن و یک کلید جدید بساز.

Never commit a real API key. Configure it locally after cloning this repository.

## نکات مهم | Notes

- این مخزن دسترسی رایگان به مدل‌ها یا اعتبار OpenRouter فراهم نمی‌کند. هزینه و محدودیت‌ها تابع حساب و مدل انتخابی تو هستند.
- خطای HTTP `402` معمولاً به اعتبار ناکافی، سقف هزینه یا محدودیت توکن مربوط است؛ نصب مجدد Termux لزوماً آن را حل نمی‌کند.
- مقدار `CLAUDE_CODE_MAX_OUTPUT_TOKENS` سقف خروجی را تنظیم می‌کند و محدودیت context ورودی مدل را برطرف نمی‌کند.
- همه مدل‌های OpenRouter الزاماً با Claude Code سازگار نیستند. شناسه مدل و پشتیبانی از Anthropic Messages API را پیش از استفاده بررسی کن.
- این اسکریپت تنظیمات فعلی Bash را بارگذاری می‌کند. اگر از shell دیگری استفاده می‌کنی، باید فایل تنظیمات را در startup فایل همان shell بارگذاری کنی.

## عیب‌یابی | Troubleshooting

**فرمان `claude` پیدا نمی‌شود**

Termux را ببند و دوباره باز کن، یا اجرا کن:

```bash
source ~/.bashrc
claude --version
```

**خطای 402 از OpenRouter**

اعتبار حساب، محدودیت هزینه، مدل انتخابی و تعداد توکن‌های درخواست را در پنل OpenRouter بررسی کن.

**مدل پاسخ نمی‌دهد یا خطای API می‌دهد**

شناسه مدل را بررسی کن و مطمئن شو مدل انتخابی با مسیر Anthropic Messages مورد استفاده Claude Code سازگار است.

## مشارکت | Contributions

گزارش مشکل و پیشنهاد بهبود از طریق GitHub Issues و Pull Requests قابل ارسال است.

## مجوز | License

این پروژه تحت مجوز MIT منتشر شده است. برای جزئیات فایل [LICENSE](LICENSE) را ببین.
