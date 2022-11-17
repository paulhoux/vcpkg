# Prefer static linking for now.
#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO paulhoux/Cinder
    REF 26d07db12d02a6306a2f7b7ba212fdd0c2f2b237 # latest master with cmake fixes
    SHA512 4994d7b1085709c080f0a7e0239929f4b77619248a29153d62b412e72f2129faba31ec7e0e5930bce7ba4f628d5dcf133ee004ebc387f254c7e87d0705f38f91
    HEAD_REF master
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" BUILD_SHARED)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS -DBUILD_SHARED_LIBS=${BUILD_SHARED}
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/cinder )

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_copy_pdbs()

file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright )
