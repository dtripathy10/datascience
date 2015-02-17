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
GunnyBagConstraint1(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet)..
                 FarmLocalCSPGunnyBags(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet)
                 =g=
                 HarvestFarmGateLocalCSPGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet)
                 *(1+GrainMoisture(HarvestingHorizonAggregation))
                 * card(HarvestingHorizonAggregationStep)
                 /
                 GunnyBagCapacity
                 ;

GunnyBagConstraint2(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet)..
                 FarmRegionalCSPGunnyBags(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet)
                 =g=
                 HarvestFarmGateRegionalCSPGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet)
                 *(1+GrainMoisture(HarvestingHorizonAggregation))
                 * card(HarvestingHorizonAggregationStep)
                 /
                 GunnyBagCapacity
                 ;

GunnyBagConstraint3(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)..
                 FarmLocalMarketGunnyBags(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
                 =g=
                 HarvestFarmGateLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
                 *(1+GrainMoisture(HarvestingHorizonAggregation))
                 * card(HarvestingHorizonAggregationStep)
                 /
                 GunnyBagCapacity
                 ;

GunnyBagConstraint4(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)$(connectselected(DistrictSelected,RegionalMarketSet))..
                 FarmRegionalMarketGunnyBags(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)
                 =g=
                 HarvestFarmGateRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)
                 *(1+GrainMoisture(HarvestingHorizonAggregation))
                 * card(HarvestingHorizonAggregationStep)
                 /
                 GunnyBagCapacity
                 ;

GunnyBagConstraint5(HarvestingHorizonAggregation,DistrictSelected,FarmNumber)..
                 FarmDirectPurchaseGunnyBags(HarvestingHorizonAggregation,DistrictSelected,FarmNumber)
                 =g=
                 HarvestFarmGateDirectPurchaseGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber)
                 *(1+GrainMoisture(HarvestingHorizonAggregation))
                 * card(HarvestingHorizonAggregationStep)
                 /
                 GunnyBagCapacity
                 ;

GunnyBagConstraint6(HarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet)$(not(CentralStorageProcessing))..
                                 LocalCSPLocalMarketGunnyBags(HarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet)
                                 =g=
                                 sum((DistrictSelected,FarmNumber,HarvestingHorizonAggregation2),
                                         LocalCSPLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,
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
                                 sum((DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                         LocalCSPRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,
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
                                 sum((DistrictSelected,FarmNumber,HarvestingHorizonAggregation2),
                                         RegionalCSPLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,
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
                                 sum((DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                         RegionalCSPRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,
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

GunnyBagConstraint10(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet)..
                 FarmLocalCSPGunnyBags(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet)
                 =g=
                 HarvestFarmGateLocalCSPGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet)
                 *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                 * card(NonHarvestingHorizonAggregationStep)
                 /
                 GunnyBagCapacity
                 ;


GunnyBagConstraint11(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet)..
                 FarmRegionalCSPGunnyBags(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet)
                 =g=
                 HarvestFarmGateRegionalCSPGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet)
                 *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                 * card(NonHarvestingHorizonAggregationStep)
                 /
                 GunnyBagCapacity
                 ;

GunnyBagConstraint12(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)..
                 FarmLocalMarketGunnyBags(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
                 =g=
                 HarvestFarmGateLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
                 *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                 * card(NonHarvestingHorizonAggregationStep)
                 /
                 GunnyBagCapacity
                 ;

GunnyBagConstraint13(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)$(connectselected(DistrictSelected,RegionalMarketSet))..
                 FarmRegionalMarketGunnyBags(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)
                 =g=
                 HarvestFarmGateRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)
                 *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                 * card(NonHarvestingHorizonAggregationStep)
                 /
                 GunnyBagCapacity
                 ;

GunnyBagConstraint14(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber)..
                 FarmDirectPurchaseGunnyBags(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber)
                 =g=
                 HarvestFarmGateDirectPurchaseGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber)
                 *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                 * card(NonHarvestingHorizonAggregationStep)
                 /
                 GunnyBagCapacity
                 ;

GunnyBagConstraint15(NonHarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet)$(not(CentralStorageProcessing))..
                                 LocalCSPLocalMarketGunnyBags(NonHarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet)
                                 =g=
                                 sum((DistrictSelected,FarmNumber,HarvestingHorizonAggregation),
                                         LocalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,
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
                                 sum((DistrictSelected,FarmNumber,HarvestingHorizonAggregation)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                         LocalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,
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
                                 sum((DistrictSelected,FarmNumber,HarvestingHorizonAggregation),
                                         RegionalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,
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
                                 sum((DistrictSelected,FarmNumber,HarvestingHorizonAggregation)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                         RegionalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,
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
