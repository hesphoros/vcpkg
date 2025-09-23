vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO hesphoros/UniConv
    REF "v${VERSION}"
    SHA512 68a55e4ff3749750cbe1d0276dd63decdc14b3d3f4b189783895767126cf917d3ef8f55137908863cd52184c4b669298384178a94cbb9b7f9aa054378bc92fbd
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DUNICONV_BUILD_TESTS=OFF
)

vcpkg_cmake_install()

# Fix absolute paths in generated config.h
if(EXISTS "${CURRENT_PACKAGES_DIR}/include/UniConv/iconv/config.h")
    vcpkg_replace_string(
        "${CURRENT_PACKAGES_DIR}/include/UniConv/iconv/config.h"
        "# define INSTALLPREFIX \"${CURRENT_PACKAGES_DIR}\""
        "# define INSTALLPREFIX NULL"
    )
endif()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/UniConv)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")