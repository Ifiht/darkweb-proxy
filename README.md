![docker build](https://github.com/Ifiht/darkweb-proxy/actions/workflows/docker-image.yml/badge.svg)

# darkweb-proxy
Privoxy, I2P, and Tor all in one docker container
 - https://yggdrasil-network.github.io/
 - https://geti2p.net/en/
 - https://www.torproject.org/

## Quickstart

- Clone the repo, build & start:
  ```
  git clone https://github.com/Ifiht/darkweb-proxy.git
  cd darkweb-proxy
  sudo docker build -t ifiht/darkweb-proxy:alpha .
  sudo docker run --name darkweb_proxy --cap-add=NET_ADMIN --cap-add=NET_BIND_SERVICE -p YOUR_DOCKER_HOST_IP:8080:8080 -it ifiht/darkweb-proxy:alpha
  ```
- Point your browser to the proxy:
![Firefox Setup](img/firefox_proxy_settings.png?raw=true "Firefox Setup")
- Enjoy!

## Container Design

#### Philosophy: "A simple _self contained_ image that anyone with docker skills can deploy, to access the greatest extent of the dark web possible"

Currently the container grants access to the Tor Project and Invisible Internet Project networks, while also providing a regular internet proxy. Should all of these be separated into their own containers and integrated through the docker bridge network? According to Docker: **"each container should do one thing and do it well."**. However, the author of this container has decided that that **one thing** is dark web access, and this container does it well. If in the future, more maintainers come along and consensus moves towards splitting the image, the project could move that way. But for now, as my personal project, one image this will remain.

For the above purpose, this container acts as a proxy server. The image should be deployed on a the host machine, secured intranet, or LAN, and the client computers pointed to the proxy. Everything else is seemless, all websites will now load based on the top-level domain (TLD), e.g. `.com` will load regular internet, `.i2p` will load eepsites, etc.

## Minimum System Requirements

 - 1GB of RAM
 - 750MB of free disk space
 - _highly recommended:_
   - multi-core CPU

## Running the Container
### Default Mode (easiest)

```
sudo docker run --network host \
    --name darkweb-proxy \
    --cap-add=NET_ADMIN \
    --cap-add=NET_BIND_SERVICE \
    ifiht/darkweb-proxy:latest
```

### Custom Configs (intermediate)

```
sudo docker run --network host \
    --name darkweb-proxy \
    --cap-add=NET_ADMIN \
    --cap-add=NET_BIND_SERVICE \
    ifiht/darkweb-proxy:latest
```
