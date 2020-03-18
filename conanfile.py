from conans import ConanFile, CMake, tools


class LuabridgeConan(ConanFile):
    name = "luabridge"
    version = "2.4.1"
    license = "MIT"
    author = "konrad"
    url = "https://github.com/KonradNoTantoo/luabridge_conan"
    description = "LuaBridge is a lightweight and dependency-free library for mapping data, functions, and classes back and forth between C++ and Lua."
    topics = ("lua", "binding", "conan")
    settings = "os", "compiler", "arch", "build_type"
    options = {"unit_tests": [True, False]}
    default_options = {"unit_tests": False}
    generators = "cmake"
    no_copy_source = True
    requires = "lua/5.1.5@utopia/testing"
    folder_name = "LuaBridge-{}".format(version)


    def build_requirements(self):
        if self.options.unit_tests:
            self.build_requires("gtest/1.8.1")


    def source(self):
        tools.get("https://github.com/vinniefalco/LuaBridge/archive/{}.tar.gz".format(self.version))
        if self.options.unit_tests:
            tools.replace_in_file("{}/CMakeLists.txt".format(self.folder_name),
                                  "project (LuaBridge)",
                                  '''project (LuaBridge)
include (${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup ()
enable_testing ()''')
            tools.replace_in_file("{}/CMakeLists.txt".format(self.folder_name),
                                  "add_subdirectory (third_party/gtest)",
                                  "# add_subdirectory (third_party/gtest)")

            tools.replace_in_file("{}/Tests/CMakeLists.txt".format(self.folder_name),
                                  "add_executable (${LUABRIDGE_TEST_NAME}",
                                  '''add_test (NAME Run${LUABRIDGE_TEST_NAME} COMMAND ${LUABRIDGE_TEST_NAME})
  add_executable (${LUABRIDGE_TEST_NAME}''')


    def build(self): # this is not building a library, just tests
        if self.options.unit_tests:
            cmake = CMake(self)
            cmake.configure(source_folder=self.folder_name)
            cmake.build()
            cmake.test()


    def package(self):
        self.copy("*.h", dst="include", src="{}/Source".format(self.folder_name), keep_path=True)


    def package_id(self):
        self.info.header_only()
