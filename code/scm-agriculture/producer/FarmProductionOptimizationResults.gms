*
* Calculating the desired parameters after the farm management optimization problems and storing the results in appropriate parameters
*
Par_CumulativeFarmGateBiomassAvailability(HarvestingHorizonAggregation) = sum((CountySelected,FarmNumber),
                                                                         Par_FarmGateBiomassAvailability(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                                                       );

Par_CumulativeFarmGateBiomassAvailability(NonHarvestingHorizonAggregation)  = sum((CountySelected,FarmNumber),
                                                                         Par_FarmGateBiomassAvailability(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                                                                       );

R_OnFarmOpenStorageAreaProgress(IterationSet)$(ord(IterationSet)=IterationCount)
                                = sum((CountySelected,FarmNumber), Par_FarmStorageConfiguration(CountySelected,FarmNumber,'Open')
                                  );

R_OnFarmCoveredStorageAreaProgress(IterationSet)$(ord(IterationSet)=IterationCount)
                                = sum((CountySelected,FarmNumber), Par_FarmStorageConfiguration(CountySelected,FarmNumber,'Covered')
                                  );

R_OnFarmSilagePitAreaProgress(IterationSet)$(ord(IterationSet)=IterationCount)
                                = sum((CountySelected,FarmNumber), Par_FarmStorageConfiguration(CountySelected,FarmNumber,'SilagePit')
                                  );

R_BiomassAvailabilityProfileProgress(HarvestingHorizonAggregation,IterationSet)$(ord(IterationSet)=IterationCount) =
                 Par_CumulativeFarmGateBiomassAvailability(HarvestingHorizonAggregation);
R_BiomassAvailabilityProfileProgress(NonHarvestingHorizonAggregation,IterationSet)$(ord(IterationSet)=IterationCount) =
                 Par_CumulativeFarmGateBiomassAvailability(NonHarvestingHorizonAggregation);


Par_ExpectedRefineryCapacity = ( sum(HarvestingHorizonAggregation,Par_CumulativeFarmGateBiomassAvailability(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep))
                                 +
                                 sum(NonHarvestingHorizonAggregation,Par_CumulativeFarmGateBiomassAvailability(NonHarvestingHorizonAggregation)*card(NonHarvestingHorizonAggregationStep))
                               )/card(simulationHorizon);


Par_AverageFarmGateCost = sum((CountySelected,FarmNumber), Par_FarmGateBiomassCost(CountySelected,FarmNumber))/card(FarmNumber);

$ontext
*
* Display results for the farm management problem solutions
*
option  Par_FarmHarvesterSelection:2:0:1;
Display Par_FarmHarvesterSelection, Par_FarmFieldLoaderSelection, Par_FarmRakerSelection, Par_FarmBalerSelection, Par_FarmChopperSelection, Par_FarmPelletizerSelection, Par_FarmGrinderSelection,
        Par_NumberOfLoaders, Par_InFieldTransportationSelection, Par_FarmHarvestSchedule, Par_FarmGateBiomassAvailability, Par_FarmBiomassBaledUnits,
        Par_FarmCost, Par_FarmStorageConfiguration,  Par_CumulativeFarmGateBiomassAvailability, Par_FarmGateBiomassCost,
        Par_HarvestingCost, Par_RakingCost, Par_PackingCost, Par_FarmStorageCost, Par_InFieldTransportationCost,
        Par_FarmBiomassHandlingCost, Par_FarmStorageConfiguration, Par_HarvestToFarmGate, Par_ExpectedRefineryCapacity;

Display Par_FarmCost, Par_FarmGateBiomassCost, Par_HarvestingCost, Par_HarvestingFixedCost, Par_HarvestingOperatingCost,
        Par_PackingCost, Par_PackingOperatingCost, Par_PackingFixedCost,
        Par_FarmStorageCost,
        Par_InFieldTransportationCost, Par_InFieldTransportationFixedCost, Par_InFieldTransportationOperatingCost,
        Par_FarmBiomassHandlingCost,Par_FarmBiomassHandlingFixedCost, Par_FarmBiomassHandlingOperatingCost;
$offtext

Display  Par_CumulativeFarmGateBiomassAvailability,  Par_ExpectedRefineryCapacity;


*====================================================================================================================
* Transportation operation related modifications: Based on the output form of biomass from a given farm, the type of
* transportation equipment that can be used is limited. A correlation indicator is created here which enables us
* to limit the number of transportation equipment considered for selection. This will reduce the number of possibilities
* in the provision problem and speed up the computational process.
*====================================================================================================================
* First initializing every combination to be zero and then making selected combinations equal to 1
Par_FarmTruckCorrelation(CountySelected,FarmNumber,TransportationTypes) = 0;
Par_FarmTruckCorrelation(CountySelected,FarmNumber,TransportationTypes) = 1
                                 $(Par_FarmBiomassForm(CountySelected,FarmNumber)=TransportationData('InputForm',TransportationTypes));


Par_CumulativeBiomassHarvested = sum((CountySelected,FarmNumber), Par_TotalBiomassHarvested(CountySelected,FarmNumber));


Par_FarmGateCostProgress(IterationSet)$(ord(IterationSet)=IterationCount) = sum((CountySelected,FarmNumber),Par_FarmCost(CountySelected,FarmNumber));

*Display  Par_HarvestToFarmGateTotal, Par_FarmCoveredStorageToFarmGateTotal, Par_FarmOpenStorageToFarmGateTotal, Par_EnsilingToFarmGateTotal,
*         Par_TotalBiomassHarvested, Par_EnergyConsumptionHarvesting, Par_CumulativeBiomassHarvested;
