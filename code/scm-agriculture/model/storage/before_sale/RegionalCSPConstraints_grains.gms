*------------------------------------------------------------------------
* Constraints related to biomass balance at the central storage facility
*------------------------------------------------------------------------
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


$ontext


CentralStorageBalance14(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                         $((not(CentralStorageProcessing) or CentralStorageOutputProcessing))..
                         CentrallyStoredBiomassTotal(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                         =e=
                         sum((FarmNumber,HarvestingHorizonAggregation),
                                 CentrallyStoredBiomass(NonHarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                         );




CentralStorageBalance15.. sum((HarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                                 $(not(CountyStorageLocationCorrelation(CentralizedStorageLocations))
                                                 or not(FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations))
                                 ),
                                 CentralStorageOutputToRefinery(HarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         )
                         =l=
                         0;

CentralStorageBalance16.. sum((NonHarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                                 $(not(CountyStorageLocationCorrelation(CentralizedStorageLocations))
                                                 or not(FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations))
                                 ),
                                 CentralStorageOutputToRefinery(NonHarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                         )
                         =l=
                         0;



*===========================================================================================
*===========================================================================================
* Constraints for the case where biomass processing is done at the storage input
*===========================================================================================
*===========================================================================================


CentralStorageBalance17(HarvestingHorizonAggregation,CentralizedStorageLocations)
                 $(CentralStorageProcessing and CentralStorageInputProcessing and ord(HarvestingHorizonAggregation)=1)..
                 CentralStorageProcessedBiomass(HarvestingHorizonAggregation,CentralizedStorageLocations)
                 =e=
                 CentralStorageProcessingOutput(HarvestingHorizonAggregation,CentralizedStorageLocations)
                 *card(HarvestingHorizonAggregationStep);

CentralStorageBalance18(HarvestingHorizonAggregation,CentralizedStorageLocations)
                 $(CentralStorageProcessing and CentralStorageInputProcessing and ord(HarvestingHorizonAggregation)>1)..
                 CentralStorageProcessedBiomass(HarvestingHorizonAggregation,CentralizedStorageLocations)
                 =e=
                 sum(HarvestingHorizonAggregation2$(ord(HarvestingHorizonAggregation2)=ord(HarvestingHorizonAggregation)-1),
                         CentralStorageProcessedBiomass(HarvestingHorizonAggregation2,CentralizedStorageLocations)
                         -
                         CentralStorageOutputToRefineryProcessed(HarvestingHorizonAggregation2,CentralizedStorageLocations)
                         *card(HarvestingHorizonAggregationStep)
                         -
                         CentralStorageOutputToRegionalProcessed(HarvestingHorizonAggregation2,CentralizedStorageLocations)
                         *card(HarvestingHorizonAggregationStep)
                         +
                         CentralStorageProcessingOutput(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         *card(HarvestingHorizonAggregationStep)
                 )
                 *(1-(CentralStorageDryMatterLossRate/365)*card(HarvestingHorizonAggregationStep));


CentralStorageBalance19(HarvestingHorizonAggregation,CentralizedStorageLocations)
                 $(CentralStorageProcessing and CentralStorageInputProcessing and ord(HarvestingHorizonAggregation)>1)..
                 CentralStorageOutputToRefineryProcessed(HarvestingHorizonAggregation,CentralizedStorageLocations)
                 *card(HarvestingHorizonAggregationStep)
                 =l=
                 CentralStorageProcessedBiomass(HarvestingHorizonAggregation,CentralizedStorageLocations);


CentralStorageBalance20(HarvestingHorizonAggregation,CentralizedStorageLocations)
                 $(CentralStorageProcessing and CentralStorageInputProcessing)..
                 CentralStorageProcessedBiomass(HarvestingHorizonAggregation,CentralizedStorageLocations)
                 /CentralStorageProcessingData('BulkDensity')
                 =l=
                 CentralStorageFacilityArea(CentralizedStorageLocations)*CentralStorageFacilityHeight;


CentralStorageBalance21(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                 $(CentralStorageProcessing and CentralStorageInputProcessing and ord(NonHarvestingHorizonAggregation)=1)..
                 CentralStorageProcessedBiomass(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                 =e=
                 sum(HarvestingHorizonAggregation $(ord(HarvestingHorizonAggregation)=card(HarvestingHorizonAggregation)),
                         CentralStorageProcessedBiomass(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         - CentralStorageOutputToRefineryProcessed(HarvestingHorizonAggregation,CentralizedStorageLocations)
                          *card(HarvestingHorizonAggregationStep)
                         - CentralStorageOutputToRegionalProcessed(HarvestingHorizonAggregation,CentralizedStorageLocations)
                          *card(HarvestingHorizonAggregationStep)
                 )
                 *(1-(CentralStorageDryMatterLossRate/365)*card(HarvestingHorizonAggregationStep));


CentralStorageBalance22(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                 $(CentralStorageProcessing and CentralStorageInputProcessing and ord(NonHarvestingHorizonAggregation)>1)..
                 CentralStorageProcessedBiomass(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                 =e=
                 sum(NonHarvestingHorizonAggregation2$(ord(NonHarvestingHorizonAggregation2)=ord(NonHarvestingHorizonAggregation)-1),
                         CentralStorageProcessedBiomass(NonHarvestingHorizonAggregation2,CentralizedStorageLocations)
                         -
                         CentralStorageOutputToRefineryProcessed(NonHarvestingHorizonAggregation2,CentralizedStorageLocations)
                         *card(NonHarvestingHorizonAggregationStep)
                         -
                         CentralStorageOutputToRegionalProcessed(NonHarvestingHorizonAggregation2,CentralizedStorageLocations)
                         *card(NonHarvestingHorizonAggregationStep)
                 )
                 *(1-(CentralStorageDryMatterLossRate/365)*card(NonHarvestingHorizonAggregationStep));


CentralStorageBalance23(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                 $(CentralStorageProcessing and CentralStorageInputProcessing)..
                 CentralStorageOutputToRefineryProcessed(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                 *card(NonHarvestingHorizonAggregationStep)
                 =l=
                 CentralStorageProcessedBiomass(NonHarvestingHorizonAggregation,CentralizedStorageLocations);


CentralStorageBalance24(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                 $(CentralStorageProcessing and CentralStorageInputProcessing)..
                 CentralStorageProcessedBiomass(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                 /CentralStorageProcessingData('BulkDensity')
                 =l=
                 CentralStorageFacilityArea(CentralizedStorageLocations)*CentralStorageFacilityHeight;


CentralStorageBalance25(CentralizedStorageLocations)$(CentralizedStorageSizePredefined)..
                         CentralStorageFacilityArea(CentralizedStorageLocations) =l= CentralizedStorageSize(CentralizedStorageLocations);


*
* Constraints that enforce a time limit on storage of biomass after it has been harvested and has arrived at the storage facility.
* This constraint will be used to model scenarios related to perishable biomass (such as sugarcane and Type I energy cane) that must be processed
* within a certain amount of time.
*
CentralStorageBalance26(FarmNumber,CentralizedStorageLocations)$(BiomassStorageTimeLimitSelector)..
                 sum((HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
                                         $((ord(HarvestingHorizonAggregation)-ord(HarvestingHorizonAggregation2))*card(HarvestingHorizonAggregationStep)
                                           >
                                           BiomassStorageTimeLimit),
                                         CentrallyStoredBiomass(HarvestingHorizonAggregation,FarmNumber,
                                         CentralizedStorageLocations,HarvestingHorizonAggregation2)
                 ) =l= 0;

CentralStorageBalance27(FarmNumber,CentralizedStorageLocations)$(BiomassStorageTimeLimitSelector)..
                 sum((NonHarvestingHorizonAggregation,HarvestingHorizonAggregation)
                                         $(ord(NonHarvestingHorizonAggregation)*card(NonHarvestingHorizonAggregationStep)-ord(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep)
                                           >
                                           BiomassStorageTimeLimit),
                                         CentrallyStoredBiomass(NonHarvestingHorizonAggregation,FarmNumber,
                                         CentralizedStorageLocations,HarvestingHorizonAggregation)
                 ) =l= 0;

CentralStorageBalance28(HarvestingHorizonAggregation,CountySelect
ed,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and
                                 CountyStorageLocationCorrelation(CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
                         )..
                         CentralStorageOutputToRegional(HarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         *card(HarvestingHorizonAggregationStep)
                         =l=
                         CentrallyStoredBiomass(HarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2);

CentralStorageBalance29(HarvestingHorizonAggregation,CountySelect
ed,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and
                                 CountyStorageLocationCorrelation(CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
                         )..
                         CentralStorageOutputToRefinery(HarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         *card(HarvestingHorizonAggregationStep)
                         +
                         CentralStorageOutputToRegional(HarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         *card(HarvestingHorizonAggregationStep)
                         =l=
                         CentrallyStoredBiomass(HarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2);

CentralStorageBalance30(HarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                    $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and ord(HarvestingHorizonAggregation)<ord(HarvestingHorizonAggregation2)
                      and CountyStorageLocationCorrelation(CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
                    )..
                    CentralStorageOutputToRegional(HarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                    =e=
                    0;

CentralStorageBalance31(NonHarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                 $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and CountyStorageLocationCorrelation(CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
                 )..
                 CentralStorageOutputToRegional(NonHarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                 *card(NonHarvestingHorizonAggregationStep)
                 =l=
                 CentrallyStoredBiomass(NonHarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation);

CentralStorageBalance32(NonHarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                 $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and CountyStorageLocationCorrelation(CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
                 )..
                 CentralStorageOutputToRefinery(NonHarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                 *card(NonHarvestingHorizonAggregationStep)
                 +
                 CentralStorageOutputToRegional(NonHarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                 *card(NonHarvestingHorizonAggregationStep)
                 =l=
                 CentrallyStoredBiomass(NonHarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation);

CentralStorageBalance33.. sum((HarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                                 $(not(CountyStorageLocationCorrelation(CentralizedStorageLocations))
                                                 or not(FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations))
                                 ),
                                 CentralStorageOutputToRegional(HarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         )
                         =l=
                         0;

CentralStorageBalance34.. sum((NonHarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                                 $(not(CountyStorageLocationCorrelation(CentralizedStorageLocations))
                                                 or not(FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations))
                                 ),
                                 CentralStorageOutputToRegional(NonHarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                         )
                         =l=
                         0;

CentralStorageBalance35(HarvestingHorizonAggregation,CentralizedStorageLocations)
                 $(CentralStorageProcessing and CentralStorageInputProcessing and ord(HarvestingHorizonAggregation)>1)..
                 CentralStorageOutputToRegionalProcessed(HarvestingHorizonAggregation,CentralizedStorageLocations)
                 *card(HarvestingHorizonAggregationStep)
                 =l=
                 CentralStorageProcessedBiomass(HarvestingHorizonAggregation,CentralizedStorageLocations);

CentralStorageBalanc36(HarvestingHorizonAggregation,CentralizedStorageLocations)
                 $(CentralStorageProcessing and CentralStorageInputProcessing and ord(HarvestingHorizonAggregation)>1)..
                 CentralStorageOutputToRefineryProcessed(HarvestingHorizonAggregation,CentralizedStorageLocations)
                 *card(HarvestingHorizonAggregationStep)
                 +
                 CentralStorageOutputToRegionalProcessed(HarvestingHorizonAggregation,CentralizedStorageLocations)
                 *card(HarvestingHorizonAggregationStep)
                 =l=
                 CentralStorageProcessedBiomass(HarvestingHorizonAggregation,CentralizedStorageLocations);

CentralStorageBalance37(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                 $(CentralStorageProcessing and CentralStorageInputProcessing)..
                 CentralStorageOutputToRegionalProcessed(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                 *card(NonHarvestingHorizonAggregationStep)
                 =l=
                 CentralStorageProcessedBiomass(NonHarvestingHorizonAggregation,CentralizedStorageLocations);

CentralStorageBalance38(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                 $(CentralStorageProcessing and CentralStorageInputProcessing)..
                 CentralStorageOutputToRefineryProcessed(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                 *card(NonHarvestingHorizonAggregationStep)
                 +
                 CentralStorageOutputToRegionalProcessed(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                 *card(NonHarvestingHorizonAggregationStep)
                 =l=
                 CentralStorageProcessedBiomass(NonHarvestingHorizonAggregation,CentralizedStorageLocations);

Model CentralizedStorageModel /
                 CentralStorageBalance1
                 CentralStorageBalance2
                 CentralStorageBalance3
                 CentralStorageBalance4
                 CentralStorageBalance5
                 CentralStorageBalance6
                 CentralStorageBalance7
                 CentralStorageBalance8
                 CentralStorageBalance9
                 CentralStorageBalance10
                 CentralStorageBalance11
                 CentralStorageBalance12
                 CentralStorageBalance13
                 CentralStorageBalance14
                 CentralStorageBalance15
                 CentralStorageBalance16
                 CentralStorageBalance17
                 CentralStorageBalance18
                 CentralStorageBalance19
                 CentralStorageBalance20
                 CentralStorageBalance21
                 CentralStorageBalance22
                 CentralStorageBalance23
                 CentralStorageBalance24
                 CentralStorageBalance26
                 CentralStorageBalance27
                 CentralStorageBalance28
                 CentralStorageBalance29
                 CentralStorageBalance30
                 CentralStorageBalance31
                 CentralStorageBalance32
                 CentralStorageBalance33
                 CentralStorageBalance34
                 CentralStorageBalance35
                 CentralStorageBalance36
                 CentralStorageBalance37
                 CentralStorageBalance38
                 /;

$offtext

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
