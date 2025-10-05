# Imagen base ligera de Python
FROM python:3.13-slim

# Crea y define el directorio de trabajo
WORKDIR /app

# Copia dependencias e instálalas
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia el código de la aplicación
COPY ./app ./app

# Expone el puerto donde correrá FastAPI
EXPOSE 8000

# Comando para iniciar el servidor
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
