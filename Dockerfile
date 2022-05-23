FROM bitnami/minideb:stretch
MAINTAINER ifiht <peter@never.lan>

# Copy application files
COPY ./etc /etc
# Install required system packages

RUN apt-get update
RUN apt-get -y install privoxy tor software-properties-common
RUN apt-get update
RUN apt-add-repository ppa:i2p-maintainers/i2p
RUN apt-get -y install i2p

EXPOSE 8080/tcp
EXPOSE 8080/udp
#EXPOSE 137/udp 138/udp 139 445

#HEALTHCHECK --interval=60s --timeout=15s \
#            CMD smbclient -L \\localhost -U % -m SMB3

VOLUME ["/etc", "/opt/i2psnark"]

#ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/samba.sh"]
