$title Transportation task variable and constraint declaration

*=======================================================================================
* Declaration of equations (constraints) related to the operation modeled in this file
*======================================================================================

Equations
                 TransportationMassConstraint1
                 TransportationMassConstraint2
                 TransportationMassConstraint3
                 TransportationMassConstraint4
                 TransportationMassConstraint5
                 TransportationMassConstraint6
                 TransportationMassConstraint7
                 TransportationMassConstraint8
                 TransportationMassConstraint9
                 TransportationMassConstraint10
                 TransportationMassConstraint11
                 TransportationMassConstraint12
                 TransportationMassConstraint13
                 TransportationMassConstraint14
                 TransportationMassConstraint15
                 TransportationMassConstraint16
                 TransportationMassConstraint17
                 TransportationMassConstraint18

                 TransportationMassConstraint1A
                 TransportationMassConstraint2A
                 TransportationMassConstraint3A
                 TransportationMassConstraint4A
                 TransportationMassConstraint5A
                 TransportationMassConstraint6A
                 TransportationMassConstraint7A
                 TransportationMassConstraint8A
                 TransportationMassConstraint9A
                 TransportationMassConstraint10A
                 TransportationMassConstraint11A
                 TransportationMassConstraint12A
                 TransportationMassConstraint13A
                 TransportationMassConstraint14A
                 TransportationMassConstraint15A
                 TransportationMassConstraint16A
                 TransportationMassConstraint17A
                 TransportationMassConstraint18A
                 ;



*==============================================================================================================================
* Including the constraint for trasportation fleet requirement based on weight of the biomass transported.
*==============================================================================================================================
TransportationMassConstraint1(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)..
                 HarvestFarmGateLocalCSPGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)
                 *(1+GrainMoisture(HarvestingHorizonAggregation))
                 =l=
                 sum(TransportationTypes$(TransportationData('ShortDistanceIndicator',TransportationTypes)),
                         FarmLocalCSPTruckTripRequirement(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,TransportationTypes)
                         *TransportationData('MaximumLoad',TransportationTypes)
                 );


TransportationMassConstraint2(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)..
                 HarvestFarmGateRegionalCSPGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
                 *(1+GrainMoisture(HarvestingHorizonAggregation))
                 =l=
                 sum(TransportationTypes$(TransportationData('MediumDistanceIndicator',TransportationTypes)),
                         FarmRegionalCSPTruckTripRequirement(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,TransportationTypes)
                         *TransportationData('MaximumLoad',TransportationTypes)
                 );


TransportationMassConstraint3(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet)..
                 HarvestFarmGateLocalMarketGrain(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
                 *(1+GrainMoisture(HarvestingHorizonAggregation))
                 =l=
                 sum(TransportationTypes$(TransportationData('ShortDistanceIndicator',TransportationTypes)),
                         FarmLocalMarketTruckTripRequirement(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet,TransportationTypes)
                         *TransportationData('MaximumLoad',TransportationTypes)
                 );

TransportationMassConstraint4(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)..
                 HarvestFarmGateRegionalMarketGrain(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)
                 *(1+GrainMoisture(HarvestingHorizonAggregation))
                 =l=
                 sum(TransportationTypes$(TransportationData('MediumDistanceIndicator',TransportationTypes)),
                         FarmRegionalMarketTruckTripRequirement(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet,TransportationTypes)
                         *TransportationData('MaximumLoad',TransportationTypes)
                 );


TransportationMassConstraint5(HarvestingHorizonAggregation,FarmNumber)..
                 HarvestFarmGateDirectPurchaseGrain(HarvestingHorizonAggregation,FarmNumber)
                 *(1+GrainMoisture(HarvestingHorizonAggregation))
                 =l=
                 sum(TransportationTypes$(TransportationData('MediumDistanceIndicator',TransportationTypes)),
                         FarmDirectPurchaseTruckTripRequirement(HarvestingHorizonAggregation,FarmNumber,TransportationTypes)
                         *TransportationData('MaximumLoad',TransportationTypes)
                 );


TransportationMassConstraint6(HarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet)$(not(CentralStorageProcessing))..
                                 sum((FarmNumber,HarvestingHorizonAggregation2)$(Par_FarmPackingDensity(FarmNumber)),
                                         LocalCSPLocalMarketGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,LocalMarketSet,
                                                         HarvestingHorizonAggregation2)
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                 )
                                 =l=
                                 sum(TransportationTypes$(TransportationData('ShortDistanceIndicator',TransportationTypes)),
                                          LocalCSPLocalMarketTruckTripRequirement(HarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,
                                                         TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );


TransportationMassConstraint7(HarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet)$(not(CentralStorageProcessing))..
                                 sum((FarmNumber,HarvestingHorizonAggregation2)$(Par_FarmPackingDensity(FarmNumber)),
                                         LocalCSPRegionalMarketGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,
                                                         HarvestingHorizonAggregation2)
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                 )
                                 =l=
                                 sum(TransportationTypes$(TransportationData('MediumDistanceIndicator',TransportationTypes)),
                                          LocalCSPRegionalMarketTruckTripRequirement(HarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,
                                                         TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );




TransportationMassConstraint8(HarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet)$(not(CentralStorageProcessing))..
                                 sum((FarmNumber,HarvestingHorizonAggregation2)$(Par_FarmPackingDensity(FarmNumber)),
                                         RegionalCSPLocalMarketGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,
                                                         HarvestingHorizonAggregation2)
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                 )
                                 =l=
                                 sum(TransportationTypes$(TransportationData('MediumDistanceIndicator',TransportationTypes)),
                                          RegionalCSPLocalMarketTruckTripRequirement(HarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,
                                                         TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );



TransportationMassConstraint9(HarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet)$(not(CentralStorageProcessing))..
                                 sum((FarmNumber,HarvestingHorizonAggregation2)$(Par_FarmPackingDensity(FarmNumber)),
                                         RegionalCSPRegionalMarketGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,
                                                         HarvestingHorizonAggregation2)
                                        *(1+GrainMoisture(HarvestingHorizonAggregation))
                                 )
                                 =l=
                                 sum(TransportationTypes$(TransportationData('MediumDistanceIndicator',TransportationTypes)),
                                          RegionalCSPRegionalMarketTruckTripRequirement(HarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,
                                                         TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );



TransportationMassConstraint10(HarvestingHorizonAggregation,LocalMarketSet,RGYSet)$(not(CentralStorageProcessing))..
                               LocalMarketPrivateTraderRGYGrain(HarvestingHorizonAggregation,LocalMarketSet,RGYSet)
                               *(1+GrainMoisture(HarvestingHorizonAggregation))
                               =l=
                               sum(TransportationTypes$(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          LocalMarketRGYTruckTripRequirement(HarvestingHorizonAggregation,LocalMarketSet,RGYSet,TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );

TransportationMassConstraint11(HarvestingHorizonAggregation,RegionalMarketSet,RGYSet)$(not(CentralStorageProcessing))..
                               RegionalMarketPrivateTraderRGYGrain(HarvestingHorizonAggregation,RegionalMarketSet,RGYSet)
                               *(1+GrainMoisture(HarvestingHorizonAggregation))
                               =l=
                               sum(TransportationTypes$(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          RegionalMarketRGYTruckTripRequirement(HarvestingHorizonAggregation,RegionalMarketSet,RGYSet,TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );

TransportationMassConstraint12(HarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet)$(not(CentralStorageProcessing))..
                               RegionalMarketFCIGrain(HarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet)
                               *(1+GrainMoisture(HarvestingHorizonAggregation))
                               =l=
                               sum(TransportationTypes$(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          RegionalMarketFCITruckTripRequirement(HarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet,TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );

TransportationMassConstraint13(HarvestingHorizonAggregation,RGYSet,MillerSet)..
                               RGYMillerGrain(HarvestingHorizonAggregation,RGYSet,MillerSet)
                               *(1+GrainMoisture(HarvestingHorizonAggregation))
                               =l=
                               sum(TransportationTypes$(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          RGYMillerTruckTripRequirement(HarvestingHorizonAggregation,RGYSet,MillerSet,TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );

TransportationMassConstraint14(HarvestingHorizonAggregation,RGYSet,RetailerSet)..
                               RGYRetailerGrain(HarvestingHorizonAggregation,RGYSet,RetailerSet)
                               *(1+GrainMoisture(HarvestingHorizonAggregation))
                               =l=
                               sum(TransportationTypes$(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          RGYRetailerTruckTripRequirement(HarvestingHorizonAggregation,RGYSet,RetailerSet,TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );

TransportationMassConstraint15(HarvestingHorizonAggregation,FCIGodownSet,MillerSet)..
                               (FCICAPMillerGrain(HarvestingHorizonAggregation,FCIGodownSet,MillerSet)
                                + FCICoveredMillerGrain(HarvestingHorizonAggregation,FCIGodownSet,MillerSet))
                               *(1+GrainMoisture(HarvestingHorizonAggregation))
                               =l=
                               sum(TransportationTypes$(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          FCIMillerTruckTripRequirement(HarvestingHorizonAggregation,FCIGodownSet,MillerSet,TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );

TransportationMassConstraint16(HarvestingHorizonAggregation,FCIGodownSet,RetailerSet)..
                               (FCICAPRetailerGrain(HarvestingHorizonAggregation,FCIGodownSet,RetailerSet)
                                + FCICoveredRetailerGrain(HarvestingHorizonAggregation,FCIGodownSet,RetailerSet))
                               *(1+GrainMoisture(HarvestingHorizonAggregation))
                               =l=
                               sum(TransportationTypes$(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          FCIRetailerTruckTripRequirement(HarvestingHorizonAggregation,FCIGodownSet,RetailerSet,TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );

TransportationMassConstraint17(HarvestingHorizonAggregation,FCIGodownSet,PDSSet)..
                               (FCICAPPDSGrain(HarvestingHorizonAggregation,FCIGodownSet,PDSSet)
                                + FCICoveredPDSGrain(HarvestingHorizonAggregation,FCIGodownSet,PDSSet))
                               *(1+GrainMoisture(HarvestingHorizonAggregation))
                               =l=
                               sum(TransportationTypes$(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          FCIPDSTruckTripRequirement(HarvestingHorizonAggregation,FCIGodownSet,PDSSet,TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );

TransportationMassConstraint18(HarvestingHorizonAggregation,MillerSet,RetailerSet)..
                               MillerRetailerGrain(HarvestingHorizonAggregation,MillerSet,RetailerSet)
                               =l=
                               sum(TransportationTypes$(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          MillerRetailerTruckTripRequirement(HarvestingHorizonAggregation,MillerSet,RetailerSet,TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );

*=================================================================================================================================================================
* Repeating the same constraints for the non-harvesting horizon
*=================================================================================================================================================================

TransportationMassConstraint1A(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)..
                 HarvestFarmGateLocalCSPGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)
                 *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                 =l=
                 sum(TransportationTypes$(TransportationData('ShortDistanceIndicator',TransportationTypes)),
                         FarmLocalCSPTruckTripRequirement(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,TransportationTypes)
                         *TransportationData('MaximumLoad',TransportationTypes)
                 );


TransportationMassConstraint2A(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)..
                 HarvestFarmGateRegionalCSPGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
                 *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                 =l=
                 sum(TransportationTypes$(TransportationData('MediumDistanceIndicator',TransportationTypes)),
                         FarmRegionalCSPTruckTripRequirement(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,TransportationTypes)
                         *TransportationData('MaximumLoad',TransportationTypes)
                 );


TransportationMassConstraint3A(NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet)..
                 HarvestFarmGateLocalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
                 *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                 =l=
                 sum(TransportationTypes$(TransportationData('ShortDistanceIndicator',TransportationTypes)),
                         FarmLocalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet,TransportationTypes)
                         *TransportationData('MaximumLoad',TransportationTypes)
                 );

TransportationMassConstraint4A(NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)..
                 HarvestFarmGateRegionalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)
                 *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                 =l=
                 sum(TransportationTypes$(TransportationData('MediumDistanceIndicator',TransportationTypes)),
                         FarmRegionalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet,TransportationTypes)
                         *TransportationData('MaximumLoad',TransportationTypes)
                 );


TransportationMassConstraint5A(NonHarvestingHorizonAggregation,FarmNumber)..
                 HarvestFarmGateDirectPurchaseGrain(NonHarvestingHorizonAggregation,FarmNumber)
                 *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                 =l=
                 sum(TransportationTypes$(TransportationData('LongDistanceIndicator',TransportationTypes)),
                         FarmDirectPurchaseTruckTripRequirement(NonHarvestingHorizonAggregation,FarmNumber,TransportationTypes)
                         *TransportationData('MaximumLoad',TransportationTypes)
                 );



TransportationMassConstraint6A(NonHarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet)$(not(CentralStorageProcessing))..
                                 sum((FarmNumber,HarvestingHorizonAggregation)$(Par_FarmPackingDensity(FarmNumber)),
                                         LocalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,LocalMarketSet,
                                                         HarvestingHorizonAggregation)
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                 )
                                 =l=
                                 sum(TransportationTypes$(TransportationData('ShortDistanceIndicator',TransportationTypes)),
                                          LocalCSPLocalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,
                                                         TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );


TransportationMassConstraint7A(NonHarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet)$(not(CentralStorageProcessing))..
                                 sum((FarmNumber,HarvestingHorizonAggregation)$(Par_FarmPackingDensity(FarmNumber)),
                                         LocalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,
                                                         HarvestingHorizonAggregation)
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                 )
                                 =l=
                                 sum(TransportationTypes$(TransportationData('MediumDistanceIndicator',TransportationTypes)),
                                          LocalCSPRegionalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,
                                                         TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );



TransportationMassConstraint8A(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet)$(not(CentralStorageProcessing))..
                                 sum((FarmNumber,HarvestingHorizonAggregation)$(Par_FarmPackingDensity(FarmNumber)),
                                         RegionalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,
                                                         HarvestingHorizonAggregation)
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                 )
                                 =l=
                                 sum(TransportationTypes$(TransportationData('MediumDistanceIndicator',TransportationTypes)),
                                          RegionalCSPLocalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,
                                                         TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );



TransportationMassConstraint9A(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet)$(not(CentralStorageProcessing))..
                                 sum((FarmNumber,HarvestingHorizonAggregation)$(Par_FarmPackingDensity(FarmNumber)),
                                         RegionalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,
                                                         HarvestingHorizonAggregation)
                                        *(1+GrainMoisture(HarvestingHorizonAggregation))
                                 )
                                 =l=
                                 sum(TransportationTypes$(TransportationData('MediumDistanceIndicator',TransportationTypes)),
                                          RegionalCSPRegionalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,
                                                         TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );

TransportationMassConstraint10A(NonHarvestingHorizonAggregation,LocalMarketSet,RGYSet)$(not(CentralStorageProcessing))..
                               LocalMarketPrivateTraderRGYGrain(NonHarvestingHorizonAggregation,LocalMarketSet,RGYSet)
                               *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                               =l=
                               sum(TransportationTypes$(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          LocalMarketRGYTruckTripRequirement(NonHarvestingHorizonAggregation,LocalMarketSet,RGYSet,TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );
TransportationMassConstraint11A(NonHarvestingHorizonAggregation,RegionalMarketSet,RGYSet)$(not(CentralStorageProcessing))..
                               RegionalMarketPrivateTraderRGYGrain(NonHarvestingHorizonAggregation,RegionalMarketSet,RGYSet)
                               *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                               =l=
                               sum(TransportationTypes$(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          RegionalMarketRGYTruckTripRequirement(NonHarvestingHorizonAggregation,RegionalMarketSet,RGYSet,TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );

TransportationMassConstraint12A(NonHarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet)$(not(CentralStorageProcessing))..
                               RegionalMarketFCIGrain(NonHarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet)
                               *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                               =l=
                               sum(TransportationTypes$(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          RegionalMarketFCITruckTripRequirement(NonHarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet,TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );

TransportationMassConstraint13A(NonHarvestingHorizonAggregation,RGYSet,MillerSet)..
                               RGYMillerGrain(NonHarvestingHorizonAggregation,RGYSet,MillerSet)
                               *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                               =l=
                               sum(TransportationTypes$(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          RGYMillerTruckTripRequirement(NonHarvestingHorizonAggregation,RGYSet,MillerSet,TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );

TransportationMassConstraint14A(NonHarvestingHorizonAggregation,RGYSet,RetailerSet)..
                               RGYRetailerGrain(NonHarvestingHorizonAggregation,RGYSet,RetailerSet)
                               *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                               =l=
                               sum(TransportationTypes$(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          RGYRetailerTruckTripRequirement(NonHarvestingHorizonAggregation,RGYSet,RetailerSet,TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );

TransportationMassConstraint15A(NonHarvestingHorizonAggregation,FCIGodownSet,MillerSet)..
                               (FCICAPMillerGrain(NonHarvestingHorizonAggregation,FCIGodownSet,MillerSet)
                                + FCICoveredMillerGrain(NonHarvestingHorizonAggregation,FCIGodownSet,MillerSet))
                               *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                               =l=
                               sum(TransportationTypes$(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          FCIMillerTruckTripRequirement(NonHarvestingHorizonAggregation,FCIGodownSet,MillerSet,TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );

TransportationMassConstraint16A(NonHarvestingHorizonAggregation,FCIGodownSet,RetailerSet)..
                               (FCICAPRetailerGrain(NonHarvestingHorizonAggregation,FCIGodownSet,RetailerSet)
                                + FCICoveredRetailerGrain(NonHarvestingHorizonAggregation,FCIGodownSet,RetailerSet))
                               *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                               =l=
                               sum(TransportationTypes$(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          FCIRetailerTruckTripRequirement(NonHarvestingHorizonAggregation,FCIGodownSet,RetailerSet,TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );

TransportationMassConstraint17A(NonHarvestingHorizonAggregation,FCIGodownSet,PDSSet)..
                               (FCICAPPDSGrain(NonHarvestingHorizonAggregation,FCIGodownSet,PDSSet)
                                + FCICoveredPDSGrain(NonHarvestingHorizonAggregation,FCIGodownSet,PDSSet))
                               *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                               =l=
                               sum(TransportationTypes$(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          FCIPDSTruckTripRequirement(NonHarvestingHorizonAggregation,FCIGodownSet,PDSSet,TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );

TransportationMassConstraint18A(NonHarvestingHorizonAggregation,MillerSet,RetailerSet)..
                               MillerRetailerGrain(NonHarvestingHorizonAggregation,MillerSet,RetailerSet)
                               =l=
                               sum(TransportationTypes$(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                          MillerRetailerTruckTripRequirement(NonHarvestingHorizonAggregation,MillerSet,RetailerSet,TransportationTypes)
                                          *TransportationData('MaximumLoad',TransportationTypes)

                                 );


Model TransportationMassModel /
                 TransportationMassConstraint1
                 TransportationMassConstraint2
                 TransportationMassConstraint3
                 TransportationMassConstraint4
                 TransportationMassConstraint5
                 TransportationMassConstraint6
                 TransportationMassConstraint7
                 TransportationMassConstraint8
                 TransportationMassConstraint9
                 TransportationMassConstraint10
                 TransportationMassConstraint11
                 TransportationMassConstraint12
                 TransportationMassConstraint13
                 TransportationMassConstraint14
                 TransportationMassConstraint15
                 TransportationMassConstraint16
                 TransportationMassConstraint17
                 TransportationMassConstraint18

                 TransportationMassConstraint1A
                 TransportationMassConstraint2A
                 TransportationMassConstraint3A
                 TransportationMassConstraint4A
                 TransportationMassConstraint5A
                 TransportationMassConstraint6A
                 TransportationMassConstraint7A
                 TransportationMassConstraint8A
                 TransportationMassConstraint9A
                 TransportationMassConstraint10A
                 TransportationMassConstraint11A
                 TransportationMassConstraint12A
                 TransportationMassConstraint13A
                 TransportationMassConstraint14A
                 TransportationMassConstraint15A
                 TransportationMassConstraint16A
                 TransportationMassConstraint17A
                 TransportationMassConstraint18A
                 /;
