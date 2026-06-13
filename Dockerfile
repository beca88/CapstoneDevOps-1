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

# ✅ Upgrade pip + setuptools + wheel
RUN pip install --upgrade pip setuptools wheel

# ✅ Step 1: Use wildcards to find requirements.txt anywhere in the structure
COPY **/requirements.txt /app/

# ✅ Step 2: Install dependencies
RUN pip install --no-cache-dir --prefer-binary -r requirements.txt

# ✅ Step 3: Use wildcards to find the app folder contents and copy them to /app
COPY **/healthchecks/ /app/

# ✅ Expose port
EXPOSE 8000

# ✅ Run Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]