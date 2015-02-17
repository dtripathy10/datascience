$title Cost calculations for the provision problem

Equations
                 ProvisionCostConstraint1
                 ProvisionCostConstraint2
                 ProvisionCostConstraint3
                 ProvisionCostConstraint4
                 ProvisionCostConstraint5
                 ProvisionCostConstraint6
                 ProvisionCostConstraint7
                 ProvisionCostConstraint8
                 ProvisionCostConstraint9
                 ProvisionCostConstraint10
                 ProvisionCostConstraint11
                 ProvisionCostConstraint12
                 ProvisionCostConstraint13
                 ProvisionCostConstraint14
                 ProvisionCostConstraint15
                 ProvisionCostConstraint16
                 ProvisionCostConstraint17
                 ProvisionCostConstraint18
                 ;


*##############################################################################################################
* Cost constraints: Common to harvesting as well as non-harvesting horizon
*##############################################################################################################
*
*---------------------------------------------------------------------------------------------------------
* Storage cost calculation constraints
*---------------------------------------------------------------------------------------------------------
* The cost calculation for storage facilities has two components.
* 1. A function of the total area and one the function of the binary location selection variable.
* The part associated with the binary variable will represent the basic installation cost that is independent of the size of the storage facility.
* 2. The second component is the cost of storage as reported in literature on per unit basis (such as Rs. per kg).
*
* The use of one or the other depends on the availability of data.
*
* Calculation of the storage cost if the cost is given in terms Rs/meter square and therefore depends on the area of the
* storage facility. The total amount of grain stored does not matter.
*
ProvisionCostConstraint1..       LocalCSPCapitalCost
                                 =g=
                                 sum(LocalCSPCenterSet,
                                                 LocalCSPFacilityArea(LocalCSPCenterSet)*
                                                 SmallScaleStorageData('TotalCost','Steel_Drums_Pucca_House')
                                                 +
                                                 LocalCSPFacilityArea(LocalCSPCenterSet)
                                                 * StorageLandCost
                                 )
                                 ;


ProvisionCostConstraint2..       RegionalCSPCapitalCost
                                 =g=
                                 sum(RegionalCSPCenterSet,
                                                 RegionalCSPFacilityArea(RegionalCSPCenterSet)*
                                                 SmallScaleStorageData('TotalCost','Steel_Drums_Pucca_House')
                                                 +
                                                 RegionalCSPFacilityArea(RegionalCSPCenterSet)
                                                 * StorageLandCost
                                 )
                                 ;
*
* Calculation of the storage cost if the cost is given in terms of Rs/kg. Here, the total area of the storage facility
* does not matter as that is not accounted for in the calculations.
*
ProvisionCostConstraint3..       LocalCSPStorageOperatingCost
                                 =g=
                                 sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet),
                                                 LocalCSPInput(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet)
                                                 *card(HarvestingHorizonAggregationStep)
                                                 *SmallScaleStorageData('StoragCost','Kothi_Pucca_House')
                                 )
                                 +
                                 sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet),
                                                 LocalCSPInput(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet)
                                                 *card(NonHarvestingHorizonAggregationStep)
                                                 *SmallScaleStorageData('StoragCost','Kothi_Pucca_House')
                                 );

ProvisionCostConstraint4..       RegionalCSPStorageOperatingCost
                                 =g=
                                 sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet),
                                                 RegionalCSPInput(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet)
                                                 *card(HarvestingHorizonAggregationStep)
                                                 *SmallScaleStorageData('StoragCost','Kothi_Pucca_House')
                                 )
                                 +
                                 sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet),
                                                 RegionalCSPInput(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet)
                                                 *card(NonHarvestingHorizonAggregationStep)
                                                 *SmallScaleStorageData('StoragCost','Steel_Drums_Pucca_House')
                                 )
                                 ;

ProvisionCostConstraint5.. RGYCapitalCost =e= sum(RGYSet, RGYCapacity(RGYSet)*RGYCapitalCostRate);
*
* The rental rate for the RGY is known in terms of rs per 50 kg bag per month. The model calculates the the total amount stored in every RGY during
* every time step, and each time step is given by card(HarvestingHorizonAggregationStep).
* The model does not track the total numbe of bags moved to RGY. Instead, the total amount stored is divided by 50 to determine the approximate number of
* bags stored in RGY. Although the number of bags will be an integer, ther error introduced through this assumption is expected to be low since the number of
* bags would be quite high. The approximate number of bags are then multiplied by the rental rate that is scaled as per the harvesting and nonharvesting horizon
* time step used in the model. If the time step is 15, the rate charged is Monthly rate*(15/30). This equation will ensure that the rate will be correctly
* calculated for other cases when the harvesting or non-harvesting horizon time steps are changed.
*
ProvisionCostConstraint6.. RGYRentalCost =e= sum((HarvestingHorizonAggregation,RGYSet), (RGYStoredGrain(HarvestingHorizonAggregation,RGYSet)/50)
                                                                                 *(RGYRentalRate*card(HarvestingHorizonAggregationStep)/30))

                                              +
                                              sum((NonHarvestingHorizonAggregation,RGYSet), (RGYStoredGrain(NonHarvestingHorizonAggregation,RGYSet)/50)
                                                                                 *(RGYRentalRate*card(HarvestingHorizonAggregationStep)/30));


*---------------------------------------------------------------------------------------------------------
* Calculating the handling (loading and unloadin) cost of grain
*---------------------------------------------------------------------------------------------------------
ProvisionCostConstraint7..
                         ProvisionGrainHandlingCost
                         =e=
                         sum((HarvestingHorizonAggregation,LocalCSPCenterSet,DistrictSelected,FarmNumber),
                                 LocalCSPInput(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,
                                                 LocalCSPCenterSet)
                                 *card(HarvestingHorizonAggregationStep)
                                 *(StorageStackingCost)
                         )
                         +
                         sum((NonHarvestingHorizonAggregation,LocalCSPCenterSet,DistrictSelected,FarmNumber),
                                 LocalCSPInput(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,
                                                 LocalCSPCenterSet)
                                 *card(NonHarvestingHorizonAggregationStep)
                                 *(StorageStackingCost)
                         )
                         +
                         sum((HarvestingHorizonAggregation,RegionalCSPCenterSet,DistrictSelected,FarmNumber),
                                 RegionalCSPInput(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,
                                                 RegionalCSPCenterSet)
                                 *card(HarvestingHorizonAggregationStep)
                                 *(StorageStackingCost)
                         )
                         +
                         sum((NonHarvestingHorizonAggregation,RegionalCSPCenterSet,DistrictSelected,FarmNumber),
                                 RegionalCSPInput(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,
                                                 RegionalCSPCenterSet)
                                 *card(NonHarvestingHorizonAggregationStep)
                                 *(StorageStackingCost)
                         )
                         +
                         sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet),
                                 HarvestFarmGateLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)*card(HarvestingHorizonAggregationStep)
                         )*GrainUnloadingCost
                         +
                         sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet),
                                 HarvestFarmGateLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)*card(NonHarvestingHorizonAggregationStep)
                         )*GrainUnloadingCost
                         +
                         sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 HarvestFarmGateRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)*card(HarvestingHorizonAggregationStep)
                         )*GrainUnloadingCost
                         +
                         sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 HarvestFarmGateRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)*card(NonHarvestingHorizonAggregationStep)
                         )*GrainUnloadingCost
                         +
                         sum((HarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 LocalCSPLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
                                 *card(HarvestingHorizonAggregationStep)
                         )*(StorageLoadingCost+GrainUnloadingCost)
                         +
                         sum((NonHarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation),
                                 LocalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                                 *card(NonHarvestingHorizonAggregationStep)
                         )*(StorageLoadingCost+GrainUnloadingCost)
                         +
                         sum((HarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and connectselected(DistrictSelected,RegionalMarketSet)),
                                 LocalCSPRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
                                 *card(HarvestingHorizonAggregationStep)
                         )*(StorageLoadingCost+GrainUnloadingCost)
                         +
                         sum((NonHarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 LocalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
                                 *card(NonHarvestingHorizonAggregationStep)
                         )*(StorageLoadingCost+GrainUnloadingCost)
                         +
                         sum((HarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 RegionalCSPLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
                                 *card(HarvestingHorizonAggregationStep)
                         )*(StorageLoadingCost+GrainUnloadingCost)
                         +
                         sum((NonHarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation),
                                 RegionalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                                 *card(NonHarvestingHorizonAggregationStep)
                         )*(StorageLoadingCost+GrainUnloadingCost)
                         +
                         sum((HarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and connectselected(DistrictSelected,RegionalMarketSet)),
                                 RegionalCSPRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
                                 *card(HarvestingHorizonAggregationStep)
                         )*(StorageLoadingCost+GrainUnloadingCost)
                         +
                         sum((NonHarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 RegionalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
                                 *card(NonHarvestingHorizonAggregationStep)
                         )*(StorageLoadingCost+GrainUnloadingCost);



ProvisionCostConstraint8..      TotalStorageCost
                                 =e=
                                 LocalCSPCapitalCost + RegionalCSPCapitalCost + LocalCSPStorageOperatingCost + RegionalCSPStorageOperatingCost
                                 + RGYCapitalCost + RGYRentalCost;


ProvisionCostConstraint9.. BagCost =e=
                                sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet),
                                         FarmLocalCSPGunnyBags(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet)
                                )*GunnyBagCost
                                +
                                sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet),
                                         FarmLocalCSPGunnyBags(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet)
                                )*GunnyBagCost
                                +
                                sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet),
                                         FarmRegionalCSPGunnyBags(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet)
                                )*GunnyBagCost
                                +
                                sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet),
                                         FarmRegionalCSPGunnyBags(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet)
                                )*GunnyBagCost
                                +
                                sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet),
                                         FarmLocalMarketGunnyBags(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
                                )*GunnyBagCost
                                +
                                sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet),
                                         FarmLocalMarketGunnyBags(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
                                )*GunnyBagCost
                                +
                                sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                         FarmRegionalMarketGunnyBags(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)
                                )*GunnyBagCost
                                +
                                sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                         FarmRegionalMarketGunnyBags(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)
                                )*GunnyBagCost
                                +
                                sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber),
                                         FarmDirectPurchaseGunnyBags(HarvestingHorizonAggregation,DistrictSelected,FarmNumber)
                                )*GunnyBagCost
                                +
                                sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber),
                                         FarmDirectPurchaseGunnyBags(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber)
                                )*GunnyBagCost
                                ;


ProvisionCostConstraint10..      TotalFarmIncome
                                 =e=
                                 sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber),
                                         HarvestFarmGateDirectPurchaseGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber)*GrainPurchasePrice_Input(HarvestingHorizonAggregation,'GrainFarmGatePrice')
                                 )
                                 +
                                 sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber),
                                         HarvestFarmGateDirectPurchaseGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber)*GrainPurchasePrice_Input(NonHarvestingHorizonAggregation,'GrainFarmGatePrice')
                                 )
                                 +
                                 sum((HarvestingHorizonAggregation,LocalMarketSet),
                                 (       sum((DistrictSelected,FarmNumber),
                                                 HarvestFarmGateLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
                                          )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep)*GrainPurchasePrice_Input(HarvestingHorizonAggregation,'GrainLocalMarketPrice')
                                         +
                                         sum((LocalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)
                                                 $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                                 LocalCSPLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
                                         )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep)*GrainPurchasePrice_Input(HarvestingHorizonAggregation,'GrainLocalMarketPrice')
                                         +
                                         sum((RegionalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)
                                                 $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                         RegionalCSPLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
                                         )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep)*GrainPurchasePrice_Input(HarvestingHorizonAggregation,'GrainLocalMarketPrice')
                                 )
                                 )
                                 +
                                 sum((NonHarvestingHorizonAggregation,LocalMarketSet),
                                 (       sum((DistrictSelected,FarmNumber),
                                                 HarvestFarmGateLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
                                          )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep)*GrainPurchasePrice_Input(NonHarvestingHorizonAggregation,'GrainLocalMarketPrice')
                                         +
                                         sum((LocalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation),
                                                 LocalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                                         )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep)*GrainPurchasePrice_Input(NonHarvestingHorizonAggregation,'GrainLocalMarketPrice')
                                         +
                                         sum((RegionalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation),
                                                 RegionalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                                         )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep)*GrainPurchasePrice_Input(NonHarvestingHorizonAggregation,'GrainLocalMarketPrice')
                                 )
                                 )
                                 +
                                 sum((HarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet),
                                         RegionalMarketFCIGrain(HarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet)*card(HarvestingHorizonAggregationStep)
                                         *MinimumSupportPrice
                                 )
                                 +
                                 sum((NonHarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet),
                                         RegionalMarketFCIGrain(NonHarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet)*card(NonHarvestingHorizonAggregationStep)
                                         *MinimumSupportPrice
                                 )
                                 +
                                 sum((HarvestingHorizonAggregation,RegionalMarketSet),
                                         RegionalMarketPrivateTraderGrain(HarvestingHorizonAggregation,RegionalMarketSet)*card(HarvestingHorizonAggregationStep)
                                         *GrainPurchasePrice_Input(HarvestingHorizonAggregation,'GrainRegionalMarketPrice')
                                 )
                                 +
                                 sum((NonHarvestingHorizonAggregation,RegionalMarketSet),
                                         RegionalMarketPrivateTraderGrain(NonHarvestingHorizonAggregation,RegionalMarketSet)*card(NonHarvestingHorizonAggregationStep)
                                         *GrainPurchasePrice_Input(NonHarvestingHorizonAggregation,'GrainRegionalMarketPrice')
                                 );


*
* Calculation of the objective function for the provision prioblem.
* Please note that the objective function calculation is a little complicated due to the possibility of using buffer biomass to satisfy
* refinery capacity. If the buffer biomass is used, then it is ensured that the buffer biomass is priced higher to discourage the use
* of buffer. Hence, the earning through refinery gate price is applicable only to biomass coming from various farms and not to buffer biomass.
* Moreover, the buffer biomass is priced at a higher value.
*
ProvisionCostConstraint11..      GrainProvisionObjective
                                 =e=
                                 TotalFarmIncome
                                 -
                                 ( TransportationOperatingCost + TransportationFixedCost*0 + TotalStorageCost +  BagCost
                                  + ProvisionGrainHandlingCost  + TotalMillerCost
                                  + sum(FCIGodownSet,FCIStorageCost(FCIGodownSet)+ FCISelector(FCIGodownSet)*10) + FCIMandiCost
                                 )
                                 -
                                 TransportationTruckCharge - DummyCost
                                 ;


*                                         + ProvisionBiomassHandlingCost + CentralStorageProcessingOperatingCost + CentralStorageSmallScaleProcessingOperatingCost
*                                         + CentralStorageProcessingCapitalCost + CentralStorageSmallScaleProcessingCapitalCost)


ProvisionCostConstraint12(MillerSet)..      MillerFixedCost(MillerSet) =e= MillerSelector(MillerSet)*MillerAnnualCost(MillerSet);

ProvisionCostConstraint13(MillerSet)..   MillerOperatingCost(MillerSet) =e=
                                         sum(HarvestingHorizonAggregation, MillerInput(HarvestingHorizonAggregation,MillerSet)
                                                 *card(HarvestingHorizonAggregationStep)*MillerOperatingCostRate(MillerSet)
                                         )
                                         +
                                         sum(NonHarvestingHorizonAggregation, MillerInput(NonHarvestingHorizonAggregation,MillerSet)
                                                 *card(NonHarvestingHorizonAggregationStep)*MillerOperatingCostRate(MillerSet)
                                         )
                                         ;

ProvisionCostConstraint14(MillerSet)..   MillerStorageCost(MillerSet) =e= MillerStorageCapacity(MillerSet)*MillerStorageCostRate(MillerSet);

ProvisionCostConstraint15..   TotalMillerCost =e= sum(MillerSet, MillerFixedCost(MillerSet)+ MillerOperatingCost(MillerSet)+  MillerStorageCost(MillerSet));

ProvisionCostConstraint16(FCIGodownSet)..    FCIStorageCost(FCIGodownSet)
                                             =e=
                                             sum(HarvestingHorizonAggregation, FCICoveredStoredGrain(HarvestingHorizonAggregation,FCIGodownSet)
                                                 +
                                                 FCICAPStoredGrain(HarvestingHorizonAggregation,FCIGodownSet)
                                             )*(card(HarvestingHorizonAggregationStep)/30)*FCIStorageCostRateMonthly
                                             +
                                             sum(NonHarvestingHorizonAggregation, FCICoveredStoredGrain(NonHarvestingHorizonAggregation,FCIGodownSet)
                                                 +
                                                 FCICAPStoredGrain(NonHarvestingHorizonAggregation,FCIGodownSet)
                                             )*(card(NonHarvestingHorizonAggregationStep)/30)*FCIStorageCostRateMonthly;

ProvisionCostConstraint17..    FCIMandiCost
                               =e=
                               sum((HarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet),
                                         RegionalMarketFCIGrain(HarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet)
                                         *card(HarvestingHorizonAggregationStep)
                               )*FCIMandiCostRate
                               +
                               sum((NonHarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet),
                                         RegionalMarketFCIGrain(NonHarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet)
                                         *card(NonHarvestingHorizonAggregationStep)
                               )*FCIMandiCostRate;


ProvisionCostConstraint18.. DummyCost =e= sum(FCIGodownSet, FCICAPCapacity(FCIGodownSet) + FCICoveredCapacity(FCIGodownSet));


Model ProvisionCostModel /
                 ProvisionCostConstraint1
                 ProvisionCostConstraint2
                 ProvisionCostConstraint3
                 ProvisionCostConstraint4
                 ProvisionCostConstraint5
                 ProvisionCostConstraint6
                 ProvisionCostConstraint7
                 ProvisionCostConstraint8
                 ProvisionCostConstraint9
                 ProvisionCostConstraint10
                 ProvisionCostConstraint11
                 ProvisionCostConstraint12
                 ProvisionCostConstraint13
                 ProvisionCostConstraint14
                 ProvisionCostConstraint15
                 ProvisionCostConstraint16
                 ProvisionCostConstraint17
                 ProvisionCostConstraint18
                /;
