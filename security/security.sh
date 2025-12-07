#!/bin/bash
# script de respaldo automatizado

echo "iniciando proceso de respaldo..."

# genero la marca de tiempo dinamica
timestamp=$(date +%Y-%m-%d_%H%M)

# creo el nombre del archivo de respaldo
archivo_backup="backup_web_${timestamp}.tar.gz"

# creo el directorio de respaldos si no existe
if [ ! -d "/var/backups/webapp" ]; then
    echo "creando directorio de respaldos..."
    sudo mkdir -p /var/backups/webapp
fi

# empaqueto y comprimo el directorio html
echo "comprimiendo contenido web..."
sudo tar -czf "/tmp/${archivo_backup}" -C /opt/webapp html

# copio el respaldo al directorio local usando rsync
echo "sincronizando respaldo local..."
sudo rsync -av "/tmp/${archivo_backup}" /var/backups/webapp/

# verifico que se copio correctamente
if [ $? -eq 0 ]; then
    echo "respaldo local exitoso"
else
    echo "error en respaldo local"
    exit 1
fi

echo "preparando transferencia remota..."


# limpio el archivo temporal
sudo rm "/tmp/${archivo_backup}"

echo ""
echo "respaldo completado: ${archivo_backup}"
echo "ubicacion: /var/backups/webapp/${archivo_backup}"
