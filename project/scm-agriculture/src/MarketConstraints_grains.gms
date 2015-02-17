$title Refinery variables and constraints

Equations
                 DemandConstraint1
                 DemandConstraint2
                 DemandConstraint3
                 DemandConstraint4
                 DemandConstraint5
                 DemandConstraint6
                 DemandConstraint7
                 DemandConstraint8
                 DemandConstraint9
                 DemandConstraint10
                 DemandConstraint11
                 DemandConstraint12

                 DemandConstraint13
                 DemandConstraint14
                 DemandConstraint15
                 DemandConstraint16
                 DemandConstraint17
                 DemandConstraint18
                 ;

*
* Demand constraints:
* The bimoass transported to the refinery is split into two part: The first one is used to meet the processing demend
* represented as BiorefineryCapacity and must be met; while the second part goes to the storage buffer at the refinery.
* Demand Constraint 1: This constraint ensure that the biorefinery processing demand is satisfied at all times.
* The demand (BiorefineryCapacity) is optimized.
*
DemandConstraint1(HarvestingHorizonAggregation,LocalMarketSet)$(not(CentralStorageProcessing))..
                         sum((DistrictSelected,FarmNumber),
                                 HarvestFarmGateLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((LocalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 LocalCSPLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((RegionalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 RegionalCSPLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                        =g=
                        LocalMarketDemand_LowerBound(HarvestingHorizonAggregation,LocalMarketSet);


DemandConstraint2(HarvestingHorizonAggregation,LocalMarketSet)$(not(CentralStorageProcessing))..
                         sum((DistrictSelected,FarmNumber),
                                 HarvestFarmGateLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((LocalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 LocalCSPLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((RegionalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 RegionalCSPLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                        =l=
                        LocalMarketDemand_UpperBound(HarvestingHorizonAggregation,LocalMarketSet);


DemandConstraint3(NonHarvestingHorizonAggregation,LocalMarketSet)$(not(CentralStorageProcessing))..
                         sum((DistrictSelected,FarmNumber),
                                 HarvestFarmGateLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((LocalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation),
                                 LocalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((RegionalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation),
                                 RegionalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)
                        =g=
                        LocalMarketDemand_LowerBound(NonHarvestingHorizonAggregation,LocalMarketSet);


DemandConstraint4(NonHarvestingHorizonAggregation,LocalMarketSet)$(not(CentralStorageProcessing))..
                         sum((DistrictSelected,FarmNumber),
                                 HarvestFarmGateLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((LocalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation),
                                 LocalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((RegionalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation),
                                 RegionalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)
                        =l=
                        LocalMarketDemand_UpperBound(NonHarvestingHorizonAggregation,LocalMarketSet);




DemandConstraint5(HarvestingHorizonAggregation,RegionalMarketSet)$(not(CentralStorageProcessing))..
                         sum((DistrictSelected,FarmNumber)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 HarvestFarmGateRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((LocalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and connectselected(DistrictSelected,RegionalMarketSet)),
                                 LocalCSPRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((RegionalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and connectselected(DistrictSelected,RegionalMarketSet)),
                                 RegionalCSPRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                        =g=
                        RegionalMarketDemand_LowerBound(HarvestingHorizonAggregation,RegionalMarketSet);


DemandConstraint6(HarvestingHorizonAggregation,RegionalMarketSet)$(not(CentralStorageProcessing))..
                         sum((DistrictSelected,FarmNumber)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 HarvestFarmGateRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((LocalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and connectselected(DistrictSelected,RegionalMarketSet)),
                                 LocalCSPRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((RegionalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and connectselected(DistrictSelected,RegionalMarketSet)),
                                 RegionalCSPRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                        =l=
                        RegionalMarketDemand_UpperBound(HarvestingHorizonAggregation,RegionalMarketSet);


DemandConstraint7(NonHarvestingHorizonAggregation,RegionalMarketSet)$(not(CentralStorageProcessing))..
                         sum((DistrictSelected,FarmNumber)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 HarvestFarmGateRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((LocalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 LocalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((RegionalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 RegionalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)
                        =g=
                        RegionalMarketDemand_LowerBound(NonHarvestingHorizonAggregation,RegionalMarketSet);


DemandConstraint8(NonHarvestingHorizonAggregation,RegionalMarketSet)$(not(CentralStorageProcessing))..
                         sum((DistrictSelected,FarmNumber)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 HarvestFarmGateRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((LocalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 LocalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((RegionalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 RegionalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)
                        =l=
                        RegionalMarketDemand_UpperBound(NonHarvestingHorizonAggregation,RegionalMarketSet);


DemandConstraint9(HarvestingHorizonAggregation,DistrictSelected,FarmNumber)$(not(CentralStorageProcessing))..
                        HarvestFarmGateDirectPurchaseGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber)
                        =g=
                        FarmGatePurchaseDemand_LowerBound(HarvestingHorizonAggregation,DistrictSelected,FarmNumber);


DemandConstraint10(HarvestingHorizonAggregation,DistrictSelected,FarmNumber)$(not(CentralStorageProcessing))..
                        HarvestFarmGateDirectPurchaseGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber)
                        =l=
                        FarmGatePurchaseDemand_UpperBound(HarvestingHorizonAggregation,DistrictSelected,FarmNumber);

DemandConstraint11(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber)$(not(CentralStorageProcessing))..
                        HarvestFarmGateDirectPurchaseGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber)
                        =g=
                        FarmGatePurchaseDemand_LowerBound(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber);


DemandConstraint12(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber)$(not(CentralStorageProcessing))..
                        HarvestFarmGateDirectPurchaseGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber)
                        =l=
                        FarmGatePurchaseDemand_UpperBound(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber);

*======================================================================================================================
* Including the constraints on the total grain that can be delivered at a particular location/market from a given farm
*======================================================================================================================
DemandConstraint13(DistrictSelected,FarmNumber)..
                         sum((HarvestingHorizonAggregation,LocalMarketSet),
                                 HarvestFarmGateLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
                         )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep)
                         +
                         sum((NonHarvestingHorizonAggregation,LocalMarketSet),
                                 HarvestFarmGateLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
                         )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep)
                         +
                         sum((LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 LocalCSPLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep)
                         +
                         sum((RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 RegionalCSPLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep)
                         +
                         sum((LocalCSPCenterSet,LocalMarketSet,NonHarvestingHorizonAggregation,HarvestingHorizonAggregation),
                                 LocalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep)
                         +
                         sum((RegionalCSPCenterSet,LocalMarketSet,NonHarvestingHorizonAggregation,HarvestingHorizonAggregation),
                                 RegionalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep)
                         =g=
                         GrainAvailable(DistrictSelected,FarmNumber)*Farm_LocalMarketSaleFraction*0.9;

DemandConstraint14(DistrictSelected,FarmNumber)..
                         sum((HarvestingHorizonAggregation,LocalMarketSet),
                                 HarvestFarmGateLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
                         )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep)
                         +
                         sum((NonHarvestingHorizonAggregation,LocalMarketSet),
                                 HarvestFarmGateLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
                         )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep)
                         +
                         sum((LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 LocalCSPLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep)
                         +
                         sum((RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 RegionalCSPLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep)
                         +
                         sum((LocalCSPCenterSet,LocalMarketSet,NonHarvestingHorizonAggregation,HarvestingHorizonAggregation),
                                 LocalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep)
                         +
                         sum((RegionalCSPCenterSet,LocalMarketSet,NonHarvestingHorizonAggregation,HarvestingHorizonAggregation),
                                 RegionalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep)
                         =l=
                         GrainAvailable(DistrictSelected,FarmNumber)*Farm_LocalMarketSaleFraction*1.1;

DemandConstraint15(DistrictSelected,FarmNumber)..
                         sum((HarvestingHorizonAggregation,RegionalMarketSet)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 HarvestFarmGateRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)
                         )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep)
                         +
                         sum((NonHarvestingHorizonAggregation,RegionalMarketSet)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 HarvestFarmGateRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)
                         )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep)
                         +
                         sum((LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and connectselected(DistrictSelected,RegionalMarketSet)),
                                 LocalCSPRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep)
                         +
                         sum((RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and connectselected(DistrictSelected,RegionalMarketSet)),
                                 RegionalCSPRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep)
                         +
                         sum((LocalCSPCenterSet,RegionalMarketSet,NonHarvestingHorizonAggregation,HarvestingHorizonAggregation)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 LocalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep)
                         +
                         sum((RegionalCSPCenterSet,RegionalMarketSet,NonHarvestingHorizonAggregation,HarvestingHorizonAggregation)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 RegionalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep)
                         =g=
                         GrainAvailable(DistrictSelected,FarmNumber)*Farm_RegionalMarketSaleFraction*0.9;


DemandConstraint16(DistrictSelected,FarmNumber)..
                         sum((HarvestingHorizonAggregation,RegionalMarketSet)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 HarvestFarmGateRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)
                         )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep)
                         +
                         sum((NonHarvestingHorizonAggregation,RegionalMarketSet)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 HarvestFarmGateRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)
                         )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep)
                         +
                         sum((LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and connectselected(DistrictSelected,RegionalMarketSet)),
                                 LocalCSPRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep)
                         +
                         sum((RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and connectselected(DistrictSelected,RegionalMarketSet)),
                                 RegionalCSPRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep)
                         +
                         sum((LocalCSPCenterSet,RegionalMarketSet,NonHarvestingHorizonAggregation,HarvestingHorizonAggregation)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 LocalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep)
                         +
                         sum((RegionalCSPCenterSet,RegionalMarketSet,NonHarvestingHorizonAggregation,HarvestingHorizonAggregation)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 RegionalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep)
                         =l=
                         GrainAvailable(DistrictSelected,FarmNumber)*Farm_RegionalMarketSaleFraction*1.1;

DemandConstraint17(DistrictSelected,FarmNumber)..
                         sum(HarvestingHorizonAggregation,
                                 HarvestFarmGateDirectPurchaseGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber)*card(HarvestingHorizonAggregationStep)
                         )
                         +
                         sum(NonHarvestingHorizonAggregation,
                                 HarvestFarmGateDirectPurchaseGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber)*card(NonHarvestingHorizonAggregationStep)
                         )
                         =g=
                         GrainAvailable(DistrictSelected,FarmNumber)*Farm_FarmGateSaleFraction*0.9;

DemandConstraint18(DistrictSelected,FarmNumber)..
                         sum(HarvestingHorizonAggregation,
                                 HarvestFarmGateDirectPurchaseGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber)*card(HarvestingHorizonAggregationStep)
                         )
                         +
                         sum(NonHarvestingHorizonAggregation,
                                 HarvestFarmGateDirectPurchaseGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber)*card(NonHarvestingHorizonAggregationStep)
                         )
                         =l=
                         GrainAvailable(DistrictSelected,FarmNumber)*Farm_FarmGateSaleFraction;

*
* Defining the model if the constraints are on the total grain that can be delivered at a particular market as a function of time.
* The contribution of individual farms is not considered in that case.
*
Model MarketDemandModel1 /
                 DemandConstraint1
                 DemandConstraint2
                 DemandConstraint3
                 DemandConstraint4
                 DemandConstraint5
                 DemandConstraint6
                 DemandConstraint7
                 DemandConstraint8
                 DemandConstraint9
                 DemandConstraint10
                 DemandConstraint11
                 DemandConstraint12
                 /;
*
* Defining the model if the constraints are on the total grain that can be delivered at a particular market from each farm.
* The total contribution to a particular market is then ignored as the constraints are only on the grain from individual farms.
*
Model MarketDemandModel2 /
                 DemandConstraint13
                 DemandConstraint14
                 DemandConstraint15
                 DemandConstraint16
                 DemandConstraint17
                 DemandConstraint18
                 /;
