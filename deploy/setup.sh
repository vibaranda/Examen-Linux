#!/bin/bash
# script de aprovisionamiento de infraestructura

echo "iniciando aprovisionamiento del sistema..."

# actualizo los repositorios del sistema
echo "actualizando repositorios..."
sudo apt-get update

# instalo las herramientas necesarias
echo "instalando herramientas basicas..."
sudo apt-get install -y git curl ufw docker.io docker-compose

# verifico si el directorio ya existe antes de crearlo
if [ ! -d "/opt/webapp/html" ]; then
    echo "creando estructura de directorios..."
    sudo mkdir -p /opt/webapp/html
else
    echo "el directorio ya existe"
fi

# cambio al directorio de trabajo
cd /opt/webapp

# descargo el archivo docker-compose.yml
echo "descargando docker-compose.yml..."
sudo curl -o docker-compose.yml https://gist.githubusercontent.com/DarkestAbed/0c1cee748bb9e3b22f89efe1933bf125/raw/5801164c0a6e4df7d8ced00122c76895997127a2/docker-compose.yml

# creo el archivo index.html con el contenido requerido
echo "generando contenido web..."
sudo bash -c 'cat > /opt/webapp/html/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>Servidor Seguro</title>
</head>
<body>
    <h1>Servidor Seguro Propiedad de Vicente Baranda - Acceso Restringido</h1>
</body>
</html>
EOF'

# verifico si el usuario sysadmin ya existe
if ! id -u sysadmin > /dev/null 2>&1; then
    echo "creando usuario sysadmin..."
    sudo useradd -m -s /bin/bash sysadmin
    sudo usermod -aG docker sysadmin
else
    echo "el usuario sysadmin ya existe"
fi

echo ""
echo "aprovisionamiento completado exitosamente"
