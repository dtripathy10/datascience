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

*
* First calculating the Grain made available at the farm gate by the farm and tagging it to the
* availiability date as done for the storage constraints
*
*-----------------------------------------------------------------------
* Constraints related to harvested Grain
*------------------------------------------------------------------------

GrainDivisionC1(HarvestingHorizonAggregation,FarmNumber)..
         Par_HarvestToFarmGate(HarvestingHorizonAggregation,FarmNumber)
         =g=
         sum(LocalCSPCenterSet,
                 HarvestFarmGateLocalCSPGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)*card(HarvestingHorizonAggregationStep)$(FutureScenario)
         )
         +
         sum(RegionalCSPCenterSet,
                 HarvestFarmGateRegionalCSPGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)*card(HarvestingHorizonAggregationStep)$(FutureScenario)
         )
         +
         sum(LocalMarketSet,
                 HarvestFarmGateLocalMarketGrain(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet)*card(HarvestingHorizonAggregationStep)
         )
         +
         sum(RegionalMarketSet,
                 HarvestFarmGateRegionalMarketGrain(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)*card(HarvestingHorizonAggregationStep)
         )
         +
         HarvestFarmGateDirectPurchaseGrain(HarvestingHorizonAggregation,FarmNumber)*card(HarvestingHorizonAggregationStep);

*##############################################################################################################
* Constraints for the non-harvesting horizon
*##############################################################################################################

GrainDivisionC2(NonHarvestingHorizonAggregation,FarmNumber)..
         Par_HarvestToFarmGate(NonHarvestingHorizonAggregation,FarmNumber)
         =g=
         sum(LocalCSPCenterSet,
                 HarvestFarmGateLocalCSPGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)*card(NonHarvestingHorizonAggregationStep)$(FutureScenario)
         )
         +
         sum(RegionalCSPCenterSet,
                 HarvestFarmGateRegionalCSPGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)*card(NonHarvestingHorizonAggregationStep)$(FutureScenario)
         )
         +
         sum(LocalMarketSet,
                 HarvestFarmGateLocalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet)*card(NonHarvestingHorizonAggregationStep)
         )
         +
         sum(RegionalMarketSet,
                 HarvestFarmGateRegionalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)*card(NonHarvestingHorizonAggregationStep)
         )
         +
         HarvestFarmGateDirectPurchaseGrain(NonHarvestingHorizonAggregation,FarmNumber)*card(NonHarvestingHorizonAggregationStep);


*########################################################################################################################
* Calculating the volumes of different streams after the division
*########################################################################################################################
*
* Harvest to refinery
*
GrainDivisionC3(HarvestingHorizonAggregation,FarmNumber)$(Par_FarmPackingDensity(FarmNumber))..
         HarvestFarmGateDirectPurchaseGrainVolume(HarvestingHorizonAggregation,FarmNumber)
         =e=
         HarvestFarmGateDirectPurchaseGrain(HarvestingHorizonAggregation,FarmNumber)
         /Par_FarmPackingDensity(FarmNumber);

GrainDivisionC4(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)$(Par_FarmPackingDensity(FarmNumber))..
         HarvestFarmGateLocalCSPGrainVolume(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)
         =e=
         HarvestFarmGateLocalCSPGrain(HarvestingHorizonAggregation,FarmNumber, LocalCSPCenterSet)
         /Par_FarmPackingDensity(FarmNumber);


GrainDivisionC5(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)$(Par_FarmPackingDensity(FarmNumber))..
         HarvestFarmGateRegionalCSPGrainVolume(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
         =e=
         HarvestFarmGateRegionalCSPGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
         /Par_FarmPackingDensity(FarmNumber);


GrainDivisionC6(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet)$(Par_FarmPackingDensity(FarmNumber))..
         HarvestFarmGateLocalMarketGrainVolume(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
         =e=
         HarvestFarmGateLocalMarketGrain(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
         /Par_FarmPackingDensity(FarmNumber);


GrainDivisionC7(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)$(Par_FarmPackingDensity(FarmNumber))..
         HarvestFarmGateRegionalMarketGrainVolume(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)
         =e=
         HarvestFarmGateRegionalMarketGrain(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)
         /Par_FarmPackingDensity(FarmNumber);


*########################################################################################################################
* Constraints limiting the flow based on a particular model scenario selected. If the current supply chain scenario is selected
* the flow between farms and local/regional CSPs is forced to zero.
*########################################################################################################################

GrainDivisionC8(HarvestingHorizonAggregation,FarmNumber)$(CurrentScenario)..
         sum(LocalCSPCenterSet,
                 HarvestFarmGateLocalCSPGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)
         )
         +
         sum(RegionalCSPCenterSet,
                 HarvestFarmGateRegionalCSPGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
         )
         =e=
         0;

GrainDivisionC9(NonHarvestingHorizonAggregation,FarmNumber)$(CurrentScenario)..
         sum(LocalCSPCenterSet,
                 HarvestFarmGateLocalCSPGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)
         )
         +
         sum(RegionalCSPCenterSet,
                 HarvestFarmGateRegionalCSPGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
         )
         =e=
         0;



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
