# Prefer static linking for now.
#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO paulhoux/Cinder
    REF e87dd0c707408934a8bb505c66f616750c0f6b1c # latest master with cmake fixes
    SHA512 2cfb2bc617310eac89ba740131a7d4ef8845c0256585b2ece536322e4b619d762bec81783994639d47d3fa753fdd38bfe855b879997f63475cca7400a074ac6b
    HEAD_REF master
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" BUILD_SHARED)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS -DBUILD_SHARED_LIBS=${BUILD_SHARED} -DCINDER_FREETYPE_USE_SYSTEM=ON
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/cinder )

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_copy_pdbs()

file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright )
