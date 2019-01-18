#!/bin/bash

mkdir -p /tmp/data
docker run -it --privileged -v /var/run/docker.sock:/var/run/docker.sock -p 80:80 -v `pwd`:/app koduki/disp
