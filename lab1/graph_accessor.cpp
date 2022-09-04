#include<string>
#include<sqlite3.h>
#include<iostream>
#include<vector>
#include "graph_node.h"
#include "neighbor_struct.cpp"
#include "graph_accessor.h"
#include "debug.h"


namespace lab1
{
    GraphAccessor::GraphAccessor(const std::string& filename){
        int rc = sqlite3_open(filename.c_str(), &connection);
        if(rc){
            std::cerr << "Can't open database: " << sqlite3_errmsg(connection) << std::endl;
            sqlite3_close(connection);
            exit(1);
        }
        sqlite3_exec(connection, "CREATE TEMPORARY TABLE distances(node_id PRIMARY KEY, dist)", NULL, NULL, NULL);
        sqlite3_exec(connection, "CREATE TEMPORARY TABLE previous(node_id PRIMARY KEY, prev_id)", NULL, NULL, NULL);
        sqlite3_exec(connection, "CREATE TEMPORARY TABLE open_list(node_id PRIMARY KEY)", NULL, NULL, NULL);
        sqlite3_exec(connection, "CREATE TEMPORARY TABLE closed_list(node_id PRIMARY KEY)", NULL, NULL, NULL);

        // For logging SQL statements
        sqlite3_trace_v2(connection, SQLITE_TRACE_STMT, [](unsigned int type, void* user_data, void* stmt, void* p){
            DEBUG_MSG("Executing statement: " << sqlite3_expanded_sql((sqlite3_stmt*)stmt));
            return 0;
        }, NULL);

        // Output current database schema:
        DEBUG_MSG("Database schema is as follows:");
        sqlite3_exec(connection, "SELECT sql FROM sqlite_master", [](void* user_data, int argc, char** argv, char** col_names){
            for(int i = 0; i < argc; i++){
                DEBUG_MSG(col_names[i] << ": " << argv[i]);
            }
            return 0;
        }, NULL, NULL);

        // Output all values in the meta table:
        DEBUG_MSG("Meta table is as follows:");
        sqlite3_exec(connection, "SELECT * FROM meta", [](void* user_data, int argc, char** argv, char** col_names){
            for(int i = 0; i < argc; i++){
                DEBUG_MSG(col_names[i] << ": " << argv[i]);
            }
            return 0;
        }, NULL, NULL);
    }


    GraphAccessor::~GraphAccessor(){
        sqlite3_close(connection);
        for(auto& node : allocated_nodes){
            delete node;
        }
    }

    GraphNode& GraphAccessor::get_node_by_id(int id){
        DEBUG_MSG("Getting node by id: " << id);
        GraphNode* node_ptr = new GraphNode();
        node_ptr->id = id;
        allocated_nodes.push_back(node_ptr);
        return *node_ptr;
    }

    int GraphAccessor::get_meta_int(std::string meta_key) const{
        int id = -1337;
        std::string sql = "SELECT value FROM meta WHERE key = ?";
        sqlite3_stmt* stmt;
        sqlite3_prepare_v2(connection, sql.c_str(), sql.length()+1, &stmt, 0);
        sqlite3_bind_text(stmt, 1, meta_key.c_str(), meta_key.length(), SQLITE_STATIC);
        int rc = sqlite3_step(stmt);
        DEBUG_MSG("Getting meta int: " << meta_key << " with rc: " << rc);
        if(rc == SQLITE_ROW){
            id = sqlite3_column_int(stmt, 0);
        }
        sqlite3_finalize(stmt);
        return id;
    }

    GraphNode& GraphAccessor::get_start_node(){
        return get_node_by_id(get_meta_int("start_node_id"));
    }
    GraphNode& GraphAccessor::get_end_node(){
        return get_node_by_id(get_meta_int("end_node_id"));
    }

    void GraphAccessor::get_neighbors(const GraphNode& node, std::vector<GraphNeighbor>& neighbors){
        std::string sql = "SELECT consequent_id, cost FROM edges WHERE antecedent_id = ?";
        sqlite3_stmt* stmt;
        sqlite3_prepare_v2(connection, sql.c_str(), sql.length()+1, &stmt, 0);
        sqlite3_bind_int(stmt, 1, node.id);
        while(sqlite3_step(stmt) == SQLITE_ROW){
            int consequent_id = sqlite3_column_int(stmt, 0);
            int cost = sqlite3_column_int(stmt, 1);
            neighbors.push_back(GraphNeighbor { .node=get_node_by_id(consequent_id),  .distance=(unsigned int)cost});
        }
        sqlite3_finalize(stmt);
    }

    unsigned int GraphAccessor::get_distance_to(const GraphNode& node) const {
        unsigned int dist = -1;
        sqlite3_stmt *stmt;
        std::string sql = "SELECT dist FROM distances WHERE node_id = ?";
        sqlite3_prepare_v2(connection, sql.c_str(), sql.length()+1, &stmt, 0);
        sqlite3_bind_int(stmt, 1, node.id);
        int rc = sqlite3_step(stmt);
        if(rc == SQLITE_ROW){
            dist = sqlite3_column_int(stmt, 0);
        }
        sqlite3_finalize(stmt);
        return dist;
    }

    void GraphAccessor::set_distance_to(const GraphNode& node, unsigned int dist){
        sqlite3_stmt *stmt;
        std::string sql = "INSERT OR REPLACE INTO distances VALUES(?, ?)";
        sqlite3_prepare_v2(connection, sql.c_str(), sql.length()+1, &stmt, 0);
        sqlite3_bind_int(stmt, 1, node.id);
        sqlite3_bind_int(stmt, 2, dist);
        while (sqlite3_step(stmt) != SQLITE_DONE) {
            // do nothing
        }
        sqlite3_finalize(stmt);
    }

    GraphNode* GraphAccessor::get_previous_node(const GraphNode& node){
        sqlite3_stmt *stmt;
        std::string sql = "SELECT prev_id FROM previous WHERE node_id = ?";
        sqlite3_prepare_v2(connection, sql.c_str(), sql.length()+1, &stmt, 0);
        sqlite3_bind_int(stmt, 1, node.id);
        int rc = sqlite3_step(stmt);
        if(rc == SQLITE_ROW){
            int prev_id = sqlite3_column_int(stmt, 0);
            sqlite3_finalize(stmt);
            GraphNode* prev = new GraphNode;
            *prev = get_node_by_id(prev_id);
            return prev;
        }
        sqlite3_finalize(stmt);
        return nullptr;
    }

    void GraphAccessor::set_previous_node(const GraphNode& node, const GraphNode& prev){
        sqlite3_stmt *stmt;
        std::string sql = "INSERT OR REPLACE INTO previous VALUES(?, ?)";
        sqlite3_prepare_v2(connection, sql.c_str(), sql.length()+1, &stmt, 0);
        sqlite3_bind_int(stmt, 1, node.id);
        sqlite3_bind_int(stmt, 2, prev.id);
        while (sqlite3_step(stmt) != SQLITE_DONE) {
            // do nothing
        }
        sqlite3_finalize(stmt);
    }

    void GraphAccessor::set_node_as_open(const GraphNode& node){
        sqlite3_stmt *stmt;
        std::string sql = "INSERT OR REPLACE INTO open_list VALUES(?)";
        sqlite3_prepare_v2(connection, sql.c_str(), sql.length()+1, &stmt, 0);
        sqlite3_bind_int(stmt, 1, node.id);
        while (sqlite3_step(stmt) != SQLITE_DONE) {
            // do nothing
        }
        sqlite3_finalize(stmt);
    }

    void GraphAccessor::set_node_as_closed(const GraphNode& node){
        sqlite3_stmt *stmt;
        std::string sql = "DELETE FROM open_list WHERE node_id = ?";
        sqlite3_prepare_v2(connection, sql.c_str(), sql.length()+1, &stmt, 0);
        sqlite3_bind_int(stmt, 1, node.id);
        while (sqlite3_step(stmt) != SQLITE_DONE) {
            // do nothing
        }
        sqlite3_finalize(stmt);


        std::string sql2 = "INSERT OR REPLACE INTO closed_list VALUES(?)";
        sqlite3_prepare_v2(connection, sql2.c_str(), sql2.length()+1, &stmt, 0);
        sqlite3_bind_int(stmt, 1, node.id);
        while (sqlite3_step(stmt) != SQLITE_DONE) {
            // do nothing
        }
        sqlite3_finalize(stmt);
    }

    GraphNode* GraphAccessor::get_least_dist_open_node(){
        sqlite3_stmt *stmt;
        std::string sql = "SELECT open_list.node_id FROM open_list JOIN distances ON open_list.node_id=distances.node_id ORDER BY dist ASC LIMIT 1";
        sqlite3_prepare_v2(connection, sql.c_str(), sql.length()+1, &stmt, 0);
        int rc = sqlite3_step(stmt);
        if(rc == SQLITE_ROW){
            int node_id = sqlite3_column_int(stmt, 0);
            sqlite3_finalize(stmt);
            GraphNode* node = new GraphNode;
            *node = get_node_by_id(node_id);
            return node;
        }
        sqlite3_finalize(stmt);
        return nullptr;
    }
} // namespace lab1
