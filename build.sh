#!/bin/bash

WORKDIR=`pwd`/`dirname $0`

cd $WORKDIR/dispatcher
pwd
docker build -t koduki/disp .

cd $WORKDIR/app
pwd
docker build -t koduki/worker .
