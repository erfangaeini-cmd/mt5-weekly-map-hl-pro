# mt5-weekly-map-hl-pro
MT5 indicator: previous week &amp; daily H/L map with extensions (±25/50/75/100%), session markers, and US close level + on-chart control panel.
# Weekly Map HL Day Pro (MT5)

## English

### Overview
Weekly Map HL Day Pro is a **MetaTrader 5 indicator** that plots the previous **weekly High/Low**, intermediate levels (Mid, 25%, 75%), and extension levels up to ±100%. It also adds the **previous daily High/Low/Mid**, the **US close level**, and **major trading session markers (Asia, London, New York)**.  
An **on-chart control panel** allows you to toggle features in real time without reloading the indicator.

### Features
- 📌 **Weekly levels**: High, Low, Mid, 25%, 75%.  
- 📌 **Extensions**: ±25%, ±50%, ±75%, ±100% beyond weekly range.  
- 📌 **Daily levels**: Previous day High/Low/Mid.  
- 📌 **US close level**: Approximate US session close price (customizable).  
- 📌 **Session markers**: Vertical lines for Asia, London, New York opens.  
- 📌 **On-chart panel**: Toggle Extensions / Daily Levels / US Close / Sessions.  
- 📌 **Alerts**: Sound, pop-up, and email alerts when price is near a level.

### Installation
1. Copy `src/Weekly_Map_HL_Day_Pro.mq5` to your **MQL5/Indicators/** folder.  
2. Restart MetaTrader 5.  
3. Add the indicator to your chart from the Navigator panel.  

### Inputs
- **Colors**: Fully customizable for each level.  
- **Line style & width**.  
- **Feature toggles**: Extensions, Daily Levels, US Close, Sessions.  

### Known Limitations
- Session times are based on **broker server time** (not DST-adjusted).  
- US close is approximated (default at 23:00 server time).  
- Requires M1 data for accurate US close calculation.  
- Alerts may trigger multiple times without debounce logic.  

### Roadmap
- [ ] Configurable session times & US close time.  
- [ ] Debounced alerts to avoid spam.  
- [ ] Auto-refresh levels on new day/week via timer.  

### Disclaimer
This indicator is provided **for educational and analytical purposes only**.  
It is **NOT financial advice**. Use at your own risk.

---

## فارسی

### معرفی
اندیکاتور **Weekly Map HL Day Pro** برای متاتریدر ۵ طراحی شده تا سطوح **بالا/پایین هفته قبل**، نقاط میانی (Mid, 25%, 75%) و سطوح اکستنشن تا ±100% را رسم کند. همچنین **بالا/پایین/میانگین روز قبل**، **کلوز آمریکا** و **مارکر جلسات معاملاتی (آسیا، لندن، نیویورک)** را نمایش می‌دهد.  
یک **پنل کنترلی روی چارت** نیز وجود دارد که به شما امکان می‌دهد ویژگی‌ها را به‌صورت زنده فعال/غیرفعال کنید.

### قابلیت‌ها
- 📌 سطوح هفتگی: High، Low، Mid، 25%، 75%  
- 📌 اکستنشن‌ها: ±25%، ±50%، ±75%، ±100%  
- 📌 سطوح روزانه: High/Low/Mid روز قبل  
- 📌 کلوز آمریکا (قابل تنظیم)  
- 📌 مارکر سشن‌ها: خطوط عمودی برای آغاز آسیا، لندن، نیویورک  
- 📌 پنل روی چارت برای مدیریت سریع  
- 📌 هشدار (آلارم): صدا، پاپ‌آپ، ایمیل نزدیک به سطوح

### نصب
1. فایل `src/Weekly_Map_HL_Day_Pro.mq5` را در مسیر **MQL5/Indicators/** کپی کنید.  
2. متاتریدر ۵ را ری‌استارت کنید.  
3. اندیکاتور را از بخش Navigator به چارت اضافه کنید.  

### ورودی‌ها
- رنگ‌ها برای هر سطح قابل تنظیم  
- استایل و ضخامت خطوط  
- فعال/غیرفعال‌سازی اکستنشن‌ها، سطوح روزانه، کلوز آمریکا، و سشن‌ها  

### محدودیت‌ها
- ساعت سشن‌ها براساس زمان سرور بروکر است (DST در نظر گرفته نشده).  
- کلوز آمریکا تقریبی است (پیش‌فرض 23:00 زمان سرور).  
- نیاز به دیتای M1 برای محاسبه دقیق کلوز.  
- آلارم‌ها ممکن است چندین بار پشت سر هم تریگر شوند.  

### نقشه راه
- [ ] ساعت‌های قابل تنظیم برای سشن‌ها و کلوز آمریکا  
- [ ] ضداسپم برای هشدارها  
- [ ] آپدیت خودکار سطوح در شروع روز/هفته  

### سلب مسئولیت
این اندیکاتور صرفاً **برای اهداف آموزشی و تحلیلی** ارائه شده است  
و **سیگنال خرید/فروش** محسوب نمی‌شود. مسئولیت استفاده کاملاً بر عهده کاربر است.
