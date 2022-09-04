#ifndef GRAPH_NODE_SQLITE_H
#define GRAPH_NODE_SQLITE_H
#include<ostream>
namespace lab1
{
    class GraphNode
    {
        private:
        int id;

        public:
        bool operator==(const GraphNode& other) const {
            return id == other.id;
        }
        bool operator!=(const GraphNode& other) const { return !(operator==(other));}
        ~GraphNode() {}

        friend std::ostream& operator<<(std::ostream& os, const GraphNode& node){
            os << "GraphNode(" << node.id << ")";
            return os;
        }



        friend class GraphAccessor;
    };

} // namespace lab1
#endif // GRAPH_NODE_SQLITE_H