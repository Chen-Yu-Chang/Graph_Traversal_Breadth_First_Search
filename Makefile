CXX = g++
all: graphMaker main

graphMaker: graphMaker.cpp
	g++ -std=c++11 graphMaker.cpp -o graphMaker

main: main.cu
	nvcc -std=c++11 main.cu -o main -arch=sm_35 -D_FORCE_INLINES

clean:
	rm *.o main script graphMaker
