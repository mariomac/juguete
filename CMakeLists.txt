# -*- mode:cmake -*-
cmake_minimum_required(VERSION 3.9)
set (CMAKE_CXX_STANDARD 11)

if(NOT UNIX)
    message(WARNING "Unsupported operating system")
endif()

find_library(ANTLR4_LIB antlr4-runtime)
message(${ANTLR4_LIB})
find_path(ANTLR4_INCLUDE antlr4-runtime )

# TODO: set if not present in env
if (NOT DEFINED(ANTLR_JAR_LOCATION))
    message(WARNING " Set ANTLR_JAR_LOCATION env var to the antlr-x.x.x-complete.jar location")
    set(ANTLR_JAR_LOCATION /usr/local/Cellar/antlr/4.7.1/antlr-4.7.1-complete.jar)
endif()

set(antlr4-demo-GENERATED_SRC
        ${PROJECT_SOURCE_DIR}/gen/GramaticaBaseListener.cpp
        ${PROJECT_SOURCE_DIR}/gen/GramaticaParser.cpp
        ${PROJECT_SOURCE_DIR}/gen/GramaticaLexer.cpp
        ${PROJECT_SOURCE_DIR}/gen/GramaticaListener.cpp
        )

foreach( src_file ${antlr4-demo-GENERATED_SRC} )
    set_source_files_properties(
            ${src_file}
            PROPERTIES
            GENERATED TRUE
    )
endforeach( src_file ${antlr4-demo-GENERATED_SRC} )

add_custom_target(GenerateParser DEPENDS ${antlr4-demo-GENERATED_SRC})
add_custom_command(OUTPUT ${antlr4-demo-GENERATED_SRC}
        COMMAND
        ${CMAKE_COMMAND} -E make_directory ${PROJECT_SOURCE_DIR}/gen/
        COMMAND
        "${Java_JAVA_EXECUTABLE}" -jar ${ANTLR_JAR_LOCATION} -Werror -Dlanguage=Cpp -listener -visitor -o ${PROJECT_SOURCE_DIR}/gen/ ${PROJECT_SOURCE_DIR}/Gramatica.g4
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
        DEPENDS ${PROJECT_SOURCE_DIR}/Gramatica.g4
        )


include_directories(
        ${PROJECT_SOURCE_DIR}/gen
        ${ANTLR4_INCLUDE}/antlr4-runtime
)

#file(GLOB antlr4-demo_SRC "${PROJECT_SOURCE_DIR}/gen/*")
set(antlr4-demo_SRC
        src/main.cpp
        ${antlr4-demo-GENERATED_SRC}
        src/Var.cpp src/Var.h)

if (NOT CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    set (flags_1 "-Wno-overloaded-virtual")
else()
    set (flags_1 "-MP /wd4251")
endif()

foreach( src_file ${antlr4-demo_SRC} )
    set_source_files_properties(
            ${src_file}
            PROPERTIES
            COMPILE_FLAGS "${COMPILE_FLAGS} ${flags_1}"
    )
endforeach( src_file ${antlr4-demo_SRC} )

add_executable(antlr4-demo
        ${antlr4-demo_SRC}
        )
#add_precompiled_header(antlr4-demo ${PROJECT_SOURCE_DIR}/runtime/src/antlrcpp-Prefix.h)

if (CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    target_compile_options(antlr4-demo PRIVATE "/MT$<$<CONFIG:Debug>:d>")
endif()

add_dependencies(antlr4-demo GenerateParser)

target_link_libraries(antlr4-demo ${ANTLR4_LIB})

install(TARGETS antlr4-demo
        DESTINATION "share"
        COMPONENT dev
        )
