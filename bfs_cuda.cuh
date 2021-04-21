#ifndef BFS_CUDA_H
#define BFS_CUDA_H

struct Node {
	int start;
	int no_of_edges;
};

// Assertion to check for errors
#define CUDA_SAFE_CALL(ans) { gpuAssert((ans), __FILE__, __LINE__); }
inline void gpuAssert(cudaError_t code, char *file, int line, bool abort=true) {
  if (code != cudaSuccess) 
  {
    fprintf(stderr,"CUDA_SAFE_CALL: %s %s %d\n", cudaGetErrorString(code), file, line);
    if (abort) exit(code);
  }
}

__global__ void Kernel( Node* g_graph, int *g_edge, bool* g_graph_mask, bool* g_updating_graph_mask, bool *g_graph_visited ) {
	int tid = blockIdx.x*MAX_THREADS_PER_BLOCK + threadIdx.x;
	if( tid < VERTICES && g_graph_mask[tid]) {
		g_graph_mask[tid]=false;
		// cuPrintf("now visiting%d, %d\n", tid, g_graph[tid].start);
		for(int i=g_graph[tid].start; i<(g_graph[tid].no_of_edges+g_graph[tid].start); i++) {
			int id = g_edge[i];
			if(!g_graph_visited[id]) {
				//cuPrintf("branches %d,", id);
				g_updating_graph_mask[id]=true;
			}
		}
		//cuPrintf("\n");
	}
}

__global__ void Kernel2( bool* g_graph_mask, bool *g_updating_graph_mask, bool* g_graph_visited, bool *g_over ) {
	int tid = blockIdx.x*MAX_THREADS_PER_BLOCK + threadIdx.x;
	if( tid<VERTICES && g_updating_graph_mask[tid]) {
		g_graph_mask[tid]=true;
		g_graph_visited[tid]=true;
		*g_over=true;
		//cuPrintf("visting branches in kernal2 %d,", tid);
		g_updating_graph_mask[tid]=false;
	}
}

void bfs(Node* graph_nodes, int* graph_edge, int vertex, bool* visited);

#endif