# Prefer static linking for now.
#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO paulhoux/Cinder
    REF ec205b680480e884f7cef3721684f66717c77b70 # latest master with cmake fixes
    SHA512 1714e1675d918682c3d2eae936f6c177522740a12802572edb1d5654919e959aeae304faa79890d1afe6f7376e479477da09c15d7f9a0837f42ce3588a2da62b
    HEAD_REF master
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")

if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    set(BUILD_SHARED ON)
else()
    set(BUILD_SHARED OFF)
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}" 
    OPTIONS -DBUILD_SHARED_LIBS=${BUILD_SHARED}
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()
#vcpkg_cmake_config_fixup()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright )
