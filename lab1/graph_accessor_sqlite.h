#ifndef GRAPH_ACCESSOR_SQLITE_H
#define GRAPH_ACCESSOR_SQLITE_H
#include<string>
#include "graph_node_sqlite.h"
#include "neighbor_struct.cpp"
#include<vector>

namespace lab1 {

    class GraphAccessorSqlite {
        public:
        GraphAccessorSqlite(const std::string& filename);  // Opens the specified file
        ~GraphAccessorSqlite();                    // Closes the file

        const GraphNodeSqlite& get_start_node();
        const GraphNodeSqlite& get_end_node();

        void get_neighbors(const GraphNodeSqlite& node, std::vector<GraphNeighbor>& neighbors);

        int get_distance_to(const GraphNodeSqlite& node) const;  // get current g-value for this node
        void set_distance_to(const GraphNodeSqlite& node, int distance); // set current g-value for this node

        const GraphNodeSqlite& get_previous_node(const GraphNodeSqlite& node); // get previous node for this node
        void set_previous_node(const GraphNodeSqlite& node, const GraphNodeSqlite& previous); // set previous node for this node

        void set_node_as_open(const GraphNode& node);
        void set_node_as_closed(const GraphNode& node);  // also unsets node as open
        const GraphNode* get_least_dist_open_node();  // get a node from the open list with the lowest g-value (if open list is empty, returns nullptr)

    };
}
#endif