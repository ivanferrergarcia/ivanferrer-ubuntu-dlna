# Indiquem la versió d'Ubuntu en la qual treballarà el Dockerfile
FROM ubuntu:20.04

# Instal·lem les dependències + el servei DLNA
RUN apt-get update
RUN apt-get install  minidlna -y

# Copiem l'arxiu de configuració del servei DLNA en el contenidor
COPY minidlna.conf /etc/minidlna.conf

# Copiem el vídeo al directori arrel del servidor DLNA
COPY video.mp4 /var/lib/minidlna/

# Fem que el directori /var/lib/minidlna tingui els permisos necessaris per al servidor DLNA
RUN chown -R minidlna:minidlna /var/lib/minidlna && chmod -R 777 /var/lib/minidlna

# Exposem el port 8200 del contenidor per accedir al servidor DLNA
EXPOSE 8200
EXPOSE 554

# Executem el servidor DLNA en iniciar el contenidor
CMD ["sh", "-c", "service minidlna start && tail -f /var/log/minidlna.log"]

