#!/bin/bash

WORKDIR=`pwd`/`dirname $0`

cd $WORKDIR
mkdir -p data

cd $WORKDIR/dispatcher
pwd
docker build -t koduki/disp .

cd $WORKDIR/worker
pwd
docker build -t koduki/worker .

cd $WORKDIR/aetl
pwd
docker build -t koduki/aetl .
