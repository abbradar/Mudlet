# Locate HUNSPELL library
# This module defines
#  HUNSPELL_FOUND, if false, do not try to link to HUNSPELL 
#  HUNSPELL_LIBRARIES
#  HUNSPELL_INCLUDE_DIR, where to find hunspell/*.h 


FIND_PATH(HUNSPELL_INCLUDE_DIR hunspell/hunspell.h
  HINTS
  ${HUNSPELL_DIR} $ENV{HUNSPELL_DIR}
  PATH_SUFFIXES include
  PATHS
  ~/Library/Frameworks
  /Library/Frameworks
  /usr/local
  /usr
  /sw # Fink
  /opt/local # DarwinPorts
  /opt/csw # Blastwave
  /opt
)

FIND_LIBRARY(HUNSPELL_LIBRARY_RELEASE 
  NAMES hunspell libhunspell hunspell-1.7 hunspell-1.6 hunspell-1.5 hunspell-1.4 hunspell-1.3
  HINTS
  ${HUNSPELL_DIR} $ENV{HUNSPELL_DIR}
  PATH_SUFFIXES lib64 lib
  PATHS
  ~/Library/Frameworks
  /Library/Frameworks
  /usr/local
  /usr
  /sw
  /opt/local
  /opt/csw
  /opt
)

FIND_LIBRARY(HUNSPELL_LIBRARY_DEBUG 
  NAMES hunspelld libhunspelld hunspelld-1.7 hunspelld-1.6 hunspelld-1.5 hunspelld-1.4 hunspelld-1.3
  HINTS
  ${HUNSPELL_DIR} $ENV{HUNSPELL_DIR}
  PATH_SUFFIXES lib64 lib
  PATHS
  ~/Library/Frameworks
  /Library/Frameworks
  /usr/local
  /usr
  /sw
  /opt/local
  /opt/csw
  /opt
)

IF(HUNSPELL_LIBRARY_DEBUG AND HUNSPELL_LIBRARY_RELEASE)
  SET(HUNSPELL_LIBRARY optimized ${HUNSPELL_LIBRARY_RELEASE} debug ${HUNSPELL_LIBRARY_DEBUG} )
ELSEIF(HUNSPELL_LIBRARY_RELEASE)
  SET(HUNSPELL_LIBRARY ${HUNSPELL_LIBRARY_RELEASE} )
ELSEIF(HUNSPELL_LIBRARY_DEBUG)
  SET(HUNSPELL_LIBRARY ${HUNSPELL_LIBRARY_DEBUG} )
ENDIF()

SET( HUNSPELL_STATIC OFF CACHE BOOL "Use HUNSPELL static libraries.")

IF(HUNSPELL_STATIC)
  ADD_DEFINITIONS(-DHUNSPELL_STATIC)
ENDIF(HUNSPELL_STATIC)

SET( HUNSPELL_LIBRARIES "${HUNSPELL_LIBRARY}" CACHE STRING "HUNSPELL Libraries")

INCLUDE(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set HUNSPELL_FOUND to TRUE if 
# all listed variables are TRUE
FIND_PACKAGE_HANDLE_STANDARD_ARGS(HUNSPELL  DEFAULT_MSG  HUNSPELL_LIBRARIES HUNSPELL_INCLUDE_DIR)

MARK_AS_ADVANCED(HUNSPELL_INCLUDE_DIR HUNSPELL_LIBRARIES HUNSPELL_LIBRARY HUNSPELL_LIBRARY_RELEASE HUNSPELL_LIBRARY_DEBUG)
