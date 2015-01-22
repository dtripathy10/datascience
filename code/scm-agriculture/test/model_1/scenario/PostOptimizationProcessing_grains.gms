
*##############################################################################################################
* Declaring parameters to store and report results of the optimization problem
*##############################################################################################################
Parameter FarmHarvest Optimized total harvest for each farm per season (Mg)
          OverallHarvestSchedule Optimized overall harvest schedule for all the farms (Mg per day)
          BiomassDistribution(SimulationHorizon,BiomassDistributionSet) Optimized distribution of biomass for all farms combined (Mg per day)
          FarmBiomassDistribution(CountyDataSet,TotalFarmNumber,BiomassDistributionSet) Optimized distribution of biomass for individual farms into different possibilities (Mg per day)
          EthanolProductionCapacity The optimized ethanol production capacity of the biorefinery (Gallons per year)
          TransportFleetSizeSchedule The number of transportation vehicles required during the horizon  (Number of vehicles per day)
          TotalOnFarmStorageArea The total on farm storage area requiremenet for all farms taken together
          FarmCoveredStorageVolume Optimized distribution of storage volume at various farms (Cubic meters)
          TotalSilagePitArea The total area devoted to silage pit for all farms taken together
          FarmHarvestingStartDate Start date of harvesting for each farm (Day in the simulation horizon)
          BiomassDelivered The total biomass delivered to the biorefinery (calculated to cross check the solution) (Mg per day)

          TotalProfit The final total profit for the complete system after the rounding-off and other calculations
          DeliveredCost Calculating the final delivered cost ($ per Mg)
          R_TotalTransportationCost Final cumulative transportation cost
          R_TransportationFixedCost Final cumulative transportation fixed cost
          R_TransportationOperatingCost Final cumulative transportation operating cost
          UnusedBiomass Biomass that is unused and remaining in the storage at the end of the simulation horizon
          PerUnitHarvestingCost  Per dry Mg cost of harvesting in $
          PerUnitRakingCost Per dry Mg cost of raking in $
          PerUnitPackingFixedCost  Per dry Mg fixed cost of packing in $
          PerUnitPackingOperatingCost  Per dry Mg operating cost of packing in $
          PerUnitPackingCost  Per dry Mg total (operating + fixed) cost of packing in $
          PerUnitTransportationFixedCost Per dry Mg fixed cost of transportation in $
          PerUnitTransportationOperatingCost Per dry Mg operating cost of transportation in $
          PerUnitTransportationCost Per dry Mg cost of transportation in $
          PerUnitStorageCost Per dry Mg cost of storage in $
          PerUnitTractorCost Per dry Mg cost of operating tractors in $
          PerUnitInfieldTransportationCost Per dry Mg cost for infield transportation
          PerUnitBiomassHandlingCost Per dry Mg cost of biomass handling (related to long range transportation)
          FarmAreaUtilization The fractional utilization of each farm in terms of number of hectares (ratio of hectares harvested to hectares available)
          AverageTransportationFleetNumberUtilization Average value of TransportationFleetUtilization over the complete horizon in terms of the number of vehicles

          EnergyConsumptionHarvesting(CountyDataSet,TotalFarmNumber) Total energy consumption for harvesting operation for a particular farm
          EnergyConsumptionRaking(CountyDataSet,TotalFarmNumber) Total energy consumption for raking operation for a particular farm
          EnergyConsumptionPacking(CountyDataSet,TotalFarmNumber) Total energy consumption for packing operation for a particular farm
          EnergyConsumptionTractors(CountyDataSet,TotalFarmNumber) Total energy consumption of tractor operationg for a particular farm
          EnergyConsumptionHarvestingTransportation Total energy consumption during the transportation of biomass in the harvesting horizon in MJ
          EnergyConsumptionNonHarvestingTransportation Total energy consumption during the transportation of biomass in the non-harvesting horizon in MJ

          PerUnitHarvestingEnergyConsumption Average energy consumption per unit dry Mg for harvesting operation
          PerUnitRakingEnergyConsumption Average energy consumption per unit dry Mg for raking operation
          PerUnitPackingEnergyConsumption Average energy consumption per unit dry Mg for packing (all inclusive) operation
          PerUnitTractorsEnergyConsumption Average energy consumption rate per unit dry Mg for tractor related operations
          PerUnitTransportationEnergyConsumption Average energy consumption per unit dry Mg for transportation operation

          GHGEmissionHarvesting(CountyDataSet,TotalFarmNumber) Total GHG emission for harvesting operation for a particular farm based on the fuel consumed
          GHGEmissionRaking(CountyDataSet,TotalFarmNumber) Total GHG emission for raking operation for a particular farm based on the fuel consumed
          GHGEmissionPacking(CountyDataSet,TotalFarmNumber) Total GHG emission for packing operation for a particular farm based on the fuel consumed
          GHGEmissionTractors(CountyDataSet,TotalFarmNumber) Total GHG emission of tractor operationg for a particular farm based on the fuel consumed
          GHGEmissionHarvestingTransportation Total GHG emission during the transportation of biomass in the harvesting horizon based on the fuel consumed
          GHGEmissionNonHarvestingTransportation Total GHG emission during the transportation of biomass in the non-harvesting horizon based on the fuel consumed

          PerUnitHarvestingGHGEmission Average GHG emission per unit dry Mg for harvesting operation
          PerUnitRakingGHGEmission Average GHG emission per unit dry Mg for raking operation
          PerUnitPackingGHGEmission Average GHG emission per unit dry Mg for packing (all inclusive) operation
          PerUnitTractorsGHGEmission Average GHG emission rate per unit dry Mg for tractor related operations
          PerUnitTransportationGHGEmission Average GHG emission per unit dry Mg for transportation operation

          HarvestersSelection(CountyDataSet,TotalFarmNumber,HarvesterTypes) Number of harvesters per farm to be used to achieve the target (rounded off value)
          RakersSelection(CountyDataSet,TotalFarmNumber,RakeTypes) Number of raking machines to be used (rounded off value)
          HarvestersSelectionFarmClass(CountyDataSet,FarmClass,HarvesterTypes) Number of harvesters per farm to be used to achieve the target (rounded off value)
          RakersSelectionFarmClass(CountyDataSet,FarmClass,RakeTypes) Number of raking machines to be used (rounded off value)
          PackersSelection(CountyDataSet,TotalFarmNumber,PackingTypes) Number of packing machines to be used (rounded off value)
          PackersSelectionFarmClass(CountyDataSet,FarmClass,PackingTypes) Number of packing machines to be used (rounded off value)
          TractorsSelection(CountyDataSet,TotalFarmNumber,TractorTypes) Number of tractors to be used (rounded off value)

          FarmRefineryTruckTripRequirementFinal The rounded off values of the farm to refinery truck trip requirement
          FarmCentralStorageTruckTripRequirementFinal The rounded off values of the farm to central storage truck trip requirement
          CentralStorageRefineryTruckTripRequirementFinal The rounded off values of the central storage to refinery truck trip requirement
          FarmRefineryTruckRequirementFinal The rounded off values of the farm to refinery truck requirement
          FarmCentralStorageTruckRequirementFinal The rounded off values of the farm to central storage truck requirement
          CentralStorageRefineryTruckRequirementFinal The rounded off values of the central storage to refinery truck requirement
          TransportationFleetSizeFinal The rounded off value of the transportation fleet size of each type

          HarvestingCost Total harvesting cost after rounding off the number of harvesters to integer values
          RakingCost Total raking cost after rounding off the number of rakers to integer values
          PackingCostFixed Total packing fixed cost after rounding off the number of packers to integer values
          PackingCostOperating Total packing operating cost after rounding off the number of packers to integer values
          PackingCostTotal Total packing cost after rounding off the number of packers to integer values
          TractorCost Total tractor related cost after rounding off the number of tractors to integer values

          FarmCoveredStorageArea The area of the farm that is used for covered storage on a particular farm in square meters
          TransportationFleetRequirement The maximum number of vehicles needed to satisfy the yearround fleet size requirement (Number of vehicles)

          ResultHarvestRate Final harvest rate
          ResultHarvestToRefinery Biomass flow from harvest to refinery for each farm on each day of the harvesting horizon
          ResultHarvestToFarmCoveredStorage Biomass flow from harvest to farm covered for each farm on each day of the harvesting horizon
          ResultHarvestToFarmOpenStorage Biomass flow from harvest to farm open storage for each farm on each day of the harvesting horizon
          ResultHarvestToCentralStorage Biomass flow from harvest to central storage for each farm on each day of the harvesting horizon
          ResultHarvestToEnsiling Biomass flow from harvest to silo for each farm on each day of the harvesting horizon
          ResultFarmCoveredStorageToRefinery Biomass flow from farm closed storage to refinery for each farm on each day of the simulation horizon
          ResultFarmOpenStorageToRefinery Biomass flow from farm open storage to refinery for each farm on each day of the simulation horizon
          ResultCentralStorageToRefinery Biomass flow from central storage to refinery for each farm on each day of the simulation horizon
          ResultEnsilingToRefinery Biomass flow from the silo to refinery for each farm on each day of the simulation horizon
          ResultFarmCoveredStoredBiomass Biomass stored in covered storage facilities for each farm
          ResultFarmOpenStoredBiomass Biomass stored in open storage facilities for each farm
          ResultCentrallyStoredBiomass Biomass stored in covered storage facilities for each farm
          ResultDailyFarmCoveredStorageBalance The balanace of biomass for each day which is equal to the difference between the total biomass stored on a particular day and the total biomass moved from the storage which was tagged to heva been delivered on that day
          ResultDailyFarmOpenStorageBalance The balanace of biomass for each day which is equal to the difference between the total biomass stored on a particular day and the total biomass moved from the storage which was tagged to heva been delivered on that day
          ResultDailyCentralStorageBalance The balanace of biomass for each day which is equal to the difference between the total biomass stored on a particular day and the total biomass moved from the storage which was tagged to heva been delivered on that day
          ResultFarmCoveredStoredBiomassVolume The volume of biomass stored at each farm for each time step in the simulation horizon
          ResultFarmRefineryTruckSchedule Truck schedule for biomass transportation from farm to the refinery
          ResultFarmCentralStorageTruckSchedule Truck schedule for biomass transportation from farm to the central storage
          ResultCentralStorageRefineryTruckSchedule Truck schedule for biomass transportation from central storage to refinery
          ResultCentralStorageToRefineryDistribution The distribution of the biomass based on the day it was tagged

          HarvestDifference Different between pre-defined harvest and actual harvest schedule;




*-----------------------------------------------------------------------------------------------
* Rounding off the machine selection values to integers if a relaxed problem is solved or if the
* variables are declared as continuous to aid computation
* This is done at the end of the problem solution so that the rounded off values are used for
* further calculations related to cost and energy consumption.
*-----------------------------------------------------------------------------------------------
FarmRefineryTruckTripRequirementFinal(HarvestingHorizonAggregation,FarmNumber,TransportationTypes)=
                 ceil(FarmRefineryTruckTripRequirement.l(HarvestingHorizonAggregation,FarmNumber,TransportationTypes));
FarmRefineryTruckTripRequirementFinal(NonHarvestingHorizonAggregation,FarmNumber,TransportationTypes)=
                 ceil(FarmRefineryTruckTripRequirement.l(NonHarvestingHorizonAggregation,FarmNumber,TransportationTypes));

FarmRegionalTruckTripRequirementFinal(HarvestingHorizonAggregation,FarmNumber,TransportationTypes)=
                 ceil(FarmRegionalTruckTripRequirement.l(HarvestingHorizonAggregation,FarmNumber,TransportationTypes));
FarmRegionalTruckTripRequirementFinal(NonHarvestingHorizonAggregation,FarmNumber,TransportationTypes)=
                 ceil(FarmRegionalTruckTripRequirement.l(NonHarvestingHorizonAggregation,FarmNumber,TransportationTypes));

FarmDirectPurchaseTruckTripRequirementFinal(HarvestingHorizonAggregation,FarmNumber,TransportationTypes)=
                 ceil(FarmDirectPurchaseTruckTripRequirement.l(HarvestingHorizonAggregation,FarmNumber,TransportationTypes));

FarmCentralStorageTruckTripRequirementFinal(HarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocationSet,TransportationTypes)=
                 ceil(FarmCentralStorageTruckTripRequirement.l(HarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocationSet,TransportationTypes));
FarmCentralStorageTruckTripRequirementFinal(NonHarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocationSet,TransportationTypes)=
                 ceil(FarmCentralStorageTruckTripRequirement.l(NonHarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocationSet,TransportationTypes));

FarmCentralStorageSmallScaleTruckTripRequirementFinal(HarvestingHorizonAggregation,FarmNumber,CentralizedStorageSmallScaleLocationSet,TransportationTypes)=
                 ceil(FarmCentralStorageSmallScaleTruckTripRequirement.l(HarvestingHorizonAggregation,FarmNumber,CentralizedStorageSmallScaleLocationSet,TransportationTypes));
FarmCentralStorageSmallScaleTruckTripRequirementFinal(NonHarvestingHorizonAggregation,FarmNumber,CentralizedStorageSmallScaleLocationSet,TransportationTypes)=
                 ceil(FarmCentralStorageSmallScaleTruckTripRequirement.l(NonHarvestingHorizonAggregation,FarmNumber,CentralizedStorageSmallScaleLocationSet,TransportationTypes));

CentralStorageRefineryTruckTripRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageLocationSet,TransportationTypes)=
                 ceil(CentralStorageRefineryTruckTripRequirement.l(HarvestingHorizonAggregation,CentralizedStorageLocationSet,TransportationTypes));
CentralStorageRefineryTruckTripRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageLocationSet,TransportationTypes)=
                 ceil(CentralStorageRefineryTruckTripRequirement.l(NonHarvestingHorizonAggregation,CentralizedStorageLocationSet,TransportationTypes));

CentralStorageRegionalTruckTripRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageLocationSet,TransportationTypes)=
                 ceil(CentralStorageRegionalTruckTripRequirement.l(HarvestingHorizonAggregation,CentralizedStorageLocationSet,TransportationTypes));
CentralStorageRegionalTruckTripRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageLocationSet,TransportationTypes)=
                 ceil(CentralStorageRegionalTruckTripRequirement.l(NonHarvestingHorizonAggregation,CentralizedStorageLocationSet,TransportationTypes));

CentralStorageSmallScaleRefineryTruckTripRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocationSet,TransportationTypes)=
                 ceil(CentralStorageSmallScaleRefineryTruckTripRequirement.l(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocationSet,TransportationTypes));
CentralStorageSmallScaleRefineryTruckTripRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocationSet,TransportationTypes)=
                 ceil(CentralStorageSmallScaleRefineryTruckTripRequirement.l(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocationSet,TransportationTypes));

CentralStorageSmallScaleRegionalTruckTripRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocationSet,TransportationTypes)=
                 ceil(CentralStorageSmallScaleRegionalTruckTripRequirement.l(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocationSet,TransportationTypes));
CentralStorageSmallScaleRegionalTruckTripRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocationSet,TransportationTypes)=
                 ceil(CentralStorageSmallScaleRegionalTruckTripRequirement.l(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocationSet,TransportationTypes));


FarmRefineryTruckRequirementFinal(HarvestingHorizonAggregation,FarmNumber,TransportationTypes)=
                 ceil(FarmRefineryTruckRequirement.l(HarvestingHorizonAggregation,FarmNumber,TransportationTypes));
FarmRefineryTruckRequirementFinal(NonHarvestingHorizonAggregation,FarmNumber,TransportationTypes)=
                 ceil(FarmRefineryTruckRequirement.l(NonHarvestingHorizonAggregation,FarmNumber,TransportationTypes));

FarmRegionalTruckRequirementFinal(HarvestingHorizonAggregation,FarmNumber,TransportationTypes)=
                 ceil(FarmRegionalTruckRequirement.l(HarvestingHorizonAggregation,FarmNumber,TransportationTypes));
FarmRegionalTruckRequirementFinal(NonHarvestingHorizonAggregation,FarmNumber,TransportationTypes)=
                 ceil(FarmRegionalTruckRequirement.l(NonHarvestingHorizonAggregation,FarmNumber,TransportationTypes));

FarmDirectPurchaseTruckRequirementFinal(HarvestingHorizonAggregation,FarmNumber,TransportationTypes)=
                 ceil(FarmDirectPurchaseTruckRequirement.l(HarvestingHorizonAggregation,FarmNumber,TransportationTypes));

FarmCentralStorageTruckRequirementFinal(HarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocationSet,TransportationTypes)=
                 ceil(FarmCentralStorageTruckRequirement.l(HarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocationSet,TransportationTypes));
FarmCentralStorageTruckRequirementFinal(NonHarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocationSet,TransportationTypes)=
                 ceil(FarmCentralStorageTruckRequirement.l(NonHarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocationSet,TransportationTypes));

FarmCentralStorageSmallScaleTruckRequirementFinal(HarvestingHorizonAggregation,FarmNumber,CentralizedStorageSmallScaleLocationSet,TransportationTypes)=
                 ceil(FarmCentralStorageSmallScaleTruckRequirement.l(HarvestingHorizonAggregation,FarmNumber,CentralizedStorageSmallScaleLocationSet,TransportationTypes));
FarmCentralStorageSmallScaleTruckRequirementFinal(NonHarvestingHorizonAggregation,FarmNumber,CentralizedStorageSmallScaleLocationSet,TransportationTypes)=
                 ceil(FarmCentralStorageSmallScaleTruckRequirement.l(NonHarvestingHorizonAggregation,FarmNumber,CentralizedStorageSmallScaleLocationSet,TransportationTypes));

CentralStorageRefineryTruckRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageLocationSet,TransportationTypes)=
                 ceil(CentralStorageRefineryTruckRequirement.l(HarvestingHorizonAggregation,CentralizedStorageLocationSet,TransportationTypes));
CentralStorageRefineryTruckRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageLocationSet,TransportationTypes)=
                 ceil(CentralStorageRefineryTruckRequirement.l(NonHarvestingHorizonAggregation,CentralizedStorageLocationSet,TransportationTypes));

CentralStorageRegionalTruckRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageLocationSet,TransportationTypes)=
                 ceil(CentralStorageRegionalTruckRequirement.l(HarvestingHorizonAggregation,CentralizedStorageLocationSet,TransportationTypes));
CentralStorageRegionalTruckRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageLocationSet,TransportationTypes)=
                 ceil(CentralStorageRegionalTruckRequirement.l(NonHarvestingHorizonAggregation,CentralizedStorageLocationSet,TransportationTypes));

CentralStorageSmallScaleRefineryTruckRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocationSet,TransportationTypes)=
                 ceil(CentralStorageSmallScaleRefineryTruckRequirement.l(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocationSet,TransportationTypes));
CentralStorageSmallScaleRefineryTruckRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocationSet,TransportationTypes)=
                 ceil(CentralStorageSmallScaleRefineryTruckRequirement.l(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocationSet,TransportationTypes));

CentralStorageSmallScaleRegionalTruckRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocationSet,TransportationTypes)=
                 ceil(CentralStorageSmallScaleRegionalTruckRequirement.l(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocationSet,TransportationTypes));
CentralStorageSmallScaleRegionalTruckRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocationSet,TransportationTypes)=
                 ceil(CentralStorageSmallScaleRegionalTruckRequirement.l(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocationSet,TransportationTypes));

$ontext
*##############################################################################################################
* Energy consumption calculations
*##############################################################################################################
*
* The energy consumption is calculated by first computing the number of hours
* each equipment is operated. Then the rated power and the Nebrasta Tractor Test data is used to calculate the average fuel
* consumption for the equipment in gallons per hour. The multiplication of the two gives the total gallons used by that maching which
* is then converted into MJ (energy units) using the calorific value of diesel fuel.
*
EnergyConsumptionHarvesting(FarmNumber) =
                 sum((HarvestingHorizonAggregation,HarvesterTypes),
                         BiomassHarvest.l(HarvestingHorizonAggregation,FarmNumber,HarvesterTypes)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (HarvesterData('Throughput',HarvesterTypes)*HarvesterData('Efficiency',HarvesterTypes))
                         * (HarvesterData('FuelConsumption',HarvesterTypes)+HarvesterData('TractorFuelConsumption',HarvesterTypes))
                         * 0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                         * HarvesterSelector.l(FarmNumber,HarvesterTypes)
                 );


EnergyConsumptionHarvesting(FarmNumber)$(FarmClassificationIndicator) =
                 sum((HarvestingHorizonAggregation,HarvesterTypes,FarmClass),
                         BiomassHarvest.l(HarvestingHorizonAggregation,FarmNumber,HarvesterTypes)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (HarvesterData('Throughput',HarvesterTypes)*HarvesterData('Efficiency',HarvesterTypes))
                         * (HarvesterData('FuelConsumption',HarvesterTypes)+HarvesterData('TractorFuelConsumption',HarvesterTypes))
                         * 0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                         * HarvesterSelectorFarmClass.l(FarmClass,HarvesterTypes)
                         * FarmClassification(FarmNumber,FarmClass)
                 );


EnergyConsumptionRaking(FarmNumber)$(not(FarmClassificationIndicator)) =
                 sum((HarvestingHorizonAggregation,RakerTypes),
                         BiomassHarvestToRaking.l(HarvestingHorizonAggregation,FarmNumber)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (RakerData('Throughput',RakerTypes)*RakerData('Efficiency',RakerTypes))
                         * RakerData('TractorFuelConsumption',RakerTypes)
                         * 0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                         * RakerSelector.l(FarmNumber,RakerTypes)
                 );


EnergyConsumptionRaking(FarmNumber)$(FarmClassificationIndicator) =
                 sum((HarvestingHorizonAggregation,FarmClass,RakerTypes),
                         BiomassHarvestToRaking.l(HarvestingHorizonAggregation,FarmNumber)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         ( RakerData('Throughput',RakerTypes)*RakerData('Efficiency',RakerTypes))
                         * RakerData('TractorFuelConsumption',RakerTypes)
                         * 0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                         * RakerSelectorFarmClass.l(FarmClass,RakerTypes)
                         * FarmClassification(FarmNumber,FarmClass)
                 );


EnergyConsumptionPacking(FarmNumber)$(not(FarmClassificationIndicator)) =
                 sum((HarvestingHorizonAggregation,PackingTypes),
                         BiomassToPackingDivision.l(HarvestingHorizonAggregation,FarmNumber,PackingTypes)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (PackingData('Throughput',PackingTypes)*PackingData('Efficiency',PackingTypes))
                         *(PackingData('FuelConsumption',PackingTypes) + PackingData('TractorFuelConsumption',PackingTypes))
                         * 0.00378 * DieselSpecificGravity * 1000 * DieselCalorificValue
                 );


EnergyConsumptionPacking(FarmNumber)$(FarmClassificationIndicator) =
                 sum((HarvestingHorizonAggregation,FarmClass,PackingTypes),
                         BiomassToPackingDivision.l(HarvestingHorizonAggregation,FarmNumber,PackingTypes)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         ( PackingData('Throughput',PackingTypes)*PackingData('Efficiency',PackingTypes))
                         *(PackingData('FuelConsumption',PackingTypes) + PackingData('TractorFuelConsumption',PackingTypes))
                         * 0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                         * FarmClassification(FarmNumber,FarmClass)
                 );


EnergyConsumptionHarvestingTransportation =
                                 sum((HarvestingHorizonAggregation,FarmNumber,TransportationTypes),
                                         FarmRefineryTruckTripRequirementFinal(HarvestingHorizonAggregation,FarmNumber,TransportationTypes)
                                         *
                                         (FarmData(FarmNumber,'RefineryDistance')/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         *0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                                 )*card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((HarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,TransportationTypes),
                                         FarmCentralStorageTruckTripRequirementFinal(HarvestingHorizonAggregation,FarmNumber,
                                                                                         CentralizedStorageLocations,TransportationTypes)
                                         *
                                         (FarmDistanceData(FarmNumber,CentralizedStorageLocations)/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         *0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                                 )*card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((HarvestingHorizonAggregation,CentralizedStorageLocations,TransportationTypes),
                                         CentralStorageRefineryTruckTripRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageLocations,
                                                                                         TransportationTypes)
                                         *
                                         (StorageDistanceData(CentralizedStorageLocations)/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         *0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                                 )*card(HarvestingHorizonAggregationStep);


EnergyConsumptionNonHarvestingTransportation =
                                sum((NonHarvestingHorizonAggregation,FarmNumber,TransportationTypes),
                                         FarmRefineryTruckTripRequirementFinal(NonHarvestingHorizonAggregation,FarmNumber,TransportationTypes)
                                         *
                                         (FarmData(FarmNumber,'RefineryDistance')/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         *0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                                 )*card(NonHarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,CentralizedStorageLocations,TransportationTypes),
                                         CentralStorageRefineryTruckTripRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageLocations,
                                                                                         TransportationTypes)
                                         *
                                         (StorageDistanceData(CentralizedStorageLocations)/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         *0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                                 )*card(NonHarvestingHorizonAggregationStep);


*##############################################################################################################
* Greenhouse gas emission (CO2 emission) calculations
*##############################################################################################################
*
* The GHG emission is calculated by first computing the number of hours
* each equipment is operated. Then the rated power and the Nebrasta Tractor Test data is used to calculate the average fuel
* consumption for the equipment in gallons per hour. The multiplication of the two gives the total gallons used by that maching which
* is then converted into green house gas (CO2) emission by using the average GHG emission factor for diesel fuel.
*

GHGEmissionHarvesting(FarmNumber)$(not(FarmClassificationIndicator)) =
                 sum((HarvestingHorizonAggregation,HarvesterTypes),
                         BiomassHarvest.l(HarvestingHorizonAggregation,FarmNumber,HarvesterTypes)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (HarvesterData('Throughput',HarvesterTypes)*HarvesterData('Efficiency',HarvesterTypes))
                         * (HarvesterData('FuelConsumption',HarvesterTypes)+HarvesterData('TractorFuelConsumption',HarvesterTypes))
                         * DieselGHGEmissionFactor
                         * HarvesterSelector.l(FarmNumber,HarvesterTypes)
                 );

GHGEmissionHarvesting(FarmNumber)$(FarmClassificationIndicator) =
                 sum((HarvestingHorizonAggregation,FarmClass,HarvesterTypes),
                         BiomassHarvest.l(HarvestingHorizonAggregation,FarmNumber,HarvesterTypes)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (HarvesterData('Throughput',HarvesterTypes)*HarvesterData('Efficiency',HarvesterTypes))
                         * (HarvesterData('FuelConsumption',HarvesterTypes)+HarvesterData('TractorFuelConsumption',HarvesterTypes))
                         * DieselGHGEmissionFactor
                         * HarvesterSelectorFarmClass.l(FarmClass,HarvesterTypes)
                         * FarmClassification(FarmNumber,FarmClass)
                 );


GHGEmissionRaking(FarmNumber)$(not(FarmClassificationIndicator)) =
                 sum((HarvestingHorizonAggregation,RakerTypes),
                         BiomassHarvestToRaking.l(HarvestingHorizonAggregation,FarmNumber)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (RakerData('Throughput',RakerTypes)*RakerData('Efficiency',RakerTypes))
                         * RakerData('TractorFuelConsumption',RakerTypes)
                         * DieselGHGEmissionFactor
                         * RakerSelector.l(FarmNumber,RakerTypes)
                 );


GHGEmissionRaking(FarmNumber)$(FarmClassificationIndicator) =
                 sum((HarvestingHorizonAggregation,RakerTypes,FarmClass),
                         BiomassHarvestToRaking.l(HarvestingHorizonAggregation,FarmNumber)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (RakerData('Throughput',RakerTypes)*RakerData('Efficiency',RakerTypes))
                         * RakerData('TractorFuelConsumption',RakerTypes)
                         * DieselGHGEmissionFactor
                         * RakerSelectorFarmClass.l(FarmClass,RakerTypes)
                         * FarmClassification(FarmNumber,FarmClass)
                 );


GHGEmissionPacking(FarmNumber)$(not(FarmClassificationIndicator)) =
                 sum((HarvestingHorizonAggregation,PackingTypes),
                         BiomassToPackingDivision.l(HarvestingHorizonAggregation,FarmNumber,PackingTypes)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         ( PackingData('Throughput',PackingTypes)*PackingData('Efficiency',PackingTypes))
                         * (PackingData('FuelConsumption',PackingTypes) + PackingData('TractorFuelConsumption',PackingTypes))
                         * DieselGHGEmissionFactor
                 );


GHGEmissionPacking(FarmNumber)$(FarmClassificationIndicator) =
                 sum((HarvestingHorizonAggregation,PackingTypes,FarmClass),
                         BiomassToPackingDivision.l(HarvestingHorizonAggregation,FarmNumber,PackingTypes)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         ( PackingData('Throughput',PackingTypes)*PackingData('Efficiency',PackingTypes))
                         * (PackingData('FuelConsumption',PackingTypes) + PackingData('TractorFuelConsumption',PackingTypes))
                         * DieselGHGEmissionFactor
                         * FarmClassification(FarmNumber,FarmClass)
                 );


GHGEmissionHarvestingTransportation =
                                 sum((HarvestingHorizonAggregation,FarmNumber,TransportationTypes),
                                         FarmRefineryTruckTripRequirementFinal(HarvestingHorizonAggregation,FarmNumber,TransportationTypes)
                                         *
                                         (FarmData(FarmNumber,'RefineryDistance')/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         *DieselGHGEmissionFactor
                                 )*card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((HarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,TransportationTypes),
                                         FarmCentralStorageTruckTripRequirementFinal(HarvestingHorizonAggregation,FarmNumber,
                                                                                         CentralizedStorageLocations,TransportationTypes)
                                         *
                                         (FarmDistanceData(FarmNumber,CentralizedStorageLocations)/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         *DieselGHGEmissionFactor
                                 )*card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((HarvestingHorizonAggregation,CentralizedStorageLocations,TransportationTypes),
                                         CentralStorageRefineryTruckTripRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageLocations,
                                                                                         TransportationTypes)
                                         *
                                         (StorageDistanceData(CentralizedStorageLocations)/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         *DieselGHGEmissionFactor
                                 )*card(HarvestingHorizonAggregationStep);


GHGEmissionNonHarvestingTransportation =
                                sum((NonHarvestingHorizonAggregation,FarmNumber,TransportationTypes),
                                         FarmRefineryTruckTripRequirementFinal(NonHarvestingHorizonAggregation,FarmNumber,TransportationTypes)
                                         *
                                         (FarmData(FarmNumber,'RefineryDistance')/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         *DieselGHGEmissionFactor
                                 )*card(NonHarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,CentralizedStorageLocations,TransportationTypes),
                                         CentralStorageRefineryTruckTripRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageLocations,
                                                                                         TransportationTypes)
                                         *
                                         (StorageDistanceData(CentralizedStorageLocations)/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         *DieselGHGEmissionFactor
                                 )*card(NonHarvestingHorizonAggregationStep);

$offtext

*##############################################################################################################
* Storing results from the first problem in approproiate parameters for result presentation
*##############################################################################################################

EthanolProductionCapacity=BiorefineryCapacity.l*EthanolYield*card(SimulationHorizon);


*------------------------------------------------------------------------
* Calculation of transportation parameters
*------------------------------------------------------------------------

ResultFarmRefineryTruckSchedule(HarvestingHorizon,FarmNumber,TransportationTypes)=
                 sum(HarvestingHorizonAggregation
                         $( ord(HarvestingHorizon)>=(ord(HarvestingHorizonAggregation)-1)*card(HarvestingHorizonAggregationStep)+1
                            and
                            ord(HarvestingHorizon)<=ord(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep)
                           ),
                         FarmRefineryTruckRequirementFinal(HarvestingHorizonAggregation,FarmNumber,TransportationTypes));

ResultFarmRefineryTruckSchedule(NonHarvestingHorizon,FarmNumber,TransportationTypes)=
                 sum(NonHarvestingHorizonAggregation
                         $( ord(NonHarvestingHorizon)>=(ord(NonHarvestingHorizonAggregation)-1)*card(NonHarvestingHorizonAggregationStep)+1
                            and
                            ord(NonHarvestingHorizon)<=ord(NonHarvestingHorizonAggregation)*card(NonHarvestingHorizonAggregationStep)
                           ),
                         FarmRefineryTruckRequirementFinal(NonHarvestingHorizonAggregation,FarmNumber,TransportationTypes));

ResultFarmRegionalTruckSchedule(HarvestingHorizon,FarmNumber,TransportationTypes)=
                 sum(HarvestingHorizonAggregation
                         $( ord(HarvestingHorizon)>=(ord(HarvestingHorizonAggregation)-1)*card(HarvestingHorizonAggregationStep)+1
                            and
                            ord(HarvestingHorizon)<=ord(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep)
                           ),
                         FarmRegionalTruckRequirementFinal(HarvestingHorizonAggregation,FarmNumber,TransportationTypes));

ResultFarmRegionalTruckSchedule(NonHarvestingHorizon,FarmNumber,TransportationTypes)=
                 sum(NonHarvestingHorizonAggregation
                         $( ord(NonHarvestingHorizon)>=(ord(NonHarvestingHorizonAggregation)-1)*card(NonHarvestingHorizonAggregationStep)+1
                            and
                            ord(NonHarvestingHorizon)<=ord(NonHarvestingHorizonAggregation)*card(NonHarvestingHorizonAggregationStep)
                           ),
                         FarmRegionalTruckRequirementFinal(NonHarvestingHorizonAggregation,FarmNumber,TransportationTypes));

ResultFarmDirectPurchaseTruckSchedule(HarvestingHorizon,FarmNumber,TransportationTypes)=
                 sum(HarvestingHorizonAggregation
                         $( ord(HarvestingHorizon)>=(ord(HarvestingHorizonAggregation)-1)*card(HarvestingHorizonAggregationStep)+1
                            and
                            ord(HarvestingHorizon)<=ord(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep)
                           ),
                         FarmDirectPurchaseTruckRequirementFinal(HarvestingHorizonAggregation,FarmNumber,TransportationTypes));

ResultFarmDirectPurchaseTruckSchedule(NonHarvestingHorizon,FarmNumber,TransportationTypes)=0;

ResultFarmCentralStorageTruckSchedule(HarvestingHorizon,FarmNumber,CentralizedStorageLocations,TransportationTypes)=
                 sum(HarvestingHorizonAggregation
                         $( ord(HarvestingHorizon)>=(ord(HarvestingHorizonAggregation)-1)*card(HarvestingHorizonAggregationStep)+1
                            and
                            ord(HarvestingHorizon)<=ord(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep)
                           ),
                         FarmCentralStorageTruckRequirementFinal(HarvestingHorizonAggregation,FarmNumber,
                                                                 CentralizedStorageLocations,TransportationTypes)
                 );

ResultFarmCentralStorageTruckSchedule(NonHarvestingHorizon,FarmNumber,CentralizedStorageLocations,TransportationTypes)=0;

ResultFarmCentralStorageSmallScaleTruckSchedule(HarvestingHorizon,FarmNumber,CentralizedStorageSmallScaleLocations,TransportationTypes)=
                 sum(HarvestingHorizonAggregation
                         $( ord(HarvestingHorizon)>=(ord(HarvestingHorizonAggregation)-1)*card(HarvestingHorizonAggregationStep)+1
                            and
                            ord(HarvestingHorizon)<=ord(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep)
                           ),
                         FarmCentralStorageSmallScaleTruckRequirementFinal(HarvestingHorizonAggregation,FarmNumber,
                                                                 CentralizedStorageSmallScaleLocations,TransportationTypes)
                 );

ResultFarmCentralStorageSmallScaleTruckSchedule(NonHarvestingHorizon,FarmNumber,CentralizedStorageSmallScaleLocations,TransportationTypes)=0;

ResultCentralStorageRefineryTruckSchedule(HarvestingHorizon,CentralizedStorageLocations,TransportationTypes)=
                 sum(HarvestingHorizonAggregation
                         $( ord(HarvestingHorizon)>=(ord(HarvestingHorizonAggregation)-1)*card(HarvestingHorizonAggregationStep)+1
                            and
                            ord(HarvestingHorizon)<=ord(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep)
                           ),
                         CentralStorageRefineryTruckRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageLocations,TransportationTypes)
                 );

ResultCentralStorageRefineryTruckSchedule(NonHarvestingHorizon,CentralizedStorageLocations,TransportationTypes)=
                 sum(NonHarvestingHorizonAggregation
                         $( ord(NonHarvestingHorizon)>=(ord(NonHarvestingHorizonAggregation)-1)*card(NonHarvestingHorizonAggregationStep)+1
                            and
                            ord(NonHarvestingHorizon)<=ord(NonHarvestingHorizonAggregation)*card(NonHarvestingHorizonAggregationStep)
                           ),
                         CentralStorageRefineryTruckRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageLocations,TransportationTypes)
                 );

ResultCentralStorageRegionalTruckSchedule(HarvestingHorizon,CentralizedStorageLocations,TransportationTypes)=
                 sum(HarvestingHorizonAggregation
                         $( ord(HarvestingHorizon)>=(ord(HarvestingHorizonAggregation)-1)*card(HarvestingHorizonAggregationStep)+1
                            and
                            ord(HarvestingHorizon)<=ord(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep)
                           ),
                         CentralStorageRegionalTruckRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageLocations,TransportationTypes)
                 );

ResultCentralStorageRegionalTruckSchedule(NonHarvestingHorizon,CentralizedStorageLocations,TransportationTypes)=
                 sum(NonHarvestingHorizonAggregation
                         $( ord(NonHarvestingHorizon)>=(ord(NonHarvestingHorizonAggregation)-1)*card(NonHarvestingHorizonAggregationStep)+1
                            and
                            ord(NonHarvestingHorizon)<=ord(NonHarvestingHorizonAggregation)*card(NonHarvestingHorizonAggregationStep)
                           ),
                         CentralStorageRegionalTruckRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageLocations,TransportationTypes)
                 );

ResultCentralStorageSmallScaleRefineryTruckSchedule(HarvestingHorizon,CentralizedStorageSmallScaleLocations,TransportationTypes)=
                 sum(HarvestingHorizonAggregation
                         $( ord(HarvestingHorizon)>=(ord(HarvestingHorizonAggregation)-1)*card(HarvestingHorizonAggregationStep)+1
                            and
                            ord(HarvestingHorizon)<=ord(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep)
                           ),
                         CentralStorageSmallScaleRefineryTruckRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,TransportationTypes)
                 );

ResultCentralStorageSmallScaleRefineryTruckSchedule(NonHarvestingHorizon,CentralizedStorageSmallScaleLocations,TransportationTypes)=
                 sum(NonHarvestingHorizonAggregation
                         $( ord(NonHarvestingHorizon)>=(ord(NonHarvestingHorizonAggregation)-1)*card(NonHarvestingHorizonAggregationStep)+1
                            and
                            ord(NonHarvestingHorizon)<=ord(NonHarvestingHorizonAggregation)*card(NonHarvestingHorizonAggregationStep)
                           ),
                         CentralStorageSmallScaleRefineryTruckRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,TransportationTypes)
                 );

ResultCentralStorageSmallScaleRegionalTruckSchedule(HarvestingHorizon,CentralizedStorageSmallScaleLocations,TransportationTypes)=
                 sum(HarvestingHorizonAggregation
                         $( ord(HarvestingHorizon)>=(ord(HarvestingHorizonAggregation)-1)*card(HarvestingHorizonAggregationStep)+1
                            and
                            ord(HarvestingHorizon)<=ord(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep)
                           ),
                         CentralStorageSmallScaleRegionalTruckRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,TransportationTypes)
                 );

ResultCentralStorageSmallScaleRegionalTruckSchedule(NonHarvestingHorizon,CentralizedStorageSmallScaleLocations,TransportationTypes)=
                 sum(NonHarvestingHorizonAggregation
                         $( ord(NonHarvestingHorizon)>=(ord(NonHarvestingHorizonAggregation)-1)*card(NonHarvestingHorizonAggregationStep)+1
                            and
                            ord(NonHarvestingHorizon)<=ord(NonHarvestingHorizonAggregation)*card(NonHarvestingHorizonAggregationStep)
                           ),
                         CentralStorageSmallScaleRegionalTruckRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,TransportationTypes)
                 );

TransportFleetSizeSchedule(HarvestingHorizon,TransportationTypes)=
                 sum((HarvestingHorizonAggregation)
                         $( ord(HarvestingHorizon)>=(ord(HarvestingHorizonAggregation)-1)*card(HarvestingHorizonAggregationStep)+1
                            and
                            ord(HarvestingHorizon)<=ord(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep)
                           ),
                         sum((FarmNumber),
                                 FarmRefineryTruckRequirementFinal(HarvestingHorizonAggregation,FarmNumber,TransportationTypes)
                         )
                         +
                         sum((FarmNumber,CentralizedStorageLocations),
                                 FarmRegionalTruckRequirementFinal(HarvestingHorizonAggregation,FarmNumber,
                                                                                 CentralizedStorageLocations,TransportationTypes)
                         )
                         +
                         sum((FarmNumber,CentralizedStorageLocations),
                                 FarmDirectPurchaseTruckRequirementFinal(HarvestingHorizonAggregation,FarmNumber,
                                                                                 CentralizedStorageLocations,TransportationTypes)
                         )
                         +
                         sum((FarmNumber,CentralizedStorageLocations),
                                 FarmCentralStorageTruckRequirementFinal(HarvestingHorizonAggregation,FarmNumber,
                                                                                 CentralizedStorageLocations,TransportationTypes)
                         )
                         +
                         sum((FarmNumber,CentralizedStorageSmallScaleLocations),
                                 FarmCentralStorageSmallScaleTruckRequirementFinal(HarvestingHorizonAggregation,FarmNumber,
                                                                                 CentralizedStorageSmallScaleLocations,TransportationTypes)
                         )
                         +
                         sum((CentralizedStorageLocations),
                                 CentralStorageRegionalTruckRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageLocations,
                                                                                         TransportationTypes)
                         )
                         +
                         sum((CentralizedStorageSmallScaleLocations),
                                 CentralStorageSmallScaleRefineryTruckRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,
                                                                                         TransportationTypes)
                         )
                         +
                         sum((CentralizedStorageSmallScaleLocations),
                                 CentralStorageSmallScaleRegionalTruckRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,
                                                                                         TransportationTypes)
                         )
                         +
                         sum((CentralizedStorageLocations),
                                 CentralStorageRefineryTruckRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageLocations,
                                                                                         TransportationTypes)
                         )
                 );

TransportFleetSizeSchedule(NonHarvestingHorizon,TransportationTypes)=
                 sum((NonHarvestingHorizonAggregation)
                         $( ord(NonHarvestingHorizon)>=(ord(NonHarvestingHorizonAggregation)-1)*card(NonHarvestingHorizonAggregationStep)+1
                            and
                            ord(NonHarvestingHorizon)<=ord(NonHarvestingHorizonAggregation)*card(NonHarvestingHorizonAggregationStep)
                           ),
                         sum((FarmNumber),
                                 FarmRefineryTruckRequirementFinal(NonHarvestingHorizonAggregation,FarmNumber,TransportationTypes)
                         )
                         +
                         sum((FarmNumber,CentralizedStorageLocations),
                                 FarmRegionalTruckRequirementFinal(NonHarvestingHorizonAggregation,FarmNumber,
                                                                                 CentralizedStorageLocations,TransportationTypes)
                         )
                         +
                         sum((CentralizedStorageLocations),
                                 CentralStorageRegionalTruckRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageLocations,
                                                                                         TransportationTypes)
                         )
                         +
                         sum((CentralizedStorageSmallScaleLocations),
                                 CentralStorageSmallScaleRefineryTruckRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,
                                                                                         TransportationTypes)
                         )
                         +
                         sum((CentralizedStorageSmallScaleLocations),
                                 CentralStorageSmallScaleRegionalTruckRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,
                                                                                         TransportationTypes)
                         )
                         +
                         sum((CentralizedStorageLocations),
                                 CentralStorageRefineryTruckRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageLocations,
                                                                                         TransportationTypes)
                         )
                 );

TransportationFleetRequirement(TransportationTypes)=smax(SimulationHorizon,TransportFleetSizeSchedule(SimulationHorizon,TransportationTypes));

* Transportation fleet utilization in terms of number of vehicles. i.e. ratio of number of vehicles used for each day to the total
* feel size requirement (maximum number for the simulation horizon)
AverageTransportationFleetNumberUtilization(SimulationHorizon,TransportationTypes)$(TransportationFleetRequirement(TransportationTypes))
                 =
                 TransportFleetSizeSchedule(SimulationHorizon,TransportationTypes)/
                 TransportationFleetRequirement(TransportationTypes);

*
* Calculating the transportation cost using the rounded off values of number of trucks
*
R_TransportationFixedCost =  sum(TransportationTypes, TransportationFleetRequirement(TransportationTypes)*
                                         TransportationData('AnnualFixedCost',TransportationTypes));


R_TransportationOperatingCost =    sum((HarvestingHorizonAggregation,FarmNumber,TransportationTypes),
                                         FarmRefineryTruckTripRequirementFinal(HarvestingHorizonAggregation,FarmNumber,TransportationTypes)
                                         * FarmRefineryTransportationTime(FarmNumber,TransportationTypes)
                                         * TransportationData('OperatingCost',TransportationTypes)
                                         +
                                         FarmRefineryTruckTripRequirementFinal(HarvestingHorizonAggregation,FarmNumber,TransportationTypes)
                                         *
                                         (FarmData(FarmNumber,'RefineryDistance')/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         *DieselFuelCost
                             )
                             * card(HarvestingHorizonAggregationStep)
                             +
                             sum((HarvestingHorizonAggregation,FarmNumber,TransportationTypes),
                                         FarmRegionalTruckTripRequirementFinal(HarvestingHorizonAggregation,FarmNumber,TransportationTypes)
                                         * FarmRegionalTransportationTime(FarmNumber,TransportationTypes)
                                         * TransportationData('OperatingCost',TransportationTypes)
                                         +
                                         FarmRegionalTruckTripRequirementFinal(HarvestingHorizonAggregation,FarmNumber,TransportationTypes)
                                         *
                                         (FarmData(FarmNumber,'RegionalDistance')/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         *DieselFuelCost
                             )
                             * card(HarvestingHorizonAggregationStep)
                             +
                             sum((HarvestingHorizonAggregation,FarmNumber,TransportationTypes),
                                         FarmDirectPurchaseTruckTripRequirementFinal(HarvestingHorizonAggregation,FarmNumber,TransportationTypes)
                                         * FarmDirectPurchaseTransportationTime(FarmNumber,TransportationTypes)
                                         * TransportationData('OperatingCost',TransportationTypes)
                                         +
                                         FarmDirectPurchaseTruckTripRequirementFinal(HarvestingHorizonAggregation,FarmNumber,TransportationTypes)
                                         *
                                         (FarmData(FarmNumber,'DirectPurchaseDistance')/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         *DieselFuelCost
                             )
                             * card(HarvestingHorizonAggregationStep)
                             +
                             sum((HarvestingHorizonAggregation,FarmNumber,CentralizedStorageLocations,TransportationTypes),
                                         FarmCentralStorageTruckTripRequirementFinal(HarvestingHorizonAggregation,FarmNumber,
                                                 CentralizedStorageLocations,TransportationTypes)
                                         * FarmCentralStorageTransportationTime(FarmNumber,CentralizedStorageLocations,TransportationTypes)
                                         * TransportationData('OperatingCost',TransportationTypes)
                                         +
                                         FarmCentralStorageTruckTripRequirementFinal(HarvestingHorizonAggregation,
                                                                                         FarmNumber,CentralizedStorageLocations,TransportationTypes)
                                         *
                                         (FarmDistanceData(FarmNumber,CentralizedStorageLocations)/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         *DieselFuelCost
                             )
                             * card(HarvestingHorizonAggregationStep)
                             +
                             sum((HarvestingHorizonAggregation,FarmNumber,CentralizedStorageSmallScaleLocations,TransportationTypes),
                                         FarmCentralStorageSmallScaleTruckTripRequirementFinal(HarvestingHorizonAggregation,FarmNumber,
                                                 CentralizedStorageSmallScaleLocations,TransportationTypes)
                                         * FarmCentralStorageSmallScaleTransportationTime(FarmNumber,CentralizedStorageSmallScaleLocations,TransportationTypes)
                                         * TransportationData('OperatingCost',TransportationTypes)
                                         +
                                         FarmCentralStorageSmallScaleTruckTripRequirementFinal(HarvestingHorizonAggregation,
                                                                                         FarmNumber,CentralizedStorageSmallScaleLocations,TransportationTypes)
                                         *
                                         (FarmDistanceData(FarmNumber,CentralizedStorageSmallScaleLocations)/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         *DieselFuelCost
                             )
                             * card(HarvestingHorizonAggregationStep)
                             +
                             sum((HarvestingHorizonAggregation,CentralizedStorageLocations,TransportationTypes),
                                         CentralStorageRefineryTruckTripRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageLocations,
                                                                                                 TransportationTypes)
                                         * CentralStorageRefineryTransportationTime(CentralizedStorageLocations,TransportationTypes)
                                         * TransportationData('OperatingCost',TransportationTypes)
                                         +
                                         CentralStorageRefineryTruckTripRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageLocations,
                                                                                                 TransportationTypes)
                                         * (StorageRefineryDistanceData(CentralizedStorageLocations)/TruckFuelEfficiency
                                            + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         * DieselFuelCost
                             )
                             * card(HarvestingHorizonAggregationStep)
                             +
                             sum((HarvestingHorizonAggregation,CentralizedStorageLocations,TransportationTypes),
                                         CentralStorageRegionalTruckTripRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageLocations,
                                                                                                 TransportationTypes)
                                         * CentralStorageRegionalTransportationTime(CentralizedStorageLocations,TransportationTypes)
                                         * TransportationData('OperatingCost',TransportationTypes)
                                         +
                                         CentralStorageRegionalTruckTripRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageLocations,
                                                                                                 TransportationTypes)
                                         * (StorageRegionalDistanceData(CentralizedStorageLocations)/TruckFuelEfficiency
                                            + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         * DieselFuelCost
                             )
                             * card(HarvestingHorizonAggregationStep)
                             +
                             sum((HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,TransportationTypes),
                                         CentralStorageSmallScaleRefineryTruckTripRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,
                                                                                                 TransportationTypes)
                                         * CentralStorageSmallScaleRefineryTransportationTime(CentralizedStorageSmallScaleLocations,TransportationTypes)
                                         * TransportationData('OperatingCost',TransportationTypes)
                                         +
                                         CentralStorageSmallScaleRefineryTruckTripRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,
                                                                                                 TransportationTypes)
                                         * (StorageSmallScaleRefineryDistanceData(CentralizedStorageSmallScaleLocations)/TruckFuelEfficiency
                                            + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         * DieselFuelCost
                             )
                             * card(HarvestingHorizonAggregationStep)
                             +
                             sum((HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,TransportationTypes),
                                         CentralStorageSmallScaleRegionalTruckTripRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,
                                                                                                 TransportationTypes)
                                         * CentralStorageSmallScaleRegionalTransportationTime(CentralizedStorageSmallScaleLocations,TransportationTypes)
                                         * TransportationData('OperatingCost',TransportationTypes)
                                         +
                                         CentralStorageSmallScaleRegionalTruckTripRequirementFinal(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,
                                                                                                 TransportationTypes)
                                         * (StorageSmallScaleRegionalDistanceData(CentralizedStorageSmallScaleLocations)/TruckFuelEfficiency
                                            + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         * DieselFuelCost
                             )
                             * card(HarvestingHorizonAggregationStep)
                             +
                             sum((NonHarvestingHorizonAggregation,FarmNumber,TransportationTypes),
                                         FarmRefineryTruckTripRequirementFinal(NonHarvestingHorizonAggregation,FarmNumber,TransportationTypes)
                                         * FarmRefineryTransportationTime(FarmNumber,TransportationTypes)
                                         * TransportationData('OperatingCost',TransportationTypes)
                                         +
                                         FarmRefineryTruckTripRequirementFinal(NonHarvestingHorizonAggregation,FarmNumber,TransportationTypes)
                                         *
                                         (FarmData(FarmNumber,'RefineryDistance')/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         *DieselFuelCost
                             )
                             * card(NonHarvestingHorizonAggregationStep)
                             +
                             sum((NonHarvestingHorizonAggregation,FarmNumber,TransportationTypes),
                                         FarmRegionalTruckTripRequirementFinal(NonHarvestingHorizonAggregation,FarmNumber,TransportationTypes)
                                         * FarmRegionalTransportationTime(FarmNumber,TransportationTypes)
                                         * TransportationData('OperatingCost',TransportationTypes)
                                         +
                                         FarmRegionalTruckTripRequirementFinal(NonHarvestingHorizonAggregation,FarmNumber,TransportationTypes)
                                         *
                                         (FarmData(FarmNumber,'RegionalDistance')/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         *DieselFuelCost
                             )
                             * card(NonHarvestingHorizonAggregationStep)
                             +
                             sum((NonHarvestingHorizonAggregation,CentralizedStorageLocations,TransportationTypes),
                                         CentralStorageRefineryTruckTripRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageLocations,
                                                                                                 TransportationTypes)
                                         * CentralStorageRefineryTransportationTime(CentralizedStorageLocations,TransportationTypes)
                                         * TransportationData('OperatingCost',TransportationTypes)
                                         +
                                         CentralStorageRefineryTruckTripRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageLocations,
                                                                                                 TransportationTypes)
                                         * (StorageRefineryDistanceData(CentralizedStorageLocations)/TruckFuelEfficiency
                                            + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         * DieselFuelCost
                             )
                             * card(NonHarvestingHorizonAggregationStep)
                             +
                             sum((NonHarvestingHorizonAggregation,CentralizedStorageLocations,TransportationTypes),
                                         CentralStorageRegionalTruckTripRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageLocations,
                                                                                                 TransportationTypes)
                                         * CentralStorageRegionalTransportationTime(CentralizedStorageLocations,TransportationTypes)
                                         * TransportationData('OperatingCost',TransportationTypes)
                                         +
                                         CentralStorageRegionalTruckTripRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageLocations,
                                                                                                 TransportationTypes)
                                         * (StorageRegionalDistanceData(CentralizedStorageLocations)/TruckFuelEfficiency
                                            + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         * DieselFuelCost
                             )
                             * card(NonHarvestingHorizonAggregationStep)
                             +
                             sum((NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,TransportationTypes),
                                         CentralStorageSmallScaleRefineryTruckTripRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,
                                                                                                 TransportationTypes)
                                         * CentralStorageSmallScaleRefineryTransportationTime(CentralizedStorageSmallScaleLocations,TransportationTypes)
                                         * TransportationData('OperatingCost',TransportationTypes)
                                         +
                                         CentralStorageSmallScaleRefineryTruckTripRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,
                                                                                                 TransportationTypes)
                                         * (StorageSmallScaleRefineryDistanceData(CentralizedStorageSmallScaleLocations)/TruckFuelEfficiency
                                            + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         * DieselFuelCost
                             )
                             * card(NonHarvestingHorizonAggregationStep)
                             +
                             sum((NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,TransportationTypes),
                                         CentralStorageSmallScaleRegionalTruckTripRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,
                                                                                                 TransportationTypes)
                                         * CentralStorageSmallScaleRegionalTransportationTime(CentralizedStorageSmallScaleLocations,TransportationTypes)
                                         * TransportationData('OperatingCost',TransportationTypes)
                                         +
                                         CentralStorageSmallScaleRegionalTruckTripRequirementFinal(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,
                                                                                                 TransportationTypes)
                                         * (StorageSmallScaleRegionalDistanceData(CentralizedStorageSmallScaleLocations)/TruckFuelEfficiency
                                            + TruckIdlingTimePerTrip*TruckIdlingFuelConsumption)
                                         * DieselFuelCost
                             )
                             * card(NonHarvestingHorizonAggregationStep);

R_TotalTransportationCost = R_TransportationFixedCost + R_TransportationOperatingCost;


*
* Using the values to different costs to calculate the per dry Mg delivered cost
*
DeliveredCost$(BiorefineryCapacity.l)=(sum((FarmNumber),Par_FarmCost(FarmNumber))
                  + R_TotalTransportationCost + ProvisionStorageCost.l + ProvisionBiomassHandlingCost.l)/(BiorefineryCapacity.l*card(SimulationHorizon));

*##############################################################################################################
* Display statements to print results
*##############################################################################################################

Display TransportFleetSizeSchedule;

Display EthanolProductionCapacity,  DeliveredCost ;
