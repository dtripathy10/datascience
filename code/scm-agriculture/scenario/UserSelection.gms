$title This file is used when the user wants to simulate/optimize for a given collection area
*
* The collection area can be defined in terms of counties or just the total area.
* For counties, the data will be stored in the database and that data will be used.
* If general area is selected, then the area value is taken from the user and the problem decides the number of farms and farm size
* using general sampling approach (this can again be a function of which region it is).
*
*##############################################################################################################
* Set Declaration
*##############################################################################################################

Sets
*         TotalFarmNumber
* This is an upper bound on the total number of farms that can be included in the problem solution (arbirtraty: Good enough to accomodate the selected area)
         FarmBasicAttributes /FarmSize, RefineryDistance/;

*##############################################################################################################
* Parameter Declaration: Selection of the case study location (importing data from the pre-defined excel file)
*##############################################################################################################
Parameter
          FarmData Farm data such as size and distance from the refinery and storage unit that is used for problem solution
          FarmDistanceData Distance between different farms and the various storage locations (centralized storage locations)
          StorageDistanceData The distance between different storage locations and the refinery
          CountyStorageLocationCorrelation The correlation parameter that indicates possible links between farms at a particular county and a particular storage location
          FarmStorageLocationCorrelation The correlation parameter that indicates possible links between farms and a particular storage location
          CentralStorageRefineryTransportationIndicator Parameter indicating whether transportation trucks are required between a particular central storage location and the refinery;


Parameter CountyFarmSizeInformation The information related to farm sizes for different counties
          FarmRefineryDistance The information related to distance between farms from different counties and the refinery
          FarmStorageDistance The information related to distance between farms from different counties and a specific storage location
          FarmHarvestStartDayUserInput The pre-defined list of harvesting start dates for every farm in the given counties
          StorageDistanceInformation The information related to the distance between various storage locations and the refinery
          CountyFarmInformation The information related to farms for different counties (such as land utilization factor and total number of farms)
          CountyFarmInformationSelected The data for counties that are selected for analysis;


Parameter
          TotalFarmArea Total area of actual farms supplying biomass to the biorefinery in square km
          AverageLandUtilizationFactor The average land utilization factor for the selected areas (counties or general area)
          BiorefineryCapacityTarget The targeted biorefinery capacity in dry tons per day input by the user
          LocalMarketDemandTarget
          RegionalMarketDemandTarget
          OnFarmPurchaseDemandTarget
          TotalCollectionArea Total area of biomass collection in square km which is a function of TotalFarmArea and land utilization factor
          CollectionDistanceMinimum Minimum distance for biomass collection in km /5/
          CollectionDistanceMaximum Maximum distance for biomass collection in km
          CollectionDistanceMean Mean distance of biomass collection
          CollectionDistanceStd Standard deviation of biomass collection distance for sampling
          RoadWindingFactor Constant correlating the travelled distance to shortest distance between two points /1.2/
          AverageFarmSize The farm size distribution for a typical farming area in square kilometeres /Class-1 0.5, Class-2 2.0, Class-3 4.0, Class-4 12.0/
* The data is an approximation of the information given in USDA as well as Illinois farm data available on the Illinois.gov website
          FarmSizeFraction The fractional distribution of the farm land among various farm sizes (must sum to 1) /Class-1 0.05, Class-2 0.25, Class-3 0.25, Class-4 0.45/
Parameter
          StorageDistanceMinimum The minimum distance between the storage facility and refinery in km /10/
          StorageDistanceMaximum The maximum distance between the storage facility and refinery in km /30/;


Parameter
          CountySelection Parameter that indicates whether the user has selected to solve the problem for a particular county
          AreaSelection Parameter that indicates whether the user has selected to solve the problem for a collection area in square kilometers
          BiorefineryCapacitySelection Parameter that indicates whether the user has selected to solve the problem for a specific biorefinery capacity
          UserEquipmentSelection The parameter that indicates whether all equipment for each of the farms are pre-selected (possibly as a solution of another problem)
          CumulativeFarmNumber The total number of farms for all the selected counties (when the analysis is done for counties will data availability)
          CentralStorageProcessing The binary parameter that indicates wether the centralized storage facility has a processing option (such as size reduction and packing)
          CentralStorageProcessingMandatory The binary parameter that indicates wether the centralized storage processing is mandatory for the farms
          CentralStorageInputProcessing The binary parameter that indicates whether the biomass processing at the central storage is carried out at the input of the storage
          CentralStorageOutputProcessing The binary parameter that indicates whether the biomass processing at the central storage is carried out at the output of the storage
          CentralStorageProcessingSelection(StorageProcessorTypes) The binary parameter that indicates which processing option is selected at the centralized storage facility
          CentralStorageRefineryRailTransport The binary parameter that indicates where there is rail transport of biomass from central storage to the refinery
          CropSelection(CropOptions) The parameter that decides which crop is being modeled
          BiomassStorageTimeLimitSelector The binary parameter that indicates whether there is a time limit to be enforced on biomass processing after harvesting (used to model Type I Energy Cane scenario with high sugar content);


*##############################################################################################################
* Parameter Declaration related to user selection
*##############################################################################################################

*
* Parameter selection related to type of problem solution (single vs multi-objective)
*
Parameter
         SingleObjectiveProblem  Binary selection parameter that indicates whether a singleobjective problem is to be solved
         MultiObjectiveProblem  Binary selection parameter that indicates whether a multi-eobjective problem is to be solved
         CostObjectiveWeight The weight on the cost objective function for the multi-objective optimization problem
         EnergyObjectiveWeight The weight on the energy consumption objective function for the multi-objective optimization problem;

*
* Selecting the user preference over the optimization of the harvesting schedule and machine selection
*
Parameters

         HarvestingScheduleOptimize The parameter that indicates whether the user wants to optimize the harvesting schedule
         HarvestingScheduleFixed The parameter that indicates whether the user wants a fixed predefined harvesting scheduled to be used for the remaining BFP chain
         HarvestingScheduleProfile The parameter that indicates whether the user will give a harvesting progress distribution which is to be approximated by the model for further calculations
* Note: The HarvestingScheduleProfile can be 1 only if HarvestingScheduleFixed is 1. If HarvestingScheduleFixed is 1 and HarvestingScheduleProfile is 0
*       then that means the user will give the harvesting start dates for various farms and that will automatically fix the harvesting schedule.

         HarvesterMachinePredefined     The scalar parameter that indicates whether the number of harvesting machines are pre-defined by the user
         HarvesterMachineTypePredefined The scalar parameter that indicates whether the harvesting machine types are pre-defined by the user (the number is still decided by the optimizer)
         HarvesterTypePredefined        The binary parameter that indicates whether a particular harvesting machine (or type) must be used or must not be used for a farm
         NumberOfHarvestersPredefined    The number of predefined harvesting machines for each farm

         HarvestStartDateUserInputIndicator The binary parameter that indicates whether the harvesting start dates for each farm are being user input;

Scalar HarvestIndicator;

*
* Parameter selection for a specific packing option such as baling, pelletizing or grinding
*
Parameter
         PackingOptionSelection The scalar parameter indicating whether the user has selected a particular packing operation
         PackingOption The scalar parameter that defines the type of packing operation selected by the user;

*
* Parameter selection related to baling machines
*
Parameters
         RakingMachinePredefined         Scalar parameter that indicates whether the raking machine selection is pre-defined by the user
         RakingMachineTypePredefined     Scalar parameter that indicates whether the raking machine type selection is pre-defined by the user (this means that the number is still decided by the optimizer)
         NumberOfRakesPredefined               The number of raking maching of each type for each farm selected by the user
         RakeTypePredefined                    The binary parameter indicating which raking machine is to be selected (the number is still a variable);

*
* Parameter selection related to baling machines
*
Parameters
         BalingMachinePredefined         Scalar parameter that indicates whether the baling machine selection is pre-defined by the user
         BalingMachineTypePredefined     Scalar parameter that indicates whether the baling machine type selection is pre-defined by the user (this means that the number is still decided by the optimizer)
         NumberOfBalersPredefined               The number of baling maching of each type for each farm selected by the user
         BalerTypePredefined                    The binary parameter indicating which baling machine is to be selected (the number is still a variable);

*
* Parameter selection related to chopping machines
*
Parameters
         ChoppingMachinePredefined         Scalar parameter that indicates whether the Chopping machine selection is pre-defined by the user
         ChoppingMachineTypePredefined     Scalar parameter that indicates whether the Chopping machine type selection is pre-defined by the user (this means that the number is still decided by the optimizer)
         NumberOfChoppersPredefined               The number of Chopping maching of each type for each farm selected by the user
         ChopperTypePredefined                    The binary parameter indicating which Chopping machine is to be selected (the number is still a variable);

*
* Parameter selection related to pelletizing machines
*
Parameters
         PelletizingMachinePredefined         Scalar parameter that indicates whether the pelletizing machine selection is pre-defined by the user
         PelletizingMachineTypePredefined     Scalar parameter that indicates whether the pelletizing machine type selection is pre-defined by the user (this means that the number is still decided by the optimizer)
         NumberOfPelletizersPredefined               The number of pelletizing maching of each type for each farm selected by the user
         PelletizerTypePredefined                    The binary parameter indicating which pelletizing machine is to be selected (the number is still a variable);

*
* Parameter selection related to grinding machines
*
Parameters
         GrindingMachinePredefined         Scalar parameter that indicates whether the grinding machine selection is pre-defined by the user
         GrindingMachineTypePredefined     Scalar parameter that indicates whether the grinding machine type selection is pre-defined by the user (this means that the number is still decided by the optimizer)
         NumberOfGrindersPredefined               The number of grinding maching of each type for each farm selected by the user
         GrinderTypePredefined                    The binary parameter indicating which grinding machine is to be selected (the number is still a variable);

*
* Parameter selection related to biomass hanlding operations
*
Parameters
         LoaderMachineTypePredefined  Scalar parameter indicating the selection of a type of loading machine by the user
         LoaderMachinePredefined Scalar parameter indicating the selection of the type and number of loading machines by the user
         LoaderTypeSelection The binary parameter indicating which type of loader is selected by the user
         LoaderMachineSelection The number of loading machines of a particular type selected by the user;


*
* Parameter selection related to infield transportation equipment selection
*
Parameters
         InFieldTransportTypePredefined  Scalar parameter indicating the selection of a type of infield transportation equipment by the user
         InFieldTransportPredefined Scalar parameter indicating the selection of the type and number of infield transportation equipment by the user
         InFieldTransportTypeSelection The binary parameter indicating which type of infield transportation equipment is selected by the user
         InFieldTransportSelection The number of infield transportation equipment of a particular type selected by the user;

*
* Parameter selection related to biomass storage options
*
Parameters
         OnFarmOpenStorageSelection Scalar parameter indicating whether on-farm open air storage is allowed
         OnFarmCoveredStorageSelection Scalar parameter indicating whether on-farm covered storage is allowed
         EnsilingSelection Scalar parameter indicating whether on-farm ensiling is allowed
         CentralizedStorageSelection Scalar parameter indicating whether centralized storage is allowed

         CentralStorageMethodSelection(StorageTypes) The scalar parameter indicating which storage method is to be used for centralized storage facility
         CoveredStorageMethodSelection(StorageTypes) The scalar parameter indicating which storage method is to be used for on-farm covered storage
         OpenStorageMethodSelection(StorageTypes) The scalar parameter indicating which storage method is to be used for on-farm covered storage
         EnsilingMethodSelection(StorageTypes) The scalar parameter indicating which storage method is to be used for on-farm ensiling

         FarmOpenStorageSizeSelection Scalar parameter that indicates whether the farm open storage size has been selected for a given farm
         FarmCoveredStorageSizeSelection  Scalar parameter that indicates whether the farm covered storage size has been selected for a given farm

         FarmOpenStorageSizePredefined The actual size of the farm open storage in square meters that is pre-selected for model simulation
         FarmCoveredStorageSizePredefined  The actual size of the farm covered storage in square meters that is pre-selected for model simulation

         CentralizedStorageSizePredefined Scalar parameter indicating that the centralized storage size has been pre-defined
         CentralizedStorageSize The actual size of the central storage facility as input by the user

         CentralizedStorageSmallScaleSizePredefined
         CentralizedStorageSmallScaleSize The actual size of the small scale storage facility as input by the user;

*
* Parameter selection related to transportation
*
Parameter
          TransportationDistanceSelection The parameter that indicates whether the transportation distance is given as a part of the input data or whether the distance it to be calculate using the sampling strategy
* The value is 1 if the distances are given and zero if the distances are to be calculated
         TransportationEquipmentPredefined       Scalar parameter that indicates whether the transportation equipment is pre-defined by the user
         TransportationEquipmentSelection        The scalar parameter that indicates (restricts) which type of transportation equipment can be picked by the optimization problem

         TransportationEquipmentNumberPredefined
         TransportationEquipmentNumber;



scalar i Dummy scalar parameter for loop assignements
       j Dummy scalar parameter for loop assignements
       k Dummy scalar parameter for loop assignements;


Parameter SolveCountyProblem;
*
* Importing the user selections through the input file
*
$include UserInputDefault.inc
*$include UserInput.inc

*
* Based on the user defined selection of which problem to solve, the appropriate data importing operation is included or skipped.
*
$if "%CountySelectionScenario%" == "no" $goto skipcountyselection
$include CountySelectionFile
$label skipcountyselection

*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
* If the user selects to solve the problem for a particular area:
* Asking the user to give the collection area
* Data processing for that collection area to get it ready for optimization problem solution
*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

$if "%AreaSelectionScenario%" == "no" $goto skipareaselection
$batinclude CollectionAreaSelectionFile  AreaSelection
$label skipareaselection

*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
* Part of the code used to include pre-defined equipment selection for individual farms
*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Parameter
         HarvesterSelectionDecision(TotalFarmNumber)
         RakeSelectionDecision(TotalFarmNumber)
         BalerSelectionDecision(TotalFarmNumber)
         GrinderSelectionDecision(TotalFarmNumber)
         ChopperSelectionDecision(TotalFarmNumber)
         PelletizerSelectionDecision(TotalFarmNumber)
         LoaderSelectionDecision(TotalFarmNumber)
         InfieldTransportationSelectionDecision(TotalFarmNumber)
         FarmOpenStorageDecision(TotalFarmNumber)
         FarmCoveredStorageDecision(TotalFarmNumber);
*
* Initializing the equipment selection decision parameters to zero (reflecting no selection).
* These parameters are lated modified IF the user has selected to do so through the gms file that is accessed below.
*
HarvesterSelectionDecision(FarmNumber) = 0;
RakeSelectionDecision(FarmNumber) = 0;
BalerSelectionDecision(FarmNumber) = 0;
GrinderSelectionDecision(FarmNumber) = 0;
ChopperSelectionDecision(FarmNumber) = 0;
PelletizerSelectionDecision(FarmNumber) = 0;
LoaderSelectionDecision(FarmNumber) = 0;
InfieldTransportationSelectionDecision(FarmNumber) = 0;
FarmOpenStorageDecision(FarmNumber) = 0;
FarmCoveredStorageDecision(FarmNumber) = 0;

HarvesterMachineTypePredefined = 0;
HarvesterMachinePredefined = 0;
RakingMachineTypePredefined = 0;
RakingMachinePredefined = 0;
BalingMachineTypePredefined = 0;
BalingMachinePredefined =0;
ChoppingMachineTypePredefined = 0;
ChoppingMachinePredefined =0;
PelletizingMachineTypePredefined = 0;
PelletizingMachinePredefined =0;
GrindingMachineTypePredefined = 0;
GrindingMachinePredefined =0;
LoaderMachineTypePredefined = 0;
LoaderMachinePredefined = 0;
InFieldTransportTypePredefined = 0;
InFieldTransportPredefined = 0;
FarmOpenStorageSizeSelection = 0;
FarmCoveredStorageSizeSelection = 0;
TransportationEquipmentPredefined = 0;
TransportationEquipmentNumberPredefined =0;
CentralizedStorageSizePredefined = 0;
CentralizedStorageSmallScaleSizePredefined = 0;
NumberOfRakesPredefined(CountySelected,FarmNumber,RakeTypes)=0;
RakeTypePredefined(CountySelected,FarmNumber,RakeTypes)=0;

NumberOfBalersPredefined(CountySelected,FarmNumber,BalerTypes)=0;
BalerTypePredefined(CountySelected,FarmNumber,BalerTypes)=0;

NumberOfChoppersPredefined(CountySelected,FarmNumber,ChopperTypes) = 0;
ChopperTypePredefined(CountySelected,FarmNumber,ChopperTypes)=0;

NumberOfGrindersPredefined(CountySelected,FarmNumber,GrinderTypes) = 0;
GrinderTypePredefined(CountySelected,FarmNumber,GrinderTypes)=0;

NumberOfPelletizersPredefined(CountySelected,FarmNumber,PelletizerTypes) = 0;
PelletizerTypePredefined(CountySelected,FarmNumber,PelletizerTypes)=0;

LoaderMachineSelection(CountySelected,FarmNumber,LoaderTypes) = 0;
LoaderTypeSelection(CountySelected,FarmNumber,LoaderTypes)=0;

InFieldTransportSelection(CountySelected,FarmNumber,InfieldTransportationTypes) = 0;
InFieldTransportTypeSelection(CountySelected,FarmNumber,TransportationTypes)=0;

FarmOpenStorageSizePredefined(CountySelected,FarmNumber,StorageTypes) = 0;
FarmCoveredStorageSizePredefined(CountySelected,FarmNumber,StorageTypes) = 0;

TransportationEquipmentSelection(TransportationTypes) = 0;
TransportationEquipmentNumber(TransportationTypes) = 0;
CentralizedStorageSize(CentralizedStorageLocations) =  0;
CentralizedStorageSmallScaleSize(CentralizedStorageSmallScaleLocations) =  0;
$setglobal FarmSpecificEquipmentSelection  no

$if "%UserEquipmentSelection%" == "no" $goto skipUserEquipmentSelection
$batinclude PredefinedEquipment
$label skipUserEquipmentSelection

*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*
* Including the file that declares the connections between various operations (tasks)
*
$include TaskConnections.gms

