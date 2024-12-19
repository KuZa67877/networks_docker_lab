FROM python:3.11-alpine

# создаем непривилегированного пользователя
RUN adduser -D -u 1000 appuser

WORKDIR /app
RUN apk add --no-cache bash
COPY requirements.txt ./

# Устанавливаем виртуальное окружение в /app/venv
RUN python -m venv /app/venv && \
    /app/venv/bin/pip install --no-cache-dir -r requirements.txt

COPY . .

RUN chown -R appuser:appuser /app

USER appuser

ENV PATH="/app/venv/bin:$PATH"

EXPOSE 5000

CMD ["python", "main.py"]
