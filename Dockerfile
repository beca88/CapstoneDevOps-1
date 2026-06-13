FROM python:3.11-slim

WORKDIR /app

# ✅ Install required system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    pkg-config \
    default-libmysqlclient-dev \
    libffi-dev \
    libssl-dev \
    curl \
    libcurl4-openssl-dev \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# ✅ Tell pycurl explicitly to use OpenSSL during pip compilation
ENV PYCURL_SSL_LIBRARY=openssl

# ✅ Upgrade pip + setuptools + wheel
RUN pip install --upgrade pip setuptools wheel

# 🎯 FIX: Use the exact explicit path to copy requirements.txt straight to /app/
COPY application/healthchecks/requirements.txt /app/requirements.txt

# ✅ Install dependencies
RUN pip install --no-cache-dir --prefer-binary -r /app/requirements.txt

# 🎯 FIX: Copy your app files explicitly straight into /app/
COPY application/healthchecks/ /app/

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]