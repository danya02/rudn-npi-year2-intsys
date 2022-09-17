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
        int width;
        int height;
        int connections;
        int metrictype; //0=euclidean, 1=manhattan, 2=octile
        double hweight;
        public:
        GraphNode start_node;
        GraphNode end_node;

        GraphAccessor(const std::string& filename);

        ~GraphAccessor();

        private:
        std::vector<GraphNode*> allocated_nodes;
        GraphNode& get_node_by_id(int i, int j);

        int get_meta_int(std::string meta_key) const;
        std::string get_meta_str(std::string meta_key) const;

        public:
        GraphNode& get_start_node();
        GraphNode& get_end_node();

        void get_neighbors(const GraphNode& node, std::vector<GraphNeighbor>& neighbors);
        private:
        void get_neighbors_4(const GraphNode& node, std::vector<GraphNeighbor>& neighbors);
        void get_neighbors_8(const GraphNode& node, std::vector<GraphNeighbor>& neighbors);

        public:
        unsigned int get_distance_to(const GraphNode& node) const ;

        void set_distance_to(const GraphNode& node, unsigned int dist);

        GraphNode* get_previous_node(const GraphNode& node);

        void set_previous_node(const GraphNode& node, const GraphNode& prev);
        void set_node_as_open(const GraphNode& node);
        void set_node_as_closed(const GraphNode& node);

        private:
        void prepare_functions_for_db();
    
        public:
        GraphNode* get_first_open_node();
        GraphNode* get_open_node_with_lowest_value();

    };
    void heuristic_function(sqlite3_context *context, int argc, sqlite3_value **argv);

}
#endif