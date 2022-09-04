#include "graph_accessor.h"
#include "graph_node.h"
#include<vector>
#include "neighbor_struct.cpp"
#include "graph_node_sqlite.h"
#include "graph_accessor_sqlite.h"

namespace lab1 {
    void expand_node(GraphAccessorSqlite& g, GraphNodeSqlite& node){
        std::vector<GraphNeighbor> neighbors;
        g.get_neighbors(node, neighbors);
        unsigned int dist_to_here = g.get_distance_to(node);
        for(auto p = neighbors.begin(); p!=neighbors.end(); p++){
            if((dist_to_here + p->distance) > g.get_distance_to(p->node)){
                g.set_distance_to(p->node, dist_to_here+p->distance);
                g.set_previous_node(p->node, node);
                g.set_node_as_open(p->node);
            }
        }
        g.set_node_as_closed(node);
    }


    void run_dijkstra(GraphAccessorSqlite& g) {
        // Run the Dijkstra algorithm on the given graph
        // The graph accessor must be initialized: the start node must be in the OPEN list,
        // the distances must be unset (except for the start node, to which the distance should be 0), and the previous nodes must be unset.
        
        GraphNodeSqlite* next_to_expand = g.get_least_dist_open_node();
        GraphNodeSqlite& next_node = *next_to_expand;
        while(next_to_expand != nullptr){
            next_node = *next_to_expand;
            expand_node(g, next_node);
            next_to_expand = g.get_least_dist_open_node();
        }
    }


    void reconstruct_path(GraphAccessorSqlite& g, GraphNodeSqlite* end_node, std::vector<GraphNodeSqlite*>& save_to){
        // Construct a path from the values saved by an invocation of a search algorithm
        // The path will be reversed, with the first element being end_node and the last element being g.get_start_node()
        // The graph accessor must have had a search algorithm run on it, and end_node must be in the CLOSED list.

        save_to.clear();
        save_to.push_back(end_node);
        GraphNodeSqlite* cur_node = end_node;
        const GraphNodeSqlite& start_node = g.get_start_node();
        while (*cur_node != start_node){
            cur_node = g.get_previous_node(*cur_node);
            save_to.push_back(cur_node);
        }
    }
}