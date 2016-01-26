cmake_minimum_required(VERSION 2.8)

if ("${CMAKE_SOURCE_DIR}" STREQUAL "${CMAKE_BINARY_DIR}")
    message(FATAL_ERROR "in-source builds are not allowed. ${CMAKE_SOURCE_DIR}")
endif ()

#FIND_PROGRAM(FOUND_CCACHE NAMES ccache)
#MESSAGE(STATUS "ccache=${FOUND_CCACHE}")
if (FOUND_CCACHE)
    message("use ccache")
    set(CMAKE_C_COMPILER "ccache")
    set(CMAKE_C_COMPILER_ARG1 "gcc")
    set(CMAKE_CXX_COMPILER "ccache")
    set(CMAKE_CXX_COMPILER_ARG1 "g++")
endif ()

project(${PROJ_NAME})

<<<<<<< HEAD
find_package(xxxx REQUIRED)

add_subdirectory(src)
install(PROGRAMS build/src/${PROJ_NAME} DESTINATION ${PROJECT_SOURCE_DIR}/pub/bin)
install(DIRECTORY DESTINATION ${PROJECT_SOURCE_DIR}/pub/log)
install(DIRECTORY tools DESTINATION ${PROJECT_SOURCE_DIR}/pub PATTERN ".svn" EXCLUDE PATTERN "*.sh" PERMISSIONS 
    OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
install(FILES ${PROJ_NAME}.conf DESTINATION ${PROJECT_SOURCE_DIR}/pub/conf)
install(DIRECTORY extra/ DESTINATION ${PROJECT_SOURCE_DIR}/pub/conf PATTERN ".svn" EXCLUDE)
=======
SET(FRAMEWORK_ADDR yyyy)                                                                            
FIND_PACKAGE(xxxx REQUIRED HINTS ${FRAMEWORK_ADDR} NO_DEFAULT_PATH) 
FIND_PACKAGE(xxxx REQUIRED)

ADD_SUBDIRECTORY(src)

SET(CMAKE_INSTALL_PREFIX ${PROJECT_SOURCE_DIR}/pub)
INSTALL(PROGRAMS build/src/${PROJ_NAME} DESTINATION bin)
INSTALL(DIRECTORY DESTINATION log)
INSTALL(FILES tools/restart.sh tools/stop.sh DESTINATION tools PERMISSIONS                                  
    OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
#INSTALL(DIRECTORY tools DESTINATION pub PATTERN ".svn" EXCLUDE PATTERN "*.sh" PERMISSIONS 
    OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
INSTALL(FILES ${PROJ_NAME}.conf DESTINATION conf)
INSTALL(DIRECTORY extra/ DESTINATION conf PATTERN ".svn" EXCLUDE)

set(CPACK_GENERATOR "TGZ")                                                                                                       
set(CPACK_PACKAGE_NAME ${PROJ_NAME})                                                                                           
include(CPack) 
>>>>>>> origin/master
