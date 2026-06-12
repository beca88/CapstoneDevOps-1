FROM python:3.11-slim

WORKDIR /app

# ✅ Install required system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    pkg-config \
    default-libmysqlclient-dev \
    libffi-dev \
    libssl-dev \
    python3-dev \
    curl \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# ✅ Copy application
COPY application/healthchecks /app

# ✅ Upgrade pip + setuptools + wheel (VERY IMPORTANT)
RUN pip install --upgrade pip setuptools wheel

# ✅ Install dependencies (fix common failures)
RUN pip install --no-cache-dir --prefer-binary -r requirements.txt

# ✅ Expose port
EXPOSE 8000

# ✅ Run Django
