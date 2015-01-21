$title Declaration of all the parameters related to farm production problem. This includes the parameters for solving the model and post-solution parameters.

*
* Parameters related to farm problem solution
*
Parameters
         FarmSizeCurrent The size of the farm that is currently being solved
         HarvesterTypePredefinedCurrent The harvester machine type decision made by the user for the current farm
         NumberOfHarvestersPredefinedCurrent The harvester machine number decision made by the user for the current farm
         RakeTypePredefinedCurrent
         NumberOfRakesPredefinedCurrent
         BalerTypePredefinedCurrent
         NumberOfBalersPredefinedCurrent
         ChopperTypePredefinedCurrent
         NumberOfChoppersPredefinedCurrent
         PelletizerTypePredefinedCurrent
         NumberOfPelletizersPredefinedCurrent
         GrinderTypePredefinedCurrent
         NumberOfGrindersPredefinedCurrent
         LoaderTypeSelectionCurrent
         LoaderMachineSelectionCurrent
         InFieldTransportTypeSelectionCurrent
         InFieldTransportSelectionCurrent
         FarmOpenStorageSizePredefinedCurrent
         FarmCoveredStorageSizePredefinedCurrent
         HarvestRateScheduleCurrent
         AverageRoadsidingDistance The average distance to be travelled per trip for biomass roadsiding
         CentralStorageLocationCorrelation(CentralizedStorageLocationSet) The correlator based on the current county under analysis
         BiomassPickupCurrent;


*#############################################################################################################################
* Intermediate parameters that connect the farm problem with the provision problem
*#############################################################################################################################

Parameters
                 Par_FarmBiomassDistribution(CountyDataSet,TotalFarmNumber,BiomassDistributionSet) Post harvest distribution of biomass on a farm

                 Par_HarvestToFarmGate(HarvestingHorizon,CountyDataSet,TotalFarmNumber) The harvested biomass that is made available to the farm gate directly after harvesting
                 Par_HarvestToFarmCoveredStorage(HarvestingHorizon,CountyDataSet,TotalFarmNumber) The harvested biomass that is sent to farm covered storage after harvesting
                 Par_HarvestToFarmOpenStorage(HarvestingHorizon,CountyDataSet,TotalFarmNumber) The harvested biomass that is sent to farm open storage after harvesting
                 Par_HarvestToEnsiling(HarvestingHorizon,CountyDataSet,TotalFarmNumber) The harvested biomass that is sent to on-farm silage pit after harvesting

                 Par_FarmCoveredStorageToFarmGate(SimulationHorizon,CountyDataSet,TotalFarmNumber) The biomass made available to the farm gate from covered storage unit
                 Par_FarmOpenStorageToFarmGate(SimulationHorizon,CountyDataSet,TotalFarmNumber) The biomass made available to the farm gate from open storage unit
                 Par_EnsilingToFarmGate(SimulationHorizon,CountyDataSet,TotalFarmNumber) The biomass made available to the farm gate from the silage pits

                 Par_HarvestToFarmGateVolume The total volume of biomass at the farm gate directy from harvesting operation
                 Par_FarmCoveredStorageToFarmGateBiomass The total volume of biomass at the farm gate from farm covered storage
                 Par_FarmOpenStorageToFarmGateVolume The total volume of biomass at the farm gate from farm open storage

                 Par_FarmStorageConfiguration(CountyDataSet,TotalFarmNumber,FarmStorageSet) The summary of storage options used by various farms

                 Par_FarmCost(CountyDataSet,TotalFarmNumber) The final cost values for each farm
                 Par_HarvestingCost(CountyDataSet,TotalFarmNumber) The harvesting cost for each farm
                 Par_HarvestingOperatingCost(CountyDataSet,TotalFarmNumber) The harvesting operating cost for each farm
                 Par_HarvestingFixedCost(CountyDataSet,TotalFarmNumber) The harvesting capital cost for each farm
                 Par_FieldLoadingCost(CountyDataSet,TotalFarmNumber) The cost of field loading in case of energy cane per farm
                 Par_FieldLoadingOperatingCost(CountyDataSet,TotalFarmNumber) The Field Loading operating cost for each farm for energy cane
                 Par_FieldLoadingFixedCost(CountyDataSet,TotalFarmNumber) The Field Loading capital cost for each farm for energy cane
                 Par_RakingCost(CountyDataSet,TotalFarmNumber) The raking cost for each farm
                 Par_RakingOperatingCost(CountyDataSet,TotalFarmNumber) The raking operating cost for each farm
                 Par_RakingFixedCost(CountyDataSet,TotalFarmNumber) The raking capital cost for each farm
                 Par_PackingCost(CountyDataSet,TotalFarmNumber) The packing cost for each farm
                 Par_PackingOperatingCost(CountyDataSet,TotalFarmNumber) The packing operating cost for each farm
                 Par_PackingFixedCost(CountyDataSet,TotalFarmNumber) The packing fixed cost for each farm
                 Par_FarmStorageCost(CountyDataSet,TotalFarmNumber) The storage cost for each farm
                 Par_InFieldTransportationCost(CountyDataSet,TotalFarmNumber) The infield transportation cost for each farm
                 Par_InFieldTransportationFixedCost(CountyDataSet,TotalFarmNumber) The infield transportation fixed cost for each farm
                 Par_InFieldTransportationOperatingCost(CountyDataSet,TotalFarmNumber) The infield transportation operating cost for each farm
                 Par_FarmBiomassHandlingCost(CountyDataSet,TotalFarmNumber) The on farm biomass handling cost for each farm
                 Par_FarmBiomassHandlingFixedCost(CountyDataSet,TotalFarmNumber) The on farm biomass handling fixed cost for each farm
                 Par_FarmBiomassHandlingOperatingCost(CountyDataSet,TotalFarmNumber) The on farm biomass handling operating cost for each farm

                 Par_EnergyConsumptionHarvesting
                 Par_EnergyConsumptionFieldLoading
                 Par_EnergyConsumptionRaking
                 Par_EnergyConsumptionPacking
                 Par_EnergyConsumptionInfieldTransportation
                 Par_EnergyConsumptionFarmBiomassHandling


                 Par_GHGEmissionHarvesting
                 Par_GHGEmissionFieldLoading
                 Par_GHGEmissionRaking
                 Par_GHGEmissionPacking
                 Par_GHGEmissionInfieldTransportation
                 Par_GHGEmissionFarmBiomassHandling

                 Par_AverageFarmGateCost The average cost of biomass at the farm gate

                 Par_FarmProfit(CountyDataSet,TotalFarmNumber) The total proft for each farm

                 MeanFarmCost The average (mean) cost of biomass production for farms which is used to calculate the farm gate price change mangitude

                 Par_FarmHarvestSchedule(CountyDataSet,TotalFarmNumber,HarvestingHorizon) The harvesting schedule decided by individual farms after the first stage of operations
                 Par_FarmGateBiomassAvailability(SimulationHorizon,CountyDataSet,TotalFarmNumber) The profile of biomass availability at each farm gate
                 Par_CumulativeFarmGateBiomassAvailability(SimulationHorizon) The profile of biomass availability for all farms taken together

                 Par_FarmHarvesterSelection(CountyDataSet,TotalFarmNumber,HarvesterTypes) The harvesting machine selection made by the farms in the individual optimization problem
                 Par_FarmFieldLoaderSelection(CountyDataSet,TotalFarmNumber,FieldLoaderTypes) The field loader selection made by the farms in the individual optimization problem
                 Par_FarmRakerSelection(CountyDataSet,TotalFarmNumber,RakeTypes) The raking machine selection made by the farms in the individual optimization problem
                 Par_FarmBalerSelection(CountyDataSet,TotalFarmNumber,BalerTypes) The packing machine selection made by the farms in the individual optimization problem
                 Par_FarmChopperSelection(CountyDataSet,TotalFarmNumber,ChopperTypes) The packing machine selection made by the farms in the individual optimization problem
                 Par_FarmPelletizerSelection(CountyDataSet,TotalFarmNumber,PelletizerTypes)
                 Par_FarmGrinderSelection(CountyDataSet,TotalFarmNumber,GrinderTypes)

                 Par_NumberOfLoaders(CountyDataSet,TotalFarmNumber,LoaderTypes) The number of loaders of a particular type used on a given farm
                 Par_LoadingRepetitions(SimulationHorizon,CountyDataSet,TotalFarmNumber,LoaderTypes)

                 Par_InFieldTransportationSelection(CountyDataSet,TotalFarmNumber,InFieldTransportationTypes) The selection of equipment for infield transportation
                 Par_InFieldTrips

                 Par_FarmBiomassBaledUnits(CountyDataSet,TotalFarmNumber,BalerTypes) The total number of units packed by a particular packing machine on a given farm

                 Par_FarmPackingDensity(CountyDataSet,TotalFarmNumber) The final packing density of the biomass delivered by a particular farm

                 Par_FarmBiomassForm(CountyDataSet,TotalFarmNumber) The form of the biomass being provided by a particular farm

                 Par_FarmStorageConfiguration(CountyDataSet,TotalFarmNumber,FarmStorageSet) The summary of storage options used by various farms

                 Par_FarmGateTotalBiomass(CountyDataSet,TotalFarmNumber) The total biomass made avaialable by a farm at the farm gate over the complete simulation horizon in Mg
                 Par_FarmGateBiomassCost(CountyDataSet,TotalFarmNumber) The farm gate cost of biomass for each farm calculated individually in $ per Mg

                 Par_FarmTruckCorrelation(CountyDataSet,TotalFarmNumber,TransportationTypes) The correlation parameter that indicates which type of trucks can be used for transportation based on what is the output biomass form from a given farm

                 Par_ExpectedRefineryCapacity The expected refinery capacity based on the total biomass being available at the farm gate after the farm production problem solution;




Parameter
                 Par_HarvestToFarmGateTotal(HarvestingHorizon,CountyDataSet,TotalFarmNumber) The harvested biomass that is made available to the farm gate directly after harvesting
                 Par_FarmCoveredStorageToFarmGateTotal(SimulationHorizon,CountyDataSet,TotalFarmNumber) The biomass made available to the farm gate from covered storage unit
                 Par_FarmOpenStorageToFarmGateTotal(SimulationHorizon,CountyDataSet,TotalFarmNumber) The biomass made available to the farm gate from open storage unit
                 Par_EnsilingToFarmGateTotal(SimulationHorizon,CountyDataSet,TotalFarmNumber) The biomass made available to the farm gate from the silage pits
                 Par_TotalBiomassHarvested(CountyDataSet,TotalFarmNumber)
                 Par_CumulativeBiomassHarvested
                 ;
