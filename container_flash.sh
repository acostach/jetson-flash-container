#!/bin/bash

echo "Machine is ${MACHINE}"
echo "Image is ${IMAGE}"

/jetson-workdir/jetson-flash/bin/cmd.js -m ${MACHINE} -f "/${IMAGE}"
