cmake_minimum_required(VERSION 2.8)


IF( NOT CMAKE_BUILD_TYPE )    
	SET(CMAKE_BUILD_TYPE Debug)
ENDIF()
MESSAGE(STATUS "Build type - " ${CMAKE_BUILD_TYPE})


add_executable(${PROJ_NAME} main.cpp)

IF ( ${CMAKE_BUILD_TYPE} STREQUAL Debug )	
	add_definitions("-g -O0 -Wall -Wextra -fprofile-arcs -ftest-coverage -pg")
	target_link_libraries(${PROJ_NAME} gflags glog event jsoncpp gcov)
ELSE()	
	add_definitions("-g -O2 -Wall -Wextra")
	target_link_libraries(${PROJ_NAME} gflags glog event jsoncpp)
ENDIF()


install(TARGETS ${PROJ_NAME} RUNTIME DESTINATION ${PROJ_NAME}/bin)

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
	COMMENT "[ generate sha1 file ]"
	COMMAND rm -f sha1sum.* 2>/dev/null
	COMMAND [ -z `which sha1sum 2>/dev/null` ] || [ -z `which touch 2>/dev/null` ] || touch sha1sum.`sha1sum src/${PROJ_NAME}`
	WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
	#VERBATIM
	)
