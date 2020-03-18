#include <string>
#include <iostream>

extern "C"
{
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
}

#include <LuaBridge/LuaBridge.h>

namespace moon
{

int global_number;
std::string global_string;

class Class
{
public:
	Class(std::string name) : _name(name) {} 

	std::string name() const { return _name; }
	void name(std::string name) { _name = name; }

	std::string eman() const { return std::string(name().rbegin(), name().rend()); }

private:
	std::string _name;
};

}

int main()
{
	lua_State * const L = lua_open();
	luaL_openlibs(L);

    luabridge::getGlobalNamespace(L)
        .beginNamespace ("moon")
        	.addProperty("global_number", &moon::global_number)
        	.addProperty("global_string", &moon::global_string)
            .beginClass<moon::Class>("Class")
                .addConstructor<void (*)(std::string)>()
                .addProperty("name"
                	, 	(std::string (moon::Class::*)() const) &moon::Class::name
                	,	(void (moon::Class::*)(std::string)) &moon::Class::name
                	)
                .addFunction("eman", &moon::Class::eman)
            .endClass()
        .endNamespace();

	lua_close (L);
	return 0;
}
