CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

IF("${CMAKE_SOURCE_DIR}" STREQUAL "${CMAKE_BINARY_DIR}")
    MESSAGE(FATAL_ERROR "in-source builds are not allowed. ${CMAKE_SOURCE_DIR}")
ENDIF()

#FIND_PROGRAM(FOUND_CCACHE NAMES ccache)                                                                                                                      
#MESSAGE(STATUS "ccache=${FOUND_CCACHE}")                                                                                                                     
IF ( FOUND_CCACHE )                                                                                                                                           
    MESSAGE(STATUS "use ccache")                                                                                                                              
    SET(CMAKE_C_COMPILER "ccache")                                                                                                                            
    SET(CMAKE_C_COMPILER_ARG1 "gcc")                                                                                                                          
    SET(CMAKE_CXX_COMPILER "ccache")                                                                                                                          
    SET(CMAKE_CXX_COMPILER_ARG1 "g++")                                                                                                                        
ENDIF()

PROJECT(${PROJ_NAME})

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
