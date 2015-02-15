$title nonlinear programming example

Variable x, y;

Equation one;

one.. y =e= sqr(x*x) + 10;

x.lo = 2;

model square / all / ;
solve square minimizing y using nlp;

Display y.l, x.l