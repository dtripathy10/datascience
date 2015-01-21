$title The file that includes constraints related to processing at the centralized storage facility


*=======================================================================================
* Constraints related to biomass processing at the central storage facility
*=======================================================================================
Equations
                 CentralStorageProcessing1
                 CentralStorageProcessing2
                 CentralStorageProcessing3
                 CentralStorageProcessing4
                 CentralStorageProcessing5
                 CentralStorageProcessing6
                 CentralStorageProcessing7
                 CentralStorageProcessing8
                 CentralStorageProcessing9
                 ;


*
* If the option of processing at the centralized storage facility is selected, then all the output from the centralized storage facility must
* be sent to the processing (input to the processing option)
*
CentralStorageProcessing1(HarvestingHorizonAggregation,CentralizedStorageLocations)$(CentralStorageProcessing and CentralStorageOutputProcessing)..
                         CentralStorageProcessingInput(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         =e=
                         sum((CountySelected,FarmNumber,HarvestingHorizonAggregation2),
                                         CentralStorageOutput(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,
                                                         HarvestingHorizonAggregation2)
                         );


*
* Bounding the selection of a particular option based on the user selection
*
CentralStorageProcessing2(CentralizedStorageLocations)$(CentralStorageProcessing and CentralStorageOutputProcessing)..
                     NumberOfCentralStorageProcessors(CentralizedStorageLocations)
                     =l=
                     NumberOfCentralStorageProcessors.up(CentralizedStorageLocations);

*
* Now, bounding the total input to a particular processing option as a function of the number of equipment of that option
* and the total throughput capacity of that option.
*
CentralStorageProcessing3(HarvestingHorizonAggregation,CentralizedStorageLocations)$(CentralStorageProcessing and CentralStorageOutputProcessing)..
                         CentralStorageProcessingInput(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         =l=
                         NumberOfCentralStorageProcessors(CentralizedStorageLocations)
                         * CentralStorageProcessingData('DesignCapacity')
                         * CentralStorageProcessingData('Efficiency')
                         * HoursPerDay;


*
* Calculating the final output from the processing unit based on the biomass loss for the selected equipment
*
CentralStorageProcessing4(HarvestingHorizonAggregation,CentralizedStorageLocations)$(CentralStorageProcessing and CentralStorageOutputProcessing)..
                         CentralStorageProcessingOutput(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         =l=
                         CentralStorageProcessingInput(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         * (1-CentralStorageProcessingData('BiomassLoss'));

*
* Calculating the volume of the biomass coming from the processing unit based on the packing/bulk density of the equipment selected.
*
CentralStorageProcessing5(HarvestingHorizonAggregation,CentralizedStorageLocations)$(CentralStorageProcessing and CentralStorageOutputProcessing)..
                         CentralStorageProcessingOutputVolume(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         =g=
                         CentralStorageProcessingOutput(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         /CentralStorageProcessingData('BulkDensity');



*
* Repeating the constraints for the non-harvesting horizon
*

CentralStorageProcessing6(NonHarvestingHorizonAggregation,CentralizedStorageLocations)$(CentralStorageProcessing and CentralStorageOutputProcessing)..
                         CentralStorageProcessingInput(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                         =e=
                         sum((CountySelected,FarmNumber,HarvestingHorizonAggregation),
                                         CentralStorageOutput(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,
                                                         HarvestingHorizonAggregation)
                         );

CentralStorageProcessing7(NonHarvestingHorizonAggregation,CentralizedStorageLocations)$(CentralStorageProcessing and CentralStorageOutputProcessing)..
                         CentralStorageProcessingInput(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                         =l=
                         NumberOfCentralStorageProcessors(CentralizedStorageLocations)
                         * CentralStorageProcessingData('DesignCapacity')
                         * CentralStorageProcessingData('Efficiency')
                         * HoursPerDay;


*
* Calculating the final output from the processing unit based on the biomass loss for the selected equipment
*
CentralStorageProcessing8(NonHarvestingHorizonAggregation,CentralizedStorageLocations)$(CentralStorageProcessing and CentralStorageOutputProcessing)..
                         CentralStorageProcessingOutput(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                         =l=
                         CentralStorageProcessingInput(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                         * (1-CentralStorageProcessingData('BiomassLoss'));

*
* Calculating the volume of the biomass coming from the processing unit based on the packing/bulk density of the equipment selected.
*
CentralStorageProcessing9(NonHarvestingHorizonAggregation,CentralizedStorageLocations)$(CentralStorageProcessing and CentralStorageOutputProcessing)..
                         CentralStorageProcessingOutputVolume(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                         =g=
                         CentralStorageProcessingOutput(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                         /CentralStorageProcessingData('BulkDensity');


*=======================================================================================
* Declaration of the model based on the constraints described in this gams file
*=======================================================================================

Model CentralizedStorageProcessingModel /
                 CentralStorageProcessing1
                 CentralStorageProcessing2
                 CentralStorageProcessing3
                 CentralStorageProcessing4
                 CentralStorageProcessing5
                 CentralStorageProcessing6
                 CentralStorageProcessing7
                 CentralStorageProcessing8
                 CentralStorageProcessing9
                 /;
