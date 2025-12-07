
**Alumno:** Vicente Baranda  


### Requisitos Previos
- Sistema Ubuntu/Debian 20.04 o superior
- Acceso root o sudo

- 1. **Clonar el repositorio:**
```bash
git clone https://github.com/vibaranda/Examen-Linux.git
cd Examen-Linux/proyecto_final
```

2. **Ejecutar aprovisionamiento:**
```bash
cd deploy
sudo ./setup.sh
```

3. **Aplicar endurecimiento de seguridad:**
```bash
cd ../security
sudo ./hardening.sh
```

4. **Levantar la aplicación:**
```bash
cd ../deploy
sudo docker-compose up -d
```

5. **Verificar el despliegue:**
```bash
sudo docker ps
curl http://localhost:8080
```

6. **Ejecutar respaldo (opcional):**
```bash
cd ../maintenance
sudo ./backup.sh
```

## Justificación de Seguridad

La implementación de medidas de endurecimiento del sistema es fundamental para proteger la infraestructura contra amenazas comunes. Deshabilitar el acceso directo de root por SSH reduce significativamente la superficie de ataque, ya que los atacantes no pueden intentar fuerza bruta directamente contra la cuenta de superusuario, que es un objetivo conocido. En su lugar, deben primero comprometer una cuenta de usuario regular y luego escalar privilegios, lo cual añade una capa adicional de defensa.

El filtrado de puertos mediante UFW implementa el principio de "Default Deny", donde solo se permite explícitamente el tráfico necesario (SSH en puerto 22 y HTTP en puerto 8080), bloqueando todo lo demás. Esto minimiza los vectores de ataque disponibles y protege servicios internos que no deben estar expuestos públicamente. Esta estrategia se alinea con la Tríada CIA (Confidencialidad, Integridad, Disponibilidad) al garantizar que solo usuarios autorizados puedan acceder a los servicios específicos requeridos, manteniendo la disponibilidad de la aplicación mientras se protege su integridad y confidencialidad.

## Comandos Útiles

```bash
# Verificar estado del firewall
sudo ufw status verbose

# Ver logs de la aplicación
sudo docker-compose logs -f

# Listar respaldos
ls -lh /var/backups/webapp/

# Detener la aplicación
sudo docker-compose down
```
