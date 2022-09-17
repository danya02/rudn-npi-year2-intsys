#ifndef GRAPH_NODE_SQLITE_H
#define GRAPH_NODE_SQLITE_H
#include<ostream>
namespace lab1
{
    class GraphNode
    {
        private:
        public:
        GraphNode(int i, int j) : i(i), j(j) {}
        int i;
        int j;


        bool operator==(const GraphNode& other) const {
            return i == other.i && j == other.j;
        }
        bool operator!=(const GraphNode& other) const { return !(operator==(other));}
        ~GraphNode() {}
        GraphNode(const GraphNode& other) : i(other.i), j(other.j) {}
        GraphNode() : i(-1), j(-1) {}

        friend std::ostream& operator<<(std::ostream& os, const GraphNode& node){
            os << "GraphNode(" << node.i << ',' << node.j << ")";
            return os;
        }

        bool operator<(const GraphNode& other) const {
            if (i < other.i) return true;
            if (i > other.i) return false;
            return j < other.j;
        }



        friend class GraphAccessor;
    };

} // namespace lab1
#endif // GRAPH_NODE_SQLITE_H