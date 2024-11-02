# Usa una imagen base de Python
FROM python:3.11-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos necesarios
COPY . .

# Instala las dependencias del sistema necesarias para mysqlclient
RUN apt-get update && \
    apt-get install -y default-libmysqlclient-dev build-essential && \
    rm -rf /var/lib/apt/lists/*

# Configura un entorno virtual e instala las dependencias de Python
RUN python -m venv /opt/venv && \
    . /opt/venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

# Define las variables de entorno para asegurar que usemos el entorno virtual
ENV PATH="/opt/venv/bin:$PATH"

# Define el comando para iniciar la aplicación
CMD ["python", "index.py"]

