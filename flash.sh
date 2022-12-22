#!/bin/bash

print_help()
{
   echo "Syntax: ./flash.sh [-h] -m <machine> -f balenaos_images/<jetson-image.img>"
   echo "Example: ./flash.sh -m jetson-agx-orin-devkit -f balenaos_images/balena-cloud-test-jetson-orin-jetson-agx-orin-devkit-2.106.7-v14.3.3.img"
}

if [ "$#" -le 1 ]; then
    print_help
    exit
fi

machine=""
image=""

while getopts ":h:m:f:" option; do
   case $option in
      h) print_help
         exit;;
      m) machine=$OPTARG;;
      f) image=$OPTARG;;   
      \?) # Invalid arg
         echo "Error: Invalid argument"
         exit;;
   esac
done

if [ ! -d "jetson-flash" ]; then
    echo "Unpacking pre-built jetson-flash"
    tar xf jetsonflash.tar.gz 
    echo "Unpacked jetson-flash"
fi

docker build -t jfcontainer .
docker run -d --rm --tty --net=host -v "$(pwd)/balenaos_images:/balenaos_images" -v /run/udev/control:/run/udev/control -v /sys:/sys -v /dev:/dev --privileged --name=jfc jfcontainer
docker exec -e IMAGE="${image}" -e MACHINE="${machine}" -it jfc bash /jetson-workdir/jetson-flash/container_flash.sh
docker kill jfc
