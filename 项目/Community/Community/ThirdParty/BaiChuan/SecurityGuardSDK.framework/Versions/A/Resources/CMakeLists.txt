include_directories(${PROJECT_SOURCE_DIR}/clib/component/include)
include_directories(${PROJECT_SOURCE_DIR}/clib/component/common/include)
include_directories(${PROJECT_SOURCE_DIR}/clib/component/errorhandler/include)
include_directories(${PROJECT_SOURCE_DIR}/clib/manager/include)

if(${OS} STREQUAL ANDROID)
set(ERROR_HANDLER_COMPONENT 	src/ErrorHandlerComponent.c 
					 			src/ErrorHandlerApi_priv.c
)
endif()

add_library(errorhandler STATIC ${ERROR_HANDLER_COMPONENT})
target_link_libraries(errorhandler common)
