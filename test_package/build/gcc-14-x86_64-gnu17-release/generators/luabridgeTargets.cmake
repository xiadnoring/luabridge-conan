# Load the debug and release variables
file(GLOB DATA_FILES "${CMAKE_CURRENT_LIST_DIR}/luabridge-*-data.cmake")

foreach(f ${DATA_FILES})
    include(${f})
endforeach()

# Create the targets for all the components
foreach(_COMPONENT ${luabridge_COMPONENT_NAMES} )
    if(NOT TARGET ${_COMPONENT})
        add_library(${_COMPONENT} INTERFACE IMPORTED)
        message(${luabridge_MESSAGE_MODE} "Conan: Component target declared '${_COMPONENT}'")
    endif()
endforeach()

if(NOT TARGET luabridge::luabridge)
    add_library(luabridge::luabridge INTERFACE IMPORTED)
    message(${luabridge_MESSAGE_MODE} "Conan: Target declared 'luabridge::luabridge'")
endif()
# Load the debug and release library finders
file(GLOB CONFIG_FILES "${CMAKE_CURRENT_LIST_DIR}/luabridge-Target-*.cmake")

foreach(f ${CONFIG_FILES})
    include(${f})
endforeach()