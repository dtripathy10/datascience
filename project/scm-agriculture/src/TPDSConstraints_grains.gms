$title "TPDS constraints"

Equations
  TPDSConstraint1 "constraint(>): FCI stored grain > demand of TPDS for harvesting horizon"
  TPDSConstraint2 "constraint(>): FCI stored grain > demand of TPDS for non-harvesting horizon"
  ;

TPDSConstraint1(HarvestingHorizonAggregation,PDSSet)..
  sum(FCIGodownSet,
    FCICAPPDSGrain(HarvestingHorizonAggregation,FCIGodownSet,PDSSet)
  ) +
  sum(FCIGodownSet,
    FCICoveredPDSGrain(HarvestingHorizonAggregation,FCIGodownSet,PDSSet)
  ) =g= PDSDemand(HarvestingHorizonAggregation,PDSSet)
  ;

TPDSConstraint2(NonHarvestingHorizonAggregation,PDSSet)..
  sum(FCIGodownSet,
    FCICAPPDSGrain(NonHarvestingHorizonAggregation,FCIGodownSet,PDSSet)
  ) +
  sum(FCIGodownSet,
    FCICoveredPDSGrain(NonHarvestingHorizonAggregation,FCIGodownSet,PDSSet)
  ) =g= PDSDemand(NonHarvestingHorizonAggregation,PDSSet)
  ;

Model TPDSModel /
  TPDSConstraint1
  TPDSConstraint2
  /;
