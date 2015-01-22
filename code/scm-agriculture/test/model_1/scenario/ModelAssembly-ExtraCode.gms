$GDXIN market_price_wheat.gdx
$LOAD BiomassRefineryGatePrice
$GDXIN
*
* Parameters related to the DDC step size
*
Parameter DDCStepSize1 The step size for the first iteration of the DDC algorithm /0.3/
          DDCStepSize2 The step size for the second and subsequent iterations of the DDC algorithm /0.05/
          ModelStatus1 The parameter that is used to store the solution status of the optimization model
          ModelStatus2 The parameter that is used to store the solution status of the optimization model;


*##############################################################################################################
* Including different data files that are independently written
*##############################################################################################################

$include BiomassProductivityData-Switchgrass.gms
$include RegionalWeatherData.gms
$include MachineData_grains.gms

*##############################################################################################################
* Including data files related to different tasks
*##############################################################################################################

$include StorageData.gms
$include TransportationData.gms
$include BiomassHandlingData.gms

*##############################################################################################################
* Including data files related to user selection. Although this file is included, the conditional statement
* included in the code ensures that the code is executed only for certain user selections.
*##############################################################################################################

$include UserSelection.gms

$include PostUserSelectionCalculations.gms

$include HarvestScheduleCalculation.gms
**$batinclude HarvestScheduleCalculation1 HarvestingScheduleFixed  HarvestingScheduleProfile
**$batinclude HarvestScheduleCalculation2 HarvestingScheduleFixed  HarvestingScheduleProfile

$include FarmProductionParameterDeclaration.gms

*#############################################################################################################################
* Parameters calculated after the solution of the provision problem
*#############################################################################################################################
Parameter
                 Par_ProvisionStorageCost The storage cost for the provision model calcualted after the provision problem solution for feedback
                 Par_ProvisionTransportationCost The transportation cost calculated after the provision model solution for feedback
                 Par_ProvisionStorageCostRateConstrained The storage cost for the provision model calcualted after the provision problem solution for feedback per unit biomass
                 Par_ProvisionStorageCostRate The storage cost for the provision model calcualted after the provision problem solution for feedback per unit biomass
                 Par_ProvisionStorageProcessingCostConstrained The processing cost at the storage facilities for the provision model calcualted after the provision problem solution for feedback
                 Par_ProvisionStorageProcessingCost The processing cost at the storage facilities for the provision model calcualted after the provision problem solution for feedback
                 Par_ProvisionTransportationCostRate The transportation cost calculated after the provision model solution for feedback per unit biomass
                 Par_ProvisionBiomassHandlingCost The total cost of biomass handling for the biomass provision model

                 Par_FarmGatePriceChangeMagnitude The magnitude of price change for the farm gate

                 Par_CentralStorageOutput The total biomass output from a centralized storage facility
                 TotalRefineryGateBiomass;


*##############################################################################################################
* Declaring parameters related to farm gate price adjustment
*##############################################################################################################
Parameter
                 FarmBiomassPickup(SimulationHorizon)

                 FarmGatePriceProfileOld The parameter to store the current farm gate price profile which is then used to calculate the next price profile
                 FarmGatePriceProgress(SimulationHorizon,IterationSet) The profile for the farm gate price for each algorithm iteration

                 Par_MeanFarmGateBiomassAvailability The mean biomass availability at the farm gate for the complete horizon
                 Par_FarmGateBiomassAvailabilityProfile The profile of biomass available at the farm gate compared to the mean biomass availability for the complete horizon

                 SupplyRangeMax
                 SupplyRangeMin

                 Par_FarmGateBiomassPickup(SimulationHorizon,CountyDataSet,TotalFarmNumber) The biomass pick-up profile at the farm gate by the biomass provision model
                 Par_FarmGateBiomassPickupProfile(SimulationHorizon,CountyDataSet,TotalFarmNumber) The biomass pick-up profile at the farm gate by the biomass provision model
                 Par_CumulativeFarmGateBiomassPickup The cumulative biomass pick up by the provision model for the simulation horizon
                 Par_CumulativeFarmGateBiomassPickupProfile The profile for biomass pick up by the provision model for the simulation horizon
                 Par_MeanFarmGateBiomassPickup

                 DemandRangeMax
                 DemandRangeMin

                 Par_FarmGatePriceProfileSupply The new price profile determined using the old profile and the supply curve
                 Par_FarmGatePriceProfileDemand The new price profile determined using the old profile and the demand curve

                 StorageProcessingPriceIncentive The price incentive that is used to model the selection of the particular pre-processing option at the farms and make it coincide with the pre-processing option at the storage facility;


*##############################################################################################################
* First including the GAMS files that are used to build the farm management optimization model and then building the model
*##############################################################################################################

*$include HarvestingConstraints.gms

*$include PostHarvestBiomassDistribution.gms
*$include RakingConstraints.gms
*$include PostRakingBiomassDistribution.gms
*$include OnFarmBiomassConstraints.gms
*$include PostOnFarmBiomassDistribution.gms
*$include FarmLoadingConstraints.gms
*$include PostFarmLoadingBiomassDistribution.gms

*$include PackingDistribution.gms
*$include BalingConstraints.gms
*$include ChoppingConstraints.gms
*$include PelletizingConstraints.gms
*$include GrindingConstraints.gms
*$include PackingOutput.gms

*$include FarmCoveredStorageConstraints.gms
*$include FarmOpenStorageConstraints.gms
*$include FarmEnsilingConstraints.gms
*$include FarmGateBiomassAvailability.gms

*$include FarmBiomassHandling.gms
*$include InFieldTransportationConstraints.gms

*$include FarmEnergyConstraints.gms
*$include FarmCostConstraints.gms
*$offtext
$ontext
if (FarmSpecificEquipmentSelection = 0,

         Par_FarmSpecificPriceProfile(HarvestingHorizonAggregation,CountySelected,FarmNumber) = FarmGatePriceProfileInitialization;
         Par_FarmSpecificPriceProfile(NonHarvestingHorizonAggregation,CountySelected,FarmNumber) = FarmGatePriceProfileInitialization;

elseif FarmSpecificEquipmentSelection = 1,

         Par_FarmSpecificPriceProfile(HarvestingHorizonAggregation,CountySelected,FarmNumber) = FarmGatePriceProfileInput(FarmNumber,HarvestingHorizonAggregation);
         Par_FarmSpecificPriceProfile(NonHarvestingHorizonAggregation,CountySelected,FarmNumber) = FarmGatePriceProfileInput(FarmNumber,NonHarvestingHorizonAggregation);

);
$offtext
$ontext
Model FarmManagementModel /HarvestingModel, PostHarvestBiomassDistribution, FieldLoadingModel, PostFarmLoadingBiomassDistribution,
                         RakingModel, PostRakingBiomassDistribution,
                         OnFarmBiomassModel, PostOnFarmBiomassDistribution,
                         PackingDistribution,
                         BalingModel, ChoppingModel, PelletizationModel, GrindingModel, PackingOutputDistribution,
                         FarmCoveredStorageModel, FarmOpenStorageModel, FarmEnsilingModel,
                         FarmBiomassHandlingModel,
                         InFieldTransportationModel,
                         FarmBiomassAvailabilityModel,  FarmEnergyCalculationModel,
                         FarmCostModel
                         /;
$offtext

*##############################################################################################################
* Now including the GAMS files that are used to build the provision model based on the results from the farm management model
*##############################################################################################################

$include VariableDeclaration_grains.gms

$include FarmGateBiomassDistribution_grains.gms
$include TransportationConstraints.gms
$include CentralizedStorageConstraints_grains.gms
$include CentralizedStorageSmallScaleConstraints_grains.gms
$include CentralizedStorageProcessing.gms
$include CentralizedStorageInputProcessing_grains.gms
$include CentralizedStorageSmallScaleInputProcessing_grains.gms
$include RefineryBufferConstraints.gms
$include RefineryConstraints.gms
$include ProvisionEnergyConstraints.gms
$include ProvisionCostConstraints.gms


Model BiomassProvisionModel /FarmGateBiomassDistributionModel, TransportationModelEquipmentPredefined, CentralizedStorageModel,
                 CentralizedStorageProcessingModel, CentralizedStorageInputProcessingModel, ProvisionCostModel, ProvisionEnergyModel,
                 RefineryBufferModel, RefineryModelConstrained/;

$include FarmGateBiomassDistributionConstrained_grains.gms

Model BiomassProvisionModelConstrained /FarmGateBiomassDistributionModelConstrained, TransportationModelEquipmentPredefined,
                 CentralizedStorageModelConstrained, CentralizedStorageProcessingModel, CentralizedStorageInputProcessingModel,
                 ProvisionCostModel, ProvisionEnergyModel, RefineryBufferModel, RefineryModelConstrained/;

Model BiomassProvisionModelOptimal /FarmGateBiomassDistributionModelConstrained, TransportationModelEquipmentPredefined,
                 CentralizedStorageModelConstrained, CentralizedStorageProcessingModel, CentralizedStorageInputProcessingModel,
                 ProvisionCostModel, ProvisionEnergyModel, RefineryBufferModel, RefineryModelConstrained/;

*##############################################################################################################
* Declaring parameters related to the solution progress of the DDC algorithm
*##############################################################################################################

Parameter
                 R_BiorefineryCapacityProgress(IterationSet) The changes in the refinery capacity as a function of the iterations
                 R_CentralStorageAreaProgress(CentralizedStorageLocationSet,IterationSet) The changes in the centralized storage area as a function of the iterations
                 R_TransportationFleetSizeProgress(TransportationTypes,IterationSet) The changes in the transportation fleet size as a function of the iteration
                 R_OnFarmOpenStorageAreaProgress(IterationSet) The change in the total on-farm covered storage are as a function of iterations
                 R_OnFarmCoveredStorageAreaProgress(IterationSet) The change in the total on-farm covered storage are as a function of iterations
                 R_OnFarmSilagePitAreaProgress(IterationSet) The change in the total on-farm covered storage are as a function of iterations
                 R_ProvisionModelObjectiveProgress(IterationSet) The changes in the objective function value for the provision model
                 R_TotalSystemCostProgress(IterationSet) The changes in the total cost of the system after the completion of both master and secondary problems
                 R_DeliveredCostProgress(IterationSet) The changes in the per unit delivered cost for the system after the completion of the master and secondary problems
                 R_ProfitProgress(IterationSet) The changes in the total system profit after each interation
                 R_TotalBiomassAvailableProgress(IterationSet)
                 R_BiomassAvailabilityProfileProgress(SimulationHorizon,IterationSet)
                 R_BiomassPickupProfileProgress(SimulationHorizon,IterationSet)

                 Par_DeliveredBiomass The profile of the biomass delivered to the refinery
                 Par_TotalDeliveredBiomass The profile of the biomass delivered to the refinery
                 Par_FarmGateSupplyDemandDifference
                 Par_TotalSupplyDemandDifference
                 Par_FarmGateCostProgress(IterationSet)
                 Par_ProvisionCostProgress(IterationSet)
                 Par_ProvisionStorageCostProgress(IterationSet)
                 Par_ProvisionHandlingCostProgress(IterationSet)
                 Par_ProvisionTransportFixedCostProgress(IterationSet)
                 Par_ProvisionCostTransportOperProgress(IterationSet)

                 ;

*##############################################################################################################
* Declaring parameters related to final presentation of the results
*##############################################################################################################

Parameters
                 TotalSystemCost The total cost of the system after the completion of both master and secondary problems
                 DeliveredCost The per unit delivered cost for the system after the completion of the master and secondary problems
                 Profit The total profit for the whole system
                 TotalBiomassAvailable

                 OptimalProvisionObjective

                 OptimalFarmSpecificPriceProfile The price profile for the optimal result that is specific to the farm
                 OptimalStorageProcessingPriceIncentive Optimal value of the processing incentive for the farms if centralized storage processing is used
                 OptimalIterationCount

                 OptimalDeliveredCost The per unit delivered cost for the system after the completion of the master and secondary problems
                 OptimalRefineryCapacity
                 OptimalTransportationFleetSize(TransportationTypes)
                 OptimalCentralStorageFacilityArea
                 OptimalOnFarmCoveredStorageArea
                 OptimalOnFarmOpenStorageArea
                 OptimalSilagePitArea

                 OptimalSupplyDemandDifference The supply and demand difference for the optimal result
                 OptimalTotalSystemCost The total cost of the system after the completion of both master and secondary problems
                 OptimalObjective The optimal value of the objective function
                 CurrentObjective The current value of the objective that is compared with the optimal objective;


*=================================================================================================================
* The first step is to solve the farm management problem individually
*=================================================================================================================

*FarmManagementModel.solvelink=3;

Option MIP = cplex;
Option ResLim = 5000;
*FarmManagementModel.optcr = 0.01;
*FarmManagementModel.optfile=1;

BiomassProvisionModelConstrained.optfile=1;
BiomassProvisionModel.optfile=1;
BiomassProvisionModelOptimal.optfile=1;

BiomassProvisionModelConstrained.optcr=0.01;
BiomassProvisionModel.optcr=0.035;
BiomassProvisionModelOptimal.optcr=0.01;


Parameter
         GridHandler(TotalFarmNumber) The handler that is used to identify a unique problem
         IterationCount The counter used to iterate in the algorithm;

* Initializing the loop counter
IterationCount=1;
*
* Initializing the storage processing cost (modified for the subsequent iterations based on the solution of the provision problem)
* This is use only if there is pre-processing at the central storage facility
*
if(CentralStorageProcessing=1,
         Par_ProvisionStorageProcessingCost = 0;
         StorageProcessingPriceIncentive = 0;
);
*
* Initializing the pick-up profile to be zero for the first iteration
*
Par_FarmGateBiomassPickup(HarvestingHorizonAggregation,CountySelected,FarmNumber) = 1E6;
Par_FarmGateBiomassPickup(NonHarvestingHorizonAggregation,CountySelected,FarmNumber) = 1E6;
*
* Initializing the optimal objective function value
*
OptimalObjective = 999999999;

$ontext

loop(CountySelected,

         CentralStorageLocationCorrelation(CentralizedStorageLocations)=CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations);

loop(FarmNumber,

         FarmGatePriceProfile(HarvestingHorizonAggregation) = Par_FarmSpecificPriceProfile(HarvestingHorizonAggregation,CountySelected,FarmNumber);
         FarmGatePriceProfile(NonHarvestingHorizonAggregation) = Par_FarmSpecificPriceProfile(NonHarvestingHorizonAggregation,CountySelected,FarmNumber);

         FarmBiomassPickup(HarvestingHorizonAggregation) = Par_FarmGateBiomassPickup(HarvestingHorizonAggregation,CountySelected,FarmNumber);
         FarmBiomassPickup(NonHarvestingHorizonAggregation) = Par_FarmGateBiomassPickup(NonHarvestingHorizonAggregation,CountySelected,FarmNumber);

*        Store the farm relevant data for the current farm (in the current loop i.e. ord(TotalFarmNumber))
*        in some common parameters that are then used by the optimization model. This way, the
*        equations for the individual farms (constraints) will be free of the farm set dimension.

         FarmSizeCurrent = FarmData(CountySelected,FarmNumber,'FarmSize');

* Calculating the average roadsiding distance by assuming that the total farm area is in a circular shape and then assuming that the
* average roadsiding distance is equal to the diameter of the circular farm.
         AverageRoadsidingDistance = (FarmSizeCurrent/3.14)**0.5*2;

         HarvesterMachinePredefined = HarvesterSelectionDecision(FarmNumber);
         RakingMachinePredefined = RakeSelectionDecision(FarmNumber);
         BalingMachinePredefined = BalerSelectionDecision(FarmNumber);
         ChoppingMachinePredefined = ChopperSelectionDecision(FarmNumber);
         GrindingMachinePredefined = GrinderSelectionDecision(FarmNumber);
         PelletizingMachinePredefined = PelletizerSelectionDecision(FarmNumber);
         LoaderMachinePredefined = LoaderSelectionDecision(FarmNumber);
         InFieldTransportPredefined = InfieldTransportationSelectionDecision(FarmNumber);

         FarmOpenStorageSizeSelection = FarmOpenStorageDecision(FarmNumber);
         FarmCoveredStorageSizeSelection = FarmCoveredStorageDecision(FarmNumber);

         HarvesterTypePredefinedCurrent(HarvesterTypes) = HarvesterTypePredefined(CountySelected,FarmNumber,HarvesterTypes)$(HarvesterMachineTypePredefined);
         NumberOfHarvestersPredefinedCurrent(HarvesterTypes) = NumberOfHarvestersPredefined(CountySelected,FarmNumber,HarvesterTypes)$(HarvesterMachinePredefined);

         RakeTypePredefinedCurrent(RakeTypes) = RakeTypePredefined(CountySelected,FarmNumber,RakeTypes)$(RakingMachineTypePredefined);
         NumberOfRakesPredefinedCurrent(RakeTypes) = NumberOfRakesPredefined(CountySelected,FarmNumber,RakeTypes)$(RakingMachinePredefined);

         BalerTypePredefinedCurrent(BalerTypes)=BalerTypePredefined(CountySelected,FarmNumber,BalerTypes)$(BalingMachineTypePredefined);
         NumberOfBalersPredefinedCurrent(BalerTypes)=NumberOfBalersPredefined(CountySelected,FarmNumber,BalerTypes)$(BalingMachinePredefined);

         ChopperTypePredefinedCurrent(ChopperTypes)=ChopperTypePredefined(CountySelected,FarmNumber,ChopperTypes)$(ChoppingMachineTypePredefined);
         NumberOfChoppersPredefinedCurrent(ChopperTypes)=NumberOfChoppersPredefined(CountySelected,FarmNumber,ChopperTypes)$(ChoppingMachinePredefined);

         PelletizerTypePredefinedCurrent(PelletizerTypes)=PelletizerTypePredefined(CountySelected,FarmNumber,PelletizerTypes)$(PelletizingMachineTypePredefined);
         NumberOfPelletizersPredefinedCurrent(PelletizerTypes)=NumberOfPelletizersPredefined(CountySelected,FarmNumber,PelletizerTypes)$(PelletizingMachinePredefined);

         GrinderTypePredefinedCurrent(GrinderTypes)=GrinderTypePredefined(CountySelected,FarmNumber,GrinderTypes)$(GrindingMachineTypePredefined);
         NumberOfGrindersPredefinedCurrent(GrinderTypes)=NumberOfGrindersPredefined(CountySelected,FarmNumber,GrinderTypes)$(GrindingMachinePredefined);

         LoaderTypeSelectionCurrent(LoaderTypes) = LoaderTypeSelection(CountySelected,FarmNumber,LoaderTypes)$(LoaderMachineTypePredefined);
         LoaderMachineSelectionCurrent(LoaderTypes) = LoaderMachineSelection(CountySelected,FarmNumber,LoaderTypes)$(LoaderMachinePredefined);

         InFieldTransportTypeSelectionCurrent(InfieldTransportationTypes) = InFieldTransportTypeSelection(CountySelected,FarmNumber,InfieldTransportationTypes)$(InFieldTransportTypePredefined);
         InFieldTransportSelectionCurrent(InfieldTransportationTypes) = InFieldTransportSelection(CountySelected,FarmNumber,InfieldTransportationTypes)$(InFieldTransportPredefined);

         FarmOpenStorageSizePredefinedCurrent(StorageTypes) = FarmOpenStorageSizePredefined(CountySelected,FarmNumber,StorageTypes)$(FarmOpenStorageSizeSelection);
         FarmCoveredStorageSizePredefinedCurrent(StorageTypes) = FarmCoveredStorageSizePredefined(CountySelected,FarmNumber,StorageTypes)$(FarmCoveredStorageSizeSelection);

         HarvestRateScheduleCurrent(HarvestingHorizonAggregation,HarvesterTypes)
                                 = HarvestRateSchedule(HarvestingHorizonAggregation,CountySelected,FarmNumber,HarvesterTypes)$(HarvestingScheduleFixed);

*         Solve FarmManagementModel using mip maximizing FarmOptimizationObjective;

*         GridHandler(FarmNumber)=FarmManagementModel.handle

);

);

* uncomment the above loop to connect production and provision, also remove the GridHandler(FarmNumber) line below
GridHandler(FarmNumber)=1;
Repeat
         Loop(FarmNumber$handlecollect(GridHandler(FarmNumber)),

* Storing the results of individual farm optimization problem
$include FarmOptimizationResults.gms

                 Display$handledelete(GridHandler(FarmNumber)) 'Trouble deleting handle';
                 GridHandler(FarmNumber)=0;
         );
         Display$sleep(card(GridHandler)*0.2) 'sleep some time'
Until card(GridHandler)=0 or timeelapsed>10000;

$include FarmProductionOptimizationResults.gms
Display Par_FarmPackingDensity, Par_FarmBiomassForm;
Display Par_HarvestToFarmGate, Par_FarmCoveredStorageToFarmGate, Par_FarmOpenStorageToFarmGate;
$offtext

$include FarmOptimizationResults.gms
$include FarmProductionOptimizationResults.gms



*====================================================================================================================================
* Now solve the provision problem with the constraint that the farm gate available biomass must be immediately picked.
* This is done to estimate the cost of centralized storage which is then used to calculate the farm gate price adjustement in the
* subsequent iterations.
*====================================================================================================================================


Solve BiomassProvisionModelConstrained using mip maximizing BiomassProvisionObjective;

Display TransportationFleetSize.l, BiorefineryCapacity.l, CentralStorageFacilityArea.l, HarvestFarmGateRefineryBiomass.l;

Par_ProvisionCostProgress(IterationSet)$(ord(IterationSet)=IterationCount) =
                           TransportationOperatingCost.l + TransportationFixedCost.l + ProvisionStorageCost.l
                                         + ProvisionBiomassHandlingCost.l;
Par_ProvisionStorageCostProgress(IterationSet)$(ord(IterationSet)=IterationCount) = ProvisionStorageCost.l;
Par_ProvisionHandlingCostProgress(IterationSet)$(ord(IterationSet)=IterationCount) = ProvisionBiomassHandlingCost.l;
Par_ProvisionTransportFixedCostProgress(IterationSet)$(ord(IterationSet)=IterationCount) = TransportationFixedCost.l;
Par_ProvisionCostTransportOperProgress(IterationSet)$(ord(IterationSet)=IterationCount) = TransportationOperatingCost.l;

ModelStatus1=BiomassProvisionModelConstrained.ModelStat;

*=================================================================================================================
* Now these modifications are used to solve the subsequent problem iteratively which begins by first solving the
* provision problem for the first iteration followed by the iterative solution of the farm and provision problem
* stored in a separate file.
*=================================================================================================================

*=================================================================================================================
* Solving the provision problem again after relaxing the constraint that the biomass available at the farm gate must
* be picked up immediately by the transportation task. This relaxation ensures that the transportation task minimizes
* the cost and thus we get the estimate of the lower bound on the transportation cost.
*=================================================================================================================
$ontext
Solve BiomassProvisionModel using mip maximizing BiomassProvisionObjective;


Display TransportationFleetSize.l, BiorefineryCapacity.l, Par_FarmGateBiomassAvailability, Par_FarmGateBiomassPickup, DeliveredCost, BiomassBufferToRefinery.l;

*========================================================================================================================
* Now the result of the two provision problems is used to set the limit on the magnitude of the farm gate price adjustment
* to reflect the actual range in which the central storage and transportation cost varies.
*========================================================================================================================

Par_FarmGatePriceChangeMagnitude =  Par_ProvisionStorageCostRate + ( Par_ProvisionTransportationCostRate
                                         - (TransportationOperatingCost.l + TransportationFixedCost.l)/(BiorefineryCapacity.l*card(SimulationHorizon)));

MeanFarmCost = sum((CountySelected,FarmNumber),Par_FarmGateBiomassCost(CountySelected,FarmNumber))/card(FarmNumber);

FarmGatePriceMinimum(CountySelected,FarmNumber) = FarmGatePriceProfileInitialization;
Par_FarmGateBiomassCost(CountySelected,FarmNumber) =   FarmGatePriceMinimum(CountySelected,FarmNumber);

*FarmGatePriceMinimum(CountySelected,FarmNumber) = Par_FarmGateBiomassCost(CountySelected,FarmNumber);
FarmGatePriceMaximum(CountySelected,FarmNumber) = FarmGatePriceMinimum(CountySelected,FarmNumber)
                                                  +
                                                  Par_FarmGatePriceChangeMagnitude*DDCStepSize1;


Display FarmGatePriceMaximum;
Display Par_ProvisionStorageCostRate, Par_ProvisionTransportationCostRate, Par_FarmGatePriceChangeMagnitude;

$offtext
$ontext
*========================================================================================================================
* Using the calculated magnitude of farm gate price fluctuations to solve the subsequent iterations of the algorithm
* where the biomass production and biomass provision problems are solved iteratively.
* If the problem being solved uses a user-defined farm specific price profile to being the problem solution, then skip this step.
*========================================================================================================================
$if "%FarmSpecificEquipmentSelection%" == "yes" $goto skipFarmGatePriceAdjustment

Display Par_FarmGatePriceChangeMagnitude;
$label skipFarmGatePriceAdjustment

*========================================================================================================================
* The iterative procedure for the solution of the DDC approach is now started. The next file includes the code in a loop that
* must be solved to converge the solution.
*========================================================================================================================


*====================================================================================================================================
* Once the problem has converged or the specified number of iterations are over, the final constrained problem is solved for the
* optimal result stored during the iterations. This problem solution again enforces the constraint that the biomass available at the
* farm gate must be picked up from the farm gate by the transportation task. However, the difference from the previous constrained problem
* is that the farm have changed their decisions based on the farm gate price incentives which are modeled during the iterations and therefore
* more biomass is stored on the farm and made available at a later date which reduces the burden on the transportation and centralized
* storage.
*====================================================================================================================================
*
* If the user has selected to run the scenario without any centralized storage, then making the following change.
*
If (CentralizedStorageSelection=0,
         CentralStorageAreaLimit = 0;
);



tcomp = TimeComp;
texec = TimeExec;
telapsed = TimeElapsed;
Display tcomp, texec, telapsed;
$offtext
Display CentralStorageDryMatterLossRate;

