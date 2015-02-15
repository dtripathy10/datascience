*------------------------------------------------------------------------
* Constraints related to biomass balance at the central storage facility
*-----------------------------------------------------------------------
Equations
  RegionalCSPBalance1
  RegionalCSPBalance2
  RegionalCSPBalance3
  RegionalCSPBalance4
  RegionalCSPBalance5
  RegionalCSPBalance6
  RegionalCSPBalance7
  RegionalCSPBalance8
  RegionalCSPBalance9
  RegionalCSPBalance10
  RegionalCSPBalance11
  RegionalCSPBalance12
  RegionalCSPBalance13
  RegionalCSPBalance14
  ;

*
* First calculating the total input to the central storage facility
*
RegionalCSPBalance1(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
                 $((not(CentralStorageProcessing) or CentralStorageOutputProcessing))..
                 RegionalCSPInput(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
                 =e=
                 ( HarvestFarmGateRegionalCSPGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
                 )
                 *(1-TransportationDryMatterLossRate);

*
* Doing the accounting for the centralized storage (input - output balance)
*
RegionalCSPBalance2(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,HarvestingHorizonAggregation2)
                                 $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and ord(HarvestingHorizonAggregation)=ord(HarvestingHorizonAggregation2)
                                 )..
                         RegionalCSPStoredGrain(HarvestingHorizonAggregation,FarmNumber,
                                         RegionalCSPCenterSet,HarvestingHorizonAggregation2)
                         =e=
                         RegionalCSPInput(HarvestingHorizonAggregation2,FarmNumber,RegionalCSPCenterSet)
                         *card(HarvestingHorizonAggregationStep);


RegionalCSPBalance3(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,HarvestingHorizonAggregation2)
                                 $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and ord(HarvestingHorizonAggregation)>ord(HarvestingHorizonAggregation2)
                                 )..
                         RegionalCSPStoredGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,HarvestingHorizonAggregation2)
                         =e=
                         sum(HarvestingHorizonAggregation3
                                 $(ord(HarvestingHorizonAggregation3)=ord(HarvestingHorizonAggregation)-1),
                                 RegionalCSPStoredGrain(HarvestingHorizonAggregation3,FarmNumber,RegionalCSPCenterSet,HarvestingHorizonAggregation2)
                                 -
                                 sum(LocalMarketSet,
                                         RegionalCSPLocalMarketGrain(HarvestingHorizonAggregation3,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
                                 )*card(HarvestingHorizonAggregationStep)
                                 -
                                 sum(RegionalMarketSet,
                                         RegionalCSPRegionalMarketGrain(HarvestingHorizonAggregation3,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
                                 )*card(HarvestingHorizonAggregationStep)
                         )
                         *(1-(RegionalCSPDryMatterLossRate/365)*card(HarvestingHorizonAggregationStep));

*
* Calculating the volume of the biomass contributed by each farm to the central storage facility
*
RegionalCSPBalance4(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
                                 $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and Par_FarmPackingDensity(FarmNumber)
                                 )..
                                 RegionalCSPStoredGrainVolume(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
                                 =e=
                                 sum(HarvestingHorizonAggregation2,
                                         RegionalCSPStoredGrain(HarvestingHorizonAggregation,FarmNumber,
                                                                         RegionalCSPCenterSet,HarvestingHorizonAggregation2)
                                 )
                                 /Par_FarmPackingDensity(FarmNumber);

*
* Calculating the total biomass stored at the central storage facility by summing the biomass amount contributed by each farm to the
* storage facility
*
RegionalCSPBalance5(HarvestingHorizonAggregation,RegionalCSPCenterSet)
                         $((not(CentralStorageProcessing) or CentralStorageOutputProcessing))..
                         RegionalCSPStoredGrainTotal(HarvestingHorizonAggregation,RegionalCSPCenterSet)
                         =e=
                         sum((FarmNumber,HarvestingHorizonAggregation2),
                                 RegionalCSPStoredGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,HarvestingHorizonAggregation2)
                         );

*
* The total biomass stored at any time must not exceed the total capacity of the centralized storage
*
RegionalCSPBalance6(HarvestingHorizonAggregation,RegionalCSPCenterSet)
                         $((not(CentralStorageProcessing) or CentralStorageOutputProcessing))..
                         sum((FarmNumber),
                                 RegionalCSPStoredGrainVolume(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
                         )
                         =l=
                         RegionalCSPFacilityArea(RegionalCSPCenterSet)*RegionalCSPFacilityHeight;


* The amount of grain moved to the refinery on a day (tagged by the day it was harvested), must be less
* that the total biomass delivered to the central storage on the day of tagging!!!! (Confusing explanation)
RegionalCSPBalance7(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,HarvestingHorizonAggregation2)
                         $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)
                         )..
                         sum(LocalMarketSet,
                                 RegionalCSPLocalMarketGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
                         )*card(HarvestingHorizonAggregationStep)
                         +
                         sum(RegionalMarketSet,
                                 RegionalCSPRegionalMarketGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
                         )*card(HarvestingHorizonAggregationStep)
                         =l=
                         RegionalCSPStoredGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,HarvestingHorizonAggregation2);

RegionalCSPBalance8(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,HarvestingHorizonAggregation2)
                    $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and ord(HarvestingHorizonAggregation)<ord(HarvestingHorizonAggregation2)
                     )..
                     sum(LocalMarketSet,
                                 RegionalCSPLocalMarketGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
                     )*card(HarvestingHorizonAggregationStep)
                     +
                     sum(RegionalMarketSet,
                                 RegionalCSPRegionalMarketGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
                     )*card(HarvestingHorizonAggregationStep)
                    =e=
                    0;

*
* A Big-M formulation for the calculation of storage area as a function of the selection of a particular storage location.
* This is a one time selection and hence the contstraint is not a function of the simulation horizon.
* If the binary variable is not selected (=0), then the area is forced to be zero.
* The cost calculation will accordingly have two components: One a function of the total area and one the function of the binary variable.
* The part associated with the binary variable will represent the basic installation cost that is independent of the size of the storage facility.
*
RegionalCSPBalance9(RegionalCSPCenterSet).. RegionalCSPFacilityArea(RegionalCSPCenterSet) =l= RegionalCSPFacilityAreaLimit*RegionalCSPFacilitySelector(RegionalCSPCenterSet);


RegionalCSPBalance10(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,HarvestingHorizonAggregation)
                 $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and ord(NonHarvestingHorizonAggregation)=1
                 )..
                 RegionalCSPStoredGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,HarvestingHorizonAggregation)
                 =e=
                 sum(HarvestingHorizonAggregation2 $(ord(HarvestingHorizonAggregation2)=card(HarvestingHorizonAggregation2)),
                         RegionalCSPStoredGrain(HarvestingHorizonAggregation2,FarmNumber,RegionalCSPCenterSet,HarvestingHorizonAggregation)
                         -
                         sum(LocalMarketSet,
                                 RegionalCSPLocalMarketGrain(HarvestingHorizonAggregation2,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                         )*card(HarvestingHorizonAggregationStep)
                         -
                         sum(RegionalMarketSet,
                                 RegionalCSPRegionalMarketGrain(HarvestingHorizonAggregation2,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
                         )*card(HarvestingHorizonAggregationStep)
                 )
                 *(1-(RegionalCSPDryMatterLossRate/365));


RegionalCSPBalance11(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,HarvestingHorizonAggregation)
                 $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and ord(NonHarvestingHorizonAggregation)>1
                 )..
                 RegionalCSPStoredGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,HarvestingHorizonAggregation)
                 =e=
                 sum(NonHarvestingHorizonAggregation2
                         $(ord(NonHarvestingHorizonAggregation2)=ord(NonHarvestingHorizonAggregation)-1),
                         RegionalCSPStoredGrain(NonHarvestingHorizonAggregation2,FarmNumber,RegionalCSPCenterSet,HarvestingHorizonAggregation)
                         -
                         sum(LocalMarketSet,
                                 RegionalCSPLocalMarketGrain(NonHarvestingHorizonAggregation2,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                         )*card(NonHarvestingHorizonAggregationStep)
                         -
                         sum(RegionalMarketSet,
                                 RegionalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation2,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
                         )*card(NonHarvestingHorizonAggregationStep)
                  )
                 *(1-(RegionalCSPDryMatterLossRate/365));


* Amount of biomass moved from storage to refinery must be less than the biomass available for moving
RegionalCSPBalance12(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,HarvestingHorizonAggregation)
                 $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                 )..
                 sum(LocalMarketSet,
                         RegionalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                 )*card(NonHarvestingHorizonAggregationStep)
                 +
                 sum(RegionalMarketSet,
                         RegionalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
                 )*card(NonHarvestingHorizonAggregationStep)
                 =l=
                 RegionalCSPStoredGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,HarvestingHorizonAggregation);


*
* Constraint to enforce complete removal of the stored grain from the central storage facilty at the end of the simulation horizon
*
RegionalCSPBalance13(RegionalCSPCenterSet,FarmNumber)$((not(CentralStorageProcessing) or CentralStorageOutputProcessing))..
                 sum((NonHarvestingHorizonAggregation,HarvestingHorizonAggregation)
                         $(ord(NonHarvestingHorizonAggregation)=card(NonHarvestingHorizonAggregation)),
                         RegionalCSPStoredGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,HarvestingHorizonAggregation)
                         -
                         sum(LocalMarketSet,
                                 RegionalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                         )*card(NonHarvestingHorizonAggregationStep)
                         -
                         sum(RegionalMarketSet,
                                 RegionalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
                         )*card(NonHarvestingHorizonAggregationStep)
                 )
                 =g= 0;


*
* Calculating the total biomass stored at the central storage facility by summing the biomass amount contributed by each farm to the
* storage facility
*
RegionalCSPBalance14(NonHarvestingHorizonAggregation,RegionalCSPCenterSet)
                         $((not(CentralStorageProcessing) or CentralStorageOutputProcessing))..
                         RegionalCSPStoredGrainTotal(NonHarvestingHorizonAggregation,RegionalCSPCenterSet)
                         =e=
                         sum((FarmNumber,HarvestingHorizonAggregation),
                                 RegionalCSPStoredGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,HarvestingHorizonAggregation)
                         );



Model RegionalCSPModel /
  RegionalCSPBalance1
  RegionalCSPBalance2
  RegionalCSPBalance3
  RegionalCSPBalance4
  RegionalCSPBalance5
  RegionalCSPBalance6
  RegionalCSPBalance7
  RegionalCSPBalance8
  RegionalCSPBalance9
  RegionalCSPBalance10
  RegionalCSPBalance11
  RegionalCSPBalance12
  RegionalCSPBalance13
  RegionalCSPBalance14
  /;
