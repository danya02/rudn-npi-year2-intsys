#ifndef DJIKSTRA_H
#define DJIKSTRA_H
#include "graph_accessor.h"
#include "graph_node.h"
#include<vector>
#include "neighbor_struct.cpp"

namespace lab1{
    void expand_node(GraphAccessor& g, GraphNode& node);
    unsigned long long run_astar_search(GraphAccessor& g);
    unsigned long long run_bfs(GraphAccessor& g);
    void reconstruct_path(GraphAccessor& g, GraphNode end_node, std::vector<GraphNode>& save_to);
}
#endif