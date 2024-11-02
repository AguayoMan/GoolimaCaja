# Usa una imagen base de Python
FROM python:3.10-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos de requerimientos a la imagen
COPY requirements.txt .

# Instala dependencias del sistema necesarias
RUN apt-get update && apt-get install -y --no-install-recommends \
    pkg-config \
    default-libmysqlclient-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*


# Crea y activa un entorno virtual, luego instala las dependencias de Python
RUN python -m venv /opt/venv && \
    . /opt/venv/bin/activate && \
    pip install --upgrade pip && \
    # Instala las dependencias, excluyendo pywin32
    sed '/pywin32/d' requirements.txt > requirements_nopywin32.txt && \
    pip install -r requirements_nopywin32.txt

# Copia el resto de la aplicación
COPY . .

# Expone el puerto si es necesario para tu aplicación
EXPOSE 8000
# Define las variables de entorno para asegurar que usemos el entorno virtual
ENV PATH="/opt/venv/bin:$PATH"

# Comando para correr la aplicación (ajusta según tu aplicación)
CMD ["/opt/venv/bin/python", "index.py"]

