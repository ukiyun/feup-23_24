// By: Gonçalo Leão
// With contributions by Eduardo Almeida

#include <iostream>
using namespace std;

int maxSubsequence(int A[], unsigned int n, unsigned int &i, unsigned int &j) {
    int maxSize = INT_MIN;
    unsigned int parameters[2] = {0,0};
    for (i=0; i<n; i++){
        int maxSizeTemp = A[i];
        for (j=i+1; j<n; j++){
            maxSizeTemp = maxSizeTemp + A[j];
            if(maxSizeTemp>maxSize){
                maxSize = maxSizeTemp;
                parameters[0] = i;
                parameters[1] = j;
            }
        }
    }

    i = parameters[0];
    j = parameters[1];
    return maxSize;
}

/// TESTS ///
#include <gtest/gtest.h>

TEST(TP2_Ex1, maxSubsequence) {
    int A[] = {-2, 1, -3, 4, -1, 2, 1, -5, 4};
    unsigned int n = 9;
    unsigned int i, j;
    EXPECT_EQ(maxSubsequence(A,n,i,j), 6);
    EXPECT_EQ(i, 3);
    EXPECT_EQ(j, 6);
}