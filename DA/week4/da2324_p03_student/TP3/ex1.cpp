// Original code by Gonçalo Leão
// Updated by DA 2023/2024 Team

#include "../data_structures/Graph.h"

using namespace std;

// Function to test given vertex 'w' and visit it if conditions are met
template <class T>
void testAndVisit(queue< Vertex<T>*> &q, Edge<T> *e, Vertex<T> *w, double residual){
    if (!w->isVisited() && residual > 0){
        w->setVisited(true);
        w->setPath(e);
        q.push(w);
    }
}

// bfs implementation
template <class T>
bool bfs(Graph<T> *g, Vertex<T> * s, Vertex<T> *t){
    // make all nodes unvisited
    for (auto vertex: g->getVertexSet()){
        vertex->setVisited(false);
    }

    // mark first node as visited and add to queue
    s->setVisited(true);
    queue<Vertex<T>*> q;
    q.push(s);

    // remove node 0 from the front of queue and visit the unvisited neighbours
    while( !q.empty() && !t->isVisited()){
        auto v = q.front();
        q.pop();

        for(auto e: v->getAdj()){
            testAndVisit(q,e, e->getDest(), e->getWeight()-e->getFlow());
        }

        // process new edges
        for (auto e: v->getIncoming()){
            testAndVisit(q, e, e->getOrig(), e->getFlow());
        }
    }

    return t->isVisited();
}

template <class T>
double findMinResidualPath(Vertex<T> *s, Vertex<T> *t){
    double f = INF; // infinity

    // transverse the augmenting path to find the min residual capacity
    for (auto v=t; v!=s;){
        auto e = v->getPath();
        if(e->getDest()==v){
            f = min(f, e->getWeight()-e->getFlow());
            v = e->getDest();
        }
    }

    return f;
}

// function to augment flow along the augmenting path with given flow value
template <class T>
void augmentFlowPath(Vertex<T> *s, Vertex<T> *t, double f) {
    for (auto v=t; v !=s;){
        auto e = v->getPath();
        double flow = e->getFlow();
        if (e->getDest() == v){
            e->setFlow(flow+f);
            v = e->getOrig();
        }
        else{
            e->setFlow(flow-f);
            v = e->getDest();
        }
    }
}


template <class T>
void edmondsKarp(Graph<T> *g, int source, int target) {
    // find source and target vertex in the graph
    Vertex<T>* s = g->findVertex(source);
    Vertex<T>* t = g->findVertex(target);

    //validate source and target values
    if (s == nullptr || t== nullptr || s==t){
        throw logic_error("Invalid source and/or target vertex");
    }

    // init the flow on all edges to 0
    for (auto v: g->getVertexSet()){
        for (auto e: v->getAdj()){
            e->setFlow(0);
        }
    }

    // while there is augmenting path, augment the flo along the path
    while(bfs(g,s,t)){
        double f = findMinResidualPath(s,t);
        augmentFlowPath(s,t,f);
    }
}

/// TESTS ///
#include <gtest/gtest.h>

TEST(TP3_Ex1, test_edmondsKarp) {
    Graph<int> myGraph;

    for(int i = 1; i <= 6; i++)
        myGraph.addVertex(i);

    myGraph.addEdge(1, 2, 3);
    myGraph.addEdge(1, 3, 2);
    myGraph.addEdge(2, 5, 4);
    myGraph.addEdge(2, 4, 3);
    myGraph.addEdge(2, 3, 1);
    myGraph.addEdge(3, 5, 2);
    myGraph.addEdge(4, 6, 2);
    myGraph.addEdge(5, 6, 3);

    edmondsKarp(&myGraph, 1, 6);

    std::stringstream ss;
    for(auto v : myGraph.getVertexSet()) {
        ss << v->getInfo() << "-> (";
        for (const auto e : v->getAdj())
            ss << (e->getDest())->getInfo() << "[Flow: " << e->getFlow() << "] ";
        ss << ") || ";
    }

    std::cout << ss.str() << std::endl << std::endl;

    EXPECT_EQ("1-> (2[Flow: 3] 3[Flow: 2] ) || 2-> (5[Flow: 1] 4[Flow: 2] 3[Flow: 0] ) || 3-> (5[Flow: 2] ) || 4-> (6[Flow: 2] ) || 5-> (6[Flow: 3] ) || 6-> () || ", ss.str());

}