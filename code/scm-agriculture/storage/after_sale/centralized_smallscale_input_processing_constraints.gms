$title The file that includes constraints related to processing at the centralized storage facility at the input


*=======================================================================================
* Constraints related to biomass processing at the central storage facility
*=======================================================================================
Equations
                 CentralStorageSmallScaleInputProcessing1
                 CentralStorageSmallScaleInputProcessing2
                 CentralStorageSmallScaleInputProcessing3
                 CentralStorageSmallScaleInputProcessing4
                 ;


*
* If the option of processing at the centralized storage facility is selected, then all the output from the centralized storage facility must
* be sent to the processing (input to the processing option)
*
CentralStorageSmallScaleInputProcessing1(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)$(CentralStorageSmallScaleProcessing and CentralStorageSmallScaleInputProcessing)..
                         CentralStorageSmallScaleProcessingInput(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         =e=
                         ( sum((CountySelected,FarmNumber)$(CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations)
                                                 and FarmStorageLocationCorrelationSmallScale(FarmNumber,CentralizedStorageSmallScaleLocations)),
                           HarvestFarmGateCentralStorageSmallScaleBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,
                                                                         CentralizedStorageSmallScaleLocations)
                           +
                           FarmCoveredStorageFarmGateCentralStorageSmallScaleBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,
                                                                         CentralizedStorageSmallScaleLocations)
                           +
                           FarmOpenStorageFarmGateCentralStorageSmallScaleBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,
                                                                         CentralizedStorageSmallScaleLocations)
                           )
                           *(1-TransportationDryMatterLossRate)
                         );


*
* Bounding the selection of a particular option based on the user selection
*
CentralStorageSmallScaleInputProcessing2(CentralizedStorageSmallScaleLocations)$(CentralStorageSmallScaleProcessing and CentralStorageSmallScaleInputProcessing)..
                     NumberOfCentralStorageSmallScaleProcessors(CentralizedStorageSmallScaleLocations)
                     =l=
                     NumberOfCentralStorageSmallScaleProcessors.up(CentralizedStorageSmallScaleLocations);

*
* Now, bounding the total input to a particular processing option as a function of the number of equipment of that option
* and the total throughput capacity of that option.
*
CentralStorageSmallScaleInputProcessing3(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)$(CentralStorageSmallScaleProcessing and CentralStorageSmallScaleInputProcessing)..
                         CentralStorageSmallScaleProcessingInput(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         =l=
                         NumberOfCentralStorageSmallScaleProcessors(CentralizedStorageSmallScaleLocations)
                         * CentralStorageSmallScaleProcessingData('DesignCapacity')
                         * CentralStorageSmallScaleProcessingData('Efficiency')
                         * HoursPerDay;


*
* Calculating the final output from the processing unit based on the biomass loss for the selected equipment
*
CentralStorageSmallScaleInputProcessing4(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)$(CentralStorageSmallScaleProcessing and CentralStorageSmallScaleInputProcessing)..
                         CentralStorageSmallScaleProcessingOutput(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         =l=
                         CentralStorageSmallScaleProcessingInput(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         * (1-CentralStoragSmallScaleProcessingData('BiomassLoss'));


*=======================================================================================
* Declaration of the model based on the constraints described in this gams file
*=======================================================================================

Model CentralizedStorageSmallScaleInputProcessingModel /
                 CentralStorageSmallScaleInputProcessing1
                 CentralStorageSmallScaleInputProcessing2
                 CentralStorageSmallScaleInputProcessing3
                 CentralStorageSmallScaleInputProcessing4
                 /;
