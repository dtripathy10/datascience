$title The file that includes constraints related to processing at the centralized storage facility at the input


*=======================================================================================
* Constraints related to biomass processing at the central storage facility
*=======================================================================================
Equations
                 CentralStorageInputProcessing1
                 CentralStorageInputProcessing2
                 CentralStorageInputProcessing3
                 CentralStorageInputProcessing4
                 ;


*
* If the option of processing at the centralized storage facility is selected, then all the output from the centralized storage facility must
* be sent to the processing (input to the processing option)
*
CentralStorageInputProcessing1(HarvestingHorizonAggregation,CentralizedStorageLocations)$(CentralStorageProcessing and CentralStorageInputProcessing)..
                         CentralStorageProcessingInput(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         =e=
                         ( sum((CountySelected,FarmNumber)$(CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)),
                           HarvestFarmGateCentralStorageBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,
                                                                         CentralizedStorageLocations)
                           +
                           FarmCoveredStorageFarmGateCentralStorageBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,
                                                                         CentralizedStorageLocations)
                           +
                           FarmOpenStorageFarmGateCentralStorageBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,
                                                                         CentralizedStorageLocations)
                           )
                           *(1-TransportationDryMatterLossRate)
                         );


*
* Bounding the selection of a particular option based on the user selection
*
CentralStorageInputProcessing2(CentralizedStorageLocations)$(CentralStorageProcessing and CentralStorageInputProcessing)..
                     NumberOfCentralStorageProcessors(CentralizedStorageLocations)
                     =l=
                     NumberOfCentralStorageProcessors.up(CentralizedStorageLocations);

*
* Now, bounding the total input to a particular processing option as a function of the number of equipment of that option
* and the total throughput capacity of that option.
*
CentralStorageInputProcessing3(HarvestingHorizonAggregation,CentralizedStorageLocations)$(CentralStorageProcessing and CentralStorageInputProcessing)..
                         CentralStorageProcessingInput(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         =l=
                         NumberOfCentralStorageProcessors(CentralizedStorageLocations)
                         * CentralStorageProcessingData('DesignCapacity')
                         * CentralStorageProcessingData('Efficiency')
                         * HoursPerDay;


*
* Calculating the final output from the processing unit based on the biomass loss for the selected equipment
*
CentralStorageInputProcessing4(HarvestingHorizonAggregation,CentralizedStorageLocations)$(CentralStorageProcessing and CentralStorageInputProcessing)..
                         CentralStorageProcessingOutput(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         =l=
                         CentralStorageProcessingInput(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         * (1-CentralStorageProcessingData('BiomassLoss'));


*=======================================================================================
* Declaration of the model based on the constraints described in this gams file
*=======================================================================================

Model CentralizedStorageInputProcessingModel /
                 CentralStorageInputProcessing1
                 CentralStorageInputProcessing2
                 CentralStorageInputProcessing3
                 CentralStorageInputProcessing4
                 /;
