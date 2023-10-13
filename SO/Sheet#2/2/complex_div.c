#include <stdlib.h>
#include "complex.h"


double Power(double base, double power){
    int i;
    int number = 1;
    for(i=0;i<power;++i){
        number *= base;
    }

    return(number);
}

complex* complex_div(complex* z, complex* w){
    double realTop = z->x*w->x + z->y * w->y;
    double realBot = Power(w->x,2)+ Power(w->y,2);
    double imgTop = z->y*w->x - z->x*w->y;
    double imgBot = Power(w->x,2)+ Power(w->y,2);
    
   return complex_new(realTop/realBot, imgTop/imgBot);
}