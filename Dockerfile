FROM --platform=linux/amd64 python:3.11-slim

ENV DEBIAN_FRONTEND=noninteractive

# تثبيت أدوات النظام و SSH و FFmpeg بدون ملفات إضافية غير ضرورية
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    openssh-server \
    sudo \
    vim \
    net-tools \
    curl \
    wget \
    git \
    tzdata \
    ffmpeg \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# تحديث pip
RUN pip install --no-cache-dir --upgrade pip setuptools wheel

# تثبيت المكتبات (تمت إزالة حزمة Telegram المهجورة المسببة للخطأ)
RUN pip install --no-cache-dir \
    mtranslate \
    google-genai \
    requests \
    g4f \
    mutagen \
    py-tgcalls~=2.2.11 \
    telethon \
    aiosqlite \
    aiocron \
    emoji \
    pytz \
    gtts \
    qrcode \
    aiohttp \
    fake_useragent \
    user_agent \
    hijri_converter \
    gpytranslate \
    watchdog

WORKDIR /root
RUN git clone https://github.com/orordev/pro

# إعدادات SSH
RUN mkdir -p /var/run/sshd && \
    echo "root:Aoror12007716@#" | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
