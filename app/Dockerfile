# Imagen base ligera con Python 3.14
FROM python:3.14-slim

# Establece directorio de trabajo
WORKDIR /app

# Evita archivos .pyc y asegura logs en stdout/stderr
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PORT=8080

# Instala dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia el código de la app
COPY . .

# Comando de arranque (1 worker es suficiente para Cloud Run)
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080", "--workers", "1"]
