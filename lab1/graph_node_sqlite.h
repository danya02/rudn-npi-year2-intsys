#ifndef GRAPH_NODE_SQLITE_H
#define GRAPH_NODE_SQLITE_H
#include "graph_node.h"
#include<ostream>
namespace lab1
{
    class GraphNodeSqlite : public GraphNode
    {
        private:
        int id;

        public:
        char type() {return 's';}
        bool operator==(const GraphNode& other) const {
            const GraphNode* other_ptr = &other;
            const GraphNodeSqlite* other_cast = dynamic_cast<const GraphNodeSqlite*>(other_ptr);
            if (other_cast == nullptr){ throw "Tried to compare different GraphNodes!"; }
            return other_cast->id == id;

        }
        bool operator!=(const GraphNode& other) const { return !(operator==(other));}
        ~GraphNodeSqlite() {}

        friend std::ostream& operator<<(std::ostream& os, const GraphNodeSqlite& node){
            os << "GraphNodeSqlite(" << node.id << ")";
            return os;
        }



        friend class GraphAccessorSqlite;
    };

} // namespace lab1
#endif // GRAPH_NODE_SQLITE_H