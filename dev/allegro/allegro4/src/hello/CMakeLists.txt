cmake_minimum_required(VERSION 3.30)


project(hello C)

# if using valgrind, set BUILD_WITH_ASAN to OFF
option(BUILD_WITH_ASAN "Build with ASAN" OFF)

# find_package(Allegro CONFIG REQUIRED)

find_package(PkgConfig REQUIRED)
pkg_check_modules(allegro REQUIRED allegro)


set(target hello)
add_executable(${target} main.c)
target_compile_features(${target} PRIVATE c_std_23)
if(BUILD_WITH_ASAN)
    target_compile_options(${target} PRIVATE -fsanitize=address)
    target_link_options(${target} PRIVATE -fsanitize=address)
endif()
# target_link_libraries(${target} PRIVATE Allegro::allegro Allegro::allegro_ttf Allegro::allegro_font Allegro::allegro_main)
target_link_libraries(${target} PRIVATE alleg)

# valgrind target

add_custom_target(valgrind
    COMMAND valgrind
        --leak-check=full
        --show-leak-kinds=all
        --track-origins=yes
        -s --suppressions=${CMAKE_SOURCE_DIR}/hello.valgrind.supp
        --gen-suppressions=all
        --log-file=${CMAKE_SOURCE_DIR}/logs/memcheck.log
        $<TARGET_FILE:${target}>
    DEPENDS ${target}
    WORKING_DIRECTORY $<TARGET_FILE_DIR:${target}>
    COMMENT "Running hello with valgrind"
)
