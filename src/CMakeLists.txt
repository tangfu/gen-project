cmake_minimum_required(VERSION 2.8)


IF( NOT CMAKE_BUILD_TYPE )    
	SET(CMAKE_BUILD_TYPE Release)
ENDIF()
MESSAGE(STATUS "Build type - " ${CMAKE_BUILD_TYPE})


add_executable(${PROJ_NAME} main.cpp)

IF ( ${CMAKE_BUILD_TYPE} STREQUAL Debug )	
	add_definitions("-g -O0 -Wall -std=c++0x -Wextra -fprofile-arcs -ftest-coverage")
	target_link_libraries(${PROJ_NAME} gflags glog event jsoncpp gcov)
ELSE()	
	add_definitions("-g -O2 -Wall -std=c++0x")
	target_link_libraries(${PROJ_NAME} gflags glog event jsoncpp)
ENDIF()


ADD_CUSTOM_COMMAND(TARGET ${PROJ_NAME}
	PRE_BUILD
	COMMENT "[ astyle code ]"
	COMMAND [ -z `which astyle 2>/dev/null` -o ! -f ~/.astylerc ] ||
	astyle src/*.cpp src/*.h 2>/dev/null 1>&2
	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
	#VERBATIM
	)

ADD_CUSTOM_COMMAND(TARGET ${PROJ_NAME}
	POST_BUILD
	COMMENT "[ generate doc ]"
	COMMAND [ -z `which doxygen 2>/dev/null` ] || doxygen 2>/dev/null 1>/dev/null
	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
	#VERBATIM
	)
	
ADD_CUSTOM_COMMAND(TARGET ${PROJ_NAME}
    POST_BUILD
    COMMENT "[ cppcheck ]"
    COMMAND [ -z `which cppcheck 2>/dev/null` ] || cppcheck -f -j 4 --enable=all src 1>/dev/null                                                         
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
    #VERBATIM
    )

#ADD_CUSTOM_COMMAND(TARGET ${PROJ_NAME}
#   PRE_BUILD
#   COMMENT "[ rebuild protobuf ]"
#   COMMAND [ -z `which protoc 2>/dev/null` ] || make
#   WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/src/proto
#   #VERBATIM
#   )

ADD_CUSTOM_TARGET(uninstall                                                                                                        
    COMMAND xargs rm < ${PROJECT_BINARY_DIR}/install_manifest.txt
    )
