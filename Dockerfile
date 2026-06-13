FROM python:3.11-slim

WORKDIR /app

# ✅ Clean up apt packages (removed python dev packages since they are pre-installed)
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

# 🎯 CRITICAL FIX: Tell GCC exactly where the pre-installed Python.h lives in this image
ENV C_INCLUDE_PATH=/usr/local/include/python3.11

# ✅ Tell pycurl explicitly to use OpenSSL during pip compilation
ENV PYCURL_SSL_LIBRARY=openssl

# ✅ Upgrade pip + setuptools + wheel
RUN pip install --upgrade pip setuptools wheel

# ✅ Step 1: Use wildcards to find requirements.txt
COPY **/requirements.txt /app/

# ✅ Step 2: Install dependencies
RUN pip install --no-cache-dir --prefer-binary -r requirements.txt

# ✅ Step 3: Copy app contents
COPY **/healthchecks/ /app/

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]