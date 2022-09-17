#ifndef GRAPH_NODE_SQLITE_H
#define GRAPH_NODE_SQLITE_H
#include<ostream>
namespace lab1
{
    class GraphNode
    {
        private:
        int i;
        int j;

        public:
        bool operator==(const GraphNode& other) const {
            return i == other.i && j == other.j;
        }
        bool operator!=(const GraphNode& other) const { return !(operator==(other));}
        ~GraphNode() {}

        friend std::ostream& operator<<(std::ostream& os, const GraphNode& node){
            os << "GraphNode(" << node.i << ',' << node.j << ")";
            return os;
        }



        friend class GraphAccessor;
    };

} // namespace lab1
#endif // GRAPH_NODE_SQLITE_H