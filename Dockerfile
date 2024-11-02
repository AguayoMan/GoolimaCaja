# Usa una imagen base de Python
FROM python:3.10-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos de requerimientos a la imagen
COPY requirements.txt ./

# Instala dependencias del sistema necesarias
RUN apt-get update && apt-get install -y --no-install-recommends \
    pkg-config \
    default-libmysqlclient-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Crea un entorno virtual y actualiza pip
RUN python -m venv /opt/venv && \
    /opt/venv/bin/pip install --upgrade pip

# Filtra el archivo requirements.txt para excluir pywin32
RUN sed '/pywin32/d' requirements.txt > requirements_nopywin32.txt

# Instala las dependencias, ignorando errores de paquetes que no se encuentren
RUN /opt/venv/bin/pip install -r requirements_nopywin32.txt || echo "Algunos paquetes no se pudieron instalar"

# Copia el resto de la aplicación
COPY . .

# Expone el puerto si es necesario para tu aplicación
EXPOSE 8000

# Define las variables de entorno para asegurar que usemos el entorno virtual
ENV PATH="/opt/venv/bin:$PATH"

# Comando para correr la aplicación (ajusta según tu aplicación)
CMD ["python", "index.py"]

