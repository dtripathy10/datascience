$title The file that includes importing data from the excel file with the information about the case study to be solved

*
* Importing data for all counties that are in the database.
*
*$CALL GDXXRW.EXE IllinoisData-Dummy.xls DSet=TotalFarmNumber rng=FarmSizeSummary!A5:A310 Rdim=1 DSet=CountyDataSet rng=FarmSizeSummary!B4 Cdim=1 DSet=CentralizedStorageLocationSet rng=CountyAttributeSummary!A18:A35 Rdim=1 DSet=StorageRefineryDistance rng=CountyAttributeSummary!B17 Cdim=1 par=CountyFarmSizeInformation rng=FarmSizeSummary!A4:N300 par=FarmRefineryDistance rng=FarmRefineryDistance!A4:N300 par=FarmStorageDistance rng=FarmStorageDistance!A4:O300 par=StorageDistanceInformation rng=CountyAttributeSummary!A17:B35 par=CountyFarmInformation rng=CountyAttributeSummary!A5:N6;

$GDXIN IllinoisData-BiomassCollection-13.gdx
*$GDXIN IllinoisData-Dummy.gdx

Set TotalFarmNumber(*) Total number of farms
    CountyDataSet(*) The county data set
    CentralizedStorageLocationSet(*) The set of centralized storage locations
    StorageRefineryDistance(*) The distance between centralized storage facility and refinery;
*
* Assigning the sets imported from the GDX (Excel) file to the sets in GAMS code
*
$LOAD TotalFarmNumber = TotalFarmNumber
$LOAD CountyDataSet = CountyDataSet
$LOAD CentralizedStorageLocationSet = CentralizedStorageLocationSet
$LOAD StorageRefineryDistance = StorageRefineryDistance

$LOAD CountyFarmSizeInformation FarmRefineryDistance FarmStorageDistance StorageDistanceInformation CountyFarmInformation

*$CALL GDXXRW.EXE FarmHarvestSchedule-Miscanthus.xls par=FarmHarvestStartDayUserInput rng=HarvestStartDate!A1:N310;
$GDXIN FarmHarvestSchedule-Miscanthus.gdx
$LOAD FarmHarvestStartDayUserInput
$GDXIN

Display CountyFarmSizeInformation;
*
* Delcaring the subsets over the predefined general sets
*
Set
     CentralizedStorageLocations(CentralizedStorageLocationSet) the storage locations that are selected for the analysis;

alias(FarmNumber,TotalFarmNumber);
alias(CountySelected,CountyDataSet);
*
* Selecting whether the refinery has a storage facility and therefore must be included in the model calculations.
* First initializing the selection by selecting all the storage locations that exist in the original excel file.
* Then eliminating the storage locations that are not to be selected.
*
         CentralizedStorageLocations(CentralizedStorageLocationSet)=yes;
         CentralizedStorageLocations('RefineryStorage')=no;

*
* Once the selections are made, then processing the input data in order to prepare the relavant data for model simulation (the processing
* is based on the the selections made by the user).
*
*           CumulativeFarmNumber=smax((CountySelected), CountyFarmInformation('CountyFarmNumber',CountySelected));
*           For (i = 1 to CumulativeFarmNumber by 1,
*                 FarmNumber(TotalFarmNumber)$(ord(TotalFarmNumber)=i)=yes;
*           );

           loop(CountyDataSet $(CountySelected(CountyDataSet)),
                 FarmData(CountyDataSet,TotalFarmNumber,'FarmSize') = CountyFarmSizeInformation(TotalFarmNumber,CountyDataSet)*0.00405;
* The factor of 0.00405 is used to convert the farm area reported in acres into farm area in square kilometers which is the unit used internally within the model
           );

          if (TransportationDistanceSelection=1,

                    loop(CountyDataSet $(CountySelected(CountyDataSet)),

                         FarmData(CountyDataSet,TotalFarmNumber,'RefineryDistance') = FarmRefineryDistance(TotalFarmNumber,CountyDataSet);

                         FarmDistanceData(CountyDataSet,TotalFarmNumber,CentralizedStorageLocations)
                                                 = FarmStorageDistance(TotalFarmNumber,CentralizedStorageLocations);

                         StorageDistanceData(CentralizedStorageLocations)
                                                 = StorageDistanceInformation(CentralizedStorageLocations,'StorageRefineryDistance');

                    );

         elseif (TransportationDistanceSelection=0),

*                    AverageLandUtilizationFactor=sum(CountySelected,CountyFarmInformation('LandUtilizationFactor',CountySelected))/card(CountySelected);
                    TotalFarmArea = sum((CountySelected,FarmNumber),FarmData(CountySelected,FarmNumber,'FarmSize'))*0.00404;
* The coefficent 0.00404 is to convert acres into square kilometer
                    TotalCollectionArea = TotalFarmArea/AverageLandUtilizationFactor;

                    CollectionDistanceMaximum=(TotalCollectionArea/3.14)**0.5;
* Sampling the refinery distance using normal distribution based on the maximum and minimum collection distance
                    CollectionDistanceMean=(CollectionDistanceMaximum+CollectionDistanceMinimum)/2;
                    CollectionDistanceStd=(CollectionDistanceMean-CollectionDistanceMinimum)/3;

                    FarmData(CountySelected,TotalFarmNumber,'RefineryDistance')
                                 =normal(CollectionDistanceMean,CollectionDistanceStd)*RoadWindingFactor;

* Sampling the distance between the selected farms and the selected storage locations using lognormal distribution
                    FarmDistanceData(CountySelected,TotalFarmNumber,CentralizedStorageLocations)
                                 =
                                 CollectionDistanceMean+exp(normal(0,1))*CollectionDistanceStd*RoadWindingFactor;

                    StorageDistanceData(CentralizedStorageLocations)=uniform(StorageDistanceMinimum,StorageDistanceMinimum);

          );

*
* Declaring the county and centralized storage location correlation parameter
*
* First initializing the parameter to zero
         CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations)=1;
*
* Assigning values to a parameter that decides whether transportation between a particular centralized storage facility
* and refinery needs truck. The value is zero for a storage facility at the refinery which means that no trucks are
* required for transportation. The value is 1 for all other storage facilities which require truck.
*
         CentralStorageRefineryTransportationIndicator(CentralizedStorageLocations)=1;
         CentralStorageRefineryTransportationIndicator('RefineryStorage')=0;

*
* Now, defining the farm-central storage correlation parameter based on the distance data between these locations. This data is imported from the
* excel file and is defined by the user prior to the simulation
*

         FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)=1$(FarmStorageDistance(FarmNumber,CentralizedStorageLocations)<150);
         FarmStorageLocationCorrelation(FarmNumber,'RefineryStorage')=1$(sum(CountyDataSet,FarmData(CountyDataSet,FarmNumber,'RefineryDistance'))<30);


CountySelection = 1;
BiorefineryCapacitySelection=0;
AreaSelection=0;

*
* Initializing the farm gate price profile to the initial value given by the user in the main code (ModelAssembly.gms)
*
         Par_FarmSpecificPriceProfile(HarvestingHorizonAggregation,CountySelected,FarmNumber) = FarmGatePriceProfileInitialization;
         Par_FarmSpecificPriceProfile(NonHarvestingHorizonAggregation,CountySelected,FarmNumber) = FarmGatePriceProfileInitialization;


Display FarmData;
Display CountyDataSet, FarmNumber, CentralizedStorageLocations,StorageRefineryDistance, CountyFarmInformation, FarmStorageDistance, StorageDistanceInformation, FarmStorageLocationCorrelation;
