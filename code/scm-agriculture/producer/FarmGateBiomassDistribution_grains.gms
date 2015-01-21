 Equations
                 GrainDivisionConstraint1
                 GrainDivisionConstraint2
                 GrainDivisionConstraint3
                 GrainDivisionConstraint4
                 GrainDivisionConstraint5
                 GrainDivisionConstraint6
                 GrainDivisionConstraint7
                 GrainDivisionConstraint8
                 GrainDivisionConstraint9
                 GrainDivisionConstraint10
                 GrainDivisionConstraint11
                 GrainDivisionConstraint12
                 GrainDivisionConstraint13
                 GrainDivisionConstraint14
                 GrainDivisionConstraint15
                 GrainDivisionConstraint16
                 GrainDivisionConstraint17
                 GrainDivisionConstraint18
                 GrainDivisionConstraint19
                 GrainDivisionConstraint20
                 GrainDivisionConstraint21
                 GrainDivisionConstraint22
                 GrainDivisionConstraint23
                 GrainDivisionConstraint24
                 GrainDivisionConstraint25
                 GrainDivisionConstraint26
                 GrainDivisionConstraint27
                 GrainDivisionConstraint28
                 GrainDivisionConstraint29
                 GrainDivisionConstraint30
                 GrainDivisionConstraint31


                 GrainDivisionConstraint32
                 GrainDivisionConstraint33
                 GrainDivisionConstraint34
                 ;

*
* First calculating the Grain made available at the farm gate by the farm and tagging it to the
* availiability date as done for the storage constraints
*
*------------------------------------------------------------------------
* Constraints related to harvested Grain
*------------------------------------------------------------------------

GrainDivisionConstraint1(HarvestingHorizonAggregation,FarmNumber)$(ord(HarvestingHorizonAggregation)=1)..
                         FarmGateGrainAvailable(HarvestingHorizonAggregation,FarmNumber)
                         =e=
                         Par_HarvestToFarmGate(HarvestingHorizonAggregation,FarmNumber);


GrainDivisionConstraint2(HarvestingHorizonAggregation,FarmNumber)$(ord(HarvestingHorizonAggregation)>1)..
                         FarmGateGrainAvailable(HarvestingHorizonAggregation,FarmNumber)
                         =e=
                         sum(HarvestingHorizonAggregation2
                                 $(ord(HarvestingHorizonAggregation2)=ord(HarvestingHorizonAggregation)-1),
                                 FarmGateGrainAvailable(HarvestingHorizonAggregation2,FarmNumber)
                                 -
                                 (
                                   HarvestFarmGateDirectPurchaseGrain(HarvestingHorizonAggregation,FarmNumber)
                                   +
                                   sum(LocalCSPCenterSet, HarvestFarmGateLocalCSPGrain(HarvestingHorizonAggregation2,FarmNumber,LocalCSPCenterSet))
                                   +
                                   sum(RegionalCSPCenterSet,HarvestFarmGateRegionalCSPGrain(HarvestingHorizonAggregation2,FarmNumber,RegionalCSPCenterSet))
                                   +
                                   sum(LocalMarketSet,HarvestFarmGateLocalMarketGrain(HarvestingHorizonAggregation2,FarmNumber,LocalMarketSet))
                                   +
                                   sum(RegionalMarketSet,HarvestFarmGateRegionalMarketGrain(HarvestingHorizonAggregation2,FarmNumber,RegionalMarketSet))
                                 )*card(HarvestingHorizonAggregationStep)
                         )
                         *(1-(FarmOpenStorageDryMatterLossRate/365)*card(HarvestingHorizonAggregationStep))
                         +
                         Par_HarvestToFarmGate(HarvestingHorizonAggregation,FarmNumber);


GrainDivisionConstraint3(HarvestingHorizonAggregation,FarmNumber)..
                         (
                          HarvestFarmGateDirectPurchaseGrain(HarvestingHorizonAggregation,FarmNumber)
                          +
                          sum(LocalCSPCenterSet, HarvestFarmGateLocalCSPGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet))
                          +
                          sum(RegionalCSPCenterSet,HarvestFarmGateRegionalCSPGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet))
                          +
                          sum(LocalMarketSet,HarvestFarmGateLocalMarketGrain(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet))
                          +
                          sum(RegionalMarketSet,HarvestFarmGateRegionalMarketGrain(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet))
                         )*card(HarvestingHorizonAggregationStep)
                         =l=
                         FarmGateGrainAvailable(HarvestingHorizonAggregation,FarmNumber);

*---------------------------------------------------------------------------------------------------------------------
* Constraints connecting the harvesting horizon values to non-harvesting horizon values
*---------------------------------------------------------------------------------------------------------------------
GrainDivisionConstraint4(NonHarvestingHorizonAggregation,FarmNumber)
                 $(ord(NonHarvestingHorizonAggregation)=1)..
                 FarmGateGrainAvailable(NonHarvestingHorizonAggregation,FarmNumber)
                 =e=
                 sum(HarvestingHorizonAggregation$(ord(HarvestingHorizonAggregation)=card(HarvestingHorizonAggregation)),
                         FarmGateGrainAvailable(HarvestingHorizonAggregation,FarmNumber)
                         -
                         (
                           HarvestFarmGateDirectPurchaseGrain(HarvestingHorizonAggregation,FarmNumber)
                           +
                           sum(LocalCSPCenterSet, HarvestFarmGateLocalCSPGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet))
                           +
                           sum(RegionalCSPCenterSet,HarvestFarmGateRegionalCSPGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet))
                           +
                           sum(LocalMarketSet,HarvestFarmGateLocalMarketGrain(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet))
                           +
                           sum(RegionalMarketSet,HarvestFarmGateRegionalMarketGrain(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet))
                         )*card(HarvestingHorizonAggregationStep)
                 )
                 *(1-(FarmOpenStorageDryMatterLossRate/365)*card(HarvestingHorizonAggregationStep));


* Make sure that the Grain at the farm gate that is coming directly from the harvest is consumed in the harvesting horizon
GrainDivisionConstraint5(NonHarvestingHorizonAggregation,FarmNumber)
                 $(ord(NonHarvestingHorizonAggregation)=1)..
                 FarmGateGrainAvailable(NonHarvestingHorizonAggregation,FarmNumber)
                 =g=
                 0;


*##############################################################################################################
* Constraints for the non-harvesting horizon
*##############################################################################################################

*------------------------------------------------------------------------
* Constraints for Grain made available directly from harvest
*------------------------------------------------------------------------
GrainDivisionConstraint6(NonHarvestingHorizonAggregation,FarmNumber)$(ord(NonHarvestingHorizonAggregation)>1)..
                         FarmGateGrainAvailable(NonHarvestingHorizonAggregation,FarmNumber)
                         =e=
                         sum((NonHarvestingHorizonAggregation2)
                                 $(ord(NonHarvestingHorizonAggregation2)=ord(NonHarvestingHorizonAggregation)-1),
                                 FarmGateGrainAvailable(NonHarvestingHorizonAggregation2,FarmNumber)
                                 -
                                 (
                                   HarvestFarmGateDirectPurchaseGrain(NonHarvestingHorizonAggregation,FarmNumber)
                                   +
                                   sum(LocalCSPCenterSet, HarvestFarmGateLocalCSPGrain(NonHarvestingHorizonAggregation2,FarmNumber,LocalCSPCenterSet))
                                   +
                                   sum(RegionalCSPCenterSet,HarvestFarmGateRegionalCSPGrain(NonHarvestingHorizonAggregation2,FarmNumber,RegionalCSPCenterSet))
                                   +
                                   sum(LocalMarketSet,HarvestFarmGateLocalMarketGrain(NonHarvestingHorizonAggregation2,FarmNumber,LocalMarketSet))
                                   +
                                   sum(RegionalMarketSet,HarvestFarmGateRegionalMarketGrain(NonHarvestingHorizonAggregation2,FarmNumber,RegionalMarketSet))
                                 )*card(NonHarvestingHorizonAggregationStep)
                         )
                         *(1-(FarmOpenStorageDryMatterLossRate/365)*card(NonHarvestingHorizonAggregationStep));



GrainDivisionConstraint7(NonHarvestingHorizonAggregation,FarmNumber)..
                         (
                           HarvestFarmGateDirectPurchaseGrain(NonHarvestingHorizonAggregation,FarmNumber)
                           +
                           sum(LocalCSPCenterSet, HarvestFarmGateLocalCSPGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet))
                           +
                           sum(RegionalCSPCenterSet,HarvestFarmGateRegionalCSPGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet))
                           +
                           sum(LocalMarketSet,HarvestFarmGateLocalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet))
                           +
                           sum(RegionalMarketSet,HarvestFarmGateRegionalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet))
                         )*card(NonHarvestingHorizonAggregationStep)
                         =l=
                         FarmGateGrainAvailable(NonHarvestingHorizonAggregation,FarmNumber);


GrainDivisionConstraint8(NonHarvestingHorizonAggregation,FarmNumber)$(ord(NonHarvestingHorizonAggregation)=card(NonHarvestingHorizonAggregation))..
                         FarmGateGrainAvailable(NonHarvestingHorizonAggregation,FarmNumber)
                         -
                         (
                           HarvestFarmGateDirectPurchaseGrain(NonHarvestingHorizonAggregation,FarmNumber)
                           +
                           sum(LocalCSPCenterSet, HarvestFarmGateLocalCSPGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet))
                           +
                           sum(RegionalCSPCenterSet,HarvestFarmGateRegionalCSPGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet))
                           +
                           sum(LocalMarketSet,HarvestFarmGateLocalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet))
                           +
                           sum(RegionalMarketSet,HarvestFarmGateRegionalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet))
                         )*card(NonHarvestingHorizonAggregationStep)
                         =e= 0;

*########################################################################################################################
* Calculating the volumes of different streams after the division
*########################################################################################################################

GrainDivisionConstraint9(HarvestingHorizonAggregation,FarmNumber)$(Par_FarmPackingDensity(FarmNumber))..
         HarvestFarmGateDirectPurchaseGrainVolume(HarvestingHorizonAggregation,FarmNumber)
         =e=
         HarvestFarmGateDirectPurchaseGrain(HarvestingHorizonAggregation,FarmNumber)
         /Par_FarmPackingDensity(FarmNumber);

GrainDivisionConstraint10(NonHarvestingHorizonAggregation,FarmNumber)$(Par_FarmPackingDensity(FarmNumber))..
         HarvestFarmGateDirectPurchaseGrainVolume(NonHarvestingHorizonAggregation,FarmNumber)
         =e=
         HarvestFarmGateDirectPurchaseGrain(NonHarvestingHorizonAggregation,FarmNumber)
         /Par_FarmPackingDensity(FarmNumber);

GrainDivisionConstraint11(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)$(Par_FarmPackingDensity(FarmNumber))..
         HarvestFarmGateLocalCSPGrainVolume(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)
         =e=
         HarvestFarmGateLocalCSPGrain(HarvestingHorizonAggregation,FarmNumber, LocalCSPCenterSet)
         /Par_FarmPackingDensity(FarmNumber);

GrainDivisionConstraint12(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)$(Par_FarmPackingDensity(FarmNumber))..
         HarvestFarmGateLocalCSPGrainVolume(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)
         =e=
         HarvestFarmGateLocalCSPGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)
         /Par_FarmPackingDensity(FarmNumber);


GrainDivisionConstraint13(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)$(Par_FarmPackingDensity(FarmNumber))..
         HarvestFarmGateRegionalCSPGrainVolume(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
         =e=
         HarvestFarmGateRegionalCSPGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
         /Par_FarmPackingDensity(FarmNumber);

GrainDivisionConstraint14(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)$(Par_FarmPackingDensity(FarmNumber))..
         HarvestFarmGateRegionalCSPGrainVolume(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
         =e=
         HarvestFarmGateRegionalCSPGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
         /Par_FarmPackingDensity(FarmNumber);

GrainDivisionConstraint15(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet)$(Par_FarmPackingDensity(FarmNumber))..
         HarvestFarmGateLocalMarketGrainVolume(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
         =e=
         HarvestFarmGateLocalMarketGrain(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
         /Par_FarmPackingDensity(FarmNumber);

GrainDivisionConstraint16(NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet)$(Par_FarmPackingDensity(FarmNumber))..
         HarvestFarmGateLocalMarketGrainVolume(NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
         =e=
         HarvestFarmGateLocalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
         /Par_FarmPackingDensity(FarmNumber);

GrainDivisionConstraint17(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)$(Par_FarmPackingDensity(FarmNumber))..
         HarvestFarmGateRegionalMarketGrainVolume(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)
         =e=
         HarvestFarmGateRegionalMarketGrain(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)
         /Par_FarmPackingDensity(FarmNumber);

GrainDivisionConstraint18(NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)$(Par_FarmPackingDensity(FarmNumber))..
         HarvestFarmGateRegionalMarketGrainVolume(NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)
         =e=
         HarvestFarmGateRegionalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)
         /Par_FarmPackingDensity(FarmNumber);


*########################################################################################################################
* Constraints limiting the flow based on a particular model scenario selected. If the current supply chain scenario is selected
* the flow between farms and local/regional CSPs is forced to zero.
*########################################################################################################################

GrainDivisionConstraint19(HarvestingHorizonAggregation,FarmNumber)$(CurrentScenario)..
         sum(LocalCSPCenterSet,
                 HarvestFarmGateLocalCSPGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)
         )
         +
         sum(RegionalCSPCenterSet,
                 HarvestFarmGateRegionalCSPGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
         )
         =e=
         0;

GrainDivisionConstraint20(NonHarvestingHorizonAggregation,FarmNumber)$(CurrentScenario)..
         sum(LocalCSPCenterSet,
                 HarvestFarmGateLocalCSPGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)
         )
         +
         sum(RegionalCSPCenterSet,
                 HarvestFarmGateRegionalCSPGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
         )
         =e=
         0;



Model FarmGateGrainDistributionModel_Current /
                 GrainDivisionConstraint1
                 GrainDivisionConstraint2
                 GrainDivisionConstraint3
                 GrainDivisionConstraint4
                 GrainDivisionConstraint5
                 GrainDivisionConstraint6
                 GrainDivisionConstraint7
                 GrainDivisionConstraint8
                 GrainDivisionConstraint9
                 GrainDivisionConstraint10
                 GrainDivisionConstraint11
                 GrainDivisionConstraint12
                 GrainDivisionConstraint13
                 GrainDivisionConstraint14
                 GrainDivisionConstraint15
                 GrainDivisionConstraint16
                 GrainDivisionConstraint17
                 GrainDivisionConstraint18
                 GrainDivisionConstraint19
                 GrainDivisionConstraint20
                 /;

Model FarmGateGrainDistributionModel /
                 GrainDivisionConstraint1
                 GrainDivisionConstraint2
                 GrainDivisionConstraint3
                 GrainDivisionConstraint4
                 GrainDivisionConstraint5
                 GrainDivisionConstraint6
                 GrainDivisionConstraint7
                 GrainDivisionConstraint8
                 GrainDivisionConstraint9
                 GrainDivisionConstraint10
                 GrainDivisionConstraint11
                 GrainDivisionConstraint12
                 GrainDivisionConstraint13
                 GrainDivisionConstraint14
                 GrainDivisionConstraint15
                 GrainDivisionConstraint16
                 GrainDivisionConstraint17
                 GrainDivisionConstraint18
                 /;
