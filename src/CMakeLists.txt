cmake_minimum_required(VERSION 2.8)

#SET(protoc_cmd "protoc")                                                                                                                                     
#SET(protoc_arg1 "--cpp_out=.")                                                                                                                               
#SET(protoc_1_arg2 "xx1.proto")                                                                                                                               
#SET(protoc_2_arg2 "xx2.proto")                                                                                                                               
#execute_process(                                                                                                                                             
#    COMMAND ${protoc_cmd} ${protoc_arg1} ${protoc_1_arg2}                                                                                                    
#    COMMAND ${protoc_cmd} ${protoc_arg1} ${protoc_2_arg2}                                                                                                    
#    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/src/protocol                                                                                                     
#    ) 

IF( NOT CMAKE_BUILD_TYPE )    
	SET(CMAKE_BUILD_TYPE Release)
ENDIF()
MESSAGE(STATUS "Build type - " ${CMAKE_BUILD_TYPE})

#FIND_PACKAGE(Protobuf REQUIRED)                                                                                       
#PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS protocol/*.proto)

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
#ADD_CUSTOM_COMMAND(                                                                                                                                          
#    OUTPUT "protocol/test1.pb.cc" "protocol/pb_test2.pb.cc"                                                                                                  
#    COMMENT "[ rebuild protobuf ]"                                                                                                                           
#    COMMAND protoc --cpp_out=. *.proto                                                                                                                       
#    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/src/protocol                                                                                                     
#    DEPENDS "protocol/pb_test1.proto" "protocol/pb_test2.proto"                                                                                              
#    )
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
