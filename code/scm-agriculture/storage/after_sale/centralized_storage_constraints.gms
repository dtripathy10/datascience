*------------------------------------------------------------------------
* Constraints related to biomass balance at the central storage facility
*------------------------------------------------------------------------
Equations
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

                 CentralStorageBalance25
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
                 ;

*
* First calculating the total input to the central storage facility
*
CentralStorageBalance1(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations)
                 $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations))..
                 CentralStorageInput(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations)
                 =e=
                 ( HarvestFarmGateCentralStorageBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,
                                                                         CentralizedStorageLocations)
*                   +
*                   FarmCoveredStorageFarmGateCentralStorageBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,
*                                                                         CentralizedStorageLocations)
*                   +
*                   FarmOpenStorageFarmGateCentralStorageBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,
*
*                                                      CentralizedStorageLocations)
                 )
                 *(1-TransportationDryMatterLossRate);

*
* Doing the accounting for the centralized storage (input - output balance)
*
CentralStorageBalance2(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                                 $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and ord(HarvestingHorizonAggregation)=ord(HarvestingHorizonAggregation2)
                                   and CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
                                 )..
                         CentrallyStoredBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,
                                         CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         =e=
                         CentralStorageInput(HarvestingHorizonAggregation2,CountySelected,FarmNumber,CentralizedStorageLocations)
                         *card(HarvestingHorizonAggregationStep);


CentralStorageBalance3(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                                 $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and ord(HarvestingHorizonAggregation)>ord(HarvestingHorizonAggregation2)
                                  and CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
                                 )..
                         CentrallyStoredBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         =e=
                         sum(HarvestingHorizonAggregation3
                                 $(ord(HarvestingHorizonAggregation3)=ord(HarvestingHorizonAggregation)-1),
                                 CentrallyStoredBiomass(HarvestingHorizonAggregation3,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                                 -
                                 CentralStorageOutputToRefinery(HarvestingHorizonAggregation3,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                                 *card(HarvestingHorizonAggregationStep)
                                 -
                                 CentralStorageOutputToRegional(HarvestingHorizonAggregation3,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                                 *card(HarvestingHorizonAggregationStep)
                         )
                         *(1-(CentralStorageDryMatterLossRate/365)*card(HarvestingHorizonAggregationStep));

*
* Calculating the volume of the biomass contributed by each farm to the central storage facility
*
CentralStorageBalance4(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations)
                                 $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and Par_FarmPackingDensity(CountySelected,FarmNumber)
                                    and CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
                                 )..
                                 CentrallyStoredBiomassVolume(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations)
                                 =e=
                                 sum(HarvestingHorizonAggregation2,
                                         CentrallyStoredBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,
                                                                         CentralizedStorageLocations,HarvestingHorizonAggregation2)
                                 )
                                 /Par_FarmPackingDensity(CountySelected,FarmNumber);

*
* Calculating the total biomass stored at the central storage facility by summing the biomass amount contributed by each farm to the
* storage facility
*
CentralStorageBalance5(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         $((not(CentralStorageProcessing) or CentralStorageOutputProcessing))..
                         CentrallyStoredBiomassTotal(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         =e=
                         sum((CountySelected,FarmNumber,HarvestingHorizonAggregation2),
                                 CentrallyStoredBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         );

*
* The total biomass stored at any time must not exceed the total capacity of the centralized storage
*
CentralStorageBalance6(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         $((not(CentralStorageProcessing) or CentralStorageOutputProcessing))..
                         sum((CountySelected,FarmNumber),
                                 CentrallyStoredBiomassVolume(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations)
                         )
                         =l=
                         CentralStorageFacilityArea(CentralizedStorageLocations)*CentralStorageFacilityHeight;


* The amount of biomass moved to the refinery on a day (tagged by the day it was harvested), must be less
* that the total biomass delivered to the central storage on the day of tagging!!!! (Confusing explanation)
CentralStorageBalance7(HarvestingHorizonAggregation,CountySelect
ed,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and
                                 CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
                         )..
                         CentralStorageOutputToRefinery(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         *card(HarvestingHorizonAggregationStep)
                         =l=
                         CentrallyStoredBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2);

CentralStorageBalance8(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                    $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and ord(HarvestingHorizonAggregation)<ord(HarvestingHorizonAggregation2)
                      and CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
                    )..
                    CentralStorageOutputToRefinery(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                    =e=
                    0;
*
* A Big-M formulation for the calculation of storage area as a function of the selection of a particular storage location.
* This is a one time selection and hence the contstraint is not a function of the simulation horizon.
* If the binary variable is not selected (=0), then the area is forced to be zero.
* The cost calculation will accordingly have two components: One a function of the total area and one the function of the binary variable.
* The part associated with the binary variable will represent the basic installation cost that is independent of the size of the storage facility.
*
CentralStorageBalance9(CentralizedStorageLocations)..
                 CentralStorageFacilityArea(CentralizedStorageLocations) =l= CentralStorageAreaLimit
                                                         * CentralStorageFacilitySelector(CentralizedStorageLocations);


CentralStorageBalance10(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                 $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and ord(NonHarvestingHorizonAggregation)=1 and CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
                 )..
                 CentrallyStoredBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                 =e=
                 sum(HarvestingHorizonAggregation2 $(ord(HarvestingHorizonAggregation2)=card(HarvestingHorizonAggregation2)),
                         CentrallyStoredBiomass(HarvestingHorizonAggregation2,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                         - CentralStorageOutputToRefinery(HarvestingHorizonAggregation2,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                          *card(HarvestingHorizonAggregationStep)
                         - CentralStorageOutputToRegional(HarvestingHorizonAggregation2,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                          *card(HarvestingHorizonAggregationStep)
                 )
                 *(1-(CentralStorageDryMatterLossRate/365)*card(HarvestingHorizonAggregationStep));


CentralStorageBalance11(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                 $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and ord(NonHarvestingHorizonAggregation)>1 and CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
                 )..
                 CentrallyStoredBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                 =e=
                 sum(NonHarvestingHorizonAggregation2
                         $(ord(NonHarvestingHorizonAggregation2)=ord(NonHarvestingHorizonAggregation)-1),
                         CentrallyStoredBiomass(NonHarvestingHorizonAggregation2,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                         -
                         CentralStorageOutputToRefinery(NonHarvestingHorizonAggregation2,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                         *card(NonHarvestingHorizonAggregationStep)
                         -
                         CentralStorageOutputToRegional(NonHarvestingHorizonAggregation2,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                         *card(NonHarvestingHorizonAggregationStep)
                 )
                 *(1-(CentralStorageDryMatterLossRate/365)*card(NonHarvestingHorizonAggregationStep));

* Amount of biomass moved from storage to refinery must be less than the biomass available for moving
CentralStorageBalance12(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                 $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
                 )..
                 CentralStorageOutputToRefinery(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                 *card(NonHarvestingHorizonAggregationStep)
                 =l=
                 CentrallyStoredBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation);

*
* Constraint to enforce complete removal of the stored biomass from the central storage facilty at the end of the simulation horizon
*
CentralStorageBalance13(CentralizedStorageLocations,CountySelected,FarmNumber)
                 $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
                 )..
                 sum((NonHarvestingHorizonAggregation,HarvestingHorizonAggregation)
                         $(ord(NonHarvestingHorizonAggregation)=card(NonHarvestingHorizonAggregation)),
                         CentrallyStoredBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                         -
                         CentralStorageOutputToRefinery(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                         *card(NonHarvestingHorizonAggregationStep)
                         -
                         CentralStorageOutputToRegional(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                         *card(NonHarvestingHorizonAggregationStep)
                 )
                 =l= 0;


CentralStorageBalance14(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                         $((not(CentralStorageProcessing) or CentralStorageOutputProcessing))..
                         CentrallyStoredBiomassTotal(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                         =e=
                         sum((CountySelected,FarmNumber,HarvestingHorizonAggregation),
                                 CentrallyStoredBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                         );




CentralStorageBalance15.. sum((HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                                 $(not(CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations))
                                                 or not(FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations))
                                 ),
                                 CentralStorageOutputToRefinery(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         )
                         =l=
                         0;

CentralStorageBalance16.. sum((NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                                 $(not(CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations))
                                                 or not(FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations))
                                 ),
                                 CentralStorageOutputToRefinery(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
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
CentralStorageBalance26(CountySelected,FarmNumber,CentralizedStorageLocations)$(BiomassStorageTimeLimitSelector)..
                 sum((HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
                                         $((ord(HarvestingHorizonAggregation)-ord(HarvestingHorizonAggregation2))*card(HarvestingHorizonAggregationStep)
                                           >
                                           BiomassStorageTimeLimit),
                                         CentrallyStoredBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,
                                         CentralizedStorageLocations,HarvestingHorizonAggregation2)
                 ) =l= 0;

CentralStorageBalance27(CountySelected,FarmNumber,CentralizedStorageLocations)$(BiomassStorageTimeLimitSelector)..
                 sum((NonHarvestingHorizonAggregation,HarvestingHorizonAggregation)
                                         $(ord(NonHarvestingHorizonAggregation)*card(NonHarvestingHorizonAggregationStep)-ord(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep)
                                           >
                                           BiomassStorageTimeLimit),
                                         CentrallyStoredBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,
                                         CentralizedStorageLocations,HarvestingHorizonAggregation)
                 ) =l= 0;

CentralStorageBalance28(HarvestingHorizonAggregation,CountySelect
ed,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and
                                 CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
                         )..
                         CentralStorageOutputToRegional(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         *card(HarvestingHorizonAggregationStep)
                         =l=
                         CentrallyStoredBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2);

CentralStorageBalance29(HarvestingHorizonAggregation,CountySelect
ed,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and
                                 CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
                         )..
                         CentralStorageOutputToRefinery(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         *card(HarvestingHorizonAggregationStep)
                         +
                         CentralStorageOutputToRegional(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         *card(HarvestingHorizonAggregationStep)
                         =l=
                         CentrallyStoredBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2);

CentralStorageBalance30(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                    $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and ord(HarvestingHorizonAggregation)<ord(HarvestingHorizonAggregation2)
                      and CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
                    )..
                    CentralStorageOutputToRegional(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                    =e=
                    0;

CentralStorageBalance31(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                 $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
                 )..
                 CentralStorageOutputToRegional(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                 *card(NonHarvestingHorizonAggregationStep)
                 =l=
                 CentrallyStoredBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation);

CentralStorageBalance32(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                 $((not(CentralStorageProcessing) or CentralStorageOutputProcessing)
                                                 and CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
                 )..
                 CentralStorageOutputToRefinery(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                 *card(NonHarvestingHorizonAggregationStep)
                 +
                 CentralStorageOutputToRegional(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                 *card(NonHarvestingHorizonAggregationStep)
                 =l=
                 CentrallyStoredBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation);

CentralStorageBalance33.. sum((HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                                 $(not(CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations))
                                                 or not(FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations))
                                 ),
                                 CentralStorageOutputToRegional(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         )
                         =l=
                         0;

CentralStorageBalance34.. sum((NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
                                 $(not(CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations))
                                                 or not(FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations))
                                 ),
                                 CentralStorageOutputToRegional(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation)
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


Model CentralizedStorageModelConstrained /
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
                 CentralStorageBalance25
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
