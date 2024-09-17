script_folder="/home/Timur/luabridge_conan/test_package/build/gcc-14-x86_64-gnu17-release/generators"
echo "echo Restoring environment" > "$script_folder/deactivate_conanrunenv-release-x86_64.sh"
for v in LD_LIBRARY_PATH DYLD_LIBRARY_PATH
do
    is_defined="true"
    value=$(printenv $v) || is_defined="" || true
    if [ -n "$value" ] || [ -n "$is_defined" ]
    then
        echo export "$v='$value'" >> "$script_folder/deactivate_conanrunenv-release-x86_64.sh"
    else
        echo unset $v >> "$script_folder/deactivate_conanrunenv-release-x86_64.sh"
    fi
done


export LD_LIBRARY_PATH="/home/Timur/.conan2/p/b/lua89182da1bdee3/p/lib:$LD_LIBRARY_PATH"
export DYLD_LIBRARY_PATH="/home/Timur/.conan2/p/b/lua89182da1bdee3/p/lib:$DYLD_LIBRARY_PATH"