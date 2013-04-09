#!/bin/bash

killall -9 ${PROJ_NAME}

BASE_PATH=$(dirname `which $0`)
cd ${BASE_PATH}

sleep 1
#这里是方便测试环境所做的参数配置
#运营环境需要做适当调整，例如可能会关掉logbufsecs=0以及v=1
../build/src/${PROJ_NAME} -conf=../${PROJ_NAME}.conf -daemon=true -logbufsecs=0 -stderrthreshold=3 -v=1

#../bin/${PROJ_NAME} -conf=../conf/${PROJ_NAME}.conf -daemon=true -stderrthreshold=3

