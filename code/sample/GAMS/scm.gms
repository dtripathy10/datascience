Sets m Millers /M1, M2, M3, M4, M5, M6, M7, M8,M9, M10/
     t No_of_steps /1*18/
     r Retailers /R1, R2, R3, R4, R5, R6, R7, R8, R9, R10/ ;


Parameter      Loss milling loss /0.05/
               AnnualFixedCost Annual Fixed cost /3356/
               MaxMillerCapacity /50000/
               OperatingCost
               TotalGrain
               RemovalRateFromStorage
               MaxStorageCapacity /100000/
               Demand
               Distance
               TravelRate storage to retailer transportation Rs-per-kg-km - trolley /0.01245/
               Max /10000000/
               HL Handling loss - trolley /0.0042/
               TL Transportation Loss - trolley /0.0019/;




Variable                Obj_Cost ;

Positive Variable       Cost_1,
                        OutputFromMiller(t,m),
                        RemovalFromStorage(t,m),
                        Cost(t,m),
                        InputToMiller(t,m),
                        StoredGrain(t,m),
                        TotalCost(t,m),
                        TotalOutputFromMiller(t,m),
                        StorageToRetailer(t,m,r),
                        TransportationCost(t,m,r)
                        CostForRetailer(t,r)
                        TotalCostForRetailer(r) ;

Binary Variable         x(m);

$GDXIN input.gdx
$LOAD  Distance TotalGrain Demand OperatingCost
$GDXIN

Parameter demand_temp;

demand_temp = Demand('1','R1');

Display TotalGrain, Demand, OperatingCost,  demand_temp;

Equations     CostForMillersForOneTimeStep
              Objective_func
              TotalInputToMillerConstraint
              MillerConstraint
              RemovalFromStorageConstraint
              StorageConstraint
              MassBalanceEquation  Mass Balance on Miller considering the milling loss
              BinaryConstraintEq
              CostEquation Capital cost and Operating cost of miller
              TotalOutputEquation Output after every step
              TotalCostEquation
              StoredGrainEquation
              DemandSideConstraint
              RemovalFromSingleStorage
              CostTransportationEquation
              CostForOneRetailerEquation
              TotalCostForRetailerEquation ;


TotalInputToMillerConstraint(t)..               TotalGrain(t) =g= sum(m,InputToMiller(t,m)) ;
MillerConstraint(t,m)..                         InputToMiller(t,m) =l= MaxMillerCapacity;
MassBalanceEquation(t,m)..                      OutputFromMiller(t,m) =l= InputToMiller(t,m) - Loss*InputToMiller(t,m);

StoredGrainEquation(t,m)..                      StoredGrain(t,m) =l= StoredGrain(t-1,m) + OutputFromMiller(t,m) - RemovalFromStorage(t-1,m);

StorageConstraint(t,m)..                        StoredGrain(t,m) =l= MaxStorageCapacity ;
RemovalFromStorageConstraint(t,m)..             RemovalFromStorage(t,m) =l= StoredGrain(t,m);

RemovalFromSingleStorage(t,m)..                 RemovalFromStorage(t,m) =g= sum(r,StorageToRetailer(t,m,r)) ;

DemandSideConstraint(t,r)..                     Demand(t,r) =l= sum(m,StorageToRetailer(t,m,r)) ;

BinaryConstraintEq(m)..                         sum(t,InputToMiller(t,m)) =L= x(m)*Max     ;
CostEquation(t,m)..                             Cost(t,m) =g= AnnualFixedCost*(x(m)) + OperatingCost(t,m)*InputToMiller(t,m) ;
TotalOutputEquation(t,m)..                      TotalOutputFromMiller(t,m) =e= 15*OutputFromMiller(t,m);
TotalCostEquation(t,m)..                        TotalCost(t,m) =g= 15*Cost(t,m);
CostForMillersForOneTimeStep(t)..               Cost_1(t) =g= sum(m,TotalCost(t,m)) ;
Objective_func..                                Obj_Cost =g= sum(t,Cost_1(t)) ;

*Temp_Constraint..                              sum(t,InputToMiller(t,'M9') + InputToMiller(t,'M10')) =e=0;

***** TRANSPORTATION *****

CostTransportationEquation(t,m,r)..             TransportationCost(t,m,r) =e= ((StorageToRetailer(t,m,r)*(1-HL))*(1-TL))*(1-HL)*TravelRate*Distance(m,r);
CostForOneRetailerEquation(t,r)..               CostForRetailer(t,r) =e= sum(m,TransportationCost(t,m,r));
TotalCostForRetailerEquation(r)..               TotalCostForRetailer(r) =e= sum(t,CostForRetailer(t,r));


Model milling "linear version" /all/;

Solve milling using MIP minimizing Obj_Cost ;

Display Obj_Cost.l, InputToMiller.l, OutputFromMiller.l, StoredGrain.l, RemovalFromStorage.l, StorageToRetailer.l,
TotalOutputFromMiller.l, TotalCost.l, Demand, TotalGrain, x.l,  TransportationCost.l, CostForRetailer.l, TotalCostForRetailer.l  ;


