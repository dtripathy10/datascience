$title The file that models the number of gunny bags required for transportation of the grains

Equations
         GunnyBagConstraint1
         GunnyBagConstraint2
         GunnyBagConstraint3
         GunnyBagConstraint4
         GunnyBagConstraint5
         GunnyBagConstraint6
         GunnyBagConstraint7
         GunnyBagConstraint8
         GunnyBagConstraint9

         GunnyBagConstraint10
         GunnyBagConstraint11
         GunnyBagConstraint12
         GunnyBagConstraint13
         GunnyBagConstraint14
         GunnyBagConstraint15
         GunnyBagConstraint16
         GunnyBagConstraint17
         GunnyBagConstraint18;



*=================================================================================================================================================================
* Modeling the constraints that calculate the total number of gunny bags required to transport material
*=================================================================================================================================================================
GunnyBagConstraint1(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)..
                 FarmLocalCSPGunnyBags(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)
                 =g=
                 HarvestFarmGateLocalCSPGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)
                 *(1+GrainMoisture(HarvestingHorizonAggregation))
                 * card(HarvestingHorizonAggregationStep)
                 /
                 GunnyBagCapacity
                 ;

GunnyBagConstraint2(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)..
                 FarmRegionalCSPGunnyBags(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
                 =g=
                 HarvestFarmGateRegionalCSPGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
                 *(1+GrainMoisture(HarvestingHorizonAggregation))
                 * card(HarvestingHorizonAggregationStep)
                 /
                 GunnyBagCapacity
                 ;

GunnyBagConstraint3(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet)..
                 FarmLocalMarketGunnyBags(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
                 =g=
                 HarvestFarmGateLocalMarketGrain(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
                 *(1+GrainMoisture(HarvestingHorizonAggregation))
                 * card(HarvestingHorizonAggregationStep)
                 /
                 GunnyBagCapacity
                 ;

GunnyBagConstraint4(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)..
                 FarmRegionalMarketGunnyBags(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)
                 =g=
                 HarvestFarmGateRegionalMarketGrain(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)
                 *(1+GrainMoisture(HarvestingHorizonAggregation))
                 * card(HarvestingHorizonAggregationStep)
                 /
                 GunnyBagCapacity
                 ;

GunnyBagConstraint5(HarvestingHorizonAggregation,FarmNumber)..
                 FarmDirectPurchaseGunnyBags(HarvestingHorizonAggregation,FarmNumber)
                 =g=
                 HarvestFarmGateDirectPurchaseGrain(HarvestingHorizonAggregation,FarmNumber)
                 *(1+GrainMoisture(HarvestingHorizonAggregation))
                 * card(HarvestingHorizonAggregationStep)
                 /
                 GunnyBagCapacity
                 ;

GunnyBagConstraint6(HarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet)$(not(CentralStorageProcessing))..
                                 LocalCSPLocalMarketGunnyBags(HarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet)
                                 =g=
                                 sum((FarmNumber,HarvestingHorizonAggregation2),
                                         LocalCSPLocalMarketGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,LocalMarketSet,
                                                         HarvestingHorizonAggregation2)
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                 )
                                 * card(HarvestingHorizonAggregationStep)
                                 /
                                 GunnyBagCapacity
                                 ;

GunnyBagConstraint7(HarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet)$(not(CentralStorageProcessing))..
                                 LocalCSPRegionalMarketGunnyBags(HarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet)
                                 =g=
                                 sum((FarmNumber,HarvestingHorizonAggregation2),
                                         LocalCSPRegionalMarketGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,
                                                         HarvestingHorizonAggregation2)
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                 )
                                 * card(HarvestingHorizonAggregationStep)
                                 /
                                 GunnyBagCapacity
                                 ;


GunnyBagConstraint8(HarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet)$(not(CentralStorageProcessing))..
                                 RegionalCSPLocalMarketGunnyBags(HarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet)
                                 =g=
                                 sum((FarmNumber,HarvestingHorizonAggregation2),
                                         RegionalCSPLocalMarketGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,
                                                         HarvestingHorizonAggregation2)
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                 )
                                 * card(HarvestingHorizonAggregationStep)
                                 /
                                 GunnyBagCapacity
                                 ;

GunnyBagConstraint9(HarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet)$(not(CentralStorageProcessing))..
                                 RegionalCSPRegionalMarketGunnyBags(HarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet)
                                 =g=
                                 sum((FarmNumber,HarvestingHorizonAggregation2),
                                         RegionalCSPRegionalMarketGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,
                                                         HarvestingHorizonAggregation2)
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                 )
                                 * card(HarvestingHorizonAggregationStep)
                                 /
                                 GunnyBagCapacity
                                 ;

*
* Gunny bag calculations for the non-harvesting horizon
*

GunnyBagConstraint10(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)..
                 FarmLocalCSPGunnyBags(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)
                 =g=
                 HarvestFarmGateLocalCSPGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)
                 *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                 * card(NonHarvestingHorizonAggregationStep)
                 /
                 GunnyBagCapacity
                 ;


GunnyBagConstraint11(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)..
                 FarmRegionalCSPGunnyBags(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
                 =g=
                 HarvestFarmGateRegionalCSPGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
                 *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                 * card(NonHarvestingHorizonAggregationStep)
                 /
                 GunnyBagCapacity
                 ;

GunnyBagConstraint12(NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet)..
                 FarmLocalMarketGunnyBags(NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
                 =g=
                 HarvestFarmGateLocalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
                 *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                 * card(NonHarvestingHorizonAggregationStep)
                 /
                 GunnyBagCapacity
                 ;

GunnyBagConstraint13(NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)..
                 FarmRegionalMarketGunnyBags(NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)
                 =g=
                 HarvestFarmGateRegionalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)
                 *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                 * card(NonHarvestingHorizonAggregationStep)
                 /
                 GunnyBagCapacity
                 ;

GunnyBagConstraint14(NonHarvestingHorizonAggregation,FarmNumber)..
                 FarmDirectPurchaseGunnyBags(NonHarvestingHorizonAggregation,FarmNumber)
                 =g=
                 HarvestFarmGateDirectPurchaseGrain(NonHarvestingHorizonAggregation,FarmNumber)
                 *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                 * card(NonHarvestingHorizonAggregationStep)
                 /
                 GunnyBagCapacity
                 ;

GunnyBagConstraint15(NonHarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet)$(not(CentralStorageProcessing))..
                                 LocalCSPLocalMarketGunnyBags(NonHarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet)
                                 =g=
                                 sum((FarmNumber,HarvestingHorizonAggregation),
                                         LocalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,LocalMarketSet,
                                                         HarvestingHorizonAggregation)
                                         *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                                 )
                                 * card(NonHarvestingHorizonAggregationStep)
                                 /
                                 GunnyBagCapacity
                                 ;

GunnyBagConstraint16(NonHarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet)$(not(CentralStorageProcessing))..
                                 LocalCSPRegionalMarketGunnyBags(NonHarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet)
                                 =g=
                                 sum((FarmNumber,HarvestingHorizonAggregation),
                                         LocalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,
                                                         HarvestingHorizonAggregation)
                                         *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                                 )
                                 * card(NonHarvestingHorizonAggregationStep)
                                 /
                                 GunnyBagCapacity
                                 ;


GunnyBagConstraint17(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet)$(not(CentralStorageProcessing))..
                                 RegionalCSPLocalMarketGunnyBags(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet)
                                 =g=
                                 sum((FarmNumber,HarvestingHorizonAggregation),
                                         RegionalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,
                                                         HarvestingHorizonAggregation)
                                         *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                                 )
                                 * card(NonHarvestingHorizonAggregationStep)
                                 /
                                 GunnyBagCapacity
                                 ;

GunnyBagConstraint18(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet)$(not(CentralStorageProcessing))..
                                 RegionalCSPRegionalMarketGunnyBags(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet)
                                 =g=
                                 sum((FarmNumber,HarvestingHorizonAggregation),
                                         RegionalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,
                                                         HarvestingHorizonAggregation)
                                         *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                                 )
                                 * card(NonHarvestingHorizonAggregationStep)
                                 /
                                 GunnyBagCapacity
                                 ;

Model GunnyBagModel /
         GunnyBagConstraint1
         GunnyBagConstraint2
         GunnyBagConstraint3
         GunnyBagConstraint4
         GunnyBagConstraint5
         GunnyBagConstraint6
         GunnyBagConstraint7
         GunnyBagConstraint8
         GunnyBagConstraint9

         GunnyBagConstraint10
         GunnyBagConstraint11
         GunnyBagConstraint12
         GunnyBagConstraint13
         GunnyBagConstraint14
         GunnyBagConstraint15
         GunnyBagConstraint16
         GunnyBagConstraint17
         GunnyBagConstraint18
         /;
