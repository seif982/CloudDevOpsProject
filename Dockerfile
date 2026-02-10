# 1. استخدم نسخة خفيفة من بايثون كقاعدة (Base Image)
FROM python:3.9-slim

# 2. حدد مسار العمل جوه الـ Container
WORKDIR /app

# 3. انسخ ملف المتطلبات أولاً (عشان نستفيد من الـ Caching)
COPY requirements.txt .

# 4. طبّق تسطيب المكتبات المطلوبة
RUN pip install --no-cache-dir -r requirements.txt

# 5. انسخ باقي ملفات الكود والمجلدات (static, templates, etc.)
COPY . .

# 6. حدد البورت اللي التطبيق بيسمع عليه (Flask غالباً 5000)
EXPOSE 5000

# 7. أمر تشغيل التطبيق
CMD ["python", "app.py"]
