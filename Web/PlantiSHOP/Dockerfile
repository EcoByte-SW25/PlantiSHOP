# Imagen base con Tomcat 9 y JDK 17
FROM tomcat:9.0-jdk17-temurin

# Elimina aplicaciones por defecto (opcional)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia el archivo WAR generado por Maven al directorio webapps/
COPY target/PlantiSHOP-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Expone el puerto 8080 (puerto por defecto de Tomcat)
EXPOSE 8080

# Inicia Tomcat al arrancar el contenedor
CMD ["catalina.sh", "run"]
