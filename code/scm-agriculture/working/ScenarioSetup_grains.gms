$title This file is used when the user wants to simulate/optimize for a given collection area
*
* The collection area can be defined in terms of countries or just the total area.
* For counties, the data will be stored in the database and that data will be used.
* If general area is selected, then the area value is taken from the user and the problem decides the number of farms and farm size
* using general sampling approach (this can again be a function of which region it is).
*

*#############################################################################################################
*** THIS FILE IS A MODIFICATION OF THE USER SELECTION FILE
*##############################################################################################################

*##############################################################################################################
* Set Declaration
*##############################################################################################################
* Adding the necessary sets for the grain problem here. These can be imported from a gdx file in a more efficient code. But that will be addressed later.
Sets
  LocalCSPCenterSet /LocalStorage-1/
  RegionalCSPCenterSet /RegionalStorage-1/
* Individual village market
  LocalMarketSet /LocalMarket-1/
* Mandis
  RegionalMarketSet /RegionalMarket-1/
* One RGY per district
  RGYSet /RGY-1, RGY-2/
*FCI godows
  FCIGodownSet /FCI-1*FCI-5/
* Miller locations
  MillerSet /M-1*M-10/
* Retailers
  RetailerSet /R-1*R-10/
* Ration shops
  PDSSet /PDS-1*PDS-5/
  FarmType /Marginal, Small, Semi_Medium, Medium, Large/
  ;


*##############################################################################################################
* Importing data pertaining to grain prices at different locations
*##############################################################################################################
Parameter  GrainPurchasePrice_Input, FarmSize_Input;
$CALL GDXXRW.EXE Grains_PricesAndDistances.xls Dset=GrainPurchasePriceSet rng=GrainPrice!B1:D1 Cdim=1 Dset=SimulationSteps rng=GrainPrice!A2:A361 Rdim=1 Par=GrainPurchasePrice_Input rng=GrainPrice!A1:D361 Dset=FarmArea rng=FarmData!B13 Cdim=1 Dset=TotalFarmNumber rng=FarmData!A14:A300 Rdim=1 Par=FarmSize_Input rng=FarmData!A13:B300;
$GDXIN Grains_PricesAndDistances.gdx

Set 
  GrainPurchasePriceSet(*)
  SimulationSteps(*)
  TotalFarmNumber(*)
  FarmArea(*)
  ;

$LOAD GrainPurchasePriceSet=GrainPurchasePriceSet
$LOAD SimulationSteps = SimulationSteps
$LOAD TotalFarmNumber = TotalFarmNumber
$LOAD FarmArea = FarmArea
$LOAD GrainPurchasePrice_Input
$LOAD FarmSize_Input
$GDXIN

alias(FarmNumber,TotalFarmNumber);

Display RegionalMarketSet;

*##############################################################################################################
* Declaring the parameters that impact which model is to be simulated (current or potential)
*##############################################################################################################
Parameter 
  CurrentScenario The parameter that indicates whether we are selecting the current wheat supply chain or not /1/
  FutureScenario The parameter that indicates whether we are selecting the future wheat supply chain or not /0/
  ;


*##############################################################################################################
* Declaration of parameters related to the distances
*##############################################################################################################
Parameter
  FarmSize(TotalFarmNumber) The farm size for the scenario in hectares
  FarmLocalCSPDistance(TotalFarmNumber,LocalCSPCenterSet)
  FarmRegionalCSPDistance(TotalFarmNumber,RegionalCSPCenterSet)
  FarmLocalMarketDistance(TotalFarmNumber,LocalMarketSet)
  FarmRegionalMarketDistance(TotalFarmNumber,RegionalMarketSet)
  LocalCSPLocalMarketDistance(LocalCSPCenterSet,LocalMarketSet)
  LocalCSPRegionalMarketDistance(LocalCSPCenterSet,RegionalMarketSet)
  RegionalCSPLocalMarketDistance(RegionalCSPCenterSet,LocalMarketSet)
  RegionalCSPRegionalMarketDistance(RegionalCSPCenterSet,RegionalMarketSet)
  LocalMarketRGYDistance(LocalMarketSet,RGYSet)
  RegionalMarketRGYDistance(RegionalMarketSet,RGYSet)
  RegionalMarketFCIDistance(RegionalMarketSet,FCIGodownSet)
  RGYMillerDistance(RGYSet,MillerSet)
  RGYRetailerDistance(RGYSet,RetailerSet)
  FCIMillerDistance(FCIGodownSet,MillerSet)
  FCIRetailerDistance(FCIGodownSet,RetailerSet)
  FCIPDSDistance(FCIGodownSet,PDSSet)
  MillerRetailerDistance(MillerSet,RetailerSet)

*
* The values of mean yield and standard deviation have been taken from Pramod Kumar (study number 109) (Table 2.1)
*
  AverageGrainYield The average grain yield in kg per ha /1823/
  GrainYieldStandardDev The standard deviation in the yield of grain in kg per ha /281.78/

  GrainProduction(TotalFarmNumber) The total grain production in kg for each farm as a function of the total area and average yield
  GrainAvailable(TotalFarmNumber) The total grain availability in kg on each farm
*
* The IIM Ahmadabad report has given the fraction of grain that is sold from each farm as a function of farm type (table 29). That information has been
* used here in this work
*
  FarmGrainFractionForSale(FarmType) The fraction of grain produced that is available for sale from a particular farm /Marginal 0.66, Small 0.84, Semi_Medium 0.81, Medium 0.86, Large 0.80/

  MinimumSupportPrice The MSP offered by FCI to buy grain /14/;

*
* Storing the input values of farm size in the desired parameter to be used in the model later. This is done to get rid of the
* additional set dimension of the parameter that is imported from the gdx file.
*
FarmSize(TotalFarmNumber) = FarmSize_Input(TotalFarmNumber,'FarmArea');
GrainProduction(TotalFarmNumber) = FarmSize(TotalFarmNumber)*normal(AverageGrainYield,GrainYieldStandardDev);

Scalar i;

loop(FarmNumber,
  if(FarmSize(FarmNumber)<1,
       GrainAvailable(FarmNumber) =  GrainProduction(FarmNumber)*FarmGrainFractionForSale('Marginal')
  )
  if(FarmSize(FarmNumber)>=1 and FarmSize(FarmNumber)<2,
       GrainAvailable(FarmNumber) =  GrainProduction(FarmNumber)*FarmGrainFractionForSale('Small')
  )
  if(FarmSize(FarmNumber)>=2 and FarmSize(FarmNumber)<4,
       GrainAvailable(FarmNumber) =  GrainProduction(FarmNumber)*FarmGrainFractionForSale('Semi_Medium')
  )
  if(FarmSize(FarmNumber)>=4 and FarmSize(FarmNumber)<10,
       GrainAvailable(FarmNumber) =  GrainProduction(FarmNumber)*FarmGrainFractionForSale('Medium')
  )
  if(FarmSize(FarmNumber)>=10,
       GrainAvailable(FarmNumber) =  GrainProduction(FarmNumber)*FarmGrainFractionForSale('Large')
  )
);


Display GrainPurchasePrice_Input, FarmSize, GrainProduction, GrainAvailable;

*##############################################################################################################
* Calculating the distances needed to run the code. These distances can later be imported from a gdx file for more
* efficient execution of the code.
*##############################################################################################################

FarmLocalCSPDistance(TotalFarmNumber,LocalCSPCenterSet)=normal(25,5);
FarmRegionalCSPDistance(TotalFarmNumber,RegionalCSPCenterSet)=normal(40,8);
FarmLocalMarketDistance(TotalFarmNumber,LocalMarketSet)=normal(30,5);
FarmRegionalMarketDistance(TotalFarmNumber,RegionalMarketSet)=normal(50,8);
LocalCSPLocalMarketDistance(LocalCSPCenterSet,LocalMarketSet)=uniform(20,30);
LocalCSPRegionalMarketDistance(LocalCSPCenterSet,RegionalMarketSet)=uniform(20,30);
RegionalCSPLocalMarketDistance(RegionalCSPCenterSet,LocalMarketSet)=uniform(20,30);
RegionalCSPRegionalMarketDistance(RegionalCSPCenterSet,RegionalMarketSet)=uniform(20,30);
LocalMarketRGYDistance(LocalMarketSet,RGYSet)=normal(30,5);
RegionalMarketRGYDistance(RegionalMarketSet,RGYSet)=normal(50,8);
RegionalMarketFCIDistance(RegionalMarketSet,FCIGodownSet)=normal(50,8);
RGYMillerDistance(RGYSet,MillerSet)=normal(70,8);
RGYRetailerDistance(RGYSet,RetailerSet)=normal(70,8);
FCIMillerDistance(FCIGodownSet,MillerSet)=normal(50,8);
FCIRetailerDistance(FCIGodownSet,RetailerSet)=normal(50,8);
FCIPDSDistance(FCIGodownSet,PDSSet) =normal(50,8);
MillerRetailerDistance(MillerSet,RetailerSet) =normal(50,8);

Display FarmLocalCSPDistance,FarmRegionalCSPDistance,FarmLocalMarketDistance,FarmRegionalMarketDistance,LocalCSPLocalMarketDistance,
LocalCSPRegionalMarketDistance, RegionalCSPLocalMarketDistance, RegionalCSPRegionalMarketDistance;

Parameter
  FarmLocalCSPDrivingTime
  FarmRegionalCSPDrivingTime
  FarmLocalMarketDrivingTime
  FarmRegionalMarketDrivingTime
  LocalCSPLocalMarketDrivingTime
  LocalCSPRegionalMarketDrivingTime
  RegionalCSPLocalMarketDrivingTime
  RegionalCSPRegionalMarketDrivingTime

  LocalMarketRGYDrivingTime
  RegionalMarketRGYDrivingTime
  RegionalMarketFCIDrivingTime
  RGYMillerDrivingTime
  RGYRetailerDrivingTime
  FCIMillerDrivingTime
  FCIRetailerDrivingTime
  FCIPDSDrivingTime
  MillerRetailerDrivingTime

  FarmLocalCSPTransportationTime
  FarmRegionalCSPTransportationTime
  FarmLocalMarketTransportationTime
  FarmRegionalMarketTransportationTime
  LocalCSPLocalMarketTransportationTime
  LocalCSPRegionalMarketTransportationTime
  RegionalCSPLocalMarketTransportationTime
  RegionalCSPRegionalMarketTransportationTime

  LocalMarketRGYTransportationTime
  RegionalMarketRGYTransportationTime
  RegionalMarketFCITransportationTime
  RGYMillerTransportationTime
  RGYRetailerTransportationTime
  FCIMillerTransportationTime
  FCIRetailerTransportationTime
  FCIPDSTransportationTime
  MillerRetailerTransportationTime

  TruckIdlingTimePerTrip Idling time of a truck per trip for loading and unloading;
  ;


FarmLocalCSPDrivingTime(FarmNumber,LocalCSPCenterSet,TransportationTypes) =
                 FarmLocalCSPDistance(FarmNumber,LocalCSPCenterSet)/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 FarmLocalCSPDistance(FarmNumber,LocalCSPCenterSet)/TransportationData('SpeedEmpty',TransportationTypes);

FarmRegionalCSPDrivingTime(FarmNumber,RegionalCSPCenterSet,TransportationTypes) =
                 FarmRegionalCSPDistance(FarmNumber,RegionalCSPCenterSet)/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 FarmRegionalCSPDistance(FarmNumber,RegionalCSPCenterSet)/TransportationData('SpeedEmpty',TransportationTypes);

FarmLocalMarketDrivingTime(FarmNumber,LocalMarketSet,TransportationTypes) =
                 FarmLocalMarketDistance(FarmNumber,LocalMarketSet)/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 FarmLocalMarketDistance(FarmNumber,LocalMarketSet)/TransportationData('SpeedEmpty',TransportationTypes);

FarmRegionalMarketDrivingTime(FarmNumber,RegionalMarketSet,TransportationTypes) =
                 FarmRegionalMarketDistance(FarmNumber,RegionalMarketSet)/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 FarmRegionalMarketDistance(FarmNumber,RegionalMarketSet)/TransportationData('SpeedEmpty',TransportationTypes);

LocalCSPLocalMarketDrivingTime(LocalCSPCenterSet,LocalMarketSet,TransportationTypes) =
                 LocalCSPLocalMarketDistance(LocalCSPCenterSet,LocalMarketSet)/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 LocalCSPLocalMarketDistance(LocalCSPCenterSet,LocalMarketSet)/TransportationData('SpeedEmpty',TransportationTypes);

LocalCSPRegionalMarketDrivingTime(LocalCSPCenterSet,RegionalMarketSet,TransportationTypes) =
                 LocalCSPRegionalMarketDistance(LocalCSPCenterSet,RegionalMarketSet)/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 LocalCSPRegionalMarketDistance(LocalCSPCenterSet,RegionalMarketSet)/TransportationData('SpeedEmpty',TransportationTypes);

RegionalCSPLocalMarketDrivingTime(RegionalCSPCenterSet,LocalMarketSet,TransportationTypes) =
                 RegionalCSPLocalMarketDistance(RegionalCSPCenterSet,LocalMarketSet)/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 RegionalCSPLocalMarketDistance(RegionalCSPCenterSet,LocalMarketSet)/TransportationData('SpeedEmpty',TransportationTypes);

RegionalCSPRegionalMarketDrivingTime(RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes) =
                 RegionalCSPRegionalMarketDistance(RegionalCSPCenterSet,RegionalMarketSet)/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 RegionalCSPRegionalMarketDistance(RegionalCSPCenterSet,RegionalMarketSet)/TransportationData('SpeedEmpty',TransportationTypes);

LocalMarketRGYDrivingTime(LocalMarketSet,RGYSet,TransportationTypes) =
                 LocalMarketRGYDistance(LocalMarketSet,RGYSet)/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 LocalMarketRGYDistance(LocalMarketSet,RGYSet)/TransportationData('SpeedEmpty',TransportationTypes);

RegionalMarketRGYDrivingTime(RegionalMarketSet,RGYSet,TransportationTypes) =
                 RegionalMarketRGYDistance(RegionalMarketSet,RGYSet)/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 RegionalMarketRGYDistance(RegionalMarketSet,RGYSet)/TransportationData('SpeedLoaded',TransportationTypes);

RegionalMarketFCIDrivingTime(RegionalMarketSet,FCIGodownSet,TransportationTypes) =
                 RegionalMarketFCIDistance(RegionalMarketSet,FCIGodownSet)/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 RegionalMarketFCIDistance(RegionalMarketSet,FCIGodownSet)/TransportationData('SpeedLoaded',TransportationTypes);

RGYMillerDrivingTime(RGYSet,MillerSet,TransportationTypes) =
                 RGYMillerDistance(RGYSet,MillerSet)/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 RGYMillerDistance(RGYSet,MillerSet)/TransportationData('SpeedLoaded',TransportationTypes);

RGYRetailerDrivingTime(RGYSet,RetailerSet,TransportationTypes) =
                 RGYRetailerDistance(RGYSet,RetailerSet)/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 RGYRetailerDistance(RGYSet,RetailerSet)/TransportationData('SpeedLoaded',TransportationTypes);

FCIMillerDrivingTime(FCIGodownSet,MillerSet,TransportationTypes)=
                 FCIMillerDistance(FCIGodownSet,MillerSet)/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 FCIMillerDistance(FCIGodownSet,MillerSet)/TransportationData('SpeedLoaded',TransportationTypes);

FCIRetailerDrivingTime(FCIGodownSet,RetailerSet,TransportationTypes)=
                 FCIRetailerDistance(FCIGodownSet,RetailerSet)/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 FCIRetailerDistance(FCIGodownSet,RetailerSet)/TransportationData('SpeedLoaded',TransportationTypes);

FCIPDSDrivingTime(FCIGodownSet,PDSSet,TransportationTypes)=
                 FCIPDSDistance(FCIGodownSet,PDSSet)/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 FCIPDSDistance(FCIGodownSet,PDSSet)/TransportationData('SpeedLoaded',TransportationTypes);

MillerRetailerDrivingTime(MillerSet,RetailerSet,TransportationTypes) =
                 MillerRetailerDistance(MillerSet,RetailerSet)/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 MillerRetailerDistance(MillerSet,RetailerSet)/TransportationData('SpeedLoaded',TransportationTypes) ;

TruckIdlingTimePerTrip(TransportationTypes) = TruckWaitingTime
                             + TransportationData('LoadingTime',TransportationTypes)/TransportationData('LoadingEfficiency',TransportationTypes)*(1/60)
                             + TransportationData('UnloadingTime',TransportationTypes)/TransportationData('UnloadingEfficiency',TransportationTypes)*(1/60);

FarmLocalCSPTransportationTime(FarmNumber,LocalCSPCenterSet,TransportationTypes) =
FarmLocalCSPDrivingTime(FarmNumber,LocalCSPCenterSet,TransportationTypes) + TruckIdlingTimePerTrip(TransportationTypes);

FarmRegionalCSPTransportationTime(FarmNumber,RegionalCSPCenterSet,TransportationTypes) =
FarmRegionalCSPDrivingTime(FarmNumber,RegionalCSPCenterSet,TransportationTypes) + TruckIdlingTimePerTrip(TransportationTypes);

FarmLocalMarketTransportationTime(FarmNumber,LocalMarketSet,TransportationTypes) =
FarmLocalMarketDrivingTime(FarmNumber,LocalMarketSet,TransportationTypes)+ TruckIdlingTimePerTrip(TransportationTypes);

FarmRegionalMarketTransportationTime(FarmNumber,RegionalMarketSet,TransportationTypes) =
FarmRegionalMarketDrivingTime(FarmNumber,RegionalMarketSet,TransportationTypes) + TruckIdlingTimePerTrip(TransportationTypes);

LocalCSPLocalMarketTransportationTime(LocalCSPCenterSet,LocalMarketSet,TransportationTypes) =
LocalCSPLocalMarketDrivingTime(LocalCSPCenterSet,LocalMarketSet,TransportationTypes) + TruckIdlingTimePerTrip(TransportationTypes);

LocalCSPRegionalMarketTransportationTime(LocalCSPCenterSet,RegionalMarketSet,TransportationTypes) =
LocalCSPRegionalMarketDrivingTime(LocalCSPCenterSet,RegionalMarketSet,TransportationTypes) + TruckIdlingTimePerTrip(TransportationTypes);

RegionalCSPLocalMarketTransportationTime(RegionalCSPCenterSet,LocalMarketSet,TransportationTypes) =
RegionalCSPLocalMarketDrivingTime(RegionalCSPCenterSet,LocalMarketSet,TransportationTypes) + TruckIdlingTimePerTrip(TransportationTypes);

RegionalCSPRegionalMarketTransportationTime(RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes) =
RegionalCSPRegionalMarketDrivingTime(RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes) + TruckIdlingTimePerTrip(TransportationTypes);

*****
LocalMarketRGYTransportationTime(LocalMarketSet,RGYSet,TransportationTypes) =
LocalMarketRGYDrivingTime(LocalMarketSet,RGYSet,TransportationTypes) + TruckIdlingTimePerTrip(TransportationTypes);

RegionalMarketRGYTransportationTime(RegionalMarketSet,RGYSet,TransportationTypes) =
RegionalMarketRGYDrivingTime(RegionalMarketSet,RGYSet,TransportationTypes) + TruckIdlingTimePerTrip(TransportationTypes);

RegionalMarketFCITransportationTime(RegionalMarketSet,FCIGodownSet,TransportationTypes) =
RegionalMarketFCIDrivingTime(RegionalMarketSet,FCIGodownSet,TransportationTypes) + TruckIdlingTimePerTrip(TransportationTypes);

RGYMillerTransportationTime(RGYSet,MillerSet,TransportationTypes) =
RGYMillerDrivingTime(RGYSet,MillerSet,TransportationTypes) + TruckIdlingTimePerTrip(TransportationTypes);

RGYRetailerTransportationTime(RGYSet,RetailerSet,TransportationTypes) =
RGYRetailerDrivingTime(RGYSet,RetailerSet,TransportationTypes) + TruckIdlingTimePerTrip(TransportationTypes);

FCIMillerTransportationTime(FCIGodownSet,MillerSet,TransportationTypes) =
FCIMillerDrivingTime(FCIGodownSet,MillerSet,TransportationTypes) + TruckIdlingTimePerTrip(TransportationTypes);

FCIRetailerTransportationTime(FCIGodownSet,RetailerSet,TransportationTypes) =
FCIRetailerDrivingTime(FCIGodownSet,RetailerSet,TransportationTypes) + TruckIdlingTimePerTrip(TransportationTypes);

FCIPDSTransportationTime(FCIGodownSet,PDSSet,TransportationTypes) =
FCIPDSDrivingTime(FCIGodownSet,PDSSet,TransportationTypes) + TruckIdlingTimePerTrip(TransportationTypes);

MillerRetailerTransportationTime(MillerSet,RetailerSet,TransportationTypes) =
MillerRetailerDrivingTime(MillerSet,RetailerSet,TransportationTypes) + TruckIdlingTimePerTrip(TransportationTypes);


Display FarmLocalCSPTransportationTime;

*##############################################################################################################
* Temporarily giving some value that will be modified later
*##############################################################################################################
Parameter
  Par_LocalCSPOutpuDensity(LocalCSPCenterSet) The ouput density from each of the local CSPs that perform some preprocessing on grains
  Par_RegionalCSPOutpuDensity(LocalCSPCenterSet) The ouput density from each of the local CSPs that perform some preprocessing on grains
  GunnyBagCapacity The capacity of each gunny bag in kgs used for storage and transportation purpose
  GunnyBagCost_new The cost of a new gunny bag in rupees /37.42/
  GunnyBagLife The total number of years or harvesting rounds for which a gunny bag can be reused /1/
  GunnyBagCost The annualized cost of the gunny bag depending on the number of years for which it will be used and assuming no salvage value
  ;
*
* The density of wheat is based on the bulk density of wheat. It is assumed that wheat is stored in gunny bags and
* therefore the bulk density in gunny bags would be same as that of the natural bulk density of wheat. The typical
* gunny bags used by FCI are of 50 kg. The dimensions of a 50-60 kg bags were found out from the internet (http://www.jute.cotheeka.com/jutesacksbags.htm)
* A cross calculation showed that the to reach the density given here, the width of the bag should be about 10 cm. This seems reasonable.
*
Par_LocalCSPOutpuDensity(LocalCSPCenterSet)=785;
Par_RegionalCSPOutpuDensity(LocalCSPCenterSet)=785;
*
* The gunny bag capacity is based on the bag used by FCI for transport and storage
*
GunnyBagCapacity = 50;
* Calculating the annualized gunny bag cost assuming a simple ratio based on the number of years for which it is operational and assuming no salvage value
GunnyBagCost = GunnyBagCost_new/GunnyBagLife;
*##############################################################################################################


*##############################################################################################################
* Parameter Declaration: Selection of the case study location (importing data from the pre-defined excel file)
*##############################################################################################################
Parameter
  CollectionDistanceMinimum Minimum distance for biomass collection in km /5/
  CollectionDistanceMaximum Maximum distance for biomass collection in km
  CollectionDistanceMean Mean distance of biomass collection
  CollectionDistanceStd Standard deviation of biomass collection distance for sampling
  RoadWindingFactor Constant correlating the travelled distance to shortest distance between two points /1.2/
  StorageDistanceMinimum The minimum distance between the storage facility and refinery in km /10/
  StorageDistanceMaximum The maximum distance between the storage facility and refinery in km /30/
  ;


Parameter
  CentralStorageProcessing The binary parameter that indicates wether the centralized storage facility has a processing option (such as size reduction and packing)
  CentralStorageProcessingMandatory The binary parameter that indicates wether the centralized storage processing is mandatory for the farms
  CentralStorageInputProcessing The binary parameter that indicates whether the biomass processing at the central storage is carried out at the input of the storage
  CentralStorageOutputProcessing The binary parameter that indicates whether the biomass processing at the central storage is carried out at the output of the storage
  CentralStorageRefineryRailTransport The binary parameter that indicates where there is rail transport of biomass from central storage to the refinery
  ;


*********************************************

*
* Importing the user selections through the input file
*
*$include UserInputDefault.inc


Parameter
  GrainMoisture(SimulationHorizon) The moisture of the grain harvested at at any time;
*
* Giving a temporary value to the grain moisture
*
  GrainMoisture(SimulationHorizon) = 0.15
  ;

*         CentralStorageProcessingData The data (attributes) for the processing machine that is selected by the user is stored in this parameter to be used for further calculations
*         CentralStorageSmallScaleProcessingData  The data (attributes) for the processing machine that is selected by the user is stored in this parameter to be used for further calculations



Parameter
  CentralStorageProcessing Binary parameter indicating whether there is processing at the local CSP /0/
  CentralStorageOutputProcessing Binary parameter indicating whether there is processing at the the output of the facility - this requires the first parameter to be selected 1 /0/
  ;


*##############################################################################################################
* Declaring the bounds on the market for grain at different locations
*##############################################################################################################

Parameter
  LocalMarketDemand Local market demand as a function of time
  LocalMarketDemand_UpperBound Upper bound on the local market demand as a function of time
  LocalMarketDemand_LowerBound Lower bound on the local market demand as a function of time

  RegionalMarketDemand Regional market demand as a function of time
  RegionalMarketDemand_UpperBound Upper bound on the Regional market demand as a function of time
  RegionalMarketDemand_LowerBound Lower bound on the Regional market demand as a function of time

  FarmGatePurchaseDemand The deamand for farm gate purchase at a given farm during a given time horizon
  FarmGatePurchaseDemand_UpperBound The deamand for farm gate purchase at a given farm during a given time horizon
  FarmGatePurchaseDemand_LowerBound The deamand for farm gate purchase at a given farm during a given time horizon

  Farm_FarmGateSaleFraction The fraction of the total grain over the whole year that can be sold at the farm gate by a particular farm /0.1/
  Farm_LocalMarketSaleFraction The Fraction of the total grain over the whole year that can be sold at the local by a particular farm  /0.2/
  Farm_RegionalMarketSaleFraction The Fraction of the total grain over the whole year that can be sold at the regional market by a particular farm /0.7/
  ;

LocalMarketDemand(HarvestingHorizonAggregation,LocalMarketSet) = 10;
LocalMarketDemand_UpperBound(HarvestingHorizonAggregation,LocalMarketSet) = 1000;
LocalMarketDemand_LowerBound(HarvestingHorizonAggregation,LocalMarketSet) = 0;
LocalMarketDemand(NonHarvestingHorizonAggregation,LocalMarketSet) = 0;
LocalMarketDemand_UpperBound(NonHarvestingHorizonAggregation,LocalMarketSet) = 1000;
LocalMarketDemand_LowerBound(NonHarvestingHorizonAggregation,LocalMarketSet) = 0;

RegionalMarketDemand(HarvestingHorizonAggregation,RegionalMarketSet) = 0;
RegionalMarketDemand_UpperBound(HarvestingHorizonAggregation,RegionalMarketSet) = 20000000;
RegionalMarketDemand_LowerBound(HarvestingHorizonAggregation,RegionalMarketSet) = 0;
RegionalMarketDemand(NonHarvestingHorizonAggregation,RegionalMarketSet) = 0;
RegionalMarketDemand_UpperBound(NonHarvestingHorizonAggregation,RegionalMarketSet) = 20000000;
RegionalMarketDemand_LowerBound(NonHarvestingHorizonAggregation,RegionalMarketSet) = 0;

FarmGatePurchaseDemand(HarvestingHorizonAggregation,FarmNumber)= 100;
FarmGatePurchaseDemand_UpperBound(HarvestingHorizonAggregation,FarmNumber)= 10000;
FarmGatePurchaseDemand_LowerBound(HarvestingHorizonAggregation,FarmNumber)= 0;
FarmGatePurchaseDemand(NonHarvestingHorizonAggregation,FarmNumber)= 100;
FarmGatePurchaseDemand_UpperBound(NonHarvestingHorizonAggregation,FarmNumber)= 10000;
FarmGatePurchaseDemand_LowerBound(NonHarvestingHorizonAggregation,FarmNumber)= 0;

*
* Fixing the dry matter loss rates for different storage locations
*
FarmOpenStorageDryMatterLossRate = SmallScaleStorageData('DryMatterLoss','Kothi_Kucha_House');
LocalCSPDryMatterLossRate = SmallScaleStorageData('DryMatterLoss','Kothi_Pucca_House');
RegionalCSPDryMatterLossRate = SmallScaleStorageData('DryMatterLoss','Steel_Drums_Pucca_House');
RGYDryMatterLossRate = SmallScaleStorageData('DryMatterLoss','Steel_Drums_Pucca_House');
MillerStorageDryMatterLossRate = SmallScaleStorageData('DryMatterLoss','Steel_Drums_Pucca_House');

*################################################################################################################################
* Declaring the capacity of the regional markets and storage facilities that will decided how much grain can be handled in a given market on a given day
*################################################################################################################################

Parameter
  RegionalMarketCapacity(RegionalMarketSet) The total capacity of the regional market (mandi) in terms of the mass of grain that can be handled on a daily basis
  LocalMarketCapacity(LocalMarketSet) The total capacity of the local market  in terms of the mass of grain that can be handled on a daily basis
  RGY_Max The maximum capacity in kg in terms of the amount of grain stored of an RGY
  RGY_Min The minimum capacity in kg in terms of the amount of grain stored of an RGY
  FCI_Max The maximum capacity in kg in terms of the amount of grain stored of an FIC godown
  FCI_Min The minimum capacity in kg in terms of the amount of grain stored of an FIC godown
  MillerProcessingCapacity_Min the minimum capacity in kg in terms of the amount of grain that must be processed by a mill
  MillerProcessingCapacity_Max the maximum capacity in kg in terms of the amount of grain that can be processed by a mill
  MillerStorageCapacity_Min the minimum capacity in kg in terms of the amount of grain that must be stored by a mill
  MillerStorageCapacity_Max the maximum capacity in kg in terms of the amount of grain that can be stored by a mill
  MillingLoss(MillerSet) The fraction of grain lost during the milling operation

  MillerAnnualCost(MillerSet) The fixed annual cost of the miller
  MillerOperatingCostRate(MillerSet) The operating cost of the milling in terms of Rs per kg
  MillerStorageCostRate(MillerSet) The cost of developing a storage facility at the miller based on the total amount that is stored at the miller
  ;


*RegionalMarketCapacity(RegionalMarketSet) = 150000;
*LocalMarketCapacity(LocalMarketSet) = 50000;
RegionalMarketCapacity(RegionalMarketSet) = 1E10;
LocalMarketCapacity(LocalMarketSet) = 1E10;

RGY_Min = 100000;
RGY_Max = 10000000;
FCI_Min(FCIGodownSet) = 0;
FCI_Max(FCIGodownSet) = 1E7;
MillerProcessingCapacity_Min(MillerSet) = 0;
MillerProcessingCapacity_Max(MillerSet) = 1E10;
MillerStorageCapacity_Min(MillerSet) = 0;
MillerStorageCapacity_Max(MillerSet) = 1E10;
MillingLoss(MillerSet) = 0.05;

MillerAnnualCost(MillerSet) = 108472512;
* This number is taken from the calculations provided by Shruti
MillerOperatingCostRate(MillerSet) = 1.37;
* This number is based on the one reported in the excel file titled "Cost of storage procurement and transportation by FIC.xls" obtained from IndiaStat.com
MillerStorageCostRate(MillerSet) = 1;


*
* Based on the data downloaded from IndiaStat.com ("Cost on Procurement, Storage and Transportation of Foodgrains (Wheat/Rice) by Food Corporation of India", (2009-2010 to 2011-2012) )
*
FCIStorageCostRate = 0.3719;
* This is the number under Distribution Cost --> Storage Charges
FCIMandiCostRate = 0.3618;
* This is the total cost for mandi.
NumberOfMonthsInFCIStorage = 8;
* This is an assumption. There have been reports (CAG report) that the duration can be as much as 2-3 years. However, the stock will typically need to be cleared before the
* next lot comes. Hence, we are assuming the avarerage storage time to be about 8 months.
FCIStorageCostRateMonthly = FCIStorageCostRate/NumberOfMonthsInFCIStorage;

*FCIGodownCAPLossRate = 0.000470211*200000000000000;
*FCIGodownCoveredLossRate = 0.000470211/20000000000;

FCIGodownCAPLossRate = 6;
FCIGodownCoveredLossRate = 0.1;

Parameter 
  PDSDemand
  RetailerDemand
  ;

PDSDemand(HarvestingHorizonAggregation,PDSSet)=100;
PDSDemand(NonHarvestingHorizonAggregation,PDSSet)=100;
RetailerDemand(HarvestingHorizonAggregation,RetailerSet)=10;
RetailerDemand(NonHarvestingHorizonAggregation,RetailerSet)=10;

PDSDemand('1',PDSSet)=0;
RetailerDemand('1',RetailerSet)=0;


Display 
  RegionalMarketFCIDistance,FCIMillerDistance,FCIRetailerDistance, FCIPDSDistance, RegionalMarketFCITransportationTime
  ;
