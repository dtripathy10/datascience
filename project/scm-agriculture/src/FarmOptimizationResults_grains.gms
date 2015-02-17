$title "Storing the results of individual farm optimization problems in parameters for future use"

Parameter
  Par_FarmGateGrainAvailability
  Par_HarvestToFarmGate
  Par_FarmGateTotalGrain
  Par_CumulativeFarmGateGrainAvailability
  Par_FarmTruckCorrelation
  Par_FarmGrainForm
  Par_FarmPackingDensity
  ;

* Calculting the base farm gate cost for each individual farm that is used later to determine the farm gate price profile
Par_FarmGateTotalGrain = 
  sum((DistrictSelected,FarmNumber),
    GrainAvailable(DistrictSelected,FarmNumber)
  );

Par_FarmGrainForm(DistrictSelected,FarmNumber) = 2;
Par_FarmPackingDensity(DistrictSelected,FarmNumber) = 785;

*----------------------------------------------------------------------------------------------------------
* Currently, we assume that all the grain that is available at the farm gate is from the harvest and there is 
* not on-farm storage
*----------------------------------------------------------------------------------------------------------

Par_HarvestToFarmGate(HarvestingHorizonAggregation,DistrictSelected,FarmNumber) = 0;
Par_HarvestToFarmGate(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber) = 0;
Par_HarvestToFarmGate('1',DistrictSelected,FarmNumber) = GrainAvailable(DistrictSelected,FarmNumber);

* Calculating the desired parameters after the farm management optimization problems and storing the results in appropriate parameters
Par_CumulativeFarmGateGrainAvailability(HarvestingHorizonAggregation) = 
  sum((DistrictSelected,FarmNumber),
    Par_HarvestToFarmGate(HarvestingHorizonAggregation,DistrictSelected,FarmNumber)
  );

Par_CumulativeFarmGateGrainAvailability(NonHarvestingHorizonAggregation)  = 
  sum((DistrictSelected,FarmNumber),
    Par_HarvestToFarmGate(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber)
  );

Display  
  Par_FarmGateTotalGrain, Par_HarvestToFarmGate, Par_CumulativeFarmGateGrainAvailability
  ;

*====================================================================================================================
* Transportation operation related modifications: Based on the output form of Grain from a given farm, the type of
* transportation equipment that can be used is limited. A correlation indicator is created here which enables us
* to limit the number of transportation equipment considered for selection. This will reduce the number of possibilities
* in the provision problem and speed up the computational process.
*====================================================================================================================
* First initializing every combination to be zero and then making selected combinations equal to 1
Par_FarmTruckCorrelation(DistrictSelected,FarmNumber,TransportationTypes) = 0;
Par_FarmTruckCorrelation(DistrictSelected,FarmNumber,TransportationTypes) = 1
  $(Par_FarmGrainForm(DistrictSelected,FarmNumber) = TransportationData('InputForm',TransportationTypes));



