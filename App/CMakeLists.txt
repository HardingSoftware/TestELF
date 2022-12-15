cmake_minimum_required(VERSION 3.6.0 FATAL_ERROR)

add_executable(TestELF main.cpp)

target_link_libraries(TestELF PRIVATE SDK1 SDK2 SDK3)
