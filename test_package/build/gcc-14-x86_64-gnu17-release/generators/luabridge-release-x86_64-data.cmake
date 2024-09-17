########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(luabridge_COMPONENT_NAMES "")
if(DEFINED luabridge_FIND_DEPENDENCY_NAMES)
  list(APPEND luabridge_FIND_DEPENDENCY_NAMES lua)
  list(REMOVE_DUPLICATES luabridge_FIND_DEPENDENCY_NAMES)
else()
  set(luabridge_FIND_DEPENDENCY_NAMES lua)
endif()
set(lua_FIND_MODE "NO_MODULE")

########### VARIABLES #######################################################################
#############################################################################################
set(luabridge_PACKAGE_FOLDER_RELEASE "/home/Timur/.conan2/p/b/luabr678f83c5ef9fd/p")
set(luabridge_BUILD_MODULES_PATHS_RELEASE )


set(luabridge_INCLUDE_DIRS_RELEASE "${luabridge_PACKAGE_FOLDER_RELEASE}/include")
set(luabridge_RES_DIRS_RELEASE )
set(luabridge_DEFINITIONS_RELEASE )
set(luabridge_SHARED_LINK_FLAGS_RELEASE )
set(luabridge_EXE_LINK_FLAGS_RELEASE )
set(luabridge_OBJECTS_RELEASE )
set(luabridge_COMPILE_DEFINITIONS_RELEASE )
set(luabridge_COMPILE_OPTIONS_C_RELEASE )
set(luabridge_COMPILE_OPTIONS_CXX_RELEASE )
set(luabridge_LIB_DIRS_RELEASE )
set(luabridge_BIN_DIRS_RELEASE )
set(luabridge_LIBRARY_TYPE_RELEASE UNKNOWN)
set(luabridge_IS_HOST_WINDOWS_RELEASE 0)
set(luabridge_LIBS_RELEASE )
set(luabridge_SYSTEM_LIBS_RELEASE )
set(luabridge_FRAMEWORK_DIRS_RELEASE )
set(luabridge_FRAMEWORKS_RELEASE )
set(luabridge_BUILD_DIRS_RELEASE )
set(luabridge_NO_SONAME_MODE_RELEASE FALSE)


# COMPOUND VARIABLES
set(luabridge_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${luabridge_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${luabridge_COMPILE_OPTIONS_C_RELEASE}>")
set(luabridge_LINKER_FLAGS_RELEASE
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${luabridge_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${luabridge_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${luabridge_EXE_LINK_FLAGS_RELEASE}>")


set(luabridge_COMPONENTS_RELEASE )