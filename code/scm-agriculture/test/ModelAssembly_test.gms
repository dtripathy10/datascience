$title The main code that integrates all the other code files

$Ontext
Conversion:
1 hectare = 0.01 square kilometer
1 square meter = 0.0001 hectare
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

*###################################################################################
* Set Declaration: Most of the sets are read from the Excel spreadsheet containing
* the problem data
*########################################################################################

Sets 
    SimulationHorizon/1*360/
    HarvestingHorizon(SimulationHorizon)/1*15/
    NonHarvestingHorizon(SimulationHorizon) /16*360/
    NonEnsilageRemovalHorizon(SimulationHorizon) /1*240/
    HarvestingHorizonAggregationStep /1*5/
    NonHarvestingHorizonAggregationStep /1*15/
    HarvestingHorizonAggregation(HarvestingHorizon) /1,6,11/
    NonHarvestingHorizonAggregation(NonHarvestingHorizon) /16, 31, 46, 61, 76, 91, 106,
                                    121, 136, 151, 166, 181, 196, 211, 226, 241, 256, 271,
                                    286, 301, 316, 331, 346/;

* Declaration of dummy set to adjust the dimensions that are convenient for representation and 
* writting

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

*########################################################################################
* Importing data pertaining to grain handling, storage and transportation technology
* and equipment
*##########################################################################################
$include "../io/MachineData_grains.gms"
$include "../io/StorageTransportationData_grains.gms"

*########################################################################################
* Importing data pertaining the specific case study: Farm number,
* farm-storage-market distances etc.
*#########################################################################################
$include "../scenario/ScenarioSetup_grains.gms"

*############################################################################################
* Parameters calculated after the solution of the provision problem
*###########################################################################################
Parameter
    Par_ProvisionStorageCost
    Par_ProvisionTransportationCost
    Par_ProvisionStorageCostRateConstrained 
    Par_ProvisionStorageCostRate
    Par_ProvisionStorageProcessingCostConstrained
    Par_ProvisionStorageProcessingCost 
    Par_ProvisionTransportationCostRate 
    Par_ProvisionBiomassHandlingCost
    Par_CentralStorageOutput;

*######################################################################################
* Now including the GAMS files that incorporate the results of the farm production
* problem. Here, we are assuming that the farm production problems are already solved 
* and the total availability of grains in known
*#######################################################################################
$include "io/FarmOptimizationResults_grains.gms"

*########################################################################################
* Now including the GAMS files that are used to build the provision model based on
* the results from the farm management model
*########################################################################################

$include "../model/VariableDeclaration_grains.gms"

$include "../model/producer/FarmGateBiomassDistributionConstrained_grains.gms"

$include "../model/storge/before_sale/LocalCSPConstraints_grains.gms"
$include "../model/storge/before_sale/RegionalCSPConstraints_grains.gms"
$include "vmodel/storge/after_sale/FCIConstraints_grains.gms"
$include "../model/storge/after_sale/RGYConstraints_grains.gms"

$include "../model/market/MarketConstraints_grains.gms"
$include "../model/market/LocalMarketConstraints_grains.gms"
$include "../model/market/RegionalMarketConstraints_grains.gms"
$include "../model/market/PrivateTraderConstraints_grains.gms"

$include "../model/consumer/milling/MillerConstraints_grains.gms"
$include "../model/consumer/pds/TPDSConstraints_grains.gms"
$include "../model/consumer/retailer/RetailConstraints_grains.gms"

$include "../model/technology/GunnyBagConstraints_grains.gms"

$include "../model/market/ProvisionCostConstraints_grains.gms"

$include "../model/PostHarvestLossConstraints_grains.gms"

********************************************************************************************
* Selection of the transportation model which leads to different set of files 
* considered for the model development. Please select only one of the following options.
**********************************************************************************************

* Option 1: The transportation costs are to be calculated by considering all the details about
* the number of vehicles required along each leg. The transportation operating cost is calculated
* using the truck idling time, transport time, diesel fuel cost and so on.

$include "../model/transportation/TransportationMassConstraints_grains.gms"
$include "../model/transportation/TransportationConstraints_grains.gms"
$include "../model/transportation/TransportationCostConstraints_grains.gms"

Model GrainProvisionModelOptimal 
          /FarmGateGrainDistributionModelConstrained_Current,
            TransportationMassModel,TransportationModel,
            TransportationCostModel,LocalCSPModel,RegionalCSPModel,
            MarketDemandModel2,LocalMarketModel,RegionalMarketModel,
            PrivateTraderModel,RGYModel,MillerModel,FCIModel,
            TPDSModel,RetailerSModel,GunnyBagModel,ProvisionCostModel,
            PHLConstraints/;

**********************************************************************************************

* Option 2: The transportation costs are to be calculated by using only the Rs/km-kg number.

$Ontext

$include "model/transportation/TransportationCostConstraintsSimplified_grains.gms"

Model GrainProvisionModelOptimal
          /FarmGateGrainDistributionModelConstrained_Current,
            TransportationCostModel,
            LocalCSPModel,RegionalCSPModel,MarketDemandModel2,
            LocalMarketModel,RegionalMarketModel,PrivateTraderModel,
            RGYModel,MillerModel,FCIModel,
            TPDSModel,RetailerSModel,GunnyBagModel,
            ProvisionCostModel,PHLConstraints/;

$offtext

***************************************************************************************

Option MIP = cplex;

Solve GrainProvisionModelOptimal using mip maximizing GrainProvisionObjective;

$include "../model/PostOptimizationCalculations.gms"


Display 
    FarmLocalMarketTruckTripRequirement.l, HarvestFarmGateLocalMarketGrain.l, 
    HarvestFarmGateRegionalMarketGrain.l, LocalMarketTotalGrain.l,
    HarvestFarmGateLocalMarketGrain.l, LocalCSPLocalMarketGrain.l,
    RegionalCSPLocalMarketGrain.l, FCIInput.l,FCICAPStorageInput.l, FCICoveredStorageInput.l,
    FCICoveredStoredGrain.l,FCICAPStoredGrain.l, RGYSelector.l, FCISelector.l, 
    MillerSelector.l, FCICoveredCapacity.l, FCICAPCapacity.l, FCICAPMillerGrain.l, 
    FCICAPRetailerGrain.l, FCICAPPDSGrain.l, RegionalMarketFCITruckTripRequirement.l;