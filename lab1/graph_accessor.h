#include "graph_node.h"
#include<vector>
#include "neighbor_struct.cpp"

namespace lab1
{
    class GraphAccessor{
        public:
            virtual ~GraphAccessor() = 0;

            virtual GraphNode& get_start_node() = 0;
            virtual GraphNode& get_end_node() = 0;

            virtual void get_neighbors(const GraphNode& node, std::vector<GraphNeighbor>& neighbors) = 0;

            virtual unsigned int get_distance_to(const GraphNode& node) = 0;  // get current g-value for this node
            virtual void set_distance_to(const GraphNode& node, unsigned int distance) = 0; // set current g-value for this node

            virtual GraphNode* get_previous_node(const GraphNode& node) = 0; // get previous node for this node (if none, returns nullptr; if some, please free it)
            virtual void set_previous_node(const GraphNode& node, const GraphNode& previous) = 0; // set previous node for this node

            virtual void set_node_as_open(const GraphNode& node) = 0;
            virtual void set_node_as_closed(const GraphNode& node) = 0;  // also unsets node as open
            virtual GraphNode* get_least_dist_open_node() = 0;  // get a node from the open list with the lowest g-value (if open list is empty, returns nullptr)

    };
} // namespace lab1
