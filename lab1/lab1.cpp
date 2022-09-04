#include<iostream>
#include "graph_accessor.h"
#include "dijkstra.h"
#include "debug.h"


using namespace lab1;

int main(){
    DEBUG_MSG("Opening database...");
    GraphAccessor g("test.db");
    DEBUG_MSG("Initializing database...");
    g.set_distance_to(g.get_start_node(), 0);
    g.set_node_as_open(g.get_start_node());
    DEBUG_MSG("Running search...");
    run_dijkstra(g);
    DEBUG_MSG("Constructing path...");
    std::vector<GraphNode> path;
    reconstruct_path(g, g.get_end_node(), path);
    for(auto p = path.rbegin(); p!=path.rend(); p++){
        std::cout << *p << std::endl;
    }


    return 0;

}