*------------------------------------------------------------------------
* Constraints related to biomass balance at the central (local) storage facility
*-----------------------------------------------------------------------
Equations
  LocalCSPBalance1
  LocalCSPBalance2
  LocalCSPBalance3
  LocalCSPBalance4
  LocalCSPBalance5
  LocalCSPBalance6
  LocalCSPBalance7
  LocalCSPBalance8
  LocalCSPBalance9
  LocalCSPBalance10
  LocalCSPBalance11
  LocalCSPBalance12
  LocalCSPBalance13
  LocalCSPBalance14
  ;

* First calculating the total input to the central storage facility
LocalCSPBalance1(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet) $((not(CentralStorageProcessing) or CentralStorageOutputProcessing))..
  LocalCSPInput(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet) =e=
    (HarvestFarmGateLocalCSPGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)) * (1-TransportationDryMatterLossRate)
  ;

* Doing the accounting for the centralized storage (input - output balance)
LocalCSPBalance2(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,HarvestingHorizonAggregation2)
  $((not(CentralStorageProcessing) or CentralStorageOutputProcessing) and ord(HarvestingHorizonAggregation)=ord(HarvestingHorizonAggregation2))..
    LocalCSPStoredGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,HarvestingHorizonAggregation2) =e=
      LocalCSPInput(HarvestingHorizonAggregation2,FarmNumber,LocalCSPCenterSet) * card(HarvestingHorizonAggregationStep)
    ;


LocalCSPBalance3(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,HarvestingHorizonAggregation2)
  $((not(CentralStorageProcessing) or CentralStorageOutputProcessing) and ord(HarvestingHorizonAggregation)>ord(HarvestingHorizonAggregation2))..
    LocalCSPStoredGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,HarvestingHorizonAggregation2) =e=
      sum(HarvestingHorizonAggregation3 $(ord(HarvestingHorizonAggregation3)=ord(HarvestingHorizonAggregation)-1),
        LocalCSPStoredGrain(HarvestingHorizonAggregation3,FarmNumber,LocalCSPCenterSet,HarvestingHorizonAggregation2) -
        sum(LocalMarketSet,
        LocalCSPLocalMarketGrain(HarvestingHorizonAggregation3,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
        )*card(HarvestingHorizonAggregationStep) -
        sum(RegionalMarketSet,
        LocalCSPRegionalMarketGrain(HarvestingHorizonAggregation3,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
        )*card(HarvestingHorizonAggregationStep)
      )*(1-(LocalCSPDryMatterLossRate/365)*card(HarvestingHorizonAggregationStep))
    ;


* Calculating the volume of the biomass contributed by each farm to the central storage facility
LocalCSPBalance4(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)
  $((not(CentralStorageProcessing) or CentralStorageOutputProcessing) and Par_FarmPackingDensity(FarmNumber))..
    LocalCSPStoredGrainVolume(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet) =e=
      sum(HarvestingHorizonAggregation2,
        LocalCSPStoredGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,HarvestingHorizonAggregation2)
      ) / Par_FarmPackingDensity(FarmNumber)
    ;

* Calculating the total biomass stored at the central storage facility by summing the biomass amount contributed by each farm to the
* storage facility
LocalCSPBalance5(HarvestingHorizonAggregation,LocalCSPCenterSet) $((not(CentralStorageProcessing) or CentralStorageOutputProcessing))..
  LocalCSPStoredGrainTotal(HarvestingHorizonAggregation,LocalCSPCenterSet) =e=
    sum((FarmNumber,HarvestingHorizonAggregation2), 
      LocalCSPStoredGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,HarvestingHorizonAggregation2)
    )
  ;

* The total biomass stored at any time must not exceed the total capacity of the centralized storage
LocalCSPBalance6(HarvestingHorizonAggregation,LocalCSPCenterSet) $((not(CentralStorageProcessing) or CentralStorageOutputProcessing))..
  sum((FarmNumber),
    LocalCSPStoredGrainVolume(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)
  ) =l= LocalCSPFacilityArea(LocalCSPCenterSet)*LocalCSPFacilityHeight
  ;

* The amount of grain moved to the refinery on a day (tagged by the day it was harvested), must be less
* that the total biomass delivered to the central storage on the day of tagging!!!! (Confusing explanation)
LocalCSPBalance7(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,HarvestingHorizonAggregation2)
  $((not(CentralStorageProcessing) or CentralStorageOutputProcessing) and ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) )..
    sum(LocalMarketSet,
      LocalCSPLocalMarketGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
    )*card(HarvestingHorizonAggregationStep) +
    sum(RegionalMarketSet,
      LocalCSPRegionalMarketGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
    )*card(HarvestingHorizonAggregationStep)
    =l= LocalCSPStoredGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,HarvestingHorizonAggregation2)
    ;

LocalCSPBalance8(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,HarvestingHorizonAggregation2)
  $((not(CentralStorageProcessing) or CentralStorageOutputProcessing) and ord(HarvestingHorizonAggregation)<ord(HarvestingHorizonAggregation2))..
    sum(LocalMarketSet,
      LocalCSPLocalMarketGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
    )*card(HarvestingHorizonAggregationStep) +
    sum(RegionalMarketSet,
      LocalCSPRegionalMarketGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
    )*card(HarvestingHorizonAggregationStep)
    =e= 0
    ;

* A Big-M formulation for the calculation of storage area as a function of the selection of a particular storage location.
* This is a one time selection and hence the contstraint is not a function of the simulation horizon.
* If the binary variable is not selected (=0), then the area is forced to be zero.
* The cost calculation will accordingly have two components: One a function of the total area and one the function of the binary variable.
* The part associated with the binary variable will represent the basic installation cost that is independent of the size of the storage facility.
LocalCSPBalance9(LocalCSPCenterSet).. 
  LocalCSPFacilityArea(LocalCSPCenterSet) =l= LocalCSPFacilityAreaLimit*LocalCSPFacilitySelector(LocalCSPCenterSet)
  ;

LocalCSPBalance10(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,HarvestingHorizonAggregation)
  $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)and ord(NonHarvestingHorizonAggregation)=1)..
    LocalCSPStoredGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,HarvestingHorizonAggregation) =e=
      sum(HarvestingHorizonAggregation2 $(ord(HarvestingHorizonAggregation2)=card(HarvestingHorizonAggregation2)),
        LocalCSPStoredGrain(HarvestingHorizonAggregation2,FarmNumber,LocalCSPCenterSet,HarvestingHorizonAggregation) -
        sum(LocalMarketSet,
          LocalCSPLocalMarketGrain(HarvestingHorizonAggregation2,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
        )*card(HarvestingHorizonAggregationStep) -
        sum(RegionalMarketSet,
          LocalCSPRegionalMarketGrain(HarvestingHorizonAggregation2,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
        )*card(HarvestingHorizonAggregationStep)
      )*(1-(LocalCSPDryMatterLossRate/365))
    ;

LocalCSPBalance11(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,HarvestingHorizonAggregation)
  $((not(CentralStorageProcessing) or CentralStorageOutputProcessing) and ord(NonHarvestingHorizonAggregation)>1 )..
    LocalCSPStoredGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,HarvestingHorizonAggregation) =e=
      sum(NonHarvestingHorizonAggregation2 $(ord(NonHarvestingHorizonAggregation2)=ord(NonHarvestingHorizonAggregation)-1),
        LocalCSPStoredGrain(NonHarvestingHorizonAggregation2,FarmNumber,LocalCSPCenterSet,HarvestingHorizonAggregation) -
        sum(LocalMarketSet,
          LocalCSPLocalMarketGrain(NonHarvestingHorizonAggregation2,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
        )*card(NonHarvestingHorizonAggregationStep) -
        sum(RegionalMarketSet,
          LocalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation2,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
        )*card(NonHarvestingHorizonAggregationStep)
      ) *(1-(LocalCSPDryMatterLossRate/365))
    ;

* Amount of biomass moved from storage to refinery must be less than the biomass available for moving
LocalCSPBalance12(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,HarvestingHorizonAggregation)
  $((not(CentralStorageProcessing) or CentralStorageOutputProcessing))..
    sum(LocalMarketSet,
      LocalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
    )*card(NonHarvestingHorizonAggregationStep) +
    sum(RegionalMarketSet,
      LocalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
    )*card(NonHarvestingHorizonAggregationStep)
    =l= LocalCSPStoredGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,HarvestingHorizonAggregation)
    ;

* Constraint to enforce complete removal of the stored grain from the central storage facilty at the end of the simulation horizon
LocalCSPBalance13(LocalCSPCenterSet,FarmNumber)$((not(CentralStorageProcessing) or CentralStorageOutputProcessing))..
  sum((NonHarvestingHorizonAggregation,HarvestingHorizonAggregation) $(ord(NonHarvestingHorizonAggregation)=card(NonHarvestingHorizonAggregation)),
    LocalCSPStoredGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,HarvestingHorizonAggregation) -
    sum(LocalMarketSet,
      LocalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
    )*card(NonHarvestingHorizonAggregationStep) -
    sum(RegionalMarketSet,
      LocalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
    )*card(NonHarvestingHorizonAggregationStep)
  ) =l= 0
  ;

* Calculating the total biomass stored at the central storage facility by summing the biomass amount contributed by each farm to the storage facility
LocalCSPBalance14(NonHarvestingHorizonAggregation,LocalCSPCenterSet) $((not(CentralStorageProcessing) or CentralStorageOutputProcessing))..
  LocalCSPStoredGrainTotal(NonHarvestingHorizonAggregation,LocalCSPCenterSet) =e=
    sum((FarmNumber,HarvestingHorizonAggregation),
      LocalCSPStoredGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,HarvestingHorizonAggregation)
    )
    ;

Model LocalCSPModel /
  LocalCSPBalance1
  LocalCSPBalance2
  LocalCSPBalance3
  LocalCSPBalance4
  LocalCSPBalance5
  LocalCSPBalance6
  LocalCSPBalance7
  LocalCSPBalance8
  LocalCSPBalance9
  LocalCSPBalance10
  LocalCSPBalance11
  LocalCSPBalance12
  LocalCSPBalance13
  LocalCSPBalance14
  /;
