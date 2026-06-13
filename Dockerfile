FROM python:3.11-slim

WORKDIR /app

# ✅ Install your preferred system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    pkg-config \
    default-libmysqlclient-dev \
    libmariadb-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 🎯 FIX: Point to the subfolder so Docker can actually find the files!
COPY application/healthchecks/requirements.txt application/healthchecks/requirements-dev.txt ./

# ✅ Install both requirements lists just like you wanted
RUN pip install --no-cache-dir \
    -r requirements.txt \
    -r requirements-dev.txt

# 🎯 FIX: Copy the contents of your app subfolder directly into /app
COPY application/healthchecks/ .

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]