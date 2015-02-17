
Variable 
  GrainProvisionObjective "The second phase objective function"
  DummyObjective "Dummy objective function needed for code debugging"
  ;

Positive variables
  LocalCSPFacilityArea(LocalCSPCenterSet) "Total area of each local CSP facility in square meters"
  LocalCSPStorageCost(LocalCSPCenterSet) "Total cost of grain storage at the local centralized storage facility"
  LocalCSPGrainHandlingCost(LocalCSPCenterSet) "Total cost of the handling of grains related to loading unloading activities at the local centralized storage"

  RegionalCSPFacilityArea(RegionalCSPCenterSet) "Total area of each Regional CSP facility in square meters"
  RegionalCSPStorageCost(RegionalCSPCenterSet) "Total cost of grain storage at the Regional centralized storage facility"
  RegionalCSPGrainHandlingCost(RegionalCSPCenterSet) "Total cost of the handling of grains related to loading unloading activities at the Regional centralized storage"
  ;

Binary Variables
  LocalCSPFacilitySelector(LocalCSPCenterSet) "The binary variable that indicates whether a particular local CSP  location is selected"
  RegionalCSPFacilitySelector(RegionalCSPCenterSet) "The binary variable that indicates whether a particular regional CSP  location is selected"
  RGYSelector(RGYSet) "The binary variable that indicated whether a particular RGY location is selected"
  MillerSelector(MillerSet) "The binary variable that indicated whether a particular miller location is selected"
  FCISelector "The binary variable that indicated whether a particular FCI location is selected"
  ;

Positive variables
  FarmGateGrainAvailable  "Grain available at the farm gate for removal at any time during the simulation horizon"

  HarvestFarmGateLocalCSPGrain(SimulationHorizon,DistrictSelected,FarmNumber,LocalCSPCenterSet)
  HarvestFarmGateRegionalCSPGrain(SimulationHorizon,DistrictSelected,FarmNumber,RegionalCSPCenterSet)
  HarvestFarmGateLocalMarketGrain(SimulationHorizon,DistrictSelected,FarmNumber,LocalMarketSet)
  HarvestFarmGateRegionalMarketGrain(SimulationHorizon,DistrictSelected,FarmNumber,RegionalMarketSet)
  HarvestFarmGateDirectPurchaseGrain(SimulationHorizon,DistrictSelected,FarmNumber)

  HarvestFarmGateLocalCSPGrainVolume(SimulationHorizon,DistrictSelected,FarmNumber,LocalCSPCenterSet)
  HarvestFarmGateRegionalCSPGrainVolume(SimulationHorizon,DistrictSelected,FarmNumber,RegionalCSPCenterSet)
  HarvestFarmGateRegionalMarketGrainVolume(SimulationHorizon,DistrictSelected,FarmNumber,RegionalMarketSet)
  HarvestFarmGateLocalMarketGrainVolume(SimulationHorizon,DistrictSelected,FarmNumber,LocalMarketSet)
  HarvestFarmGateDirectPurchaseGrainVolume(SimulationHorizon,DistrictSelected,FarmNumber)

  LocalCSPLocalMarketGrain "Total amount of grain that is moved from a particular local CSP to the local market"
  LocalCSPRegionalMarketGrain "Total amount of grain that is moved from a particular local CSP to the regional market"
  LocalCSPInput "The total grain input to a particular local central storage facility"
  LocalCSPStoredGrain "The total input of grain from a particular farm that is being sent to the local CSP - this is the total grain that is sent during the whole simulation time step"
  LocalCSPStoredGrainVolume "The volume of the grain stored in a particular local CSP"
  LocalCSPOutput "The total grain output from a particular local central storage facility"
  LocalCSPStoredGrainTotal "The total grain that is stored in the local central storage facility at any time"

  RegionalCSPLocalMarketGrain "Total amount of grain that is moved from a particular regional CSP to the local market"
  RegionalCSPRegionalMarketGrain "Total amount of grain that is moved from a particular regional CSP to the regional market"
  RegionalCSPInput "The total grain input to a particular Regional central storage facility"
  RegionalCSPStoredGrain "The total input of grain from a particular farm that is being sent to the Regional CSP - this is the total grain that is sent during the whole simulation time step"
  RegionalCSPStoredGrainVolume "The volume of the grain stored in a particular Regional CSP"
  RegionalCSPOutput "The total grain output from a particular Regional central storage facility"
  RegionalCSPStoredGrainTotal "The total grain that is stored in the Regional central storage facility at any time"

  LocalMarketTotalGrain "The total amount of grain coming into the local market for sale"
  LocalMarketPrivateTraderGrain "The total grain purchased by a Private Trader at the Local market in Mg or kg"
  LocalMarketPrivateTraderGrainVolume "The total volume of grain purchased by a Private Trader at the Local market in cubic meters"

  RegionalMarketTotalGrain "The total amount of grain coming into the regional market for sale"
  RegionalMarketFCIGrain "The total grain purchased by FCI at the regional market in Mg or kg"
  RegionalMarketFCIGrainVolume "The total volume of grain purchased by FCI at the regional market in cubic meters"
  RegionalMarketPrivateTraderGrain "The total grain purchased by a Private Trader at the regional market in Mg or kg"
  RegionalMarketPrivateTraderGrainVolume "The total volume of grain purchased by a Private Trader at the regional market in cubic meters"

  PrivateTraderPurchaseTotal "The total amount of grain purchased by the traders across all markets"
  LocalMarketPrivateTraderRGYGrain "The total amount of grain purchased by the private traders that is moved to the RGY from local market"
  RegionalMarketPrivateTraderRGYGrain "The total amount of grain purchased by the private traders that is moved to the RGY from regional market"
  LocalMarketPrivateTraderRetailerGrain "The total amount of grain purchased by the private traders that is sent to retailers from local market"
  RegionalMarketPrivateTraderRetailerGrain "The total amount of grain purchased by the private traders that is sent to retailers from regional market"

  RGYStoredGrain "The total grain stored in a particular RGY at a given time step"
  RGYMillerGrain "The total grain moved from an RGY to a particular miller"
  RGYRetailerGrain "The total grain moved from an RGY to a retailer"
  RGYCapacity "The total capacity of the RGY that is calcualted based on the amount of grain stored at each time in the RGY"

  MillerInput "The total input to a particular miller during a given time-step"
  MilledGrainOutput "The total output of milled grain from a particular miller during a given time-step which can  be sent to the storage facility"
  MillerStoredGrain "The total amount of grain stored at a miller during a particular time-step"
  MillerOutput "The total output of milled grain from a particular miller during a given time-step that is removed from the milling facility and sent to further destinations"
  MillerProcessingCapacity "the capacity in kg in terms of the amount of grain that can be processed by a mill"
  MillerStorageCapacity "the capacity in kg in terms of the amount of grain that must be stored by a mill"
  MillerRetailerGrain "The total grain that is transported from a particular  miller to a particular  retailer"

  FCIInput  "The total input to a particular FCI godown during a given time-step"
  FCICAPStorageInput "The input grain to a particular godown that is sent to CAP storage at that godown"
  FCICoveredStorageInput "The input grain to a particular godown that is sent to covered storage at that godown"
  FCICAPStoredGrain "The total grain that is stored in a CAP facility within an FCI godown"
  FCICoveredStoredGrain "The total grain that is stored in a covered facility within an FCI godown"
  FCICAPMillerGrain "Amount of grain removed from the CAP storage facility in a particular FCI godown to be sent to a particular miller"
  FCICAPRetailerGrain "Amount of grain removed from the CAP storage facility in a particular FCI godown to be sent to a particular retailer"
  FCICAPPDSGrain "Amount of grain removed from the CAP storage facility in a particular FCI godown to be sent to a particular PDS outlet"
  FCICoveredMillerGrain "Amount of grain removed from the covered storage facility in a particular FCI godown to be sent to a particular miller"
  FCICoveredRetailerGrain "Amount of grain removed from the covered storage facility in a particular FCI godown to be sent to a particular retailer"
  FCICoveredPDSGrain "Amount of grain removed from the covered storage facility in a particular FCI godown to be sent to a particular PDS outlet"
  FCICoveredCapacity "The total covered (indoor) storage capacity of a particular FCI godown"
  FCICAPCapacity "The total CAP storage capacity of a particular FCI godown"
  ;

Positive variables
  FarmLocalCSPTruckTripRequirement(SimulationHorizon,DistrictSelected,TotalFarmNumber,LocalCSPCenterSet,TransportationTypes) "The number of total trips for each farm on each day to move grains from the farm to each local CSP location"
  FarmRegionalCSPTruckTripRequirement(SimulationHorizon,DistrictSelected,TotalFarmNumber,RegionalCSPCenterSet,TransportationTypes) "The number of total trips for each farm on each day to move grains from the farm to each Regional CSP location"

  FarmLocalMarketTruckTripRequirement(SimulationHorizon,DistrictSelected,TotalFarmNumber,LocalMarketSet,TransportationTypes) "The number of total trips for each farm on each day to move grains from the farm to each local market location"
  FarmRegionalMarketTruckTripRequirement(SimulationHorizon,DistrictSelected,TotalFarmNumber,RegionalMarketSet,TransportationTypes) "The number of total trips for each farm on each day to move grains from the farm to each Regional market location"

  LocalCSPLocalMarketTruckTripRequirement(SimulationHorizon,LocalCSPCenterSet,LocalMarketSet,TransportationTypes) "The number of total trips between each local CSP and local market to move grains on a daily basis"
  LocalCSPRegionalMarketTruckTripRequirement(SimulationHorizon,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes) "The number of total trips between each local CSP and regional market to move grains on a daily basis"

  RegionalCSPLocalMarketTruckTripRequirement(SimulationHorizon,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes) "The number of total trips between each regional CSP and local market to move grains on a daily basis"
  RegionalCSPRegionalMarketTruckTripRequirement(SimulationHorizon,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes) "The number of total trips between each regional CSP and regional market to move grains on a daily basis"

  FarmDirectPurchaseTruckTripRequirement(SimulationHorizon,DistrictSelected,TotalFarmNumber,TransportationTypes) "The number of total trips for each farm on each day to move biomass from the farm to the regional market (includes direct movement from the harvest and movement from on-farm open and covered storage)"

  LocalMarketRGYTruckTripRequirement(SimulationHorizon,LocalMarketSet,RGYSet,TransportationTypes) "The number of total trips between each local market and each RGY facility to move grains on a daily basis"
  RegionalMarketRGYTruckTripRequirement(SimulationHorizon,RegionalMarketSet,RGYSet,TransportationTypes) "The number of total trips between each regional market and each RGY facility to move grains on a daily basis"
  RegionalMarketFCITruckTripRequirement(SimulationHorizon,RegionalMarketSet,FCIGodownSet,TransportationTypes) "The number of total trips between each regional market and each FCI facility to move grains on a daily basis"

  RGYMillerTruckTripRequirement(SimulationHorizon,RGYSet,MillerSet,TransportationTypes) "The number of total trips between each RGY facility and each miller to move grains on a daily basis"
  RGYRetailerTruckTripRequirement(SimulationHorizon,RGYSet,RetailerSet,TransportationTypes) "The number of total trips between each RGY facility and each retailer to move grains on a daily basis"

  MillerRetailerTruckTripRequirement(SimulationHorizon,MillerSet,RetailerSet,TransportationTypes) "The number of total trips between each RGY facility and each retailer to move grains on a daily basis"

  FCIMillerTruckTripRequirement(SimulationHorizon,FCIGodownSet,MillerSet,TransportationTypes) "The number of total trips between each RGY facility and each miller to move grains on a daily basis"
  FCIRetailerTruckTripRequirement(SimulationHorizon,FCIGodownSet,RetailerSet,TransportationTypes) "The number of total trips between each RGY facility and each retailer to move grains on a daily basis"
  FCIPDSTruckTripRequirement(SimulationHorizon,FCIGodownSet,PDSSet,TransportationTypes) "The number of total trips between each RGY facility and each miller to move grains on a daily basis"
  ;

Integer variables
  FarmLocalCSPTruckRequirement(SimulationHorizon,DistrictSelected,TotalFarmNumber,LocalCSPCenterSet,TransportationTypes) "The number of total trucks for each farm on each day to move grains from the farm to each local CSP location"
  FarmRegionalCSPTruckRequirement(SimulationHorizon,DistrictSelected,TotalFarmNumber,RegionalCSPCenterSet,TransportationTypes) "The number of total trucks for each farm on each day to move grains from the farm to each Regional CSP location"

  FarmLocalMarketTruckRequirement(SimulationHorizon,DistrictSelected,TotalFarmNumber,LocalMarketSet,TransportationTypes) "The number of total trucks for each farm on each day to move grains from the farm to each local market location"
  FarmRegionalMarketTruckRequirement(SimulationHorizon,DistrictSelected,TotalFarmNumber,RegionalMarketSet,TransportationTypes) "The number of total trucks for each farm on each day to move grains from the farm to each Regional market location"

  LocalCSPLocalMarketTruckRequirement(SimulationHorizon,LocalCSPCenterSet,LocalMarketSet,TransportationTypes) "The number of total trucks between each local CSP and local market to move grains on a daily basis"
  LocalCSPRegionalMarketTruckRequirement(SimulationHorizon,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes) "The number of total trucks between each local CSP and regional market to move grains on a daily basis"

  RegionalCSPLocalMarketTruckRequirement(SimulationHorizon,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes) "The number of total trucks between each regional CSP and local market to move grains on a daily basis"
  RegionalCSPRegionalMarketTruckRequirement(SimulationHorizon,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes) "The number of total trucks between each regional CSP and regional market to move grains on a daily basis"

  FarmDirectPurchaseTruckRequirement(SimulationHorizon,DistrictSelected,TotalFarmNumber,TransportationTypes) "The number of total trucks for each farm on each day to move biomass from the farm to the regional market (includes direct movement from the harvest and movement from on-farm open and covered storage)"

  LocalMarketRGYTruckRequirement(SimulationHorizon,LocalMarketSet,RGYSet,TransportationTypes) "The number of total trips between each local market and each RGY facility to move grains on a daily basis"
  RegionalMarketRGYTruckRequirement(SimulationHorizon,RegionalMarketSet,RGYSet,TransportationTypes) "The number of total trips between each regional market and each RGY facility to move grains on a daily basis"
  RegionalMarketFCITruckRequirement(SimulationHorizon,RegionalMarketSet,FCIGodownSet,TransportationTypes) "The number of total trips between each regional market and each FCI facility to move grains on a daily basis"

  RGYMillerTruckRequirement(SimulationHorizon,RGYSet,MillerSet,TransportationTypes) "The number of total trips between each RGY facility and each miller to move grains on a daily basis"
  RGYRetailerTruckRequirement(SimulationHorizon,RGYSet,RetailerSet,TransportationTypes) "The number of total trips between each RGY facility and each retailer to move grains on a daily basis"

  MillerRetailerTruckRequirement(SimulationHorizon,MillerSet,RetailerSet,TransportationTypes) "The number of total trucks between each RGY facility and each retailer to move grains on a daily basis"

  FCIMillerTruckRequirement(SimulationHorizon,FCIGodownSet,MillerSet,TransportationTypes) "The number of total trips between each RGY facility and each miller to move grains on a daily basis"
  FCIRetailerTruckRequirement(SimulationHorizon,FCIGodownSet,RetailerSet,TransportationTypes) "The number of total trips between each RGY facility and each retailer to move grains on a daily basis"
  FCIPDSTruckRequirement(SimulationHorizon,FCIGodownSet,PDSSet,TransportationTypes) "The number of total trips between each RGY facility and each miller to move grains on a daily basis"

  TransportationFleetSize(TransportationTypes) "The optimized transportation fleet size bounded by MaximumTransportationFleetSize"
  ;

* PostCentralStorageProcessingBiomassForm The form of the biomass after processing at the centralized storage facility;
* Variables corresponding to gunny bags required for transportation. Ideally, these should be defined as integer variables, but they are defined
* as continuous variable for the sake of computatoinal simplicity.
*
Integer variables
  FarmLocalCSPGunnyBags(SimulationHorizon,DistrictSelected,TotalFarmNumber,LocalCSPCenterSet) "The number of gunny bags required to transport grains between given different locations"
  FarmRegionalCSPGunnyBags(SimulationHorizon,DistrictSelected,TotalFarmNumber,RegionalCSPCenterSet) "The number of gunny bags required to transport grains between given different locations"

  FarmLocalMarketGunnyBags(SimulationHorizon,DistrictSelected,TotalFarmNumber,LocalMarketSet) "The number of gunny bags required to transport grains between given different locations"
  FarmRegionalMarketGunnyBags(SimulationHorizon,DistrictSelected,TotalFarmNumber,RegionalMarketSet) "The number of gunny bags required to transport grains between given different locations"

  LocalCSPLocalMarketGunnyBags(SimulationHorizon,LocalCSPCenterSet,LocalMarketSet) "The number of gunny bags required to transport grains between given different locations"
  LocalCSPRegionalMarketGunnyBags(SimulationHorizon,LocalCSPCenterSet,RegionalMarketSet) "The number of gunny bags required to transport grains between given different locations"

  RegionalCSPLocalMarketGunnyBags(SimulationHorizon,RegionalCSPCenterSet,LocalMarketSet) "The number of gunny bags required to transport grains between given different locations"
  RegionalCSPRegionalMarketGunnyBags(SimulationHorizon,RegionalCSPCenterSet,RegionalMarketSet) "The number of gunny bags required to transport grains between given different locations"

  FarmDirectPurchaseGunnyBags(SimulationHorizon,DistrictSelected,TotalFarmNumber) "The number of gunny bags required to transport grains between given different locations"
  ;

*=======================================================================================
* Declaration of the bounds (if any) on the variables declared above
*=======================================================================================
FarmLocalCSPTruckTripRequirement.up(SimulationHorizon,DistrictSelected,TotalFarmNumber,LocalCSPCenterSet,TransportationTypes) = MaximumTransportationFleetSize;
FarmRegionalCSPTruckTripRequirement.up(SimulationHorizon,DistrictSelected,TotalFarmNumber,RegionalCSPCenterSet,TransportationTypes) = MaximumTransportationFleetSize;
FarmLocalMarketTruckTripRequirement.up(SimulationHorizon,DistrictSelected,TotalFarmNumber,LocalMarketSet,TransportationTypes) = MaximumTransportationFleetSize;
FarmRegionalMarketTruckTripRequirement.up(SimulationHorizon,DistrictSelected,TotalFarmNumber,RegionalMarketSet,TransportationTypes) = MaximumTransportationFleetSize;
LocalCSPLocalMarketTruckTripRequirement.up(SimulationHorizon,LocalCSPCenterSet,LocalMarketSet,TransportationTypes) = MaximumTransportationFleetSize;
LocalCSPRegionalMarketTruckTripRequirement.up(SimulationHorizon,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes) = MaximumTransportationFleetSize;
RegionalCSPLocalMarketTruckTripRequirement.up(SimulationHorizon,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes) = MaximumTransportationFleetSize;
RegionalCSPRegionalMarketTruckTripRequirement.up(SimulationHorizon,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes) = MaximumTransportationFleetSize;
FarmDirectPurchaseTruckTripRequirement.up(SimulationHorizon,DistrictSelected,TotalFarmNumber,TransportationTypes) = MaximumTransportationFleetSize;

FarmLocalCSPTruckRequirement.up(SimulationHorizon,DistrictSelected,TotalFarmNumber,LocalCSPCenterSet,TransportationTypes) = MaximumTransportationFleetSize;
FarmRegionalCSPTruckRequirement.up(SimulationHorizon,DistrictSelected,TotalFarmNumber,RegionalCSPCenterSet,TransportationTypes) = MaximumTransportationFleetSize;
FarmLocalMarketTruckRequirement.up(SimulationHorizon,DistrictSelected,TotalFarmNumber,LocalMarketSet,TransportationTypes) = MaximumTransportationFleetSize;
FarmRegionalMarketTruckRequirement.up(SimulationHorizon,DistrictSelected,TotalFarmNumber,RegionalMarketSet,TransportationTypes) = MaximumTransportationFleetSize;
LocalCSPLocalMarketTruckRequirement.up(SimulationHorizon,LocalCSPCenterSet,LocalMarketSet,TransportationTypes) = MaximumTransportationFleetSize;
LocalCSPRegionalMarketTruckRequirement.up(SimulationHorizon,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes) = MaximumTransportationFleetSize;
RegionalCSPLocalMarketTruckRequirement.up(SimulationHorizon,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes) = MaximumTransportationFleetSize;
RegionalCSPRegionalMarketTruckRequirement.up(SimulationHorizon,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes) = MaximumTransportationFleetSize;
FarmDirectPurchaseTruckRequirement.up(SimulationHorizon,DistrictSelected,TotalFarmNumber,TransportationTypes) = MaximumTransportationFleetSize;
LocalMarketRGYTruckRequirement.up(SimulationHorizon,LocalMarketSet,RGYSet,TransportationTypes) = MaximumTransportationFleetSize;
RegionalMarketRGYTruckRequirement.up(SimulationHorizon,RegionalMarketSet,RGYSet,TransportationTypes) = MaximumTransportationFleetSize;
RegionalMarketFCITruckRequirement.up(SimulationHorizon,RegionalMarketSet,FCIGodownSet,TransportationTypes) = MaximumTransportationFleetSize;
RGYMillerTruckRequirement.up(SimulationHorizon,RGYSet,MillerSet,TransportationTypes) = MaximumTransportationFleetSize;
RGYRetailerTruckRequirement.up(SimulationHorizon,RGYSet,RetailerSet,TransportationTypes) = MaximumTransportationFleetSize;
MillerRetailerTruckRequirement.up(SimulationHorizon,MillerSet,RetailerSet,TransportationTypes)= MaximumTransportationFleetSize;
FCIMillerTruckRequirement.up(SimulationHorizon,FCIGodownSet,MillerSet,TransportationTypes) = MaximumTransportationFleetSize;
FCIRetailerTruckRequirement.up(SimulationHorizon,FCIGodownSet,RetailerSet,TransportationTypes) = MaximumTransportationFleetSize;
FCIPDSTruckRequirement.up(SimulationHorizon,FCIGodownSet,PDSSet,TransportationTypes) = MaximumTransportationFleetSize;

TransportationFleetSize.up(TransportationTypes)=MaximumTransportationFleetSize;

FarmLocalCSPGunnyBags.up(SimulationHorizon,DistrictSelected,TotalFarmNumber,LocalCSPCenterSet) = 1000;
FarmRegionalCSPGunnyBags.up(SimulationHorizon,DistrictSelected,TotalFarmNumber,RegionalCSPCenterSet) = 1000;
FarmLocalMarketGunnyBags.up(SimulationHorizon,DistrictSelected,TotalFarmNumber,LocalMarketSet) = 1000;
FarmRegionalMarketGunnyBags.up(SimulationHorizon,DistrictSelected,TotalFarmNumber,RegionalMarketSet) = 1000;
LocalCSPLocalMarketGunnyBags.up(SimulationHorizon,LocalCSPCenterSet,LocalMarketSet) = 1000;
LocalCSPRegionalMarketGunnyBags.up(SimulationHorizon,LocalCSPCenterSet,RegionalMarketSet) = 1000;
RegionalCSPLocalMarketGunnyBags.up(SimulationHorizon,RegionalCSPCenterSet,LocalMarketSet) = 1000;
RegionalCSPRegionalMarketGunnyBags.up(SimulationHorizon,RegionalCSPCenterSet,RegionalMarketSet) = 1000;
FarmDirectPurchaseGunnyBags.up(SimulationHorizon,DistrictSelected,TotalFarmNumber) = 1000;

*#############################################################################################################################
* Variables declaration for cost calculation
*#############################################################################################################################
Positive variables
  TransportationOperatingCost "Total operating cost of transportation during the harvesting as well as non-harvesting horizon"
  TransportationFixedCost "Total capital (fixed) cost of transportation"
  TransportationTruckCharge "The dummy variable that is used as a penalty to ensure that the required number of trucks are reported"

  FarmLocalCSPTransportationOperatingCost "Total operating cost of transportation during the harvesting as well as non-harvesting horizon"
  FarmRegionalCSPTransportationOperatingCost "Total operating cost of transportation during the harvesting as well as non-harvesting horizon"
  FarmLocalMarketTransportationOperatingCost "Total operating cost of transportation during the harvesting as well as non-harvesting horizon"
  FarmRegionalMarketTransportationOperatingCost "Total operating cost of transportation during the harvesting as well as non-harvesting horizon"
  LocalCSPLocalMarketTransportationOperatingCost "Total operating cost of transportation during the harvesting as well as non-harvesting horizon"
  RegionalCSPLocalMarketTransportationOperatingCost "Total operating cost of transportation during the harvesting as well as non-harvesting horizon"
  LocalCSPRegionalMarketTransportationOperatingCost "Total operating cost of transportation during the harvesting as well as non-harvesting horizon"
  RegionalCSPRegionalMarketTransportationOperatingCost "Total operating cost of transportation during the harvesting as well as non-harvesting horizon"
  LocalMarketRGYTransportationOperatingCost "Total operating cost of transportation during the harvesting as well as non-harvesting horizon"
  RegionalMarketRGYTransportationOperatingCost "Total operating cost of transportation during the harvesting as well as non-harvesting horizon"
  RegionalMarketFCITransportationOperatingCost "Total operating cost of transportation during the harvesting as well as non-harvesting horizon"
  RGYMillerTransportationOperatingCost "Total operating cost of transportation during the harvesting as well as non-harvesting horizon"
  RGYRetailerTransportationOperatingCost
  FCIMillerTransportationOperatingCost
  FCIRetailerTransportationOperatingCost
  FCIPDSTransportationOperatingCost
  MillerRetailerTransportationOperatingCost

  StorageCapitalCost "The capital cost of storage which includes the cost of land and the cost of building the structure and is a function of the storage area"
  TotalStorageCost "Total cost of biomass storage (including basic cost and drying cost)"

  LocalCSPCapitalCost "The capital cost of storage at local CSP which includes the cost of land and the cost of building the structure and is a function of the storage area"
  RegionalCSPCapitalCost "The capital cost of storage at regional CSP which includes the cost of land and the cost of building the structure and is a function of the storage area"
  LocalCSPStorageOperatingCost "The cost of storage at local CSP based on the total amount of material stored when the cost rate is given"
  RegionalCSPStorageOperatingCost "The cost of storage at regional CSP based on the total amount of material stored when the cost rate is given"

  RGYCapitalCost "The capital cost of builing an RGY"
  RGYRentalCost "The cost of storage of grains in RGY"
  ProvisionGrainHandlingCost "Total cost of the handling of grain related to transportation activites"
  BagCost "The total cost of bagging the grains for storage and transportation purpose"

  MillerFixedCost "The fixed cost of a miller"
  MillerOperatingCost "The operating cost of a miller"
  MillerStorageCost "The total storge cost of the miller"
  TotalMillerCost "the total cost of the miller"

  FCIStorageCost "The total cost incurred by FCI for storing the grain"
  FCIMandiCost "The total cost incurred by FCI while purchasing the grain at the Mandi (Regional Market) which includes Lab. & Transpt. charges Mandi Labour Forwarding Charges and Internal Movt."

  BagCost "The total cost of bagging the grains for storage and transportation purpose"

  TotalFarmIncome "The total income of farmers by selling grains"
  ;

Variable
  DummyCost "A dummy variable that is included in the cost function to ensure that proper numbers of variables in the solution are reported that do not have any cost component in the objective function (such as the godown capacity of an already existing FCI godown)"
  ;
