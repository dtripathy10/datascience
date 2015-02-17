Equations
  GrainDivisionC1
  GrainDivisionC2
  GrainDivisionC3
  GrainDivisionC4
  GrainDivisionC5
  GrainDivisionC6
  GrainDivisionC7
  GrainDivisionC8
  GrainDivisionC9
  ;

* First calculating the Grain made available at the farm gate by the farm and tagging it to the availiability date as done for the storage constraints
* Constraints related to harvested Grain
GrainDivisionC1(HarvestingHorizonAggregation,DistrictSelected,FarmNumber)..
  Par_HarvestToFarmGate(HarvestingHorizonAggregation,DistrictSelected,FarmNumber) =g=
    sum(LocalCSPCenterSet,
      HarvestFarmGateLocalCSPGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet)*card(HarvestingHorizonAggregationStep)$(FutureScenario)
    ) +
    sum(RegionalCSPCenterSet,
      HarvestFarmGateRegionalCSPGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet)*card(HarvestingHorizonAggregationStep)$(FutureScenario)
    ) +
    sum(LocalMarketSet,
      HarvestFarmGateLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)*card(HarvestingHorizonAggregationStep)
    ) +
    sum(RegionalMarketSet$(connectselected(DistrictSelected,RegionalMarketSet)),
      HarvestFarmGateRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)*card(HarvestingHorizonAggregationStep)
    ) +
    HarvestFarmGateDirectPurchaseGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber)*card(HarvestingHorizonAggregationStep)
  ;

* Constraints related to non-harvested Grain
GrainDivisionC2(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber)..
  Par_HarvestToFarmGate(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber) =g=
    sum(LocalCSPCenterSet,
      HarvestFarmGateLocalCSPGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet)*card(NonHarvestingHorizonAggregationStep)$(FutureScenario)
    ) +
    sum(RegionalCSPCenterSet,
      HarvestFarmGateRegionalCSPGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet)*card(NonHarvestingHorizonAggregationStep)$(FutureScenario)
    ) +
    sum(LocalMarketSet,
      HarvestFarmGateLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)*card(NonHarvestingHorizonAggregationStep)
    ) +
    sum(RegionalMarketSet$(connectselected(DistrictSelected,RegionalMarketSet)),
      HarvestFarmGateRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)*card(NonHarvestingHorizonAggregationStep)
    ) +
    HarvestFarmGateDirectPurchaseGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber)*card(NonHarvestingHorizonAggregationStep)
  ;

* Calculating the volumes of different streams after the division
* Harvest to refinery
GrainDivisionC3(HarvestingHorizonAggregation,DistrictSelected,FarmNumber)$(Par_FarmPackingDensity(DistrictSelected,FarmNumber))..
  HarvestFarmGateDirectPurchaseGrainVolume(HarvestingHorizonAggregation,DistrictSelected,FarmNumber) =e=
    HarvestFarmGateDirectPurchaseGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber) / Par_FarmPackingDensity(DistrictSelected,FarmNumber)
  ;

GrainDivisionC4(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet)$(Par_FarmPackingDensity(DistrictSelected,FarmNumber))..
  HarvestFarmGateLocalCSPGrainVolume(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet) =e=
    HarvestFarmGateLocalCSPGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber, LocalCSPCenterSet) / Par_FarmPackingDensity(DistrictSelected,FarmNumber)
  ;

GrainDivisionC5(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet)$(Par_FarmPackingDensity(DistrictSelected,FarmNumber))..
  HarvestFarmGateRegionalCSPGrainVolume(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet) =e=
    HarvestFarmGateRegionalCSPGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet) / Par_FarmPackingDensity(DistrictSelected,FarmNumber)
  ;


GrainDivisionC6(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)$(Par_FarmPackingDensity(DistrictSelected,FarmNumber))..
  HarvestFarmGateLocalMarketGrainVolume(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet) =e=
    HarvestFarmGateLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet) / Par_FarmPackingDensity(DistrictSelected,FarmNumber)
  ;


GrainDivisionC7(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)$(Par_FarmPackingDensity(DistrictSelected,FarmNumber) and connectselected(DistrictSelected,RegionalMarketSet))..
  HarvestFarmGateRegionalMarketGrainVolume(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet) =e=
    HarvestFarmGateRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet) / Par_FarmPackingDensity(DistrictSelected,FarmNumber)
  ;

* Constraints limiting the flow based on a particular model scenario selected. If the current supply chain scenario is selected
* the flow between farms and local/regional CSPs is forced to zero.
GrainDivisionC8(HarvestingHorizonAggregation,DistrictSelected,FarmNumber)$(CurrentScenario)..
  sum(LocalCSPCenterSet,
    HarvestFarmGateLocalCSPGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet)
  ) +
  sum(RegionalCSPCenterSet,
    HarvestFarmGateRegionalCSPGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet)
  )
  =e= 0
  ;

GrainDivisionC9(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber)$(CurrentScenario)..
  sum(LocalCSPCenterSet,
    HarvestFarmGateLocalCSPGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet)
  ) +
  sum(RegionalCSPCenterSet,
    HarvestFarmGateRegionalCSPGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet)
  )
  =e= 0
  ;

Model FarmGateGrainDistributionModelConstrained_Current /
  GrainDivisionC1
  GrainDivisionC2
  GrainDivisionC3
  GrainDivisionC4
  GrainDivisionC5
  GrainDivisionC6
  GrainDivisionC7
  GrainDivisionC8
  GrainDivisionC9
  /;

Model FarmGateGrainDistributionModelConstrained /
  GrainDivisionC1
  GrainDivisionC2
  GrainDivisionC3
  GrainDivisionC4
  GrainDivisionC5
  GrainDivisionC6
  GrainDivisionC7
  /;
