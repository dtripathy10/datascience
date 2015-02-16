$title "Retail demand constraints"

Equations
  RetailConstraint1
  RetailConstraint2
  ;

RetailConstraint1(HarvestingHorizonAggregation,RetailerSet)..
  sum(LocalMarketSet,
    LocalMarketPrivateTraderRetailerGrain(HarvestingHorizonAggregation,LocalMarketSet,RetailerSet)
  ) +
  sum(RegionalMarketSet,
    RegionalMarketPrivateTraderRetailerGrain(HarvestingHorizonAggregation,RegionalMarketSet,RetailerSet)
  ) +
  sum(FCIGodownSet,
    FCICAPRetailerGrain(HarvestingHorizonAggregation,FCIGodownSet,RetailerSet)
  ) +
  sum(FCIGodownSet,
    FCICoveredRetailerGrain(HarvestingHorizonAggregation,FCIGodownSet,RetailerSet)
  ) +
  sum(RGYSet,
    RGYRetailerGrain(HarvestingHorizonAggregation,RGYSet,RetailerSet)
  ) +
  sum(MillerSet,
    MillerRetailerGrain(HarvestingHorizonAggregation,MillerSet,RetailerSet)
  ) =g= RetailerDemand(HarvestingHorizonAggregation,RetailerSet)
  ;

RetailConstraint2(NonHarvestingHorizonAggregation,RetailerSet)..
  sum(LocalMarketSet,
    LocalMarketPrivateTraderRetailerGrain(NonHarvestingHorizonAggregation,LocalMarketSet,RetailerSet)
  ) +
  sum(RegionalMarketSet,
    RegionalMarketPrivateTraderRetailerGrain(NonHarvestingHorizonAggregation,RegionalMarketSet,RetailerSet)
  ) +
  sum(FCIGodownSet,
    FCICAPRetailerGrain(NonHarvestingHorizonAggregation,FCIGodownSet,RetailerSet)
  ) +
  sum(FCIGodownSet,
    FCICoveredRetailerGrain(NonHarvestingHorizonAggregation,FCIGodownSet,RetailerSet)
  ) +
  sum(RGYSet,
    RGYRetailerGrain(NonHarvestingHorizonAggregation,RGYSet,RetailerSet)
  ) +
  sum(MillerSet,
    MillerRetailerGrain(NonHarvestingHorizonAggregation,MillerSet,RetailerSet)
  ) =g= RetailerDemand(NonHarvestingHorizonAggregation,RetailerSet)
  ;

Model RetailerSModel /
  RetailConstraint1
  RetailConstraint2
  /;
