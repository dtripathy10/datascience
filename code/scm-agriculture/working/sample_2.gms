* The map of your labels in the GAMS order can be seen by putting the compiler directive
* $onuellist somewhere before the first set declaration.

$Ontext

$onuellist

set
  t1 / 1987, 1988, 1989, 1990, 1991 /
  t2 / 1983, 1984, 1985, 1986, 1987 /
  t3 / 1987, 1989, 1991, 1983, 1985 / ;

Display t1,t2,t3;

set t time periods / 1985*1995 /
parameter val(t) ;
val(t) = ord(t);

* Ord can be used only with a one-dimensional, static, ordered set.

set t time periods / 1985*1995 /
parameter val(t) ;
val(t) = ord(t);

Display val;


set i row and column labels / x1*x10 /;
alias (i,j);
parameter a(i,j) a general square matrix;

a(i,j)$(ord(i) lt ord(j)) = ord(i) + ord(j) ;

Display a;

$offtext

set t time periods / 1985*1995 /
parameter s ; s = card(t);

Display s;