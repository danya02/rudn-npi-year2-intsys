#ifndef GRAPH_ACCESSOR_SQLITE_H
#define GRAPH_ACCESSOR_SQLITE_H
#include<string>
#include<sqlite3.h>
#include "graph_node.h"
#include "neighbor_struct.cpp"
#include<vector>

namespace lab1 {

    class GraphAccessor {
        private:
        sqlite3* connection;
        public:
        GraphAccessor(const std::string& filename);

        ~GraphAccessor();

        private:
        std::vector<GraphNode*> allocated_nodes;
        GraphNode& get_node_by_id(int id);

        int get_meta_int(std::string meta_key) const;

        public:
        GraphNode& get_start_node();
        GraphNode& get_end_node();

        void get_neighbors(const GraphNode& node, std::vector<GraphNeighbor>& neighbors);

        unsigned int get_distance_to(const GraphNode& node) const ;

        void set_distance_to(const GraphNode& node, unsigned int dist);

        GraphNode* get_previous_node(const GraphNode& node);

        void set_previous_node(const GraphNode& node, const GraphNode& prev);
        void set_node_as_open(const GraphNode& node);
        void set_node_as_closed(const GraphNode& node);

        GraphNode* get_least_dist_open_node();

    };
}
#endif