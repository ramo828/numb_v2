# proje adı
project(numb_v2)

# minimum cmake sürümü
cmake_minimum_required(VERSION 3.10)
# compile
add_executable(numb numb.cpp sources/mylib.cpp sources/runner.cpp sources/mysql.cpp)
target_compile_options (numb PRIVATE -std=c++11)
target_compile_definitions (numb PRIVATE BOOST_ERROR_CODE_HEADER_ONLY)
target_link_libraries (numb mariadbclientpp)
set(name numb)
set(Numb_v2_VERSION_MAJOR 2)
set(Numb_v2_VERSION_MINOR 0)

include_directories(header/)

message(STATUS "her sey qaydasindadir")

