# Usa una imagen base oficial de Python
FROM python:3.9-slim

# Configura el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia los archivos de la aplicación al contenedor
COPY . .

# Instala las dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Expone el puerto en el que la aplicación se ejecutará
EXPOSE 8080

# Comando de inicio para ejecutar la aplicación
CMD ["python", "index.py"]
