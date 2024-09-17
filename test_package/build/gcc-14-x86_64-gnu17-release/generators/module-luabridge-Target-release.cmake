# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(luabridge_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
conan_find_apple_frameworks(luabridge_FRAMEWORKS_FOUND_RELEASE "${luabridge_FRAMEWORKS_RELEASE}" "${luabridge_FRAMEWORK_DIRS_RELEASE}")

set(luabridge_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET luabridge_DEPS_TARGET)
    add_library(luabridge_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET luabridge_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Release>:${luabridge_FRAMEWORKS_FOUND_RELEASE}>
             $<$<CONFIG:Release>:${luabridge_SYSTEM_LIBS_RELEASE}>
             $<$<CONFIG:Release>:lua::lua>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### luabridge_DEPS_TARGET to all of them
conan_package_library_targets("${luabridge_LIBS_RELEASE}"    # libraries
                              "${luabridge_LIB_DIRS_RELEASE}" # package_libdir
                              "${luabridge_BIN_DIRS_RELEASE}" # package_bindir
                              "${luabridge_LIBRARY_TYPE_RELEASE}"
                              "${luabridge_IS_HOST_WINDOWS_RELEASE}"
                              luabridge_DEPS_TARGET
                              luabridge_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELEASE"
                              "luabridge"    # package_name
                              "${luabridge_NO_SONAME_MODE_RELEASE}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${luabridge_BUILD_DIRS_RELEASE} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Release ########################################
    set_property(TARGET luabridge::luabridge
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Release>:${luabridge_OBJECTS_RELEASE}>
                 $<$<CONFIG:Release>:${luabridge_LIBRARIES_TARGETS}>
                 )

    if("${luabridge_LIBS_RELEASE}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET luabridge::luabridge
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     luabridge_DEPS_TARGET)
    endif()

    set_property(TARGET luabridge::luabridge
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Release>:${luabridge_LINKER_FLAGS_RELEASE}>)
    set_property(TARGET luabridge::luabridge
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Release>:${luabridge_INCLUDE_DIRS_RELEASE}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET luabridge::luabridge
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Release>:${luabridge_LIB_DIRS_RELEASE}>)
    set_property(TARGET luabridge::luabridge
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Release>:${luabridge_COMPILE_DEFINITIONS_RELEASE}>)
    set_property(TARGET luabridge::luabridge
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Release>:${luabridge_COMPILE_OPTIONS_RELEASE}>)

########## For the modules (FindXXX)
set(luabridge_LIBRARIES_RELEASE luabridge::luabridge)
