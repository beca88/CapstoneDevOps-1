FROM python:3.11-slim

WORKDIR /app

# ✅ Install ALL required development libraries for pycurl and psycopg
RUN apt-get update && apt-get install -y \
    build-essential \
    pkg-config \
    default-libmysqlclient-dev \
    libffi-dev \
    libssl-dev \
    python3-dev \
    curl \
    libcurl4-openssl-dev \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

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