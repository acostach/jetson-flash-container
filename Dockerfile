# jetson-flash runs on node 12-14
FROM node:12-bullseye

WORKDIR jetson-workdir
COPY ./jetson-flash ./jetson-flash
COPY container_flash.sh ./jetson-flash/container_flash.sh

RUN apt-get update && apt-get install -y python3 python3-pip usbutils sudo e2fsprogs dosfstools libxml2-utils vim && \
    pip3 install pyyaml && \
    echo 'alias python=python3' >> /root/.bashrc && \
    echo 'cd /jetson-workdir/jetson-flash/' >> /root/.bashrc

ENTRYPOINT ["/bin/bash"]

