*========================================================================================================================
* Calculation of the harvesting capacity
*========================================================================================================================
Parameter
          HarvesterCapacity(HarvesterTypes) The harvester capacity in terms of square kilometers per hour calculated using the harvester attributes;

HarvesterCapacity(HarvesterTypes) = HarvesterData('Speed',HarvesterTypes)*HarvesterData('Width',HarvesterTypes)*0.001*HarvesterData('Efficiency',HarvesterTypes);
* The 0.001 factor is to convert the width given in meters into kilometers.

*========================================================================================================================
* Calculating the average transportation times for various possible transportations between different locations
*========================================================================================================================
Parameter

           FarmCoveredStorageDryMatterLossRate The dry matter loss rate for on-farm covered storage calculated as a function of user selection
           FarmCoveredStorageFacilityHeight The height of the facility for on-farm covered storage
           FarmCoveredStorageFractionLimit The fraction of the farm area that can be used for on-farm covered storage

           FarmOpenStorageDryMatterLossRate Fraction of dry matter lost during storage
           FarmOpenStorageFacilityHeight The height of the facility for on-farm open storage
           FarmOpenStorageFractionLimit The fraction of the farm area that can be used for on-farm open storage

           EnsilingDryMatterLossRate Fraction of dry matter lost during silage pit storage
           SilagePitDepth The depth of the silage pit
           SilagePitFractionLimit The fraction of the farm area that can be used for on-farm silage pit
           EnsilingBulkDensity The bulk density of the ensiling method

           CentralStorageDryMatterLossRate The dry matter loss rate for centralized storage calculated as a function of user selection
           CentralStorageFacilityHeight The height of the facility for centralized storage
           CentralStorageAreaLimit The maximum permitted area for the centralized storage facility

           CentralStorageSmallScaleDryMatterLossRate The dry matter loss rate for centralized storage calculated as a function of user selection
           CentralStorageSmallScaleFacilityHeight The height of the facility for centralized storage
           CentralStorageSmallScaleAreaLimit The maximum permitted area for the centralized storage facility

           FarmRefineryDrivingTime Average truck driving time from each farm to the biorefinery
           FarmRegionalDrivingTime Average truck driving time from each farm to the regional market
           FarmCentralStorageDrivingTime Average truck driving time from each farm to the centralized storage facility
           FarmDirectPurchaseDrivingTime Average truck driving time from each farm to direct purchasing point
           FarmCentralStorageSmallScaleDrivingTime Average truck driving time from each farm to the small scale centralized storage facility
           CentralStorageRefineryDrivingTime Average truck driving time from the centralized storage facility to the refinery
           CentralStorageRegionalDrivingTime Average truck driving time from the centralized storage facility to the regional market
           CentralStorageSmallScaleRegionalDrivingTime Average truck driving time from the small scale centralized storage facility to the regional market
           CentralStorageSmallScaleRefineryDrivingTime Average truck driving time from the small scale centralized storage facility to the refinery
           TruckIdlingTimePerTrip Idling time of a truck per trip for loading and unloading
           FarmRefineryTransportationTime Average transportation time from each farm to the biorefinery
           FarmRegionalTransportationTime Average transportation time from each farm to the regional market
           FarmDirectPurchaseTransportationTime Average transportation time from open storage closed storage for direct purchase at the farm
           FarmCentralStorageTransportationTime Average transportation time from each farm to the centralized storage facility
           FarmCentralStorageSmallScaleTransportationTime Average transportation time from each farm to the small scale centralized storage facility
           CentralStorageRegionalTransportationTime Average transportation time from centralized storage facility to the regional market
           CentralStorageSmallScaleRefineryTransportationTime Average transportation time from small scale centralized storage facility to refinery
           CentralStorageSmallScaleRegionalTransportationTime Average transportation time from small scale centralized storage facility to regional market
           CentralStorageRefineryTransportationTime Average transportation time from the centralized storage facility to the refinery;

Parameter
         CentralStorageProcessingData The data (attributes) for the processing machine that is selected by the user is stored in this parameter to be used for further calculations
         CentralStorageSmallScaleProcessingData  The data (attributes) for the processing machine that is selected by the user is stored in this parameter to be used for further calculations
         CentralStorageRefineryTruckCorrelation The binary correlation parameter that enables selection of the appropriate truck based on the form of the biomass being produced at the centralized storage processing
         CentralStorageRegionalTruckCorrelation
         CentralStorageSmallScaleRefineryTruckCorrelation The binary correlation parameter that enables selection of the appropriate truck based on the form of the biomass being produced at the small scale centralized processing;
         CentralStorageSmallScaleRegionalTruckCorrelation

FarmRefineryDrivingTime(CountySelected,FarmNumber,TransportationTypes) =
                 FarmData(CountySelected,FarmNumber,'RefineryDistance')/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 FarmData(CountySelected,FarmNumber,'RefineryDistance')/TransportationData('SpeedEmpty',TransportationTypes);

FarmRegionalDrivingTime(CountySelected,FarmNumber,TransportationTypes) =
                 FarmData(CountySelected,FarmNumber,'RegionalDistance')/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 FarmData(CountySelected,FarmNumber,'RegionalDistance')/TransportationData('SpeedEmpty',TransportationTypes);

FarmDirectPurchaseDrivingTime(CountySelected,FarmNumber,TransportationTypes) =
                 FarmData(CountySelected,FarmNumber,'DirectPurchaseDistance')/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 FarmData(CountySelected,FarmNumber,'DirectPurchaseDistance')/TransportationData('SpeedEmpty',TransportationTypes);

FarmCentralStorageDrivingTime(CountySelected,FarmNumber,CentralizedStorageLocations,TransportationTypes) =
                 FarmDistanceData(CountySelected,FarmNumber,CentralizedStorageLocations)/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 FarmDistanceData(CountySelected,FarmNumber,CentralizedStorageLocations)/TransportationData('SpeedEmpty',TransportationTypes) ;

FarmCentralStorageSmallScaleDrivingTime(CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,TransportationTypes) =
                 FarmDistanceData(CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations)/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 FarmDistanceData(CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations)/TransportationData('SpeedEmpty',TransportationTypes);

CentralStorageRefineryDrivingTime(CentralizedStorageLocations,TransportationTypes) =
                 StorageRefineryDistanceData(CentralizedStorageLocations)/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 StorageRefineryDistanceData(CentralizedStorageLocations)/TransportationData('SpeedEmpty',TransportationTypes);

CentralStorageRegionalDrivingTime(CentralizedStorageLocations,TransportationTypes) =
                 StorageRegionalDistanceData(CentralizedStorageLocations)/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 StorageRegionalDistanceData(CentralizedStorageLocations)/TransportationData('SpeedEmpty',TransportationTypes);

CentralStorageSmallScaleRefineryDrivingTime(CentralizedSmallScaleStorageLocations,TransportationTypes) =
                 StorageSmallScaleRefineryDistanceData(CentralizedStorageSmallScaleLocations)/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 StorageSmallScaleRefineryDistanceData(CentralizedStorageSmallScaleLocations)/TransportationData('SpeedEmpty',TransportationTypes);

CentralStorageSmallScaleRegionalDrivingTime(CentralizedStorageSmallScaleLocations,TransportationTypes) =
                 StorageSmallScaleRegionalDistanceData(CentralizedStorageSmallScaleLocations)/TransportationData('SpeedLoaded',TransportationTypes)
                 +
                 StorageSmallScaleRegionalDistanceData(CentralizedStorageSmallScaleLocations)/TransportationData('SpeedEmpty',TransportationTypes);

TruckIdlingTimePerTrip(TransportationTypes) = TruckWaitingTime
                             + TransportationData('LoadingTime',TransportationTypes)/TransportationData('LoadingEfficiency',TransportationTypes)*(1/60)
                             + TransportationData('UnloadingTime',TransportationTypes)/TransportationData('UnloadingEfficiency',TransportationTypes)*(1/60);


FarmRefineryTransportationTime(CountySelected,FarmNumber,TransportationTypes)
                                 = FarmRefineryDrivingTime(CountySelected,FarmNumber,TransportationTypes) + TruckIdlingTimePerTrip(TransportationTypes) ;
FarmRegionalTransportationTime(CountySelected,FarmNumber,TransportationTypes)
                                 = FarmRegionalDrivingTime(CountySelected,FarmNumber,TransportationTypes) + TruckIdlingTimePerTrip(TransportationTypes) ;

FarmDirectPurchaseTransportationTime(CountySelected,FarmNumber,TransportationTypes)
                                 = FarmDirectPurchaseDrivingTime(CountySelected,FarmNumber,TransportationTypes) + TruckIdlingTimePerTrip(TransportationTypes) ;

FarmCentralStorageTransportationTime(CountySelected,FarmNumber,CentralizedStorageLocations,TransportationTypes)
                                 = FarmCentralStorageDrivingTime(CountySelected,FarmNumber,CentralizedStorageLocations,TransportationTypes)
                                         + TruckIdlingTimePerTrip(TransportationTypes) ;

FarmCentralStorageSmallScaleTransportationTime(CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,TransportationTypes)
                                 = FarmCentralStorageSmallScaleDrivingTime(CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,TransportationTypes)
                                         + TruckIdlingTimePerTrip(TransportationTypes) ;

CentralStorageRefineryTransportationTime(CentralizedStorageLocations,TransportationTypes)
                                 = CentralStorageRefineryDrivingTime(CentralizedStorageLocations,TransportationTypes)
                                 + TruckIdlingTimePerTrip(TransportationTypes) * CentralStorageRefineryTransportationIndicator(CentralizedStorageLocations);

CentralStorageRegionalTransportationTime(CentralizedStorageLocations,TransportationTypes)
                                 = CentralStorageRegionalDrivingTime(CentralizedStorageLocations,TransportationTypes)
                                 + TruckIdlingTimePerTrip(TransportationTypes) * CentralStorageRegionalTransportationIndicator(CentralizedStorageLocations);

CentralStorageSmallScaleRegionalTransportationTime(CentralizedStorageSmallScaleLocations,TransportationTypes)
                                 = CentralStorageSmallScaleRegionalDrivingTime(CentralizedStorageSmallScaleLocations,TransportationTypes)
                                 + TruckIdlingTimePerTrip(TransportationTypes) * CentralStorageSmallScaleRegionalTransportationIndicator(CentralizedStorageSmallScaleLocations);

CentralStorageSmallScaleRefineryTransportationTime(CentralizedStorageSmallScaleLocations,TransportationTypes)
                                 = CentralStorageSmallScaleRefineryDrivingTime(CentralizedStorageSmallScaleLocations,TransportationTypes)
                                 + TruckIdlingTimePerTrip(TransportationTypes) * CentralStorageSmallScaleRefineryTransportationIndicator(CentralizedStorageSmallScaleLocations);



FarmCoveredStorageDryMatterLossRate = Sum(StorageTypes,StorageData('DryMatterLoss',StorageTypes)*CoveredStorageMethodSelection(StorageTypes));
FarmCoveredStorageFacilityHeight = Sum(StorageTypes,StorageData('Height',StorageTypes)*CoveredStorageMethodSelection(StorageTypes));
FarmCoveredStorageFractionLimit = Sum(StorageTypes,StorageData('Capacity',StorageTypes)*CoveredStorageMethodSelection(StorageTypes));

FarmOpenStorageDryMatterLossRate = Sum(StorageTypes,StorageData('DryMatterLoss',StorageTypes)*OpenStorageMethodSelection(StorageTypes));
FarmOpenStorageFacilityHeight = Sum(StorageTypes,StorageData('Height',StorageTypes)*OpenStorageMethodSelection(StorageTypes));
FarmOpenStorageFractionLimit = Sum(StorageTypes,StorageData('Capacity',StorageTypes)*OpenStorageMethodSelection(StorageTypes));

EnsilingDryMatterLossRate = Sum(StorageTypes,StorageData('DryMatterLoss',StorageTypes)*EnsilingMethodSelection(StorageTypes));
SilagePitDepth = Sum(StorageTypes,StorageData('Height',StorageTypes)*EnsilingMethodSelection(StorageTypes));
SilagePitFractionLimit = Sum(StorageTypes,StorageData('Capacity',StorageTypes)*EnsilingMethodSelection(StorageTypes));
EnsilingBulkDensity = Sum(StorageTypes,StorageData('BulkDensity',StorageTypes)*EnsilingMethodSelection(StorageTypes));

CentralStorageDryMatterLossRate = Sum(StorageTypes,StorageData('DryMatterLoss',StorageTypes)*CentralStorageMethodSelection(StorageTypes));
CentralStorageFacilityHeight = Sum(StorageTypes,StorageData('Height',StorageTypes)*CentralStorageMethodSelection(StorageTypes))*2;
CentralStorageAreaLimit = Sum(StorageTypes,StorageData('AreaMaximum',StorageTypes)*CentralStorageMethodSelection(StorageTypes));

CentralStorageSmallScaleDryMatterLossRate = Sum(StorageTypes,StorageSmallScaleData('DryMatterLoss',StorageTypes)*CentralStorageSmallScaleMethodSelection(StorageTypes));
CentralStorageSmallScaleFacilityHeight = Sum(StorageTypes,StorageSmallScaleData('Height',StorageTypes)*CentralStorageSmallScaleMethodSelection(StorageTypes))*2;
CentralStorageSmallScaleAreaLimit = Sum(StorageTypes,StorageSmallScaleData('AreaMaximum',StorageTypes)*CentralStorageSmallScaleMethodSelection(StorageTypes));

CentralStorageProcessingData(StorageProcessorAttributes)=sum(StorageProcessorTypes, StorageProcessorData(StorageProcessorAttributes,StorageProcessorTypes)
                                                                 * CentralStorageProcessingSelection(StorageProcessorTypes)
                                                         );

CentralStorageSmallScaleProcessingData(StorageProcessorAttributes)=sum(StorageProcessorTypes, StorageSmallScaleProcessorData(StorageSmallScaleProcessorAttributes,StorageSmallScaleProcessorTypes)
                                                                 * CentralStorageSmallScaleProcessingSelection(StorageProcessorTypes)
                                                         );

CentralStorageRefineryTruckCorrelation(CentralizedStorageLocations,TransportationTypes)=1;
CentralStorageRegionalTruckCorrelation(CentralizedStorageLocations,TransportationTypes)=1;
CentralStorageSmallScaleRefineryTruckCorrelation(CentralizedStorageSmallScaleLocations,TransportationTypes)=1;
CentralStorageSmallScaleRegionalTruckCorrelation(CentralizedStorageSmallScaleLocations,TransportationTypes)=1;
CentralStorageRefineryTruckCorrelation(CentralizedStorageLocations,TransportationTypes)
                 $(CentralStorageProcessing and CentralStorageProcessingData('OutputForm')<>TransportationData('InputForm',TransportationTypes))
                 = 0;
CentralStorageRegionalTruckCorrelation(CentralizedStorageLocations,TransportationTypes)
                 $(CentralStorageProcessing and CentralStorageProcessingData('OutputForm')<>TransportationData('InputForm',TransportationTypes))
                 = 0;
CentralStorageSmallScaleRefineryTruckCorrelation(CentralizedStorageSmallScaleLocations,TransportationTypes)
                 $(CentralStorageSmallScaleProcessing and CentralStorageSmallScaleProcessingData('OutputForm')<>TransportationData('InputForm',TransportationTypes))
                 = 0;
CentralStorageSmallScaleRegionalTruckCorrelation(CentralizedStorageSmallScaleLocations,TransportationTypes)
                 $(CentralStorageSmallScaleProcessing and CentralStorageSmallScaleProcessingData('OutputForm')<>TransportationData('InputForm',TransportationTypes))
                 = 0;


Display HarvesterCapacity, FarmRefineryTransportationTime,   FarmCentralStorageTransportationTime, CentralStorageRefineryTransportationTime,
        FarmCoveredStorageDryMatterLossRate, FarmCoveredStorageFacilityHeight, FarmCoveredStorageFractionLimit,
        FarmOpenStorageDryMatterLossRate, FarmOpenStorageFacilityHeight, FarmOpenStorageFractionLimit,
        EnsilingDryMatterLossRate, SilagePitDepth, SilagePitFractionLimit, EnsilingBulkDensity, CentralStorageAreaLimit, CentralStorageFacilityHeight,
        CentralStorageProcessingData;

