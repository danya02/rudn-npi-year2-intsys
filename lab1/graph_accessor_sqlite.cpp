#include<string>
#include<sqlite3.h>
#include<iostream>
#include<vector>
#include "graph_node.h"
#include "neighbor_struct.cpp"
#include "graph_accessor.h"
#include "debug.h"
#include<math.h>

#ifdef SQLITE_VAR
namespace lab1
{

    int sqlite3_step_or_error(sqlite3_stmt* stmt){
        int rc = sqlite3_step(stmt);        sqlite3_stmt *stmt;
        std::string sql;
        if(hweight < __FLT_EPSILON__){  // if hweight is 0, then we don't need to use heuristic function
            sql = "SELECT open_list.node_i, open_list.node_j FROM open_list "
            "JOIN distances ON open_list.node_i = distances.node_i AND open_list.node_j = distances.node_j "
            "ORDER BY distances.dist DESC LIMIT 1";
            sqlite3_prepare_v2(connection, sql.c_str(), sql.length()+1, &stmt, 0);
 
        } else {
            sql = "SELECT open_list.node_i, open_list.node_j FROM open_list "
            "JOIN distances ON open_list.node_i = distances.node_i AND open_list.node_j = distances.node_j "
            "ORDER BY distances.dist + (heuristic(open_list.node_i, open_list.node_j, ?, ?)*?) DESC LIMIT 1";
            sqlite3_prepare_v2(connection, sql.c_str(), sql.length()+1, &stmt, 0);
            sqlite3_bind_int(stmt, 1, end_node.i);
            sqlite3_bind_int(stmt, 2, end_node.j);
            sqlite3_bind_double(stmt, 3, hweight);

        }
        int rc = sqlite3_step_or_error(stmt);
        if(rc == SQLITE_ROW){
            int node_i = sqlite3_column_int(stmt, 0);
            int node_j = sqlite3_column_int(stmt, 1);
            sqlite3_finalize(stmt);
            GraphNode* node = new GraphNode;
            *node = get_node_by_id(node_i, node_j);
            return node;
        }
        sqlite3_finalize(stmt);
        return nullptr;

        if(rc != SQLITE_DONE && rc != SQLITE_ROW && rc != SQLITE_OK){
            std::cerr << "Error: " << sqlite3_errstr(rc) << rc << std::endl;
            exit(1);
        }
        return rc;
    }

    GraphAccessor::GraphAccessor(const std::string& filename){
        int rc = sqlite3_open(filename.c_str(), &connection);
        if(rc){
            std::cerr << "Can't open database: " << sqlite3_errmsg(connection) << std::endl;
            sqlite3_close(connection);
            exit(1);
        }
        sqlite3_exec(connection, "CREATE TEMPORARY TABLE distances(node_i, node_j, dist)", NULL, NULL, NULL);
        sqlite3_exec(connection, "CREATE UNIQUE INDEX distances_index ON distances(node_i, node_j)", NULL, NULL, NULL);
        sqlite3_exec(connection, "CREATE TEMPORARY TABLE previous(node_i, node_j, prev_i, prev_j)", NULL, NULL, NULL);
        sqlite3_exec(connection, "CREATE UNIQUE INDEX previous_index ON previous(node_i, node_j)", NULL, NULL, NULL);
        sqlite3_exec(connection, "CREATE TEMPORARY TABLE open_list(node_i, node_j)", NULL, NULL, NULL);
        sqlite3_exec(connection, "CREATE UNIQUE INDEX open_list_index ON open_list(node_i, node_j)", NULL, NULL, NULL);
        sqlite3_exec(connection, "CREATE TEMPORARY TABLE closed_list(node_i, node_j)", NULL, NULL, NULL);
        sqlite3_exec(connection, "CREATE UNIQUE INDEX closed_list_index ON closed_list(node_i, node_j)", NULL, NULL, NULL);

        #ifdef DEBUG
        // For logging SQL statements
        sqlite3_trace_v2(connection, SQLITE_TRACE_STMT|SQLITE_TRACE_PROFILE|SQLITE_TRACE_ROW, [](unsigned int type, void* user_data, void* stmt, void* x){
            if(type==SQLITE_TRACE_STMT){
                DEBUG_MSG("Executing statement: " << sqlite3_expanded_sql((sqlite3_stmt*)stmt));
                return 0;
            } else if (type==SQLITE_TRACE_PROFILE){
                DEBUG_MSG("Statement took " << *((sqlite3_uint64*)x)/1000000 << " ms");
                return 0;
            } else if (type==SQLITE_TRACE_ROW){
            //DEBUG_MSG("Row returned: ");
            //    int cols = sqlite3_column_count((sqlite3_stmt*)stmt);
            //    for(int i = 0; i < cols; i++){
            //        DEBUG_MSG(sqlite3_column_name((sqlite3_stmt*)stmt, i) << " = " << sqlite3_column_text((sqlite3_stmt*)stmt, i));
            //    }
            return 0;
            }
            DEBUG_MSG("Unknown trace type: " << type);
            return 0;
        }, NULL);
        DEBUG_MSG("Logging setup done");
        #endif

        // Output current database schema:
        /*DEBUG_MSG("Database schema is as follows:");
        sqlite3_exec(connection, "SELECT sql FROM sqlite_master", [](void* user_data, int argc, char** argv, char** col_names){
            for(int i = 0; i < argc; i++){
                DEBUG_MSG(col_names[i] << ": " << argv[i]);
            }
            return 0;
        }, NULL, NULL);
*/
        // Output all values in the meta table:
        DEBUG_MSG("Meta table is as follows:");
        sqlite3_exec(connection, "SELECT * FROM meta", [](void* user_data, int argc, char** argv, char** col_names){
            for(int i = 0; i < argc; i++){
                DEBUG_MSG(col_names[i] << ": " << argv[i]);
            }
            return 0;
        }, NULL, NULL);

        width = get_meta_int("width");
        height = get_meta_int("height");
        connections = get_meta_int("connections");
        auto metrictype = get_meta_str("metrictype");
        if(metrictype == "Euclidean"){
            this->metrictype = 0;
        } else if(metrictype == "Manhattan"){
            this->metrictype = 1;
        } else if(metrictype == "Octile"){
            this->metrictype = 2;
        } else {
            std::cerr << "Unknown metrictype: " << metrictype << std::endl;
            exit(1);
        }
        std::string hweight_str = get_meta_str("hweight");
        hweight = std::stod(hweight_str);

        // Prepare heuristic function
        prepare_functions_for_db();

        // Get nodes
        start_node = get_start_node();
        end_node = get_end_node();
    }


    GraphAccessor::~GraphAccessor(){
        sqlite3_close(connection);
        for(auto& node : allocated_nodes){
            delete node;
        }
    }

    GraphNode& GraphAccessor::get_node_by_id(int i, int j){
        DEBUG_MSG("Getting node by id: " << i << ", " << j);
        GraphNode* node_ptr = new GraphNode();
        node_ptr->i = i;
        node_ptr->j = j;
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

    std::string GraphAccessor::get_meta_str(std::string meta_key) const{
        std::string value;
        std::string sql = "SELECT value FROM meta WHERE key = ?";
        sqlite3_stmt* stmt;
        sqlite3_prepare_v2(connection, sql.c_str(), sql.length()+1, &stmt, 0);
        sqlite3_bind_text(stmt, 1, meta_key.c_str(), meta_key.length(), SQLITE_STATIC);
        int rc = sqlite3_step_or_error(stmt);
        DEBUG_MSG("Getting meta string: " << meta_key << " with rc: " << rc);
        if(rc == SQLITE_ROW){
            value = std::string((char*)sqlite3_column_text(stmt, 0));
        }
        sqlite3_finalize(stmt);
        return value;
    }

    GraphNode& GraphAccessor::get_start_node(){
        return get_node_by_id(get_meta_int("start_node_i"), get_meta_int("start_node_j"));
    }
    GraphNode& GraphAccessor::get_end_node(){
        return get_node_by_id(get_meta_int("end_node_i"), get_meta_int("end_node_j"));
    }

    void GraphAccessor::get_neighbors(const GraphNode& node, std::vector<GraphNeighbor>& neighbors){
        switch (connections)
        {
        case 4:
            get_neighbors_4(node, neighbors);
            break;
        case 8:
            get_neighbors_8(node, neighbors);
            break;

        default:
            std::cerr << "Unknown connections: " << connections << std::endl;
            exit(1);
            break;
        }
    }

    void GraphAccessor::get_neighbors_4(const GraphNode& node, std::vector<GraphNeighbor>& neighbors){
        while(neighbors.size() > 0){
            neighbors.pop_back();
        }
        neighbors.reserve(4);
        DEBUG_MSG("Getting 4-neighbors for node: " << node.i << ", " << node.j);
        std::string sql = "WITH t(node_i, node_j) AS (" // in the list of neighbors to the current node
            "VALUES (?, ?-1), (?, ?+1), (?-1, ?), (?+1, ?)"
        ") SELECT node_i, node_j FROM t "  // List all node IDs
        "WHERE node_i >= 0 AND node_i < ? AND node_j >= 0 AND node_j < ? AND NOT EXISTS ("  // where the node is within the bounds of the map
            "SELECT * FROM obstacles WHERE node_i = t.node_i AND node_j = t.node_j" // and there is no obstacle at that place
        ")";
        sqlite3_stmt* stmt;
        sqlite3_prepare_v2(connection, sql.c_str(), sql.length()+1, &stmt, 0);
        for(int i = 0; i < 4; i++){
            sqlite3_bind_int(stmt, i*2+1, node.i);
            sqlite3_bind_int(stmt, i*2+2, node.j);
        }
        sqlite3_bind_int(stmt, 9, width);
        sqlite3_bind_int(stmt, 10, height);

        int rc;
        while((rc = sqlite3_step_or_error(stmt)) == SQLITE_ROW){
            int i = sqlite3_column_int(stmt, 0);
            int j = sqlite3_column_int(stmt, 1);
            neighbors.push_back(GraphNeighbor{.node=get_node_by_id(i, j), .distance=1.0f});        
        }
        sqlite3_finalize(stmt);
    }

    void GraphAccessor::get_neighbors_8(const GraphNode& node, std::vector<GraphNeighbor>& neighbors){
        while(neighbors.size() > 0){
            neighbors.pop_back();
        }
        neighbors.reserve(8);
        DEBUG_MSG("Getting 8-neighbors for node: " << node.i << ", " << node.j);
        get_neighbors_4(node, neighbors);

        // A diagonal neighbor is connected if there are no obstacles at the neighbor or to the sides of me and the neighbor
        // Ex:
        // 0 1 0
        // 1 X 0
        // 0 0 0
        // Here, X has only a diagonal neighbor to the down-right, because there is an obstacle to the right and down
        // that prevents going to the top-right, top-left and down-left.

        std::string sql = "WITH t(node_i, node_j, ortho_i, ortho_j, ortho2_i, ortho2_j) AS ("  
            "VALUES (?-1, ?-1, ?-1, ?, ?, ?-1), " // In a list whose first two elements are the neighbor's coords,
            "(?-1, ?+1, ?-1, ?, ?, ?+1), "       // and the second two are the coords of the two nodes orthogonally adjacent to the neighbor and me
            "(?+1, ?-1, ?+1, ?, ?, ?-1), "
            "(?+1, ?+1, ?+1, ?, ?, ?+1) "
            ") "
            "SELECT node_i, node_j FROM t " // list all node IDs
            "WHERE node_i >= 0 AND node_i < ? AND node_j >= 0 AND node_j < ? AND NOT EXISTS ("  // where the node is within the bounds of the map
                "SELECT * FROM obstacles WHERE (node_i, node_j) NOT IN (" // and there is no obstacle
                        "VALUES (t.node_i, t.node_j)," // at the neighbor
                        "(t.ortho_i, t.ortho_j)," // or at the first orthogonally adjacent node
                        "(t.ortho2_i, t.ortho2_j)" // or at the second
                    ")"
            ")";
        sqlite3_stmt* stmt;
        sqlite3_prepare_v2(connection, sql.c_str(), sql.length()+1, &stmt, 0);
        for(int i = 0; i < 12; i++){
            sqlite3_bind_int(stmt, i*2+1, node.i);
            sqlite3_bind_int(stmt, i*2+2, node.j);
        }
        sqlite3_bind_int(stmt, 25, width);
        sqlite3_bind_int(stmt, 26, height);

        int rc;
        while((rc = sqlite3_step_or_error(stmt)) == SQLITE_ROW){
            int i = sqlite3_column_int(stmt, 0);
            int j = sqlite3_column_int(stmt, 1);
            neighbors.push_back(GraphNeighbor{.node=get_node_by_id(i, j), .distance=1.41421356237f});     
        }
        sqlite3_finalize(stmt);
    }


    unsigned int GraphAccessor::get_distance_to(const GraphNode& node) const {
        unsigned int dist = -1;
        sqlite3_stmt *stmt;
        std::string sql = "SELECT dist FROM distances WHERE node_i = ? AND node_j = ?";
        sqlite3_prepare_v2(connection, sql.c_str(), sql.length()+1, &stmt, 0);
        sqlite3_bind_int(stmt, 1, node.i);
        sqlite3_bind_int(stmt, 2, node.j);
        int rc = sqlite3_step_or_error(stmt);
        if(rc == SQLITE_ROW){
            dist = sqlite3_column_int(stmt, 0);
        }
        sqlite3_finalize(stmt);
        return dist;
    }

    void GraphAccessor::set_distance_to(const GraphNode& node, unsigned int dist){
        sqlite3_stmt *stmt;
        std::string sql = "INSERT OR REPLACE INTO distances VALUES(?, ?, ?)";
        sqlite3_prepare_v2(connection, sql.c_str(), sql.length()+1, &stmt, 0);
        sqlite3_bind_int(stmt, 1, node.i);
        sqlite3_bind_int(stmt, 2, node.j);
        sqlite3_bind_int(stmt, 3, dist);
        sqlite3_step_or_error(stmt);
        sqlite3_finalize(stmt);
    }

    GraphNode* GraphAccessor::get_previous_node(const GraphNode& node){
        sqlite3_stmt *stmt;
        std::string sql = "SELECT prev_i, prev_j FROM previous WHERE node_i = ? AND node_j = ?";
        sqlite3_prepare_v2(connection, sql.c_str(), sql.length()+1, &stmt, 0);
        sqlite3_bind_int(stmt, 1, node.i);
        sqlite3_bind_int(stmt, 2, node.j);
        int rc = sqlite3_step_or_error(stmt);
        if(rc == SQLITE_ROW){
            int prev_i = sqlite3_column_int(stmt, 0);
            int prev_j = sqlite3_column_int(stmt, 1);
            sqlite3_finalize(stmt);
            GraphNode* prev = new GraphNode;
            *prev = get_node_by_id(prev_i, prev_j);
            return prev;
        }
        sqlite3_finalize(stmt);
        return nullptr;
    }

    void GraphAccessor::set_previous_node(const GraphNode& node, const GraphNode& prev){
        sqlite3_stmt *stmt;
        std::string sql = "INSERT OR REPLACE INTO previous VALUES(?, ?, ?, ?)";
        sqlite3_prepare_v2(connection, sql.c_str(), sql.length()+1, &stmt, 0);
        sqlite3_bind_int(stmt, 1, node.i);
        sqlite3_bind_int(stmt, 2, node.j);
        sqlite3_bind_int(stmt, 3, prev.i);
        sqlite3_bind_int(stmt, 4, prev.j);
        sqlite3_step_or_error(stmt);
        sqlite3_finalize(stmt);
    }

    void GraphAccessor::set_node_as_open(const GraphNode& node){

        sqlite3_stmt *stmt;
        std::string sql = "DELETE FROM closed_list WHERE node_i = ? AND node_j = ?";
        sqlite3_prepare_v2(connection, sql.c_str(), sql.length()+1, &stmt, 0);
        sqlite3_bind_int(stmt, 1, node.i);
        sqlite3_bind_int(stmt, 2, node.j);
        sqlite3_step_or_error(stmt);
        sqlite3_finalize(stmt);


        std::string sql2 = "INSERT OR REPLACE INTO open_list VALUES(?, ?)";
        sqlite3_prepare_v2(connection, sql2.c_str(), sql2.length()+1, &stmt, 0);
        sqlite3_bind_int(stmt, 1, node.i);
        sqlite3_bind_int(stmt, 2, node.j);
        sqlite3_step_or_error(stmt);
        sqlite3_finalize(stmt);
    }

    void GraphAccessor::set_node_as_closed(const GraphNode& node){
        sqlite3_stmt *stmt;
        std::string sql = "DELETE FROM open_list WHERE node_i = ? AND node_j = ?";
        sqlite3_prepare_v2(connection, sql.c_str(), sql.length()+1, &stmt, 0);
        sqlite3_bind_int(stmt, 1, node.i);
        sqlite3_bind_int(stmt, 2, node.j);
        sqlite3_step_or_error(stmt);
        sqlite3_finalize(stmt);


        std::string sql2 = "INSERT OR REPLACE INTO closed_list VALUES(?, ?)";
        sqlite3_prepare_v2(connection, sql2.c_str(), sql2.length()+1, &stmt, 0);
        sqlite3_bind_int(stmt, 1, node.i);
        sqlite3_bind_int(stmt, 2, node.j);
        sqlite3_step_or_error(stmt);
        sqlite3_finalize(stmt);
    }

    void GraphAccessor::prepare_functions_for_db(){
        sqlite3_create_function_v2(
            connection,
            "heuristic",
            4,
            SQLITE_UTF8|SQLITE_DETERMINISTIC|SQLITE_DIRECTONLY,
            &metrictype,
            &heuristic_function,
            NULL,
            NULL,
            NULL
        );
    }
    void heuristic_function(sqlite3_context *context, int argc, sqlite3_value **argv){
        int ai = sqlite3_value_int(argv[0]);
        int aj = sqlite3_value_int(argv[1]);
        int bi = sqlite3_value_int(argv[2]);
        int bj = sqlite3_value_int(argv[3]);
        double dx = abs(ai - bi);
        double dy = abs(aj - bj);
        int heuristic_type = *(int*)sqlite3_user_data(context);
        double answer;
        switch(heuristic_type){
            case 0: // euclidean
                answer = sqrt(pow(ai-bi, 2) + pow(aj-bj, 2));
                break;
            case 1: // manhattan
                answer = abs(ai-bi) + abs(aj-bj);
                break;
            case 2: // octile
                answer = abs(dx - dy) + (sqrt(2))*std::min(dx, dy);
                break;
            default: // heuristic is unknown, assuming no heuristic
                answer = 0; 
                break;
        }
        sqlite3_result_double(context, answer);
    }

    GraphNode* GraphAccessor::get_first_open_node(){
        sqlite3_stmt *stmt;
        std::string sql = "SELECT node_i, node_j FROM open_list LIMIT 1";
        sqlite3_prepare_v2(connection, sql.c_str(), sql.length()+1, &stmt, 0);
        int rc = sqlite3_step_or_error(stmt);
        if(rc == SQLITE_ROW){
            int node_i = sqlite3_column_int(stmt, 0);
            int node_j = sqlite3_column_int(stmt, 1);
            sqlite3_finalize(stmt);
            GraphNode* node = new GraphNode;
            *node = get_node_by_id(node_i, node_j);
            return node;
        }
        sqlite3_finalize(stmt);
        return nullptr;
    }

    GraphNode* GraphAccessor::get_open_node_with_lowest_value(){
        sqlite3_stmt *stmt;
        std::string sql;
        if(hweight < __FLT_EPSILON__){  // if hweight is 0, then we don't need to use heuristic function
            sql = "SELECT open_list.node_i, open_list.node_j FROM open_list "
            "JOIN distances ON open_list.node_i = distances.node_i AND open_list.node_j = distances.node_j "
            "ORDER BY distances.dist DESC LIMIT 1";
            sqlite3_prepare_v2(connection, sql.c_str(), sql.length()+1, &stmt, 0);
 
        } else {
            sql = "SELECT open_list.node_i, open_list.node_j FROM open_list "
            "JOIN distances ON open_list.node_i = distances.node_i AND open_list.node_j = distances.node_j "
            "ORDER BY distances.dist + (heuristic(open_list.node_i, open_list.node_j, ?, ?)*?) DESC LIMIT 1";
            sqlite3_prepare_v2(connection, sql.c_str(), sql.length()+1, &stmt, 0);
            sqlite3_bind_int(stmt, 1, end_node.i);
            sqlite3_bind_int(stmt, 2, end_node.j);
            sqlite3_bind_double(stmt, 3, hweight);

        }
        int rc = sqlite3_step_or_error(stmt);
        if(rc == SQLITE_ROW){
            int node_i = sqlite3_column_int(stmt, 0);
            int node_j = sqlite3_column_int(stmt, 1);
            sqlite3_finalize(stmt);
            GraphNode* node = new GraphNode;
            *node = get_node_by_id(node_i, node_j);
            return node;
        }
        sqlite3_finalize(stmt);
        return nullptr;
    }




} // namespace lab1
#endif