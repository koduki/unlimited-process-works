#!/bin/bash

docker run -it --privileged -v /var/run/docker.sock:/var/run/docker.sock -p 80:80 -v `pwd`:/app -v `pwd`/data:/data koduki/disp
