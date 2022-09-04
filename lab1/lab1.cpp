#include<iostream>
#include "graph_accessor_sqlite.cpp"
#include "dijkstra.h"

using namespace lab1;

int main(){
    GraphAccessorSqlite g("test.db");
    g.set_distance_to(g.get_start_node(), 0);
    g.set_node_as_open(g.get_start_node());
    run_dijkstra((GraphAccessor&) g);
    std::vector<GraphNode*> path;
    reconstruct_path((GraphAccessor&) g, &g.get_end_node(), path);
    for(auto p = path.begin(); p!=path.end(); p++){
        std::cout << *p << std::endl;
    }


    return 0;

}