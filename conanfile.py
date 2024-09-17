from conan import ConanFile, tools
from conan.tools.cmake import CMakeToolchain, CMake, cmake_layout, CMakeDeps
from conan.tools.files import files, get, copy, replace_in_file, collect_libs, rmdir, rm, apply_conandata_patches, export_conandata_patches
from conan.errors import ConanInvalidConfiguration
from conan.tools.apple import fix_apple_shared_install_name
from conan.tools.scm import Version
from conan.tools.build import check_min_cppstd
from conan.tools.microsoft import check_min_vs, is_msvc, is_msvc_static_runtime
import os

required_conan_version = ">=1.53.0"

class LuabridgeConan(ConanFile):
    name = "luabridge"
    version = "2.8"
    license = "MIT"
    author = "xiadnoring, konrad"
    url = "https://github.com/xiadnoring/luabridge-conan"
    description = "LuaBridge is a lightweight and dependency-free library for mapping data, functions, and classes back and forth between C++ and Lua."
    topics = ("lua", "binding", "conan")
    settings = "os", "compiler", "arch", "build_type"
    no_copy_source = True
    options = {}
    default_options = {}

    def source(self):
        get(self, url="https://github.com/vinniefalco/LuaBridge/archive/{}.tar.gz".format(self.version), strip_root=True)

    def package_info(self):
        self.cpp_info.set_property("cmake_find_mode", "both")
        self.cpp_info.set_property("cmake_file_name", "luabridge")
        self.cpp_info.set_property("cmake_target_name", "luabridge::luabridge")
        self.cpp_info.set_property("pkg_config_name", "luabridge")

        self.cpp_info.bindirs = []
        self.cpp_info.libdirs = []

    def requirements(self):
        self.requires("lua/[>5.0.0]")

    def package_id(self):
        self.info.clear()

    def package(self):
        copy(self, "*.h", os.path.join(self.source_folder, "Source"), os.path.join(self.package_folder, "include"), keep_path=True)
