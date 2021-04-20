CC=/Graph_Traversal_Breadth_First_Search/
CFLAGS=-std=c++11 -Xcompiler -fPIC -O3

bfs: $(wildcard *.cu)
	$(CC) $(CFLAGS) -o bfs bfs_basic.cu

clean:
	rm bfs

