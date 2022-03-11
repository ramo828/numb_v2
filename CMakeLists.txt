# proje adı
project(Numb_v2)

# minimum cmake sürümü
cmake_minimum_required(VERSION 2.8)

# çalıştırılabilir dosya (executable) oluşturun
add_executable(numb numb.cpp lib/mylib.cpp)

set(MathSolver_VERSION_MAJOR 2)
set(MathSolver_VERSION_MINOR 0)

include_directories(lib/)

