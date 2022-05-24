FROM keymetrics/pm2:latest-stretch
#debian:buster-slim
MAINTAINER ifiht <peter@never.lan>

#+=======[ ENV VARS ]===========================+#
ENV TERM linux
ENV GPG_TTY /dev/console
ENV DEBIAN_FRONTEND noninteractive

#+=======[ INSTALL PRE-REQS ]===================+#
RUN apt-get update
RUN apt-get -y install apt-utils ca-certificates curl dirmngr gnupg lsb-release
#software-properties-common apt-transport-https 

#+=======[ ADD APT REPOS ]======================+#
RUN gpg --fetch-keys https://neilalexander.s3.dualstack.eu-west-2.amazonaws.com/deb/key.txt
RUN gpg --export 569130E8CA20FBC4CB3FDE555898470A764B32C9 | tee /usr/share/keyrings/yggdrasil-keyring.gpg > /dev/null
RUN echo 'deb [signed-by=/usr/share/keyrings/yggdrasil-keyring.gpg] http://neilalexander.s3.dualstack.eu-west-2.amazonaws.com/deb/ debian yggdrasil' \
    | tee /etc/apt/sources.list.d/yggdrasil.list
RUN echo "deb http://deb.i2p2.de/ $(lsb_release -sc) main" \
    | tee /etc/apt/sources.list.d/i2p.list   
#software-properties-common
# remove "-k" from production builds!!!
RUN curl -k -o /usr/share/keyrings/i2p-archive-keyring.gpg https://geti2p.net/_static/i2p-archive-keyring.gpg
RUN ln -sf /usr/share/keyrings/i2p-archive-keyring.gpg /etc/apt/trusted.gpg.d/i2p-archive-keyring.gpg

#+=======[ YGGDRASIL, PRIVOXY, TOR, I2P ]=======+#
RUN apt-get update
RUN apt-get -y install privoxy tor i2p i2p-keyring yggdrasil \
    net-tools procps
    #!! ^ debug builds only!!

#+=======[ SYSTEM SETUP ]=======================+#
RUN echo "tun" >> /etc/modules

# Copy application files
COPY ./etc /etc

#CMD mkdir /dev/net && mknod /dev/net/tun c 10 200
#CMD chmod 0666 /dev/net/tun
#CMD /usr/bin/yggdrasil -useconffile /etc/yggdrasil.conf
CMD ['pm2-docker', '/opt/procs.json']

EXPOSE 8080/tcp
EXPOSE 8080/udp

#HEALTHCHECK --interval=60s --timeout=15s \
#            CMD smbclient -L \\localhost -U % -m SMB3

#VOLUME ["/etc", "/opt/i2psnark"]

#ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/samba.sh"]
