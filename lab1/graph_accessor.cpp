#include<string>
#include<iostream>
#include<vector>
#include "graph_node.h"
#include "neighbor_struct.cpp"
#include "graph_accessor.h"
#include "debug.h"
#include<math.h>
#include<fstream>


namespace lab1
{

    GraphAccessor::GraphAccessor(std::string filename){
        // Open file stream
        std::ifstream f(filename);
        if (!f.is_open()) {
            std::cerr << "Could not open file " << filename << std::endl;
            exit(1);
        }
        f >> width >> height;
        f >> connections;
        f >> hweight;
        f >> metrictype;
        f >> algorithm;
        f >> start_node.i >> start_node.j;
        f >> end_node.i >> end_node.j;
        int num_walls;
        f >> num_walls;
        for (int i = 0; i < num_walls; i++) {
            int x, y;
            f >> x >> y;
            walls.insert(std::make_pair(x, y));
        }
        f.close();

    }

    GraphAccessor::~GraphAccessor(){
    }

    GraphNode GraphAccessor::get_node_by_id(int i, int j){
        DEBUG_MSG("Getting node by id: " << i << ", " << j);
        nodes_constructed ++;
        return GraphNode(i, j);
    }

    GraphNode GraphAccessor::get_start_node(){
        return start_node;
    }
    GraphNode GraphAccessor::get_end_node(){
        return end_node;
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

    bool GraphAccessor::is_wall(int i, int j) const{
        return walls.find(std::pair<int, int>{i, j}) != walls.end();
    }
    
    void GraphAccessor::get_neighbors_4(const GraphNode& node, std::vector<GraphNeighbor>& neighbors){
        while(neighbors.size() > 0){
            neighbors.pop_back();
        }
        neighbors.reserve(4);
        DEBUG_MSG("Getting 4-neighbors for node: " << node.i << ", " << node.j);

        for(int i = -1; i <= 1; i++){
            for(int j = -1; j <= 1; j++){
                if(i == 0 && j == 0){
                    continue;
                }
                if(i != 0 && j != 0){
                    continue;
                }

                int ni = node.i + i;
                int nj = node.j + j;
                if(get_node_by_id(ni, nj) == get_end_node()){
                    neighbors.push_back(GraphNeighbor{.node=get_node_by_id(ni, nj), .distance=1.0});
                    continue;
                }
                if(ni < 0 || nj < 0 || ni >= height || nj >= width){
                    continue;
                }
                if(is_wall(ni, nj)){
                    continue;
                }
                neighbors.push_back(GraphNeighbor{.node=get_node_by_id(ni, nj), .distance=1.0});
            }
        }
    }

    void GraphAccessor::get_neighbors_8(const GraphNode& node, std::vector<GraphNeighbor>& neighbors){
        while(neighbors.size() > 0){
            neighbors.pop_back();
        }
        neighbors.reserve(8);
        get_neighbors_4(node, neighbors);

        // A diagonal neighbor is connected if there are no obstacles at the neighbor or to the sides of me and the neighbor
        // Ex:
        // 0 1 0
        // 1 X 0
        // 0 0 0
        // Here, X has only a diagonal neighbor to the down-right, because there is an obstacle to the right and down
        // that prevents going to the top-right, top-left and down-left.

        for(int i = -1; i <= 1; i++){
            for(int j = -1; j <= 1; j++){
                if(i == 0 && j == 0){
                    continue;
                }
                if(i == 0 || j == 0){
                    continue;
                }
                int ni = node.i + i;
                int nj = node.j + j;
                if(get_node_by_id(ni, nj) == get_end_node()){
                    neighbors.push_back(GraphNeighbor{.node=get_node_by_id(ni, nj), .distance=1.0});
                    continue;
                }
                if(ni < 0 || nj < 0 || ni >= height || nj >= width){
                    continue;
                }
                if(is_wall(ni, nj)){
                    continue;
                }
                if(is_wall(node.i + i, node.j)){
                    continue;
                }
                if(is_wall(node.i, node.j + j)){
                    continue;
                }
                neighbors.push_back(GraphNeighbor{ .node=get_node_by_id(ni, nj), .distance=1.41421356237f});
            }
        }

    }


    double GraphAccessor::get_distance_to(const GraphNode& node) const {
        if(g_score.find(node) == g_score.end()){
            return __DBL_MAX__;
        }
        return g_score.at(node);
    }

    void GraphAccessor::set_distance_to(const GraphNode& node, double dist){
        g_score[node] = dist;
    }

    GraphNode* GraphAccessor::get_previous_node(const GraphNode& node){
        if(came_from.find(node) == came_from.end()){
            return nullptr;
        }
        return &came_from.at(node);
    }

    void GraphAccessor::set_previous_node(const GraphNode& node, const GraphNode& prev){
        came_from[node] = prev;
    }

    void GraphAccessor::set_node_as_open(const GraphNode& node){
        open_nodes.insert(node);
        closed_nodes.erase(node);
    }

    void GraphAccessor::set_node_as_closed(const GraphNode& node){
        closed_nodes.insert(node);
        open_nodes.erase(node);
    }

    double heuristic_function(int heuristic_type, int ai, int aj, int bi, int bj){
        double dx = abs(ai - bi);
        double dy = abs(aj - bj);
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
        DEBUG_MSG("Heuristic for " << ai << ", " << aj << " and " << bi << ", " << bj << " is " << answer);
        return answer;
    }

    bool GraphAccessor::has_open_nodes() const{
        return open_nodes.size() > 0;
    }

    GraphNode GraphAccessor::get_first_open_node(){
        return *open_nodes.begin();
    }

    GraphNode GraphAccessor::get_open_node_with_lowest_value(){
        GraphNode lowest_node = *open_nodes.begin();
        double lowest_value = __DBL_MAX__;
        for(auto& node : open_nodes){
            double value = get_distance_to(node) + heuristic_function(metrictype, node.i, node.j, end_node.i, end_node.j)*hweight;
            if(value < lowest_value){
                lowest_value = value;
                lowest_node = node;
            }
        }
        return lowest_node;
    }

} // namespace lab1
