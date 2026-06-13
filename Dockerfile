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

# ✅ Upgrade pip + setuptools + wheel (VERY IMPORTANT)
RUN pip install --upgrade pip setuptools wheel

# ✅ Step 1: Copy ONLY the requirements file from the subfolder first
COPY application/healthchecks/requirements.txt /app/

# ✅ Step 2: Install dependencies (This will now find /app/requirements.txt perfectly)
RUN pip install --no-cache-dir --prefer-binary -r requirements.txt

# ✅ Step 3: Copy the rest of your application code
COPY application/healthchecks /app

# ✅ Expose port
EXPOSE 8000

# ✅ Run Django (Using the standard CMD structure)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]