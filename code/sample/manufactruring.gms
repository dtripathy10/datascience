$title Manufacturing Example  to maximize the profit

$Ontext
  Author: Debabrata Tripathy
  Email: dtripathy10@gmail.com
  Problem Refernce: http://goo.gl/DNptkv
$offtext

*####################################################
*   Set the Index
*###################################################

Sets
    product product unit /P, Q, R/
    machine machine unit    /A, B, C, D/;



*####################################################
*   Parameter
*###################################################

Table constraint(machine,product) "unit processing time"
    P   Q   R
A  20   10  10
B  12   28  16
C  15   6   16
D  10   15  0;

parameter machine_availability(machine) machine availability
            / A 2400,
              B 2400
              C 2400
              D 2400 / ;

parameter product_profit(product) profit of product
            / P 45
              Q 60
              R 50/;

parameter market_constrint(product) market constraint of product
            / P 100
              Q 40
              R 60/;


Display constraint,machine_availability, product_profit, market_constrint ;

*####################################################
*   Variable
*###################################################

Variables

    product_unit(product) number of product of each unit
    tottal_profit total profit ;

Positive Variable product_unit ;

*####################################################
*   Equation
*###################################################

Equations
    cost define objective function
    resource_constraint(machine) constraint impose by machine
    market_constraint(product) constraint impose by market ;

cost .. tottal_profit =e= sum((product), product_unit(product)*product_profit(product)) ;

resource_constraint(machine) .. sum(product, product_unit(product)*constraint(machine,product)) =l= machine_availability(machine) ;

market_constraint(product) .. product_unit(product) =l= market_constrint(product) ;

*####################################################
*   Model
*###################################################

Model manufacturing /all/ ;

*####################################################
*   Solver
*###################################################

Solve manufacturing using lp maximizing tottal_profit ;


