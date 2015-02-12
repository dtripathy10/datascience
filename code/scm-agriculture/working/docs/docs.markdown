################################################
Project Name: "Optimization Model:- Post Harvest Loss of Grain supply chain model for India"
Total number of files : 25
#################################################


=================================Main File======================================
## {X} Main File
+ ModelAssembly_test.gms
+ ScenarioSetup_grains.gms

========================Set and Parameter Declaration file===========================
## {X} Set and Parameter Declaration file
+ StorageTransportationData_grains.gms
+ MachineData_grains.gms
+ FarmOptimizationResults_grains.gms

=========================Variable Decalaration file==================================
## {X} Variable Decalaration file
+ VariableDeclaration_grains.gms

=========================Constrains===============================================
## Constrains

#### {X} Farmer:
  + FarmGateBiomassDistributionConstrained_grains.gms

#### Storage before sale:
  + LocalCSPConstraints_grains.gms
  + RegionalCSPConstraints_grains.gms

#### {X} Intermediate market
  + MarketConstraints_grains.gms
  + LocalMarketConstraints_grains.gms
  + RegionalMarketConstraints_grains.gms

#### Storage after sale:
  + FCIConstraints_grains.gms
  + RGYConstraints_grains.gms
  + PrivateTraderConstraints_grains.gms


#### Grains processor
  + MillerConstraints_grains.gms

#### End Conumer
  + TPDSConstraints_grains.gms
  + RetailConstraints_grains.gms

#### Transportation
  + TransportationConstraints_grains.gms
  + TransportationCostConstraints_grains.gms
  + TransportationMassConstraints_grains.gms

#### Technology
  + GunnyBagConstraints_grains.gms


================================Objective==================================
###### Objective

+ ProvisionCostConstraints_grains.gms
+ PostHarvestLossConstraints_grains.gms


================================Result============================================
###### Result

+ PostOptimizationCalculations.gms


===================================END=================================================