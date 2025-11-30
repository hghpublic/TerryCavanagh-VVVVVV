#-----------------------------------------------------------------------------#
#
# loadpng
#

cmake_minimum_required(VERSION 3.30)

project(loadpng C)

find_package(PNG REQUIRED)

set(LOADPNG_SOURCES
    loadpng.c
    savepng.c
    regpng.c
    )

set(LOADPNG_HEADERS
    loadpng.h
    )

set(target loadpng)
add_library(${target} SHARED)
target_sources(${target} PRIVATE
    ${LOADPNG_SOURCES}
    ${LOADPNG_HEADERS}
    )
# target_include_directories(${target} PRIVATE ${PNG_INCLUDE_DIRS})
target_link_libraries(${target} PRIVATE PNG::PNG)
target_include_directories(${target} INTERFACE ${CMAKE_CURRENT_LIST_DIR})





# target_link_libraries(loadpng allegro ${PNG_LIBRARIES})


