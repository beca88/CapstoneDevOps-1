FROM python:3.11-slim
WORKDIR /app
RUN apt-get update && apt-get install -y \
    build-essential pkg-config default-libmysqlclient-dev \
    libffi-dev libssl-dev curl libcurl4-openssl-dev libpq-dev gcc \
    && rm -rf /var/lib/apt/lists/*
ENV C_INCLUDE_PATH=/usr/local/include/python3.11
ENV PYCURL_SSL_LIBRARY=openssl
RUN pip install --upgrade pip setuptools wheel
COPY **/requirements.txt /app/
RUN pip install --no-cache-dir --prefer-binary -r requirements.txt
COPY **/healthchecks/ /app/
EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]