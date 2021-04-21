hybrid_cuda:
	nvcc adv_sync.cu -o hybrid_cuda -O3 -arch=sm_20  -Xcompiler -O3  -Xcompiler  -fopenmp
hybrid_cpu:
	export OMP_PLACES=cores
	g++ hybrid-prefix2.cpp -fopenmp -O3 -std=c++11 -o hybrid_cpu -mavx -mavx2
ercu:	
	nvcc ercu.cu -o ercuercu -arch=sm_20  -Xcompiler -O3  -Xcompiler  -fopenmp
