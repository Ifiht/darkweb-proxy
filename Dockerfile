FROM bitnami/minideb:stretch
MAINTAINER ifiht <peter@never.lan>

# Copy application files
COPY . /app
# Install required system packages
RUN apt-get update
RUN apt-get -y install privoxy
# Install NPM dependencies
#RUN npm install --prefix /app
#EXPOSE 80
#CMD ["npm", "start", "--prefix", "app"]
#COPY samba.sh /usr/bin/

EXPOSE 137/udp 138/udp 139 445

HEALTHCHECK --interval=60s --timeout=15s \
            CMD smbclient -L \\localhost -U % -m SMB3

VOLUME ["/etc", "/var/cache/samba", "/var/lib/samba", "/var/log/samba",\
            "/run/samba"]

ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/samba.sh"]
