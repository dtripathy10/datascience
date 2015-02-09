$title "This file is used when the user wants to simulate/optimize for a given collection area"
*
* The collection area can be defined in terms of counties or just the total area.
* For counties, the data will be stored in the database and that data will be used.
* If general area is selected, then the area value is taken from the user and the 
* problem decides the number of farms and farm size
* using general sampling approach (this can again be a function of which region it is).
*

*############################################################################################
*** THIS FILE IS A MODIFICATION OF THE USER SELECTION FILE
*###########################################################################################

*##############################################################################################
* Set Declaration
*###############################################################################################
* Adding the necessary sets for the grain problem here. These can be imported from a gdx file in a 
* more efficient code. But that will be addressed later.

Sets
  LocalCSPCenterSet /LocalStorage-1/
  RegionalCSPCenterSet /RegionalStorage-1/
  LocalMarketSet /LocalMarket-1/
  RegionalMarketSet /RegionalMarket-1/
  RGYSet /RGY-1, RGY-2/
  FCIGodownSet /FCI-1*FCI-5/
  MillerSet /M-1*M-10/
  RetailerSet /R-1*R-10/
  PDSSet /PDS-1*PDS-5/
  FarmType /Marginal, Small, Semi_Medium, Medium, Large/;


*###########################################################################################
* Importing data pertaining to grain prices at different locations
*#################################################################################################
Parameter  GrainPurchasePrice_Input, FarmSize_Input;
$CALL GDXXRW.EXE Grains_PricesAndDistances.xls Dset=GrainPurchasePriceSet rng=GrainPrice!B1:D1 
  Cdim=1 Dset=SimulationSteps rng=GrainPrice!A2:A361 Rdim=1 Par=GrainPurchasePrice_Input 
  rng=GrainPrice!A1:D361 Dset=FarmArea rng=FarmData!B13 Cdim=1 Dset=TotalFarmNumber 
  rng=FarmData!A14:A300 Rdim=1 Par=FarmSize_Input rng=FarmData!A13:B300;

$GDXIN Grains_PricesAndDistances.gdx

Set 
  GrainPurchasePriceSet(*)
  SimulationSteps(*)
  TotalFarmNumber(*)
  FarmArea(*);

$LOAD GrainPurchasePriceSet=GrainPurchasePriceSet
$LOAD SimulationSteps = SimulationSteps
$LOAD TotalFarmNumber = TotalFarmNumber
$LOAD FarmArea = FarmArea
$LOAD GrainPurchasePrice_Input
$LOAD FarmSize_Input
$GDXIN

alias(FarmNumber,TotalFarmNumber);

Display RegionalMarketSet;

*###########################################################################################
* Declaring the parameters that impact which model is to be simulated (current or potential)
*############################################################################################
Parameter 
  CurrentScenario  /1/
  FutureScenario /0/;


*##################################################################################
* Declaration of parameters related to the distances
*#######################################################################################
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
  AverageGrainYield /1823/
  GrainYieldStandardDev /281.78/
  GrainProduction(TotalFarmNumber)
  GrainAvailable(TotalFarmNumber)
  FarmGrainFractionForSale(FarmType) /Marginal 0.66, 
                                      Small 0.84, Semi_Medium 0.81, 
                                      Medium 0.86, Large 0.80/

  MinimumSupportPrice /14/;

*
* Storing the input values of farm size in the desired parameter to be used in the model later. 
* This is done to get rid of the
* additional set dimension of the parameter that is imported from the gdx file.
*
FarmSize(TotalFarmNumber) = FarmSize_Input(TotalFarmNumber,'FarmArea');

GrainProduction(TotalFarmNumber)
  = FarmSize(TotalFarmNumber)*normal(AverageGrainYield,GrainYieldStandardDev);

Scalar i;

loop(FarmNumber,
  if(FarmSize(FarmNumber)<1,
    GrainAvailable(FarmNumber)
      =  GrainProduction(FarmNumber)*FarmGrainFractionForSale('Marginal')
  )
  if(FarmSize(FarmNumber)>=1 and FarmSize(FarmNumber)<2,
    GrainAvailable(FarmNumber)
      =  GrainProduction(FarmNumber)*FarmGrainFractionForSale('Small')
  )
  if(FarmSize(FarmNumber)>=2 and FarmSize(FarmNumber)<4,
    GrainAvailable(FarmNumber)
      = GrainProduction(FarmNumber)*FarmGrainFractionForSale('Semi_Medium')
  )
  if(FarmSize(FarmNumber)>=4 and FarmSize(FarmNumber)<10,
    GrainAvailable(FarmNumber)
      =  GrainProduction(FarmNumber)*FarmGrainFractionForSale('Medium')
  )
  if(FarmSize(FarmNumber)>=10,
    GrainAvailable(FarmNumber)
      =  GrainProduction(FarmNumber)*FarmGrainFractionForSale('Large')
  )
);


Display GrainPurchasePrice_Input, FarmSize, GrainProduction, GrainAvailable;

*###############################################################################################
* Calculating the distances needed to run the code. These distances can later be imported 
* from a gdx file for more
* efficient execution of the code.
*##############################################################################################

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

Display 
  FarmLocalCSPDistance,FarmRegionalCSPDistance,FarmLocalMarketDistance,
  FarmRegionalMarketDistance,LocalCSPLocalMarketDistance,
  LocalCSPRegionalMarketDistance, RegionalCSPLocalMarketDistance, 
  RegionalCSPRegionalMarketDistance;

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
  TruckIdlingTimePerTrip;


FarmLocalCSPDrivingTime(FarmNumber,LocalCSPCenterSet,TransportationTypes) =
  FarmLocalCSPDistance(FarmNumber,LocalCSPCenterSet)
    / TransportationData('SpeedLoaded',TransportationTypes) +
  FarmLocalCSPDistance(FarmNumber,LocalCSPCenterSet)
    /TransportationData('SpeedEmpty',TransportationTypes);

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

*##################################################################
* Temporarily giving some value that will be modified later
*#####################################################################
Parameter
  Par_LocalCSPOutpuDensity(LocalCSPCenterSet)
  Par_RegionalCSPOutpuDensity(LocalCSPCenterSet) 
  GunnyBagCapacity
  GunnyBagCost_new  /37.42/
  GunnyBagLife  /1/
  GunnyBagCost;
*
* The density of wheat is based on the bulk density of wheat. It is assumed that wheat is stored 
*in gunny bags and
* therefore the bulk density in gunny bags would be same as that of the natural bulk density of 
*wheat. The typical
* gunny bags used by FCI are of 50 kg. The dimensions of a 50-60 kg bags were found out from 
*the internet (http://www.jute.cotheeka.com/jutesacksbags.htm)
* A cross calculation showed that the to reach the density given here, the width of the bag 
*should be about 10 cm. This seems reasonable.
*

Par_LocalCSPOutpuDensity(LocalCSPCenterSet)=785;
Par_RegionalCSPOutpuDensity(LocalCSPCenterSet)=785;

*
* The gunny bag capacity is based on the bag used by FCI for transport and storage
*
GunnyBagCapacity = 50;
* Calculating the annualized gunny bag cost assuming a simple ratio based on the number of years 
* for which it is operational and assuming no salvage value

GunnyBagCost = GunnyBagCost_new/GunnyBagLife;
*###############################################################################


*###########################################################################################
* Parameter Declaration: Selection of the case study location (importing data from the 
* pre-defined excel file)
*###############################################################################################
Parameter
  CollectionDistanceMinimum  /5/
  CollectionDistanceMaximum
  CollectionDistanceMean
  CollectionDistanceStd
  RoadWindingFactor /1.2/
  StorageDistanceMinimum /10/
  StorageDistanceMaximum  /30/;


Parameter
  CentralStorageProcessing
  CentralStorageProcessingMandatory
  CentralStorageInputProcessing
  CentralStorageOutputProcessing
  CentralStorageRefineryRailTransport;


Parameter
  GrainMoisture(SimulationHorizon);

GrainMoisture(SimulationHorizon) = 0.15;


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

*################################################################################################
* Declaring the capacity of the regional markets and storage facilities that will decided how 
* much grain can be handled in a given market on a given day
*################################################################################################

Parameter
  RegionalMarketCapacity(RegionalMarketSet)
  LocalMarketCapacity(LocalMarketSet)
  RGY_Max
  RGY_Min
  FCI_Max
  FCI_Min
  MillerProcessingCapacity_Min
  MillerProcessingCapacity_Max
  MillerStorageCapacity_Min
  MillerStorageCapacity_Max
  MillingLoss(MillerSet)
  MillerAnnualCost(MillerSet)
  MillerOperatingCostRate(MillerSet)
  MillerStorageCostRate(MillerSet);


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
MillerOperatingCostRate(MillerSet) = 1.37;
MillerStorageCostRate(MillerSet) = 1;
FCIStorageCostRate = 0.3719;
FCIMandiCostRate = 0.3618;
NumberOfMonthsInFCIStorage = 8;
FCIStorageCostRateMonthly = FCIStorageCostRate/NumberOfMonthsInFCIStorage;

FCIGodownCAPLossRate = 6;
FCIGodownCoveredLossRate = 0.1;

Parameter PDSDemand
          RetailerDemand;

PDSDemand(HarvestingHorizonAggregation,PDSSet)=100;
PDSDemand(NonHarvestingHorizonAggregation,PDSSet)=100;
RetailerDemand(HarvestingHorizonAggregation,RetailerSet)=10;
RetailerDemand(NonHarvestingHorizonAggregation,RetailerSet)=10;
PDSDemand('1',PDSSet)=0;
RetailerDemand('1',RetailerSet)=0;

Display RegionalMarketFCIDistance,FCIMillerDistance,FCIRetailerDistance, 
  FCIPDSDistance, RegionalMarketFCITransportationTime;
