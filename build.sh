#!/bin/bash

WORKDIR=`dirname $0`

cd $WORKDIR/dispatcher
docker build -t koduki/disp .

cd $WORKDIR/app
docker build -t koduki/worker .
