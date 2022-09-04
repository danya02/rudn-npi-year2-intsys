#ifndef GRAPH_NODE_H
#define GRAPH_NODE_H
#include<ostream>
namespace lab1 {
    class GraphNode {
        public:
        virtual char type()=0;
        virtual bool operator==(const GraphNode&) const=0;
        virtual bool operator!=(const GraphNode&) const=0;
        virtual ~GraphNode() {}
        friend std::ostream& operator<<(std::ostream& os, const GraphNode& node);


    };
};
#endif