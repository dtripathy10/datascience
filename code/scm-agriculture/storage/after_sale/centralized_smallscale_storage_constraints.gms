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
CentralStorageBalance1(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations)
                 $((not(CentralStorageSmallScaleProcessing) or CentralStorageSmallScaleOutputProcessing)
                                                 and CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations)
                                                 and FarmStorageLocationCorrelationSmallScale(FarmNumber,CentralizedStorageSmallScaleLocations))..
                 CentralStorageSmallScaleInput(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations)
                 =e=
                 ( HarvestFarmGateCentralStorageSmallScaleBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,
                                                                         CentralizedStorageSmallScaleLocations)
*                   +
*                   FarmCoveredStorageFarmGateCentralStorageBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,
*                                                                         CentralizedStorageSmallScaleLocations)
*                   +
*                   FarmOpenStorageFarmGateCentralStorageBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,
*
*                                                      CentralizedStorageSmallScaleLocations)
                 )
                 *(1-TransportationDryMatterLossRate);

*
* Doing the accounting for the centralized storage (input - output balance)
*
CentralStorageBalance2(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                                 $((not(CentralStorageSmallScaleProcessing) or CentralStorageSmallScaleOutputProcessing)
                                                 and ord(HarvestingHorizonAggregation)=ord(HarvestingHorizonAggregation2)
                                   and CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations)
                                                 and FarmStorageLocationCorrelationSmallScale(FarmNumber,CentralizedStorageSmallScaleLocations)
                                 )..
                         CentrallyStoredSmallScaleBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,
                                         CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                         =e=
                         CentralStorageSmallScaleInput(HarvestingHorizonAggregation2,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations)
                         *card(HarvestingHorizonAggregationStep);


CentralStorageBalance3(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                                 $((not(CentralStorageSmallScaleProcessing) or CentralStorageSmallScaleOutputProcessing)
                                                 and ord(HarvestingHorizonAggregation)>ord(HarvestingHorizonAggregation2)
                                  and CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations)
                                                 and FarmStorageLocationCorrelationSmallScale(FarmNumber,CentralizedStorageSmallScaleLocations)
                                 )..
                         CentrallyStoredSmallScaleBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                         =e=
                         sum(HarvestingHorizonAggregation3
                                 $(ord(HarvestingHorizonAggregation3)=ord(HarvestingHorizonAggregation)-1),
                                 CentrallyStoredSmallScaleBiomass(HarvestingHorizonAggregation3,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                                 -
                                 CentralStorageSmallScaleOutputToRefinery(HarvestingHorizonAggregation3,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                                 *card(HarvestingHorizonAggregationStep)
                                 -
                                 CentralStorageSmallScaleOutputToRegional(HarvestingHorizonAggregation3,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                                 *card(HarvestingHorizonAggregationStep)
                         )
                         *(1-(CentralStorageSmallScaleDryMatterLossRate/365)*card(HarvestingHorizonAggregationStep));

*
* Calculating the volume of the biomass contributed by each farm to the central storage facility
*
CentralStorageBalance4(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations)
                                 $((not(CentralStorageSmallScaleProcessing) or CentralStorageSmallScaleOutputProcessing)
                                                 and Par_FarmPackingDensity(CountySelected,FarmNumber)
                                    and CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations)
                                                 and FarmStorageLocationCorrelationSmallScale(FarmNumber,CentralizedStorageSmallScaleLocations)
                                 )..
                                 CentrallyStoredSmallScaleBiomassVolume(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations)
                                 =e=
                                 sum(HarvestingHorizonAggregation2,
                                         CentrallyStoredSmallScaleBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,
                                                                         CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                                 )
                                 /Par_FarmPackingDensity(CountySelected,FarmNumber);

*
* Calculating the total biomass stored at the central storage facility by summing the biomass amount contributed by each farm to the
* storage facility
*
CentralStorageBalance5(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         $((not(CentralStorageSmallScaleProcessing) or CentralStorageSmallScaleOutputProcessing))..
                         CentrallyStoredSmallScaleBiomassTotal(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         =e=
                         sum((CountySelected,FarmNumber,HarvestingHorizonAggregation2),
                                 CentrallyStoredSmallScaleBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                         );

*
* The total biomass stored at any time must not exceed the total capacity of the centralized storage
*
CentralStorageBalance6(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         $((not(CentralStorageSmallScaleProcessing) or CentralStorageSmallScaleOutputProcessing))..
                         sum((CountySelected,FarmNumber),
                                 CentrallyStoredSmallScaleBiomassVolume(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations)
                         )
                         =l=
                         CentralStorageSmallScaleFacilityArea(CentralizedStorageSmallScaleLocations)*CentralStorageSmallScaleFacilityHeight;


* The amount of biomass moved to the refinery on a day (tagged by the day it was harvested), must be less
* that the total biomass delivered to the central storage on the day of tagging!!!! (Confusing explanation)
CentralStorageBalance7(HarvestingHorizonAggregation,CountySelect
ed,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                         $((not(CentralStorageSmallScaleProcessing) or CentralStorageSmallScaleOutputProcessing)
                                                 and ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and
                                 CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations)
                                                 and FarmStorageLocationCorrelationSmallScale(FarmNumber,CentralizedStorageSmallScaleLocations)
                         )..
                         CentralStorageOutputToRefinery(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                         *card(HarvestingHorizonAggregationStep)
                         =l=
                         CentrallyStoredSmallScaleBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2);

CentralStorageBalance8(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                    $((not(CentralStorageSmallScaleProcessing) or CentralStorageSmallScaleOutputProcessing)
                                                 and ord(HarvestingHorizonAggregation)<ord(HarvestingHorizonAggregation2)
                      and CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations)
                                                 and FarmStorageLocationCorrelationSmallScale(FarmNumber,CentralizedStorageSmallScaleLocations)
                    )..
                    CentralStorageSmallScaleOutputToRefinery(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                    =e=
                    0;
*
* A Big-M formulation for the calculation of storage area as a function of the selection of a particular storage location.
* This is a one time selection and hence the contstraint is not a function of the simulation horizon.
* If the binary variable is not selected (=0), then the area is forced to be zero.
* The cost calculation will accordingly have two components: One a function of the total area and one the function of the binary variable.
* The part associated with the binary variable will represent the basic installation cost that is independent of the size of the storage facility.
*
CentralStorageBalance9(CentralizedStorageSmallScaleLocations)..
                 CentralStorageSmallScaleFacilityArea(CentralizedStorageSmallScaleLocations) =l= CentralStorageSmallScaleAreaLimit
                                                         * CentralStorageSmallScaleFacilitySelector(CentralizedStorageSmallScaleLocations);


CentralStorageBalance10(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                 $((not(CentralStorageSmallScaleProcessing) or CentralStorageSmallScaleOutputProcessing)
                                                 and ord(NonHarvestingHorizonAggregation)=1 and CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations)
                                                 and FarmStorageLocationCorrelationSmallScale(FarmNumber,CentralizedStorageSmallScaleLocations)
                 )..
                 CentrallyStoredSmallScaleBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                 =e=
                 sum(HarvestingHorizonAggregation2 $(ord(HarvestingHorizonAggregation2)=card(HarvestingHorizonAggregation2)),
                         CentrallyStoredSmallScaleBiomass(HarvestingHorizonAggregation2,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                         - CentralStorageSmallScaleOutputToRefinery(HarvestingHorizonAggregation2,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                          *card(HarvestingHorizonAggregationStep)
                         - CentralStorageSmallScaleOutputToRegional(HarvestingHorizonAggregation2,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                          *card(HarvestingHorizonAggregationStep)
                 )
                 *(1-(CentralStorageSmallScaleDryMatterLossRate/365)*card(HarvestingHorizonAggregationStep));


CentralStorageBalance11(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                 $((not(CentralStorageSmallScaleProcessing) or CentralStorageSmallScaleOutputProcessing)
                                                 and ord(NonHarvestingHorizonAggregation)>1 and CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations)
                                                 and FarmStorageLocationCorrelationSmallScale(FarmNumber,CentralizedStorageSmallScaleLocations)
                 )..
                 CentrallyStoredSmallScaleBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                 =e=
                 sum(NonHarvestingHorizonAggregation2
                         $(ord(NonHarvestingHorizonAggregation2)=ord(NonHarvestingHorizonAggregation)-1),
                         CentrallyStoredSmallScaleBiomass(NonHarvestingHorizonAggregation2,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                         -
                         CentralStorageSmallScaleOutputToRefinery(NonHarvestingHorizonAggregation2,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                         *card(NonHarvestingHorizonAggregationStep)
                         -
                         CentralStorageSmallScaleOutputToRegional(NonHarvestingHorizonAggregation2,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                         *card(NonHarvestingHorizonAggregationStep)
                 )
                 *(1-(CentralStorageSmallScaleDryMatterLossRate/365)*card(NonHarvestingHorizonAggregationStep));

* Amount of biomass moved from storage to refinery must be less than the biomass available for moving
CentralStorageBalance12(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                 $((not(CentralStorageSmallScaleProcessing) or CentralStorageSmallScaleOutputProcessing)
                                                 and CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations)
                                                 and FarmStorageLocationCorrelationSmallScale(FarmNumber,CentralizedStorageSmallScaleLocations)
                 )..
                 CentralStorageSmallScaleOutputToRefinery(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                 *card(NonHarvestingHorizonAggregationStep)
                 =l=
                 CentrallyStoredSmallScaleBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation);

*
* Constraint to enforce complete removal of the stored biomass from the central storage facilty at the end of the simulation horizon
*
CentralStorageBalance13(CentralizedStorageSmallScaleLocations,CountySelected,FarmNumber)
                 $((not(CentralStorageSmallScaleProcessing) or CentralStorageSmallScaleOutputProcessing)
                                                 and CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations)
                                                 and FarmStorageLocationCorrelationSmallScale(FarmNumber,CentralizedStorageSmallScaleLocations)
                 )..
                 sum((NonHarvestingHorizonAggregation,HarvestingHorizonAggregation)
                         $(ord(NonHarvestingHorizonAggregation)=card(NonHarvestingHorizonAggregation)),
                         CentrallyStoredSmallScaleBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                         -
                         CentralStorageSmallScaleOutputToRefinery(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                         *card(NonHarvestingHorizonAggregationStep)
                         -
                         CentralStorageSmallScaleOutputToRegional(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                         *card(NonHarvestingHorizonAggregationStep)
                 )
                 =l= 0;


CentralStorageBalance14(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         $((not(CentralStorageSmallScaleProcessing) or CentralStorageSmallScaleOutputProcessing))..
                         CentrallyStoredSmallScaleBiomassTotal(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         =e=
                         sum((CountySelected,FarmNumber,HarvestingHorizonAggregation),
                                 CentrallyStoredSmallScaleBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                         );




CentralStorageBalance15.. sum((HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                                 $(not(CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations))
                                                 or not(FarmStorageLocationCorrelationSmallScale(FarmNumber,CentralizedStorageSmallScaleLocations))
                                 ),
                                 CentralStorageSmallScaleOutputToRefinery(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                         )
                         =l=
                         0;

CentralStorageBalance16.. sum((NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                                 $(not(CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations))
                                                 or not(FarmStorageLocationCorrelationSmallScale(FarmNumber,CentralizedStorageSmallScaleLocations))
                                 ),
                                 CentralStorageSmallScaleOutputToRefinery(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                         )
                         =l=
                         0;



*===========================================================================================
*===========================================================================================
* Constraints for the case where biomass processing is done at the storage input
*===========================================================================================
*===========================================================================================


CentralStorageBalance17(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 $(CentralStorageSmallScaleProcessing and CentralStorageSmallScaleInputProcessing and ord(HarvestingHorizonAggregation)=1)..
                 CentralStorageSmallScaleProcessedBiomass(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 =e=
                 CentralStorageSmallScaleProcessingOutput(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 *card(HarvestingHorizonAggregationStep);

CentralStorageBalance18(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 $(CentralStorageSmallScaleProcessing and CentralStorageSmallScaleInputProcessing and ord(HarvestingHorizonAggregation)>1)..
                 CentralStorageSmallScaleProcessedBiomass(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 =e=
                 sum(HarvestingHorizonAggregation2$(ord(HarvestingHorizonAggregation2)=ord(HarvestingHorizonAggregation)-1),
                         CentralStorageSmallScaleProcessedBiomass(HarvestingHorizonAggregation2,CentralizedStorageSmallScaleLocations)
                         -
                         CentralStorageSmallScaleOutputToRefineryProcessed(HarvestingHorizonAggregation2,CentralizedStorageSmallScaleLocations)
                         *card(HarvestingHorizonAggregationStep)
                         -
                         CentralStorageSmallScaleOutputToRegionalProcessed(HarvestingHorizonAggregation2,CentralizedStorageSmallScaleLocations)
                         *card(HarvestingHorizonAggregationStep)
                         +
                         CentralStorageSmallScaleProcessingOutput(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         *card(HarvestingHorizonAggregationStep)
                 )
                 *(1-(CentralStorageSmallScaleDryMatterLossRate/365)*card(HarvestingHorizonAggregationStep));


CentralStorageBalance19(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 $(CentralStorageSmallScaleProcessing and CentralStorageSmallScaleInputProcessing and ord(HarvestingHorizonAggregation)>1)..
                 CentralStorageSmallScaleOutputToRefineryProcessed(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 *card(HarvestingHorizonAggregationStep)
                 =l=
                 CentralStorageSmallScaleProcessedBiomass(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations);


CentralStorageBalance20(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 $(CentralStorageSmallScaleProcessing and CentralStorageSmallScaleInputProcessing)..
                 CentralStorageSmallScaleProcessedBiomass(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 /CentralStorageSmallScaleProcessingData('BulkDensity')
                 =l=
                 CentralStorageSmallScaleFacilityArea(CentralizedStorageSmallScaleLocations)*CentralStorageSmallScaleFacilityHeight;


CentralStorageBalance21(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 $(CentralStorageSmallScaleProcessing and CentralStorageSmallScaleInputProcessing and ord(NonHarvestingHorizonAggregation)=1)..
                 CentralStorageSmallScaleProcessedBiomass(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 =e=
                 sum(HarvestingHorizonAggregation $(ord(HarvestingHorizonAggregation)=card(HarvestingHorizonAggregation)),
                         CentralStorageSmallScaleProcessedBiomass(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         - CentralStorageSmallScaleOutputToRefineryProcessed(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                          *card(HarvestingHorizonAggregationStep)
                         - CentralStorageSmallScaleOutputToRegionalProcessed(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                          *card(HarvestingHorizonAggregationStep)
                 )
                 *(1-(CentralStorageSmallScaleDryMatterLossRate/365)*card(HarvestingHorizonAggregationStep));


CentralStorageBalance22(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 $(CentralStorageSmallScaleProcessing and CentralStorageSmallScaleInputProcessing and ord(NonHarvestingHorizonAggregation)>1)..
                 CentralStorageSmallScaleProcessedBiomass(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 =e=
                 sum(NonHarvestingHorizonAggregation2$(ord(NonHarvestingHorizonAggregation2)=ord(NonHarvestingHorizonAggregation)-1),
                         CentralStorageSmallScaleProcessedBiomass(NonHarvestingHorizonAggregation2,CentralizedStorageSmallScaleLocations)
                         -
                         CentralStorageSmallScaleOutputToRefineryProcessed(NonHarvestingHorizonAggregation2,CentralizedStorageSmallScaleLocations)
                         *card(NonHarvestingHorizonAggregationStep)
                         -
                         CentralStorageSmallScaleOutputToRegionalProcessed(NonHarvestingHorizonAggregation2,CentralizedStorageSmallScaleLocations)
                         *card(NonHarvestingHorizonAggregationStep)
                 )
                 *(1-(CentralStorageSmallScaleDryMatterLossRate/365)*card(NonHarvestingHorizonAggregationStep));


CentralStorageBalance23(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 $(CentralStorageSmallScaleProcessing and CentralStorageSmallScaleInputProcessing)..
                 CentralStorageSmallScaleOutputToRefineryProcessed(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 *card(NonHarvestingHorizonAggregationStep)
                 =l=
                 CentralStorageSmallScaleProcessedBiomass(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations);


CentralStorageBalance24(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 $(CentralStorageSmallScaleProcessing and CentralStorageSmallScaleInputProcessing)..
                 CentralStorageSmallScaleProcessedBiomass(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 /CentralStorageSmallScaleProcessingData('BulkDensity')
                 =l=
                 CentralStorageSmallScaleFacilityArea(CentralizedStorageSmallScaleLocations)*CentralStorageSmallScaleFacilityHeight;


CentralStorageBalance25(CentralizedStorageSmallScaleLocations)$(CentralizedStorageSizePredefined)..
                         CentralStorageSmallScaleFacilityArea(CentralizedStorageSmallScaleLocations) =l= CentralizedStorageSmallScaleSize(CentralizedStorageSmallScaleLocations);


*
* Constraints that enforce a time limit on storage of biomass after it has been harvested and has arrived at the storage facility.
* This constraint will be used to model scenarios related to perishable biomass (such as sugarcane and Type I energy cane) that must be processed
* within a certain amount of time.
*
CentralStorageBalance26(CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations)$(BiomassStorageTimeLimitSelector)..
                 sum((HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
                                         $((ord(HarvestingHorizonAggregation)-ord(HarvestingHorizonAggregation2))*card(HarvestingHorizonAggregationStep)
                                           >
                                           BiomassStorageTimeLimit),
                                         CentrallyStoredSmallScaleBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,
                                         CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                 ) =l= 0;

CentralStorageBalance27(CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations)$(BiomassStorageTimeLimitSelector)..
                 sum((NonHarvestingHorizonAggregation,HarvestingHorizonAggregation)
                                         $(ord(NonHarvestingHorizonAggregation)*card(NonHarvestingHorizonAggregationStep)-ord(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep)
                                           >
                                           BiomassStorageTimeLimit),
                                         CentrallyStoredSmallScaleBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,
                                         CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                 ) =l= 0;

CentralStorageBalance28(HarvestingHorizonAggregation,CountySelect
ed,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                         $((not(CentralStorageSmallScaleProcessing) or CentralStorageSmallScaleOutputProcessing)
                                                 and ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and
                                 CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations)
                                                 and FarmStorageLocationCorrelationSmallScale(FarmNumber,CentralizedStorageSmallScaleLocations)
                         )..
                         CentralStorageSmallScaleOutputToRegional(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                         *card(HarvestingHorizonAggregationStep)
                         =l=
                         CentrallyStoredSmallScaleBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2);
CentralStorageBalance29(HarvestingHorizonAggregation,CountySelect
ed,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                         $((not(CentralStorageSmallScaleProcessing) or CentralStorageSmallScaleOutputProcessing)
                                                 and ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and
                                 CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations)
                                                 and FarmStorageLocationCorrelationSmallScale(FarmNumber,CentralizedStorageSmallScaleLocations)
                         )..
                         CentralStorageSmallScaleOutputToRefinery(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                         *card(HarvestingHorizonAggregationStep)
                         +
                         CentralStorageSmallScaleOutputToRegional(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                         *card(HarvestingHorizonAggregationStep)
                         =l=
                         CentrallyStoredSmallScaleBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2);
CentralStorageBalance30(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                    $((not(CentralStorageSmallScaleProcessing) or CentralStorageSmallScaleOutputProcessing)
                                                 and ord(HarvestingHorizonAggregation)<ord(HarvestingHorizonAggregation2)
                      and CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations)
                                                 and FarmStorageLocationCorrelationSmallScale(FarmNumber,CentralizedStorageSmallScaleLocations)
                    )..
                    CentralStorageSmallScaleOutputToRegional(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                    =e=
                    0;

CentralStorageBalance31(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                 $((not(CentralStorageSmallScaleProcessing) or CentralStorageSmallScaleOutputProcessing)
                                                 and CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations)
                                                 and FarmStorageLocationCorrelationSmallScale(FarmNumber,CentralizedStorageSmallScaleLocations)
                 )..
                 CentralStorageSmallScaleOutputToRegional(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                 *card(NonHarvestingHorizonAggregationStep)
                 =l=
                 CentrallyStoredSmallScaleBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation);

CentralStorageBalance32(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                 $((not(CentralStorageSmallScaleProcessing) or CentralStorageSmallScaleOutputProcessing)
                                                 and CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations)
                                                 and FarmStorageLocationCorrelationSmallScale(FarmNumber,CentralizedStorageSmallScaleLocations)
                 )..
                 CentralStorageSmallScaleOutputToRefinery(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                 *card(NonHarvestingHorizonAggregationStep)
                 +
                 CentralStorageSmallScaleOutputToRegional(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                 *card(NonHarvestingHorizonAggregationStep)
                 =l=
                 CentrallyStoredSmallScaleBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation);

CentralStorageBalance33.. sum((HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                                 $(not(CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations))
                                                 or not(FarmStorageLocationCorrelationSmallScale(FarmNumber,CentralizedStorageSmallScaleLocations))
                                 ),
                                 CentralStorageSmallScaleOutputToRegional(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                         )
                         =l=
                         0;

CentralStorageBalance34.. sum((NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                                 $(not(CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations))
                                                 or not(FarmStorageLocationCorrelationSmallScale(FarmNumber,CentralizedStorageSmallScaleLocations))
                                 ),
                                 CentralStorageSmallScaleOutputToRegional(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation)
                         )
                         =l=
                         0;

CentralStorageBalance35(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 $(CentralStorageSmallScaleProcessing and CentralStorageSmallScaleInputProcessing and ord(HarvestingHorizonAggregation)>1)..
                 CentralStorageSmallScaleOutputToRegionalProcessed(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 *card(HarvestingHorizonAggregationStep)
                 =l=
                 CentralStorageSmallScaleProcessedBiomass(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations);

CentralStorageBalanc36(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 $(CentralStorageSmallScaleProcessing and CentralStorageSmallScaleInputProcessing and ord(HarvestingHorizonAggregation)>1)..
                 CentralStorageSmallScaleOutputToRefineryProcessed(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 *card(HarvestingHorizonAggregationStep)
                 +
                 CentralStorageSmallScaleOutputToRegionalProcessed(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 *card(HarvestingHorizonAggregationStep)
                 =l=
                 CentralStorageSmallScaleProcessedBiomass(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations);

CentralStorageBalance37(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 $(CentralStorageSmallScaleProcessing and CentralStorageSmallScaleInputProcessing)..
                 CentralStorageSmallScaleOutputToRegionalProcessed(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 *card(NonHarvestingHorizonAggregationStep)
                 =l=
                 CentralStorageSmallScaleProcessedBiomass(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations);

CentralStorageBalance38(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 $(CentralStorageSmallScaleProcessing and CentralStorageSmallScaleInputProcessing)..
                 CentralStorageSmallScaleOutputToRefineryProcessed(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 *card(NonHarvestingHorizonAggregationStep)
                 +
                 CentralStorageSmallScaleOutputToRegionalProcessed(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                 *card(NonHarvestingHorizonAggregationStep)
                 =l=
                 CentralStorageSmallScaleProcessedBiomass(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations);

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
