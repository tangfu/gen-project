#!/bin/bash

killall -9 ${PROJ_NAME}

BASE_PATH=$(dirname `which $0`)
cd ${BASE_PATH}

sleep 1
../bin/${PROJ_NAME} -conf=../conf/${PROJ_NAME}.conf -log_dir=../log -daemon=true -logbufsecs=0 -stderrthreshold=3

