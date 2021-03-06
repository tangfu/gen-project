cmake_minimum_required(VERSION 2.8)
                                                                                                                           
if(NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE Release)
endif()
message("Build type - " ${CMAKE_BUILD_TYPE})

#find_package(Protobuf REQUIRED)
#protobuf_generate_cpp(PROTO_SRCS PROTO_HDRS ${PROTOCOL}/msg_mask.proto)
#get_filename_component(PB_DIR ${PROTO_HDRS} PATH)
#include_directories(${PB_DIR})

#add_library(${PROJ_LIB_NAME} STATIC xx.cpp)
#set_target_properties(${PROJ_LIB_NAME} PROPERTIES COMPILE_FLAGS "-m32" LINK_FLAGS "-m32")

add_executable(${PROJ_NAME} main.cpp)

if (CMAKE_CXX_COMPILER_VERSION VERSION_LESS 4.8)
    set(std_info "c++0x")
else ()
    set(std_info "c++11")
endif ()

if ( ${CMAKE_BUILD_TYPE} STREQUAL Debug )
	add_definitions("-g -O0 -Wall -std=${std_info} -Wextra -fprofile-arcs -ftest-coverage")
	target_link_libraries(${PROJ_NAME} gflags glog event jsoncpp gcov)
else ()
	add_definitions("-g -O2 -Wall -std=${std_info}")
	target_link_libraries(${PROJ_NAME} gflags glog event jsoncpp)
endif ()

find_program(ASTYLE astyle)
if (${ASTYLE} STREQUAL "ASTYLE-NOTFOUND")
    message("Could not find Astyle.")
else ()
add_custom_command(TARGET ${PROJ_NAME}
	PRE_BUILD
	COMMENT "[ astyle code ]"
	COMMAND [ -z `which astyle 2>/dev/null` -o ! -f ~/.astylerc ] ||
	astyle src/*.cpp src/*.h 2>/dev/null 1>&2
	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
	#VERBATIM
	)
endif ()

find_program(DOXYGEN Doxygen)
if (${DOXYGEN} STREQUAL "DOXYGEN-NOTFOUND")
    message("Could not find Doxygen.")
else ()
add_custom_command(TARGET ${PROJ_NAME}
	POST_BUILD
	COMMENT "[ generate doc ]"
	COMMAND [ -z `which doxygen 2>/dev/null` ] || doxygen 2>/dev/null 1>/dev/null
	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
	#VERBATIM
	)
endif ()
	
find_program(CPPCHECK cppcheck)
if (${CPPCHECK} STREQUAL "CPPCHECK-NOTFOUND")
    message("Could not find CppCheck.")
else ()
add_custom_command(TARGET ${PROJ_NAME}
    POST_BUILD
    COMMENT "[ cppcheck ]"
    COMMAND [ -z `which cppcheck 2>/dev/null` ] || cppcheck -f -j 4 --enable=all src 1>/dev/null                                        
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
    #VERBATIM
    )
endif ()

add_custom_target(uninstall
    COMMAND xargs rm < ${PROJECT_BINARY_DIR}/install_manifest.txt
    )
