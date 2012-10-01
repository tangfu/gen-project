#!/bin/bash

killall -9 ${PROJ_NAME}

BASE_PATH=$(dirname `which $0`)
cd ${BASE_PATH}

sleep 1
./${PROJ_NAME} -conf=${PROJ_NAME}.cfg -daemon=true -logbufsecs=0 -v=1

