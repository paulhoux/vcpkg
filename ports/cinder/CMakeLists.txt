CMAKE_MINIMUM_REQUIRED(VERSION 3.10 FATAL_ERROR)

# vcpkg-specific CMakeLists.txt, based on Cinder's own version in the root of its repository.

project( cinder VERSION 0.9.2 DESCRIPTION "Cinder is a peer-reviewed, free, open source C++ library for creative coding." )

set(INSTALL_BIN_DIR "${CMAKE_INSTALL_PREFIX}/bin" CACHE PATH "Installation directory for executables")
set(INSTALL_LIB_DIR "${CMAKE_INSTALL_PREFIX}/lib" CACHE PATH "Installation directory for libraries")
set(INSTALL_INC_DIR "${CMAKE_INSTALL_PREFIX}/include" CACHE PATH "Installation directory for headers")

set( CINDER_PATH      "${CMAKE_CURRENT_SOURCE_DIR}" )
set( CINDER_CMAKE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/proj/cmake" )

include( ${CINDER_CMAKE_DIR}/configure.cmake )
include( ${CINDER_CMAKE_DIR}/libcinder_configure.cmake )
include( ${CINDER_CMAKE_DIR}/libcinder_source_files.cmake )

# TODO: add support for Android, MacOS and Linux
if( CINDER_MSW )
	include( "${CINDER_CMAKE_DIR}/platform_msw.cmake" )
#elseif( CINDER_LINUX )
#	include( "${CINDER_CMAKE_DIR}/platform_linux.cmake" )
#elseif( CINDER_MAC )
#	include( "${CINDER_CMAKE_DIR}/platform_macosx.cmake" )
#elseif( CINDER_ANDROID )
#	include( "${CINDER_CMAKE_DIR}/platform_android.cmake" )
else()
	message( FATAL_ERROR "no target defined for system: '${CMAKE_SYSTEM_NAME}.'" )
endif()

include( ${CINDER_CMAKE_DIR}/libcinder_target.cmake )

# 
include(CMakePackageConfigHelpers)

# Install the targets.
install(TARGETS cinder
		EXPORT cinderTargets
		RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
		LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
		ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
		FRAMEWORK DESTINATION ${CMAKE_INSTALL_PREFIX}
		PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cinder
)
install(EXPORT cinderTargets
		FILE cinder-targets.cmake
		DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/cinder"
)

# Install all the public include files while keeping the directory structure intact.
install( FILES ${INC_SET_CINDER} DESTINATION "${INSTALL_INC_DIR}/cinder" )
install( FILES ${INC_SET_CINDER_APP} DESTINATION "${INSTALL_INC_DIR}/cinder/app" )
if( NOT CINDER_DISABLE_AUDIO )
	install( FILES ${INC_SET_CINDER_AUDIO} DESTINATION "${INSTALL_INC_DIR}/cinder/audio" )
	install( FILES ${INC_SET_CINDER_AUDIO_DSP} DESTINATION "${INSTALL_INC_DIR}/cinder/audio/dsp" )
endif()
install( FILES ${INC_SET_CINDER_GL} DESTINATION "${INSTALL_INC_DIR}/cinder/gl" )
install( FILES ${INC_SET_CINDER_GL_NV} DESTINATION "${INSTALL_INC_DIR}/cinder/gl/nv" )
install( FILES ${INC_SET_CINDER_IP} DESTINATION "${INSTALL_INC_DIR}/cinder/ip" )
install( FILES ${INC_SET_CINDER_SVG} DESTINATION "${INSTALL_INC_DIR}/cinder/svg" )
if( CINDER_ANTTWEAKBAR_ENABLED )
	install( FILES ${INC_SET_CINDER_PARAMS} DESTINATION "${INSTALL_INC_DIR}/cinder/params" )
endif()

if( CINDER_MSW )
	install( FILES ${INC_SET} DESTINATION "${INSTALL_INC_DIR}/cinder" )
	install( FILES ${INC_SET_MSW} DESTINATION "${INSTALL_INC_DIR}/cinder/msw" )
	install( FILES ${INC_SET_APP_MSW} DESTINATION "${INSTALL_INC_DIR}/cinder/app/msw" )
	if( NOT CINDER_DISABLE_AUDIO )
		install( FILES ${INC_SET_AUDIO_MSW} DESTINATION "${INSTALL_INC_DIR}/cinder/audio/msw" )
	endif()
endif()