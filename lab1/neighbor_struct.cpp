#ifndef NEIGHBOR_STRUCT
#define NEIGHBOR_STRUCT
#include "graph_node.h"
namespace lab1 {
    struct GraphNeighbor {
        GraphNode& node;
        int distance;
    };
}
#endif // NEIGHBOR_STRUCT