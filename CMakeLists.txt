CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
#SET(PROJ_NAME xxx)
PROJECT(${PROJ_NAME})

FIND_PACKAGE(xxxx REQUIRED)

ADD_SUBDIRECTORY(src)
INSTALL(PROGRAMS tools/restart.sh DESTINATION ${PROJ_NAME}/tools)
INSTALL(FILES ${PROJ_NAME}.cfg DESTINATION ${PROJ_NAME}/conf