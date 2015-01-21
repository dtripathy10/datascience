$title Transportation task variable and constraint declaration

*=======================================================================================
* Declaration of equations (constraints) related to the operation modeled in this file
*=======================================================================================

Equations
                 TransportationVolumeConstraint1
                 TransportationVolumeConstraint2
                 TransportationVolumeConstraint3
                 TransportationVolumeConstraint4
                 TransportationVolumeConstraint5
                 TransportationVolumeConstraint6
                 TransportationVolumeConstraint7
                 TransportationVolumeConstraint8
                 TransportationVolumeConstraint9

                 TransportationVolumeConstraint1A
                 TransportationVolumeConstraint2A
                 TransportationVolumeConstraint3A
                 TransportationVolumeConstraint4A
                 TransportationVolumeConstraint5A
                 TransportationVolumeConstraint6A
                 TransportationVolumeConstraint7A
                 TransportationVolumeConstraint8A
                 TransportationVolumeConstraint9A
                 ;


*=======================================================================================
* Constraints related to biomass Transportation
*=======================================================================================
* Transportation constraints
* Total biomass weight transported from the farm to the refinery on a given day must not exceed the total capacity of the
* transportation fleet dedicated to the farm. The total transported weight is calculated as the sum of the dry weight (which
* is given by the Biomass variables, and the additional weight due to the moisture content.
* Similarly, the total volume of biomass transported per truck should not exceed the volumetric capacity of the truck. Hence a similar
* constraint (like the weight constraint) is also applied for volume. The constraint for volume is expected to be binding one.

*=======================================================================================
* First calculating the total number of trips of each type required
*=======================================================================================
*
* Including the constraint for trasportation fleet requirement based on volume of the grain transported.
*
TransportationVolumeConstraint1(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)..
                 HarvestFarmGateLocalCSPGrainVolume(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)
                 =l=
                 sum(TransportationTypes$
                                 (TransportationData('LongDistanceIndicator',TransportationTypes)),
                         FarmLocalCSPTruckTripRequirement(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,TransportationTypes)
                         *TransportationData('Volume',TransportationTypes)
                 );


TransportationVolumeConstraint2(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)..
                 HarvestFarmGateRegionalCSPGrainVolume(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
                 =l=
                 sum(TransportationTypes$
                                 (TransportationData('LongDistanceIndicator',TransportationTypes)),
                         FarmRegionalCSPTruckTripRequirement(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,TransportationTypes)
                         *TransportationData('Volume',TransportationTypes)
                 );


TransportationVolumeConstraint3(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet)..
                 HarvestFarmGateLocalMarketGrainVolume(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
                 =l=
                 sum(TransportationTypes$
                                 (TransportationData('LongDistanceIndicator',TransportationTypes)),
                         FarmLocalMarketTruckTripRequirement(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet,TransportationTypes)
                         *TransportationData('Volume',TransportationTypes)
                 );

TransportationVolumeConstraint4(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)..
                 HarvestFarmGateRegionalMarketGrainVolume(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)
                 =l=
                 sum(TransportationTypes$
                                 (TransportationData('LongDistanceIndicator',TransportationTypes)),
                         FarmRegionalMarketTruckTripRequirement(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet,TransportationTypes)
                         *TransportationData('Volume',TransportationTypes)
                 );


TransportationVolumeConstraint5(HarvestingHorizonAggregation,FarmNumber)..
                 HarvestFarmGateDirectPurchaseGrainVolume(HarvestingHorizonAggregation,FarmNumber)
                 =l=
                 sum(TransportationTypes$
                                 (TransportationData('LongDistanceIndicator',TransportationTypes)),
                         FarmDirectPurchaseTruckTripRequirement(HarvestingHorizonAggregation,FarmNumber,TransportationTypes)
                         *TransportationData('Volume',TransportationTypes)
                 );


*=============================================================================================================================================
* The transportation between CSPs and the markets depends on whether processing is being carried out since that will impact the density of
* grains.
* First, considering constraints for the case where there is no processing and hence the density remains same as that of the farm output
*=============================================================================================================================================
TransportationVolumeConstraint6(HarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet)$(not(CentralStorageProcessing))..
                                 sum((FarmNumber,HarvestingHorizonAggregation2)$(Par_FarmPackingDensity(FarmNumber)),
                                         LocalCSPLocalMarketGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,LocalMarketSet,
                                                         HarvestingHorizonAggregation2)
                                         /
                                         Par_FarmPackingDensity(FarmNumber)
                                 )
                                 =l=
                                 sum(TransportationTypes$
                                         (TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          LocalCSPLocalMarketTruckTripRequirement(HarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,
                                                         TransportationTypes)
                                          *TransportationData('Volume',TransportationTypes)

                                 );


TransportationVolumeConstraint7(HarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet)$(not(CentralStorageProcessing))..
                                 sum((FarmNumber,HarvestingHorizonAggregation2)$(Par_FarmPackingDensity(FarmNumber)),
                                         LocalCSPRegionalMarketGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,
                                                         HarvestingHorizonAggregation2)
                                         /
                                         Par_FarmPackingDensity(FarmNumber)
                                 )
                                 =l=
                                 sum(TransportationTypes$
                                         (TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          LocalCSPRegionalMarketTruckTripRequirement(HarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,
                                                         TransportationTypes)
                                          *TransportationData('Volume',TransportationTypes)

                                 );




TransportationVolumeConstraint8(HarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet)$(not(CentralStorageProcessing))..
                                 sum((FarmNumber,HarvestingHorizonAggregation2)$(Par_FarmPackingDensity(FarmNumber)),
                                         RegionalCSPLocalMarketGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,
                                                         HarvestingHorizonAggregation2)
                                         /
                                         Par_FarmPackingDensity(FarmNumber)
                                 )
                                 =l=
                                 sum(TransportationTypes$
                                         (TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          RegionalCSPLocalMarketTruckTripRequirement(HarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,
                                                         TransportationTypes)
                                          *TransportationData('Volume',TransportationTypes)

                                 );



TransportationVolumeConstraint9(HarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet)$(not(CentralStorageProcessing))..
                                 sum((FarmNumber,HarvestingHorizonAggregation2)$(Par_FarmPackingDensity(FarmNumber)),
                                         RegionalCSPRegionalMarketGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,
                                                         HarvestingHorizonAggregation2)
                                         /
                                         Par_FarmPackingDensity(FarmNumber)
                                 )
                                 =l=
                                 sum(TransportationTypes$
                                         (TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          RegionalCSPRegionalMarketTruckTripRequirement(HarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,
                                                         TransportationTypes)
                                          *TransportationData('Volume',TransportationTypes)

                                 );


*=================================================================================================================================================================
* Repeating the same constraints for the non-harvesting horizon
*=================================================================================================================================================================

*
* Including the constraint for trasportation fleet requirement based on volume of the grain transported.
*
TransportationVolumeConstraint1A(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)..
                 HarvestFarmGateLocalCSPGrainVolume(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)
                 =l=
                 sum(TransportationTypes$
                                 (TransportationData('LongDistanceIndicator',TransportationTypes)),
                         FarmLocalCSPTruckTripRequirement(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,TransportationTypes)
                         *TransportationData('Volume',TransportationTypes)
                 );


TransportationVolumeConstraint2A(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)..
                 HarvestFarmGateRegionalCSPGrainVolume(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
                 =l=
                 sum(TransportationTypes$
                                 (TransportationData('LongDistanceIndicator',TransportationTypes)),
                         FarmRegionalCSPTruckTripRequirement(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,TransportationTypes)
                         *TransportationData('Volume',TransportationTypes)
                 );


TransportationVolumeConstraint3A(NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet)..
                 HarvestFarmGateLocalMarketGrainVolume(NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
                 =l=
                 sum(TransportationTypes$
                                 (TransportationData('LongDistanceIndicator',TransportationTypes)),
                         FarmLocalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet,TransportationTypes)
                         *TransportationData('Volume',TransportationTypes)
                 );

TransportationVolumeConstraint4A(NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)..
                 HarvestFarmGateRegionalMarketGrainVolume(NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)
                 =l=
                 sum(TransportationTypes$
                                 (TransportationData('LongDistanceIndicator',TransportationTypes)),
                         FarmRegionalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet,TransportationTypes)
                         *TransportationData('Volume',TransportationTypes)
                 );


TransportationVolumeConstraint5A(NonHarvestingHorizonAggregation,FarmNumber)..
                 HarvestFarmGateDirectPurchaseGrainVolume(NonHarvestingHorizonAggregation,FarmNumber)
                 =l=
                 sum(TransportationTypes$
                                 (TransportationData('LongDistanceIndicator',TransportationTypes)),
                         FarmDirectPurchaseTruckTripRequirement(NonHarvestingHorizonAggregation,FarmNumber,TransportationTypes)
                         *TransportationData('Volume',TransportationTypes)
                 );


*=============================================================================================================================================
* The transportation between CSPs and the markets depends on whether processing is being carried out since that will impact the density of
* grains.
* First, considering constraints for the case where there is no processing and hence the density remains same as that of the farm output
*=============================================================================================================================================
TransportationVolumeConstraint6A(NonHarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet)$(not(CentralStorageProcessing))..
                                 sum((FarmNumber,HarvestingHorizonAggregation)$(Par_FarmPackingDensity(FarmNumber)),
                                         LocalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,LocalMarketSet,
                                                         HarvestingHorizonAggregation)
                                         /
                                         Par_FarmPackingDensity(FarmNumber)
                                 )
                                 =l=
                                 sum(TransportationTypes$
                                         (TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          LocalCSPLocalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,
                                                         TransportationTypes)
                                          *TransportationData('Volume',TransportationTypes)

                                 );


TransportationVolumeConstraint7A(NonHarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet)$(not(CentralStorageProcessing))..
                                 sum((FarmNumber,HarvestingHorizonAggregation)$(Par_FarmPackingDensity(FarmNumber)),
                                         LocalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,
                                                         HarvestingHorizonAggregation)
                                         /
                                         Par_FarmPackingDensity(FarmNumber)
                                 )
                                 =l=
                                 sum(TransportationTypes$
                                         (TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          LocalCSPRegionalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,
                                                         TransportationTypes)
                                          *TransportationData('Volume',TransportationTypes)

                                 );




TransportationVolumeConstraint8A(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet)$(not(CentralStorageProcessing))..
                                 sum((FarmNumber,HarvestingHorizonAggregation)$(Par_FarmPackingDensity(FarmNumber)),
                                         RegionalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,
                                                         HarvestingHorizonAggregation)
                                         /
                                         Par_FarmPackingDensity(FarmNumber)
                                 )
                                 =l=
                                 sum(TransportationTypes$
                                         (TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          RegionalCSPLocalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,
                                                         TransportationTypes)
                                          *TransportationData('Volume',TransportationTypes)

                                 );



TransportationVolumeConstraint9A(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet)$(not(CentralStorageProcessing))..
                                 sum((FarmNumber,HarvestingHorizonAggregation)$(Par_FarmPackingDensity(FarmNumber)),
                                         RegionalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,
                                                         HarvestingHorizonAggregation)
                                         /
                                         Par_FarmPackingDensity(FarmNumber)
                                 )
                                 =l=
                                 sum(TransportationTypes$
                                         (TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          RegionalCSPRegionalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,
                                                         TransportationTypes)
                                          *TransportationData('Volume',TransportationTypes)

                                 );



Model TransportationVolumeModel /
                 TransportationVolumeConstraint1
                 TransportationVolumeConstraint2
                 TransportationVolumeConstraint3
                 TransportationVolumeConstraint4
                 TransportationVolumeConstraint5
                 TransportationVolumeConstraint6
                 TransportationVolumeConstraint7
                 TransportationVolumeConstraint8
                 TransportationVolumeConstraint9

                 TransportationVolumeConstraint1A
                 TransportationVolumeConstraint2A
                 TransportationVolumeConstraint3A
                 TransportationVolumeConstraint4A
                 TransportationVolumeConstraint5A
                 TransportationVolumeConstraint6A
                 TransportationVolumeConstraint7A
                 TransportationVolumeConstraint8A
                 TransportationVolumeConstraint9A
                 /;
