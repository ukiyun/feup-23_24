#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include "vector.h"

vector* vector_new(double a,double b,double c){
    vector* w = (vector*) malloc (sizeof(vector));
    w->x=a;
    w->y=b;
    w->z=c;
    return w;
}

vector* vector_add(vector* a, vector* b){
    vector* w = vector_new(a->x + b->x, a->y + b->y, a->z + b->z);
    return w;
}

vector* vector_sub(vector* a, vector* b){
    vector* w = vector_new(a->x - b->x, a->y - b->y, a->z - b->z);
    return w;
}

vector* vector_scale(double t, vector* a){
    vector* w = vector_new(a->x * t, a->y * t, a->z * t);
    return w;
}

vector* vector_vprod(vector* a, vector* b){ // check algebra cross product
    double xs =  a->y * b->z - a->z * b->y;
    double ys =  a->x * b->z - a->z * b->x;
    double zs =  a->x * b->y - a->y * b->x;
    vector* w = vector_new(xs,ys,zs);
    return w;
}

double vector_sprod(vector* a, vector* b){ // check algebra scalar/dot product
    double xs = a->x * b->x;
    double ys = a->y * b->y;
    double zs = a->z * b->z;
    double w = xs + ys + zs;
    return w;
}

double vector_mod(vector* a){
    double inside = pow(a->x,2) + pow(a->y,2) + pow(a->z,2);
    double res = sqrt(inside);
    return res; 
}