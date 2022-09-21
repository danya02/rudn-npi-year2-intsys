#include "graph_accessor.h"
#include "graph_node.h"
#include<vector>
#include<iostream>
#include "neighbor_struct.cpp"
#include "graph_node.h"
#include "graph_accessor.h"
#include "debug.h"

namespace lab1 {
    void expand_node(GraphAccessor& g, GraphNode node){
        std::vector<GraphNeighbor> neighbors;
        g.get_neighbors(node, neighbors);
        DEBUG_MSG("Expanding node " << node);
        for(auto neighbor: neighbors){
            DEBUG_MSG("Neighbor: " << neighbor.node);
        }
        double dist_to_here = g.get_distance_to(node);
        for(auto p = neighbors.begin(); p!=neighbors.end(); p++){
            DEBUG_MSG("Distance to neighbor " << p->node << " without going through " << node << ": " << g.get_distance_to(p->node));
            DEBUG_MSG("Distance to neighbor " << p->node << " going through " << node << ": " << dist_to_here + p->distance);
            if((dist_to_here + p->distance) < g.get_distance_to(p->node)){
                g.set_distance_to(p->node, dist_to_here+p->distance);
                g.set_previous_node(p->node, node);
                g.set_node_as_open(p->node);
            }
        }
        g.set_node_as_closed(node);
    }


    unsigned long long run_astar_search(GraphAccessor& g) {
        // Run the Dijkstra/A* algorithm on the given graph
        // The graph accessor must be initialized: the start node must be in the OPEN list,
        // the distances must be unset (except for the start node, to which the distance should be 0), and the previous nodes must be unset.
        
        unsigned long long expansions = 0;

        GraphNode next_to_expand = g.get_open_node_with_lowest_value();
        while(g.has_open_nodes()){
            DEBUG_MSG("Expanding node " << next_to_expand);
            expand_node(g, next_to_expand);
            expansions++;
            next_to_expand = g.get_open_node_with_lowest_value();
        }
        return expansions;
    }

    unsigned long long run_bfs(GraphAccessor& g) {
        // Run the BFS algorithm on the given graph
        // The graph accessor must be initialized: the start node must be in the OPEN list,
        // the distances must be unset (except for the start node, to which the distance should be 0), and the previous nodes must be unset.
        //
        // Is identical to run_astar_search, except for the method used to get the next node to expand.
        unsigned long long expansions = 0;

        GraphNode next_to_expand = g.get_first_open_node();
        while(g.has_open_nodes()){
            DEBUG_MSG("Expanding node " << next_to_expand);
            expand_node(g, next_to_expand);
            expansions++;
            next_to_expand = g.get_first_open_node();
        }
        return expansions;
    }


    void reconstruct_path(GraphAccessor& g, GraphNode end_node, std::vector<GraphNode>& save_to){
        // Construct a path from the values saved by an invocation of a search algorithm
        // The path will be reversed, with the first element being end_node and the last element being g.get_start_node()
        // The graph accessor must have had a search algorithm run on it, and end_node must be in the CLOSED list.

        save_to.clear();
        save_to.push_back(end_node);
        GraphNode cur_node = end_node;
        GraphNode start_node = g.get_start_node();
        DEBUG_MSG("Reconstructing path from " << cur_node);
        DEBUG_MSG("Its previous: " << g.get_previous_node(cur_node));
        while (g.get_previous_node(cur_node)){
            cur_node = *g.get_previous_node(cur_node);
            DEBUG_MSG("Next: " << cur_node);
            DEBUG_MSG("Its previous: " << g.get_previous_node(cur_node));
            save_to.push_back(cur_node);
        }
    }
}