FROM python:3.14-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
build-essential \
pkg-config \
default-libmysqlclient-dev \
libmariadb-dev \
curl \
&& rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements-dev.txt ./

RUN pip install --no-cache-dir \
-r requirements.txt \
-r requirements-dev.txt

COPY . .

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
