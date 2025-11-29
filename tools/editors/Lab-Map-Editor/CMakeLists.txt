cmake_minimum_required(VERSION 3.30)


project(Lab-Map-Editor CXX)

# if using valgrind, set BUILD_WITH_ASAN to OFF
option(BUILD_WITH_ASAN "Build with ASAN" ON)

# find_package(Allegro CONFIG REQUIRED)

find_package(PkgConfig REQUIRED)
pkg_check_modules(allegro REQUIRED allegro)


set(LOADPNG_DIR "$ENV{VVVVVV_ROOT}/third_party/loadpng")
add_subdirectory(${LOADPNG_DIR} ${CMAKE_CURRENT_BINARY_DIR}/loadpng)

set(target Lab-Map-Editor)
set(SRC_DIR "../Lab Map Editor")
add_executable(${target} ${SRC_DIR}/main.cpp)
target_compile_features(${target} PRIVATE cxx_std_23)
if(BUILD_WITH_ASAN)
    target_compile_options(${target} PRIVATE -fsanitize=address)
    target_link_options(${target} PRIVATE -fsanitize=address)
endif()
# target_link_libraries(${target} PRIVATE Allegro::allegro Allegro::allegro_ttf Allegro::allegro_font Allegro::allegro_main)
target_link_libraries(${target} PRIVATE alleg)
target_link_libraries(${target} PRIVATE loadpng)


# valgrind target

add_custom_target(valgrind
    COMMAND valgrind
        --leak-check=full
        --show-leak-kinds=all
        --track-origins=yes
        -s --suppressions=${CMAKE_SOURCE_DIR}/Lab-Map-Editor.valgrind.supp
        --gen-suppressions=all
        --log-file=$ENV{VVVVVV_ROOT}/dev/logs/memcheck.log
        $<TARGET_FILE:${target}>
    DEPENDS ${target}
    WORKING_DIRECTORY $<TARGET_FILE_DIR:${target}>
    COMMENT "Running Lab-Map-Editor with valgrind"
)
