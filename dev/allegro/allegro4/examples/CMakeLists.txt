cmake_minimum_required(VERSION 3.30)

project(examples C)

# if using valgrind, set BUILD_WITH_ASAN to OFF
option(BUILD_WITH_ASAN "Build with ASAN" OFF)

# find_package(Allegro CONFIG REQUIRED)

find_package(PkgConfig REQUIRED)
pkg_check_modules(allegro REQUIRED allegro)


set(examples
    ex12bit
    ex3buf
    ex3d
    exaccel
    exalpha
    exbitmap
    exblend
    excamera
    excolmap
    exconfig
    excustom
    exdata
    exdbuf
    exexedat
    exfixed
    exflame
    exflip
    exfont
    exgui
    exhello
    exjoy
    exkeys
    exlights
    exmem
    exmidi
    exmouse
    expackf
    expal
    expat
    exquat
    exrgbhsv
    exrotscl
    exsample
    exsyscur
    exscale
    exscn3d
    exscroll
    exshade
    exspline
    exsprite
    exstars
    exstream
    exswitch
    extimer
    extrans
    extrans2
    extruec
    exunicod
    exupdate
    exxfade
    exzbuf
)

foreach(target ${examples})
add_executable(${target} ${target}.c)
target_compile_features(${target} PRIVATE c_std_23)
if(BUILD_WITH_ASAN)
    target_compile_options(${target} PRIVATE -fsanitize=address)
    target_link_options(${target} PRIVATE -fsanitize=address)
endif()
# target_link_libraries(${target} PRIVATE Allegro::allegro Allegro::allegro_ttf Allegro::allegro_font Allegro::allegro_main)
target_link_libraries(${target} PRIVATE alleg)    
target_link_libraries(${target} PRIVATE m)    
endforeach()


# copy resources

set(resources
    allegro.pcx
    example.dat
    examples.txt
    exconfig.ini
    inkblot.tga
    mysha.pcx
    planet.pcx
    running.dat
    unifont.dat
)

set(target exhello)
foreach(res ${resources})
add_custom_command(
    TARGET ${target} PRE_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
        ${CMAKE_CURRENT_SOURCE_DIR}/${res}
        $<TARGET_FILE_DIR:${target}>
    COMMENT "Copying ${res}"
)
endforeach()

#-----------------------------------------------------------------------------#
# vim: set sts=4 sw=4 et:
