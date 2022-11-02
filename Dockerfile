FROM node:current-buster
#debian:buster-slim
MAINTAINER ifiht <peter@never.lan>

#+=======[ ENV VARS ]===========================+#
ENV TERM linux
ENV GPG_TTY /dev/console
ENV DEBIAN_FRONTEND noninteractive

#+=======[ INSTALL PRE-REQS ]===================+#
RUN apt-get update
RUN apt-get -y install apt ca-certificates curl dirmngr gnupg
#software-properties-common apt-transport-https 

#+=======[ ADD APT REPOS ]======================+#
RUN echo "deb http://deb.i2p2.de/ buster main" \
    | tee /etc/apt/sources.list.d/i2p.list 
#software-properties-common
# remove "-k" from production builds!!!
#RUN curl -k -o /usr/share/keyrings/i2p-archive-keyring.gpg https://geti2p.net/_static/i2p-archive-keyring.gpg
COPY ./i2p-archive-keyring.gpg /usr/share/keyrings/i2p-archive-keyring.gpg
RUN ln -sf /usr/share/keyrings/i2p-archive-keyring.gpg /etc/apt/trusted.gpg.d/i2p-archive-keyring.gpg

#+=======[ PRIVOXY, TOR, I2P ]=======+#
#RUN apt-get update
#RUN apt-get -y install privoxy tor i2p i2p-keyring \
#    nano net-tools procps
    #!! ^ debug builds only!!

#+=======[ SYSTEM SETUP ]=======================+#
#RUN echo "tun" >> /etc/modules
#RUN mkdir /var/run/tor && chown debian-tor:debian-tor /var/run/tor && chmod 700 /var/run/tor
#RUN mkdir /dev/net && mknod /dev/net/tun c 10 200
#RUN chmod 0666 /dev/net/tun
# temp fix for npm not resolving repo:
#RUN npm install pm2 -g
RUN npm install https://github.com/Unitech/pm2/archive/refs/tags/5.2.2.tar.gz -g

# Copy application files
COPY ./etc /etc/
COPY ./opt /opt/

#ENTRYPOINT ["pm2-docker", "/opt/procs.json"]
ENTRYPOINT ["pm2-runtime", "start", "/opt/procs.json"]

#EXPOSE 8080/tcp
#EXPOSE 8080/udp

#HEALTHCHECK --interval=60s --timeout=15s \
#            CMD smbclient -L \\localhost -U % -m SMB3

#VOLUME ["/etc", "/opt/i2psnark"]

#ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/samba.sh"]
