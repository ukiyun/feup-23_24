
#include <stdlib.h>
#include <vector>

struct Point
{
	int x, y;

};

Point* convexHullNaive( Point vp[], int n , int &nPoints) {
    // TODO
}


Point* convexHullDC( Point vp[], int n, int &nPoints) {
	// TODO
}

#include <gtest/gtest.h>

bool findPoint(Point ref, Point *solution, int nPoints) {
    for (int i = 0; i < nPoints; ++i) {
        if (ref.x == (*(solution+i)).x and ref.y == (*(solution+i)).y) return true;
    }
    return false;
}

TEST(TP4_Ex9_1, convexHullNaive) {
    Point points []= {{0, 3}, {1, 1}, {2, 2}, {4, 4},
                            {0, 0}, {1, 2}, {3, 1}, {3, 3}};
    int nPoints = 0;
    Point * solution = convexHullNaive(points,8,nPoints);
    Point expected_solution[] = {{0,3},{4,4},{3,1},{0,0}};

    EXPECT_EQ(nPoints, 4);
    EXPECT_TRUE(findPoint(expected_solution[0],solution,nPoints));
    EXPECT_TRUE(findPoint(expected_solution[1],solution,nPoints));
    EXPECT_TRUE(findPoint(expected_solution[2],solution,nPoints));
    EXPECT_TRUE(findPoint(expected_solution[3],solution,nPoints));
    delete solution;
}

TEST(TP4_Ex9_2, convexHullNaive) {
    Point points []= {{0, 0}, {0, 4}, {-4, 0}, {5, 0},
                      {0, -6}, {1, 0}};
    int nPoints = 0;
    Point * solution = convexHullNaive(points,6,nPoints);
    Point expected_solution[] = {{-4,0},{5,0},{0,-6},{0,4}};

    EXPECT_EQ(nPoints, 4);
    EXPECT_TRUE(findPoint(expected_solution[0],solution,nPoints));
    EXPECT_TRUE(findPoint(expected_solution[1],solution,nPoints));
    EXPECT_TRUE(findPoint(expected_solution[2],solution,nPoints));
    EXPECT_TRUE(findPoint(expected_solution[3],solution,nPoints));
    delete solution;

}


TEST(TP4_Ex9_3, convexHullDC) {
    Point points []= {{0, 3}, {1, 1}, {2, 2}, {4, 4},
                      {0, 0}, {1, 2}, {3, 1}, {3, 3}};
    int nPoints = 0;
    Point * solution = convexHullDC(points,8,nPoints);
    Point expected_solution[] = {{0,3},{4,4},{3,1},{0,0}};

    EXPECT_EQ(nPoints, 4);
    EXPECT_TRUE(findPoint(expected_solution[0],solution,nPoints));
    EXPECT_TRUE(findPoint(expected_solution[1],solution,nPoints));
    EXPECT_TRUE(findPoint(expected_solution[2],solution,nPoints));
    EXPECT_TRUE(findPoint(expected_solution[3],solution,nPoints));
    delete solution;
}

TEST(TP4_Ex9_4, convexHullDC) {
    Point points []= {{0, 0}, {0, 4}, {-4, 0}, {5, 0},
                      {0, -6}, {1, 0}};
    int nPoints = 0;
    Point * solution = convexHullDC(points,6,nPoints);
    Point expected_solution[] = {{-4,0},{5,0},{0,-6},{0,4}};

    EXPECT_EQ(nPoints, 4);
    EXPECT_TRUE(findPoint(expected_solution[0],solution,nPoints));
    EXPECT_TRUE(findPoint(expected_solution[1],solution,nPoints));
    EXPECT_TRUE(findPoint(expected_solution[2],solution,nPoints));
    EXPECT_TRUE(findPoint(expected_solution[3],solution,nPoints));
    delete solution;

}

TEST(TP4_Ex9_5, convexHullDC) {
    Point points []= {{0, 0}, {1, -4}, {-1, -5}, {-5, -3},
                      {-3, -1}, {-1, -3},{-2,-2},{-1,-1},{-2,-1}
                      ,{-1,1},};
    int nPoints = 0;
    Point * solution = convexHullDC(points,10,nPoints);
    Point expected_solution[] = {{ 0,0},{-5,-3},{1,-4},{-1,1},{-1,-5}};

    EXPECT_EQ(nPoints, 5);
    EXPECT_TRUE(findPoint(expected_solution[0],solution,nPoints));
    EXPECT_TRUE(findPoint(expected_solution[1],solution,nPoints));
    EXPECT_TRUE(findPoint(expected_solution[2],solution,nPoints));
    EXPECT_TRUE(findPoint(expected_solution[3],solution,nPoints));
    EXPECT_TRUE(findPoint(expected_solution[4],solution,nPoints));
    delete solution;

}

TEST(TP4_Ex9_6, convexHullDC) {
    Point points []= {{7, 4},{6,5},
                      {3,3},
                      {0,5},
                      {-2,3},
                      {-2,2},
                      {-5,1},
                      {0,0},
                      {-3,-2},
                      {3,-2},
                      {2,1}};
    int nPoints = 0;
    Point * solution = convexHullDC(points,11,nPoints);
    Point expected_solution[] = {{ -5,1},{0,5},{6,5},{7,4},{3,-2},{-3,-2}};

    EXPECT_EQ(nPoints, 6);
    EXPECT_TRUE(findPoint(expected_solution[0],solution,nPoints));
    EXPECT_TRUE(findPoint(expected_solution[1],solution,nPoints));
    EXPECT_TRUE(findPoint(expected_solution[2],solution,nPoints));
    EXPECT_TRUE(findPoint(expected_solution[3],solution,nPoints));
    EXPECT_TRUE(findPoint(expected_solution[4],solution,nPoints));
    delete solution;

}




