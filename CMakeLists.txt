# proje adı
project(Numb_v2)

# minimum cmake sürümü
cmake_minimum_required(VERSION 3.10)

# çalıştırılabilir dosya (executable) oluşturun
add_executable(numb numb.cpp lib/mylib.cpp)

set(mk [=[
	#!/bin/bash
	echo "Biraz Gozle"
	]=])

set(name Numb)
set(Numb_v2_VERSION_MAJOR 2)
set(Numb_v2_VERSION_MINOR 0)

include_directories(lib/)

execute_process (
	COMMAND bash -c ${mk}
    	OUTPUT_VARIABLE outVar
)
message(WARNING ${pwd})

