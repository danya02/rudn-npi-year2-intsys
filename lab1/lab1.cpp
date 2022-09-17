#include<iostream>
#include "graph_accessor.h"
#include "search.h"
#include "debug.h"
#include<x86intrin.h>


using namespace lab1;

int main(int argc, char** argv){
    DEBUG_MSG("Opening database...");
    std::string file = argv[1];
    GraphAccessor g(file);
    DEBUG_MSG("Initializing database...");
    g.set_distance_to(g.get_start_node(), 0);
    g.set_node_as_open(g.get_start_node());
    // Record start time
    unsigned long long start_time = __rdtsc();
    DEBUG_MSG("Running search...");
    unsigned long long expansions = run_astar_search(g);
    DEBUG_MSG("Constructing path...");
    std::vector<GraphNode> path;
    reconstruct_path(g, g.get_end_node(), path);
    // Record end time
    unsigned long long end_time = __rdtsc();
    std::cout << "Time taken: " << (end_time - start_time) << " cycles" << std::endl;
    std::cout << "Nodes constructed: " << g.nodes_constructed << std::endl;
    std::cout << "Expansions: " << expansions << std::endl;
    for(auto p = path.rbegin(); p!=path.rend(); p++){
        std::cout << *p << "; ";
    }

    for(int i=0; i<g.height; i++){
        for(int j=0; j<g.width; j++){
            if(g.is_wall(i, j)){
                std::cout << "X";
            }else {
                bool found = false;
                for(auto p = path.rbegin(); p!=path.rend(); p++){
                    if(p->i == i && p->j == j){
                        std::cout << "O";
                        found = true;
                        break;
                    }
                }
                if(!found){
                    std::cout << " ";
                }
            }
        }
        std::cout << std::endl;
    }
    std::cout << std::endl;


    return 0;

}