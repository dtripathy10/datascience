*Copyright © 2012 The Board of Trustees of the University of Illinois. All Rights Reserved

$title The main code that integrates all the other code files
$Ontext
Conversion:
1 square meter = 0.0001 hectare
1 hectare = 0.01 square kilometer
1 square foot = 0.0929 square meter
1 acre = 4046.85 square meter
1 hectare = 2.271 acres
1 gallon [US, liquid] = 0.003785411784 cubic meter
$offtext

$Offlisting
$Offsymxref
$Offsymlist
$Offuelxref
$Offuellist
$Offupper

options Limcol=0;
options Limrow=0;
options profile=0;
option sysout=off;
option solprint=off;

Option iterlim=1000000;
Option reslim=9E+8;

Scalar tcomp, texec, telapsed;

*############################################################################################################
* Set Declaration: Most of the sets are read from the Excel spreadsheet containing the problem data
*############################################################################################################

Sets     
  SimulationHorizon/1*360/
  HarvestingHorizon(SimulationHorizon)/1*15/
  NonHarvestingHorizon(SimulationHorizon) /16*360/
  HarvestingHorizonAggregationStep /1*5/
  NonHarvestingHorizonAggregationStep /1*15/
  HarvestingHorizonAggregation(HarvestingHorizon) /1,6,11/
  NonHarvestingHorizonAggregation(NonHarvestingHorizon) /
    16, 31, 46, 61, 76, 91, 106, 121, 136, 151, 166, 181, 196, 211, 226, 241, 256, 271, 286, 301, 316, 331, 346
    /
  ;
*
* Declaration of dummy set to adjust the dimensions that are convenient for representation and writting
*
Sets Representation /1/;

Sets ProcessingDecision /Processing, Noprocessing/;

alias(SimulationHorizon,SimulationHorizon2)
alias(HarvestingHorizon,HarvestingHorizon2)
alias(HarvestingHorizon,HarvestingHorizon3)
alias(NonHarvestingHorizon,NonHarvestingHorizon2)

alias(HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
alias(HarvestingHorizonAggregation,HarvestingHorizonAggregation3)
alias(NonHarvestingHorizonAggregation,NonHarvestingHorizonAggregation2)
alias(NonHarvestingHorizonAggregation,NonHarvestingHorizonAggregation3)

*##############################################################################################################
* Importing data pertaining to grain handling, storage and transportation technology and equipment
*##############################################################################################################
$include MachineData_grains.gms
$include StorageTransportationData_grains.gms

*##############################################################################################################
* Importing data pertaining the specific case study: Farm number, farm-storage-market distances etc.
*##############################################################################################################
$include ScenarioSetup_grains.gms

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
  Par_CentralStorageOutput The total biomass output from a centralized storage facility
  ;

*##############################################################################################################
* Now including the GAMS files that incorporate the results of the farm production problem.
* Here, we are assuming that the farm production problems are already solved and the total availability of grains in known
*##############################################################################################################
$include FarmOptimizationResults_grains.gms

*##############################################################################################################
* Now including the GAMS files that are used to build the provision model based on the results from the farm management model
*##############################################################################################################

$include VariableDeclaration_grains.gms
$include FarmGateBiomassDistributionConstrained_grains.gms
$include LocalCSPConstraints_grains.gms
$include RegionalCSPConstraints_grains.gms
$include MarketConstraints_grains.gms
$include LocalMarketConstraints_grains.gms
$include RegionalMarketConstraints_grains.gms
$include PrivateTraderConstraints_grains.gms
$include RGYConstraints_grains.gms
$include MillerConstraints_grains.gms
$include FCIConstraints_grains.gms
$include TPDSConstraints_grains.gms
$include RetailConstraints_grains.gms
$include GunnyBagConstraints_grains.gms
$include ProvisionCostConstraints_grains.gms
$include PostHarvestLossConstraints_grains.gms

*********************************************************************************************************************
* Selection of the transportation model which leads to different set of files considered for the model development.
* Please select only one of the following options.
*********************************************************************************************************************
*$ontext
*
* Option 1: The transportation costs are to be calculated by considering all the details about the number of vehicles
* required along each leg. The transportation operating cost is calculated using the truck idling time, transport time,
* diesel fuel cost and so on.
*
*$include TransportationVolumeConstraints_grains.gms
$include TransportationMassConstraints_grains.gms
$include TransportationConstraints_grains.gms
$include TransportationCostConstraints_grains.gms

Model GrainProvisionModelOptimal   /
  FarmGateGrainDistributionModelConstrained_Current,TransportationMassModel,TransportationModel, TransportationCostModel,
  LocalCSPModel,RegionalCSPModel,MarketDemandModel2,
  LocalMarketModel,RegionalMarketModel,PrivateTraderModel,RGYModel,MillerModel,FCIModel,
  TPDSModel,RetailerSModel,GunnyBagModel,ProvisionCostModel,PHLConstraints
  /;

*$offtext
$ontext
* Option 2: The transportation costs are to be calculated by using only the Rs/km-kg number.
*
$include TransportationCostConstraintsSimplified_grains.gms
Model GrainProvisionModelOptimal /
  FarmGateGrainDistributionModelConstrained_Current,TransportationCostModel,
  LocalCSPModel,RegionalCSPModel,MarketDemandModel2,
  LocalMarketModel,RegionalMarketModel,PrivateTraderModel,RGYModel,MillerModel,FCIModel,
  TPDSModel,RetailerSModel,GunnyBagModel,ProvisionCostModel,PHLConstraints
  /;
$offtext
*********************************************************************************************************************

Option MIP = cplex;
*Option optca = 1e-6;
*Option optcr = 1e-6;

Solve GrainProvisionModelOptimal using mip maximizing GrainProvisionObjective;

$include PostOptimizationCalculations.gms


Display 
  FarmLocalMarketTruckTripRequirement.l, HarvestFarmGateLocalMarketGrain.l, HarvestFarmGateRegionalMarketGrain.l,
  LocalMarketTotalGrain.l, HarvestFarmGateLocalMarketGrain.l, LocalCSPLocalMarketGrain.l, RegionalCSPLocalMarketGrain.l,
  FCIInput.l,FCICAPStorageInput.l, FCICoveredStorageInput.l,FCICoveredStoredGrain.l,FCICAPStoredGrain.l,
  RGYSelector.l, FCISelector.l, MillerSelector.l,
  FCICoveredCapacity.l, FCICAPCapacity.l,
  FCICAPMillerGrain.l, FCICAPRetailerGrain.l, FCICAPPDSGrain.l, RegionalMarketFCITruckTripRequirement.l, TotalPHLLoss.l
  ;
