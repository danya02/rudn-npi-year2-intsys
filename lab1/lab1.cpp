#include<iostream>
#include "graph_accessor.h"
#include "search.h"
#include "debug.h"
#include<x86intrin.h>
#include <sched.h>
#include <sys/time.h>
#include <sys/resource.h> 


using namespace lab1;

int main(int argc, char** argv){

    #ifdef __linux__
    cpu_set_t cpuset;
    DEBUG_MSG("Current CPU affinity:");
    sched_getaffinity(0, sizeof(cpu_set_t), &cpuset);
    for(int i = 0; i < CPU_SETSIZE; i++){
        if(CPU_ISSET(i, &cpuset)){
            DEBUG_MSG("CPU " << i);
        }
    }


    DEBUG_MSG("Binding to CPU 0...");
    CPU_ZERO(&cpuset);
    CPU_SET(0, &cpuset);
    sched_setaffinity(0, sizeof(cpu_set_t), &cpuset);
    DEBUG_MSG("Current CPU affinity:");
    sched_getaffinity(0, sizeof(cpu_set_t), &cpuset);
    for(int i = 0; i < CPU_SETSIZE; i++){
        if(CPU_ISSET(i, &cpuset)){
            DEBUG_MSG("CPU " << i);
        }
    }

    DEBUG_MSG("Trying to escalate priority...");
    int rc = setpriority(PRIO_PROCESS, 0, -20);
    if(rc == 0){
        DEBUG_MSG("Escalated successfully!");
    }else{
        DEBUG_MSG("Escalation failed, errno: " << errno << "; try as root");
    }

    #endif


    DEBUG_MSG("Opening database...");
    std::string file = "maps/instance4.txt";
    GraphAccessor g(file);
    DEBUG_MSG("Initializing database...");
    g.set_distance_to(g.get_start_node(), 0);
    g.set_node_as_open(g.get_start_node());

    // Set algorithm used: If Dijsktra, hweight is 0
    // If BFS, we will call a different search function
    g.hweight = (g.algorithm==0) ? g.hweight : 0;
    DEBUG_MSG("Will run search " << g.algorithm << " with hweight " << g.hweight);

    #ifdef DEBUG
    char foo;
    std::cout << "Type any character and press Enter";
    std::cin >> foo;
    #endif


    // Record start time
    unsigned long long start_time = __rdtsc();
    DEBUG_MSG("Running search...");
    unsigned long long expansions;
    if(g.algorithm != 2){
        expansions = run_astar_search(g);
    } else {
        expansions = run_bfs(g);
    }

    DEBUG_MSG("Constructing path...");
    std::vector<GraphNode> path;
    reconstruct_path(g, g.get_end_node(), path);
    // Record end time
    unsigned long long end_time = __rdtsc();
    std::cout << "Time taken: " << (end_time - start_time) << " cycles" << std::endl;
    std::cout << "Nodes constructed: " << g.nodes_constructed << std::endl;
    std::cout << "Expansions: " << expansions << std::endl;
    std::cout << "Path length: " << g.get_distance_to(g.get_end_node()) << std::endl;
    if(g.closed_nodes.find(g.get_end_node()) == g.closed_nodes.end()){
        std::cerr << "No path found!" << std::endl;
    }


    for(auto p = path.rbegin(); p!=path.rend(); p++){
        std::cout << *p << "; ";
    }
    std::cout << std::endl;

    for(int j=0; j<g.height; j++){
        for(int i=0; i<g.width; i++){
            if(g.get_start_node() == GraphNode(i,j)){
                std::cout << "S";
            } else if(g.get_end_node() == GraphNode(i,j)){
                std::cout << "E";
            } else if(g.is_wall(i,j)){
                std::cout << "X";
            } else if(g.closed_nodes.find(GraphNode(i,j)) != g.closed_nodes.end()){
                std::cout << ".";

            } else {
                bool found = false;
                for(auto p = path.rbegin(); p!=path.rend(); p++){
                    if(*p == GraphNode(i,j)){
                        std::cout << "*";
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


}