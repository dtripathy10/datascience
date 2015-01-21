$title Storing the results of individual farm optimization problems in parameters for future use

*--------------------------------------------------------------------------------------------
* Storing the harvesting schedule
*--------------------------------------------------------------------------------------------
* parameters here are obtained from the results of production model
* uncomment the appropriate lines of code so that no dummy data is selected
*Par_FarmHarvestSchedule(CountySelected,FarmNumber,HarvestingHorizonAggregation)=TotalHarvest.l(HarvetingHorizonAggregation);
*

Par_FarmHarvestSchedule(CountySelected,FarmNumber,HarvestingHorizonAggregation)=2;
*--------------------------------------------------------------------------------------------
* Storing the machine selection decisions
*--------------------------------------------------------------------------------------------

*Par_FarmHarvesterSelection(CountySelected,FarmNumber,HarvesterTypes)$(not(HarvesterSelectionDecision(FarmNumber))) = NumberOfHarvesters.l(HarvesterTypes);
Par_FarmHarvesterSelection(CountySelected,FarmNumber,HarvesterTypes)$(not(HarvesterSelectionDecision(FarmNumber)))=1;
*Par_FarmRakerSelection(CountySelected,FarmNumber,RakeTypes)=NumberOfRakers.l(RakeTypes);
Par_FarmRakerSelection(CountySelected,FarmNumber,RakeTypes)=3;
*Par_FarmFieldLoaderSelection(CountySelected,FarmNumber,FieldLoaderTypes)=NumberOfFieldLoaders.l(FieldLoaderTypes);
Par_FarmFieldLoaderSelection(CountySelected,FarmNumber,FieldLoaderTypes)=2;
*Par_FarmBalerSelection(CountySelected,FarmNumber,BalerTypes)$(not(BalerSelectionDecision(FarmNumber)))=NumberOfBalers.l(BalerTypes);
Par_FarmBalerSelection(CountySelected,FarmNumber,BalerTypes)$(not(BalerSelectionDecision(FarmNumber)))=10;
*Par_FarmChopperSelection(CountySelected,FarmNumber,ChopperTypes)$(not(ChopperSelectionDecision(FarmNumber)))=NumberOfChoppers.l(ChopperTypes);
Par_FarmChopperSelection(CountySelected,FarmNumber,ChopperTypes)$(not(ChopperSelectionDecision(FarmNumber)))=11;
*Par_FarmPelletizerSelection(CountySelected,FarmNumber,PelletizerTypes)$(not(PelletizerSelectionDecision(FarmNumber)))=NumberOfPelletizers.l(PelletizerTypes);
Par_FarmPelletizerSelection(CountySelected,FarmNumber,PelletizerTypes)$(not(PelletizerSelectionDecision(FarmNumber)))=5;
*Par_FarmGrinderSelection(CountySelected,FarmNumber,GrinderTypes)$(not(GrinderSelectionDecision(FarmNumber)))=NumberOfGrinders.l(GrinderTypes);
Par_FarmGrinderSelection(CountySelected,FarmNumber,GrinderTypes)$(not(GrinderSelectionDecision(FarmNumber)))=4;
*Par_NumberOfLoaders(CountySelected,FarmNumber,LoaderTypes)$(not(LoaderSelectionDecision(FarmNumber))) = NumberOfLoaders.l(LoaderTypes);
Par_NumberOfLoaders(CountySelected,FarmNumber,LoaderTypes)$(not(LoaderSelectionDecision(FarmNumber)))=7;
*Par_InFieldTransportationSelection(CountySelected,FarmNumber,InFieldTransportationTypes)$(not(InfieldTransportationSelectionDecision(FarmNumber))) = InFieldTransportationEquipmentNumber.l(InFieldTransportationTypes);
Par_InFieldTransportationSelection(CountySelected,FarmNumber,InFieldTransportationTypes)$(not(InfieldTransportationSelectionDecision(FarmNumber)))=6;
*Par_FarmHarvesterSelection(CountySelected,FarmNumber,HarvesterTypes)$(HarvesterSelectionDecision(FarmNumber)) = NumberOfHarvestersPredefined(CountySelected,FarmNumber,HarvesterTypes);
Par_FarmHarvesterSelection(CountySelected,FarmNumber,HarvesterTypes)$(HarvesterSelectionDecision(FarmNumber))=9;
*Par_FarmRakerSelection(CountySelected,FarmNumber,RakeTypes)=NumberOfRakers.l(RakeTypes);
Par_FarmRakerSelection(CountySelected,FarmNumber,RakeTypes)=11;
*Par_FarmFieldLoaderSelection(CountySelected,FarmNumber,FieldLoaderTypes)=NumberOfFieldLoaders.l(FieldLoaderTypes);
Par_FarmFieldLoaderSelection(CountySelected,FarmNumber,FieldLoaderTypes)=18;
*Par_FarmBalerSelection(CountySelected,FarmNumber,BalerTypes)$(BalerSelectionDecision(FarmNumber))=NumberOfBalersPredefined(CountySelected,FarmNumber,BalerTypes);
Par_FarmBalerSelection(CountySelected,FarmNumber,BalerTypes)$(BalerSelectionDecision(FarmNumber))=3;
*Par_FarmChopperSelection(CountySelected,FarmNumber,ChopperTypes)$(ChopperSelectionDecision(FarmNumber))=NumberOfChoppersPredefined(CountySelected,FarmNumber,ChopperTypes);
Par_FarmChopperSelection(CountySelected,FarmNumber,ChopperTypes)$(ChopperSelectionDecision(FarmNumber))=21;
*Par_FarmPelletizerSelection(CountySelected,FarmNumber,PelletizerTypes)$(PelletizerSelectionDecision(FarmNumber))=NumberOfPelletizersPredefined(CountySelected,FarmNumber,PelletizerTypes);
Par_FarmPelletizerSelection(CountySelected,FarmNumber,PelletizerTypes)$(PelletizerSelectionDecision(FarmNumber))=10;
*Par_FarmGrinderSelection(CountySelected,FarmNumber,GrinderTypes)$(GrinderSelectionDecision(FarmNumber))=NumberOfGrindersPredefined(CountySelected,FarmNumber,GrinderTypes);
Par_FarmGrinderSelection(CountySelected,FarmNumber,GrinderTypes)$(GrinderSelectionDecision(FarmNumber))=20;
*Par_NumberOfLoaders(CountySelected,FarmNumber,LoaderTypes)$(LoaderSelectionDecision(FarmNumber)) = LoaderMachineSelection(CountySelected,FarmNumber,LoaderTypes);
Par_NumberOfLoaders(CountySelected,FarmNumber,LoaderTypes)$(LoaderSelectionDecision(FarmNumber))=8;
*Par_InFieldTransportationSelection(CountySelected,FarmNumber,InFieldTransportationTypes)$(InfieldTransportationSelectionDecision(FarmNumber)) = InFieldTransportSelection(CountySelected,FarmNumber,InFieldTransportationTypes);
Par_InFieldTransportationSelection(CountySelected,FarmNumber,InFieldTransportationTypes)$(InfieldTransportationSelectionDecision(FarmNumber))=12;
*--------------------------------------------------------------------------------------------
* Storing the packing related variables
*--------------------------------------------------------------------------------------------
*
* Calculating the final density of the biomass generated by each farm. Please note that the model allows only one type of packing
* option per farm. So in the following equation, only one term will be non-zero, which will lead to the correct packing density.
* The packing density for ensiling is typically higher. However, it is possible that if some of the chopped biomass is sent for ensiling
* while the rest is sent for transportation as loose biomass, the density will be wrongly calculated. Here, we are assuming that even
* if biomass is ensiled, it is removed from the silage pit before transportation. Which means that packed biomass will probably regain its loose
* biomass density (which is a function of the chopper). Hence for the transportation, even if biomass is ensiled, the output density is taken
* as the density of the loose biomass after chopping.

$ontext
Par_FarmPackingDensity(CountySelected,FarmNumber) = sum(BalerTypes,BalerSelector.l(BalerTypes)*BalerData('PackingDensity',BalerTypes))
                                                    +
                                                    sum(ChopperTypes,ChopperSelector.l(ChopperTypes)*ChopperData('BulkDensity',ChopperTypes))
                                                    +
                                                    sum(PelletizerTypes,PelletizerSelector.l(PelletizerTypes)*PelletizerData('PackingDensity',PelletizerTypes))
                                                    +
                                                    sum(GrinderTypes,GrinderSelector.l(GrinderTypes)*GrinderData('BulkDensity',GrinderTypes))
                                                    +
                                                    sum(HarvesterTypes, HarvesterSelector.l(HarvesterTypes)*HarvesterData('BiomassOutputDensity',HarvesterTypes))
                                                         $(sum(PackingTypes,PackingSelection.l(PackingTypes))=0)
                                                    ;
$offtext
Par_FarmPackingDensity(CountySelected,FarmNumber)=20;
$ontext
Par_FarmBiomassBaledUnits(CountySelected,FarmNumber,BalerTypes) =
                         sum(HarvestingHorizonAggregation,
                                 BiomassUnitsBaled.l(HarvestingHorizonAggregation,BalerTypes)
                         );
$offtext
Par_FarmBiomassBaledUnits(CountySelected,FarmNumber,BalerTypes)=25;
$ontext
Par_FarmBiomassForm(CountySelected,FarmNumber)$(not(BalerSelectionDecision(FarmNumber)) and not(ChopperSelectionDecision(FarmNumber))
                 and not(GrinderSelectionDecision(FarmNumber)) and not(PelletizerSelectionDecision(FarmNumber)))
                 =
                 round(
                 sum(BalerTypes,BalerSelector.l(BalerTypes)*BalerData('OutputForm',BalerTypes))
                 +
                 sum(ChopperTypes,ChopperSelector.l(ChopperTypes)*ChopperData('OutputForm',ChopperTypes))
                 +
                 sum(GrinderTypes,GrinderSelector.l(GrinderTypes)*GrinderData('OutputForm',GrinderTypes))
                 +
                 sum(PelletizerTypes,PelletizerSelector.l(PelletizerTypes)*PelletizerData('OutputForm',PelletizerTypes))
                 +
                 sum(HarvesterTypes, HarvesterSelector.l(HarvesterTypes)*HarvesterData('OutputForm',HarvesterTypes))
                                                         $(sum(PackingTypes,PackingSelection.l(PackingTypes))=0)
                 )
                 ;
$offtext
Par_FarmBiomassForm(CountySelected,FarmNumber)$(not(BalerSelectionDecision(FarmNumber)) and not(ChopperSelectionDecision(FarmNumber))
                 and not(GrinderSelectionDecision(FarmNumber)) and not(PelletizerSelectionDecision(FarmNumber)))
                 =2;
$ontext
Par_FarmBiomassForm(CountySelected,FarmNumber)$(BalerSelectionDecision(FarmNumber) or ChopperSelectionDecision(FarmNumber)
                 or GrinderSelectionDecision(FarmNumber) or PelletizerSelectionDecision(FarmNumber))
                 =
                 round(
                 smax(BalerTypes,BalerData('OutputForm',BalerTypes))$(BalerSelectionDecision(FarmNumber))
                 +
                 smax(ChopperTypes,ChopperData('OutputForm',ChopperTypes))$(ChopperSelectionDecision(FarmNumber))
                 +
                 smax(GrinderTypes,GrinderData('OutputForm',GrinderTypes))$(GrinderSelectionDecision(FarmNumber))
                 +
                 smax(PelletizerTypes,PelletizerData('OutputForm',PelletizerTypes))$(PelletizerSelectionDecision(FarmNumber))
                 )
                 ;
$offtext
Par_FarmBiomassForm(CountySelected,FarmNumber)$(BalerSelectionDecision(FarmNumber) or ChopperSelectionDecision(FarmNumber)
                 or GrinderSelectionDecision(FarmNumber) or PelletizerSelectionDecision(FarmNumber))= 1;
*Par_LoadingRepetitions(HarvestingHorizonAggregation,CountySelected,FarmNumber,LoaderTypes) =  NumberOfRepetitions.l(HarvestingHorizonAggregation,LoaderTypes);
Par_LoadingRepetitions(HarvestingHorizonAggregation,CountySelected,FarmNumber,LoaderTypes)=3;
*Par_LoadingRepetitions(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,LoaderTypes) =  NumberOfRepetitions.l(NonHarvestingHorizonAggregation,LoaderTypes);
Par_LoadingRepetitions(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,LoaderTypes)=2;
*Par_InFieldTrips(HarvestingHorizonAggregation,CountySelected,FarmNumber,InFieldTransportationTypes) = InFieldTrips.l(HarvestingHorizonAggregation,InFieldTransportationTypes);
Par_InFieldTrips(HarvestingHorizonAggregation,CountySelected,FarmNumber,InFieldTransportationTypes)=5;
*--------------------------------------------------------------------------------------------
* Storing the biomass availability and biomass distribution on a farm
*--------------------------------------------------------------------------------------------

*Par_FarmGateBiomassAvailability(HarvestingHorizonAggregation,CountySelected,FarmNumber)=FarmGateTotalBiomass.l(HarvestingHorizonAggregation);
Par_FarmGateBiomassAvailability(HarvestingHorizonAggregation,CountySelected,FarmNumber)=0;

*Parameter par_dummy(FarmNumber);
*$libinclude xlimport par_dummy production.xls prod!A1:A200
*Par_FarmGateBiomassAvailability(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)=FarmGateTotalBiomass.l(NonHarvestingHorizonAggregation);



Par_FarmGateBiomassAvailability(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)=0;
$CALL GDXXRW.EXE production.xls par=par_dummy rng=prod!
Parameter par_dummy(FarmNumber,z);
$GDXIN production.gdx
$LOAD par_dummy
$GDXIN


*Display par_dummy;

Par_FarmGateBiomassAvailability('1',CountySelected,FarmNumber)= par_dummy(FarmNumber,'1');
*Par_FarmBiomassDistribution(CountySelected,FarmNumber,'HarvestToFarmGate')=
*                                sum(HarvestingHorizonAggregation,BiomassPackingToFarmGate.l(HarvestingHorizonAggregation))
*                                         *card(HarvestingHorizonAggregationStep);
Par_FarmBiomassDistribution(CountySelected,FarmNumber,'HarvestToFarmGate')=21;
*Par_FarmBiomassDistribution(CountySelected,FarmNumber,'HarvestToFarmCoveredStorage')=
*                                 sum(HarvestingHorizonAggregation,BiomassPackingToFarmCoveredStorage.l(HarvestingHorizonAggregation))
*                                         *card(HarvestingHorizonAggregationStep);
*Par_FarmBiomassDistribution(CountySelected,FarmNumber,'HarvestToFarmCoveredStorage')=23;
*Par_FarmBiomassDistribution(CountySelected,FarmNumber,'HarvestToFarmOpenStorage')=
*                                 sum(HarvestingHorizonAggregation,BiomassPackingToFarmOpenStorage.l(HarvestingHorizonAggregation))
*                                         *card(HarvestingHorizonAggregationStep);
*Par_FarmBiomassDistribution(CountySelected,FarmNumber,'HarvestToFarmOpenStorage')=28;
*Par_FarmBiomassDistribution(CountySelected,FarmNumber,'HarvestToEnsiling')=
*                                 sum(HarvestingHorizonAggregation,BiomassRakingToEnsiling.l(HarvestingHorizonAggregation))
*                                         *card(HarvestingHorizonAggregationStep);
*Par_FarmBiomassDistribution(CountySelected,FarmNumber,'HarvestToEnsiling')=11;
*Par_FarmBiomassDistribution(CountySelected,FarmNumber,'FarmCoveredStorageToFarmGate')=
*                                 sum((HarvestingHorizonAggregation,HarvestingHorizonAggregation2),
*                                         FarmCoveredStorageOutput.l(HarvestingHorizonAggregation,HarvestingHorizonAggregation2))
*                                         *card(HarvestingHorizonAggregationStep)
*                                +
*                                 sum((NonHarvestingHorizonAggregation,HarvestingHorizonAggregation2),
*                                         FarmCoveredStorageOutput.l(NonHarvestingHorizonAggregation,HarvestingHorizonAggregation2))
*                                         *card(NonHarvestingHorizonAggregationStep);
Par_FarmBiomassDistribution(CountySelected,FarmNumber,'FarmCoveredStorageToFarmGate')=12;
*Par_FarmBiomassDistribution(CountySelected,FarmNumber,'FarmOpenStorageToFarmGate')=
*                                 sum((HarvestingHorizonAggregation,HarvestingHorizonAggregation2),
*                                         FarmOpenStorageOutput.l(HarvestingHorizonAggregation,HarvestingHorizonAggregation2))
*                                         *card(HarvestingHorizonAggregationStep)
*                                 +
*                                 sum((NonHarvestingHorizonAggregation,HarvestingHorizonAggregation2),
*                                         FarmOpenStorageOutput.l(NonHarvestingHorizonAggregation,HarvestingHorizonAggregation2))
*                                         *card(NonHarvestingHorizonAggregationStep);
Par_FarmBiomassDistribution(CountySelected,FarmNumber,'FarmOpenStorageToFarmGate')= 15;
*Par_FarmBiomassDistribution(CountySelected,FarmNumber,'EnsilingToFarmGate')=
*                                 sum((NonHarvestingHorizonAggregation,HarvestingHorizonAggregation2),
*                                         FarmEnsilingOutput.l(NonHarvestingHorizonAggregation,HarvestingHorizonAggregation2))
*                                         *card(NonHarvestingHorizonAggregationStep);
Par_FarmBiomassDistribution(CountySelected,FarmNumber,'EnsilingToFarmGate')=11;

*--------------------------------------------------------------------------------------------
* Storing the distribution of biomass among different storage locations
*--------------------------------------------------------------------------------------------
Par_FarmStorageConfiguration(CountySelected,FarmNumber,'Open') =  0;
Par_FarmStorageConfiguration(CountySelected,FarmNumber,'Covered') =  0;

*Par_FarmStorageConfiguration(CountySelected,FarmNumber,'Open')$(not(FarmOpenStorageDecision(FarmNumber))) =  FarmOpenStorageFacilityArea.l;
Par_FarmStorageConfiguration(CountySelected,FarmNumber,'Open')$(not(FarmOpenStorageDecision(FarmNumber))) =2;
*Par_FarmStorageConfiguration(CountySelected,FarmNumber,'Covered')$(not(FarmCoveredStorageDecision(FarmNumber))) =  FarmCoveredStorageFacilityArea.l;
Par_FarmStorageConfiguration(CountySelected,FarmNumber,'Covered')$(not(FarmCoveredStorageDecision(FarmNumber))) = 1;
*Par_FarmStorageConfiguration(CountySelected,FarmNumber,'SilagePit') =  SilagePitArea.l;
Par_FarmStorageConfiguration(CountySelected,FarmNumber,'SilagePit') =1;
Par_FarmStorageConfiguration(CountySelected,FarmNumber,'Open')$(FarmOpenStorageDecision(FarmNumber)) =  sum(StorageTypes, FarmOpenStorageSizePredefined(CountySelected,FarmNumber,StorageTypes));
Par_FarmStorageConfiguration(CountySelected,FarmNumber,'Covered')$(FarmCoveredStorageDecision(FarmNumber)) =  sum(StorageTypes, FarmCoveredStorageSizePredefined(CountySelected,FarmNumber,StorageTypes));
Par_FarmStorageConfiguration(CountySelected,FarmNumber,'SilagePit') = 0;

*--------------------------------------------------------------------------------------------
* Storing the distribution of biomass among different streams
*--------------------------------------------------------------------------------------------
*Par_HarvestToFarmGate(HarvestingHorizonAggregation,CountySelected,FarmNumber)
*                                 =
*                                 BiomassHarvestToFarmGate.l(HarvestingHorizonAggregation)
*                                 +
*                                 BiomassRakingToFarmGate.l(HarvestingHorizonAggregation)
*                                 +
*                                 BiomassOnFarmToFarmGate.l(HarvestingHorizonAggregation)
*                                 +
*                                 BiomassPackingToFarmGate.l(HarvestingHorizonAggregation)
*                                 +
*                                 BiomassLoadingToFarmGate.l(HarvestingHorizonAggregation)
*                                 ;
Par_HarvestToFarmGate(HarvestingHorizonAggregation,CountySelected,FarmNumber)=10;
$ontext
Par_HarvestToFarmCoveredStorage(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                         =
                         BiomassHarvestToCoveredStorage.l(HarvestingHorizonAggregation)
                         +
                         BiomassRakingToCoveredStorage.l(HarvestingHorizonAggregation)
                         +
                         BiomassOnFarmToCoveredStorage.l(HarvestingHorizonAggregation)
                         +
                         BiomassPackingToFarmCoveredStorage.l(HarvestingHorizonAggregation)
                         +
                         BiomassLoadingToCoveredStorage.l(HarvestingHorizonAggregation);
$offtext
Par_HarvestToFarmCoveredStorage(HarvestingHorizonAggregation,CountySelected,FarmNumber)=12;
$ontext
Par_HarvestToFarmOpenStorage(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                         =
                         BiomassHarvestToOpenStorage.l(HarvestingHorizonAggregation)
                         +
                         BiomassRakingToOpenStorage.l(HarvestingHorizonAggregation)
                         +
                         BiomassOnFarmToOpenStorage.l(HarvestingHorizonAggregation)
                         +
                         BiomassPackingToFarmOpenStorage.l(HarvestingHorizonAggregation)
                         +
                         BiomassLoadingToOpenStorage.l(HarvestingHorizonAggregation);
$offtext
Par_HarvestToFarmOpenStorage(HarvestingHorizonAggregation,CountySelected,FarmNumber)=15;
$ontext
Par_HarvestToEnsiling(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                         =
                         BiomassHarvestToEnsiling.l(HarvestingHorizonAggregation)
                         +
                         BiomassRakingToEnsiling.l(HarvestingHorizonAggregation)
                         +
                         BiomassOnFarmToEnsiling.l(HarvestingHorizonAggregation)
                         +
                         BiomassRakingToEnsiling.l(HarvestingHorizonAggregation);
$offtext
Par_HarvestToEnsiling(HarvestingHorizonAggregation,CountySelected,FarmNumber)=18;

*Par_FarmCoveredStorageToFarmGate(HarvestingHorizonAggregation,CountySelected,FarmNumber)=
*                         sum(HarvestingHorizonAggregation2,
*                                 FarmCoveredStorageOutput.l(HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
*                         );
Par_FarmCoveredStorageToFarmGate(HarvestingHorizonAggregation,CountySelected,FarmNumber)=12;
*Par_FarmCoveredStorageToFarmGate(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)=
*                         sum(HarvestingHorizonAggregation,
*                                  FarmCoveredStorageOutput.l(NonHarvestingHorizonAggregation,HarvestingHorizonAggregation)
*                         );
Par_FarmCoveredStorageToFarmGate(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)=15;
*Par_FarmOpenStorageToFarmGate(HarvestingHorizonAggregation,CountySelected,FarmNumber)=
*                         sum(HarvestingHorizonAggregation2,
*                                  FarmOpenStorageOutput.l(HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
*                         );
Par_FarmOpenStorageToFarmGate(HarvestingHorizonAggregation,CountySelected,FarmNumber)=20;
*Par_FarmOpenStorageToFarmGate(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)=
*                         sum(HarvestingHorizonAggregation,
*                                 FarmOpenStorageOutput.l(NonHarvestingHorizonAggregation,HarvestingHorizonAggregation)
*                         );
Par_FarmOpenStorageToFarmGate(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)=22;
Par_EnsilingToFarmGate(HarvestingHorizonAggregation,CountySelected,FarmNumber)=0;
*Par_EnsilingToFarmGate(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)=
*                         sum(HarvestingHorizonAggregation,
*                                  FarmEnsilingOutput.l(NonHarvestingHorizonAggregation,HarvestingHorizonAggregation)
*                         );
Par_EnsilingToFarmGate(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)=25;
*--------------------------------------------------------------------------------------------
* Calculating the final delivered biomass for the given farm
*--------------------------------------------------------------------------------------------
*
* Calculting the base farm gate cost for each individual farm that is used later to determine the farm gate price profile
*
Par_FarmGateTotalBiomass(CountySelected,FarmNumber) = sum(HarvestingHorizonAggregation,
                                                         Par_FarmGateBiomassAvailability(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                                         *card(HarvestingHorizonAggregationStep)
                                                      )
                                                      +
                                                      sum(NonHarvestingHorizonAggregation,
                                                         Par_FarmGateBiomassAvailability(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                                                         *card(NonHarvestingHorizonAggregationStep)
                                                      );

*--------------------------------------------------------------------------------------------
* Storing the cost values
*--------------------------------------------------------------------------------------------
*Par_FarmCost(CountySelected,FarmNumber)=TotalFarmCost.l;
Par_FarmCost(CountySelected,FarmNumber)=1000;
*Par_HarvestingCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) = TotalHarvestingCost.l/Par_FarmGateTotalBiomass(CountySelected,FarmNumber);
Par_HarvestingCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) =150;
*Par_HarvestingFixedCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) = HarvestingCapitalCost.l/Par_FarmGateTotalBiomass(CountySelected,FarmNumber);
Par_HarvestingFixedCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) = 120;
*Par_HarvestingOperatingCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) = HarvestingOperatingCost.l/Par_FarmGateTotalBiomass(CountySelected,FarmNumber);
Par_HarvestingOperatingCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber))=30;
*Par_FieldLoadingCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) = TotalFieldLoadingCost.l/Par_FarmGateTotalBiomass(CountySelected,FarmNumber);
Par_FieldLoadingCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber))=150;
*Par_FieldLoadingFixedCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) = FieldLoadingCapitalCost.l/Par_FarmGateTotalBiomass(CountySelected,FarmNumber);
Par_FieldLoadingFixedCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber))=20;
*Par_FieldLoadingOperatingCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) = FieldLoadingOperatingCost.l/Par_FarmGateTotalBiomass(CountySelected,FarmNumber);
Par_FieldLoadingOperatingCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) =25;
*Par_RakingCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) = TotalRakingCost.l/Par_FarmGateTotalBiomass(CountySelected,FarmNumber);
Par_RakingCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) =30;
*Par_RakingFixedCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) = RakingCapitalCost.l/Par_FarmGateTotalBiomass(CountySelected,FarmNumber);
Par_RakingFixedCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) =40;
*Par_RakingOperatingCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) = RakingOperatingCost.l/Par_FarmGateTotalBiomass(CountySelected,FarmNumber);
Par_RakingOperatingCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) =50;
*Par_PackingCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) = TotalPackingCost.l/Par_FarmGateTotalBiomass(CountySelected,FarmNumber);
Par_PackingCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) = 115;
*Par_PackingOperatingCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) = PackingOperatingCost.l/Par_FarmGateTotalBiomass(CountySelected,FarmNumber);
Par_PackingOperatingCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) =55;
*Par_PackingFixedCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) = PackingCapitalCost.l/Par_FarmGateTotalBiomass(CountySelected,FarmNumber);
Par_PackingFixedCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber))=60;
*Par_FarmStorageCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) = FarmStorageCost.l/Par_FarmGateTotalBiomass(CountySelected,FarmNumber);
Par_FarmStorageCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) =40;
*Par_InFieldTransportationCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) = InFieldTransportationCost.l/Par_FarmGateTotalBiomass(CountySelected,FarmNumber);
Par_InFieldTransportationCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber))=100;
*Par_InFieldTransportationFixedCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) = InFieldTransportationCapitalCost.l/Par_FarmGateTotalBiomass(CountySelected,FarmNumber);
Par_InFieldTransportationFixedCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) =50;
*Par_InFieldTransportationOperatingCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) = InFieldTransportationOperatingCost.l/Par_FarmGateTotalBiomass(CountySelected,FarmNumber);
Par_InFieldTransportationOperatingCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) = 50;
*Par_FarmBiomassHandlingCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) = FarmBiomassHandlingCost.l/Par_FarmGateTotalBiomass(CountySelected,FarmNumber);
Par_FarmBiomassHandlingCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) =120;
*Par_FarmBiomassHandlingFixedCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) = FarmBiomassHandlingCapitalCost.l/Par_FarmGateTotalBiomass(CountySelected,FarmNumber);
Par_FarmBiomassHandlingFixedCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber))=70;
*Par_FarmBiomassHandlingOperatingCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) = FarmBiomassHandlingOperatingCost.l/Par_FarmGateTotalBiomass(CountySelected,FarmNumber);
Par_FarmBiomassHandlingOperatingCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) =50;

*Par_FarmProfit(CountySelected,FarmNumber)=TotalFarmProfit.l;
Par_FarmProfit(CountySelected,FarmNumber)=1000;
Par_FarmGateBiomassCost(CountySelected,FarmNumber)$(Par_FarmGateTotalBiomass(CountySelected,FarmNumber)) = Par_FarmCost(CountySelected,FarmNumber)/Par_FarmGateTotalBiomass(CountySelected,FarmNumber);

*Par_TotalBiomassHarvested(CountySelected,FarmNumber)  = sum((HarvestingHorizonAggregation,HarvesterTypes), BiomassHarvest.l(HarvestingHorizonAggregation,HarvesterTypes)*card(HarvestingHorizonAggregationStep) );
Par_TotalBiomassHarvested(CountySelected,FarmNumber)  =1200;
*-----------------------------------------------------------------------------------------
* Calculation of the energy consumption and greenhouse gas emission calculations
*-----------------------------------------------------------------------------------------
*
* The energy consumption is calculated by first computing the number of hours
* each equipment is operated. Then the rated power and the Nebrasta Tractor Test data is used to calculate the average fuel
* consumption for the equipment in gallons per hour. The multiplication of the two gives the total gallons used by that maching which
* is then converted into MJ (energy units) using the calorific value of diesel fuel.
*
*Par_EnergyConsumptionHarvesting(CountySelected,FarmNumber) = HarvestingEnergyConsumption.l;
Par_EnergyConsumptionHarvesting(CountySelected,FarmNumber) = 120;
*Par_EnergyConsumptionFieldLoading(CountySelected,FarmNumber) = FieldLoadingEnergyConsumption.l;
Par_EnergyConsumptionFieldLoading(CountySelected,FarmNumber) =100;
*Par_EnergyConsumptionRaking(CountySelected,FarmNumber) = RakingEnergyConsumption.l;
Par_EnergyConsumptionRaking(CountySelected,FarmNumber)=110;
*Par_EnergyConsumptionPacking(CountySelected,FarmNumber) = PackingEnergyConsumption.l;
Par_EnergyConsumptionPacking(CountySelected,FarmNumber) =120;
*Par_EnergyConsumptionInfieldTransportation(CountySelected,FarmNumber) = InFieldTransportationEnergyConsumption.l;
Par_EnergyConsumptionInfieldTransportation(CountySelected,FarmNumber)=150;
*Par_EnergyConsumptionFarmBiomassHandling(CountySelected,FarmNumber) = FarmBiomassHandlingEnergyConsumption.l;
Par_EnergyConsumptionFarmBiomassHandling(CountySelected,FarmNumber) =160;

*
* The GHG emission is calculated by first computing the number of hours
* each equipment is operated. Then the rated power and the Nebrasta Tractor Test data is used to calculate the average fuel
* consumption for the equipment in gallons per hour. The multiplication of the two gives the total gallons used by that maching which
* is then converted into green house gas (CO2) emission by using the average GHG emission factor for diesel fuel.
*
$ontext
Par_GHGEmissionHarvesting(CountySelected,FarmNumber) =
                 max(
                         sum((HarvestingHorizonAggregation,HarvesterTypes),
                                 BiomassHarvest.l(HarvestingHorizonAggregation,HarvesterTypes)
                                 * card(HarvestingHorizonAggregationStep)
                                 /
                                 (HarvesterData('Throughput',HarvesterTypes)*HarvesterData('Efficiency',HarvesterTypes))
                                 * (HarvesterData('FuelConsumption',HarvesterTypes)+HarvesterData('TractorFuelConsumption',HarvesterTypes))
                                 * DieselGHGEmissionFactor
                                 * HarvesterSelector.l(HarvesterTypes)
                         ),
                         sum((HarvestingHorizonAggregation,HarvesterTypes),
                                 HarvestRate.l(HarvestingHorizonAggregation,HarvesterTypes)
                                 * card(HarvestingHorizonAggregationStep)
                                 /
                                 (HarvesterCapacity(HarvesterTypes))
                                 * (HarvesterData('FuelConsumption',HarvesterTypes)+HarvesterData('TractorFuelConsumption',HarvesterTypes))
                                 * DieselGHGEmissionFactor
                                 * HarvesterSelector.l(HarvesterTypes)
                         )
                 );
$offtext
Par_GHGEmissionHarvesting(CountySelected,FarmNumber) =21;
$ontext
Par_GHGEmissionFieldLoading(CountySelected,FarmNumber)$(CropSelection('EnergyCane')) =
                 max(
                         sum((HarvestingHorizonAggregation,FieldLoaderTypes),
                                         BiomassLoaded.l(HarvestingHorizonAggregation,FieldLoaderTypes)
                                         *card(HarvestingHorizonAggregationStep)
                         /
                         (FieldLoaderData('Throughput',FieldLoaderTypes)*FieldLoaderData('Efficiency',FieldLoaderTypes))
                         * FieldLoaderData('FuelConsumption',FieldLoaderTypes)
                         * DieselGHGEmissionFactor
                         * FieldLoaderSelector.l(FieldLoaderTypes)
                         ),
                         sum((HarvestingHorizonAggregation,FieldLoaderTypes),
                                         BiomassLoaded.l(HarvestingHorizonAggregation,FieldLoaderTypes)
                                         *card(HarvestingHorizonAggregationStep)
                         /
                         (FieldLoaderData('Capacity',FieldLoaderTypes)* BiomassSupplyAggregation(HarvestingHorizonAggregation)
                                         * FieldLoaderData('Efficiency',FieldLoaderTypes))
                         * FieldLoaderData('FuelConsumption',FieldLoaderTypes)
                         * DieselGHGEmissionFactor
                         * FieldLoaderSelector.l(FieldLoaderTypes)
                         )
                 );
$offtext
Par_GHGEmissionFieldLoading(CountySelected,FarmNumber)$(CropSelection('EnergyCane')) = 25;
$ontext
Par_GHGEmissionRaking(CountySelected,FarmNumber) =
                 sum((HarvestingHorizonAggregation,RakeTypes),
                         RakingInput.l(HarvestingHorizonAggregation)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (RakeData('Throughput',RakeTypes)*RakeData('Efficiency',RakeTypes))
                         * RakeData('TractorFuelConsumption',RakeTypes)
                         * DieselGHGEmissionFactor
                         * RakerSelector.l(RakeTypes)
                 );
$offtext
Par_GHGEmissionRaking(CountySelected,FarmNumber) =30;
$ontext
Par_GHGEmissionPacking(CountySelected,FarmNumber) =
                 sum((HarvestingHorizonAggregation,BalerTypes),
                         BalerInput.l(HarvestingHorizonAggregation,BalerTypes)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (BalerData('DesignCapacity',BalerTypes)*BalerData('Efficiency',BalerTypes))
                         * (BalerData('FuelConsumption',BalerTypes) + BalerData('TractorFuelConsumption',BalerTypes))
                         * DieselGHGEmissionFactor
                 )$PackingOption('Baling')
                 +
                 sum((HarvestingHorizonAggregation,PelletizerTypes),
                         PelletizerInput.l(HarvestingHorizonAggregation,PelletizerTypes)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (PelletizerData('DesignCapacity',PelletizerTypes)*PelletizerData('Efficiency',PelletizerTypes))
                         * ( PelletizerData('CorrectedEMPower',PelletizerTypes) + PelletizerData('CorrectedEnergy',PelletizerTypes)) *ElectricityGHGEmissionFactor
*                         * PelletizerData('FuelConsumption',PelletizerTypes)
*                         * DieselGHGEmissionFactor
                 )$PackingOption('Pelletization')
                 +
                 sum((HarvestingHorizonAggregation,ChopperTypes),
                         ChopperInput.l(HarvestingHorizonAggregation,ChopperTypes)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (ChopperData('DesignCapacity',ChopperTypes)*ChopperData('Efficiency',ChopperTypes))
                         * ( ChopperData('FuelConsumption',ChopperTypes) * DieselGHGEmissionFactor * ChopperData('Mobile',ChopperTypes)
                             + ChopperData('CorrectedEMPower',ChopperTypes) * ElectricityGHGEmissionFactor * ChopperData('Stationary',ChopperTypes)
                           )
                 )$PackingOption('Chopping')
                 +
                 sum((HarvestingHorizonAggregation,GrinderTypes),
                         GrinderInput.l(HarvestingHorizonAggregation,GrinderTypes)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (GrinderData('DesignCapacity',GrinderTypes)*GrinderData('Efficiency',GrinderTypes))
                         * GrinderData('CorrectedEMPower',GrinderTypes)*ElectricityGHGEmissionFactor
*                         * GrinderData('FuelConsumption',GrinderTypes)
*                         * DieselGHGEmissionFactor
                 )$PackingOption('Grinding');
$offtext
Par_GHGEmissionPacking(CountySelected,FarmNumber) =35;
$ontext
Par_GHGEmissionInfieldTransportation(CountySelected,FarmNumber)$(CropSelection('Grass')) =
                       sum((HarvestingHorizonAggregation,InFieldTransportationTypes),
                                 InFieldTransportationTime.l(HarvestingHorizonAggregation,InFieldTransportationTypes)
                                 * InFieldTransportationData('FuelConsumption',InFieldTransportationTypes)
                                 * DieselGHGEmissionFactor
                       )*card(HarvestingHorizonAggregationStep);

$offtext
Par_GHGEmissionInfieldTransportation(CountySelected,FarmNumber)$(CropSelection('Grass')) =45;
$ontext
Par_GHGEmissionInfieldTransportation(CountySelected,FarmNumber)$(CropSelection('EnergyCane')) =
                       sum((HarvestingHorizonAggregation,InFieldTransportationTypes),
                                 InFieldTransportationTime.l(HarvestingHorizonAggregation,InFieldTransportationTypes)
                                 * ( InFieldTransportationData('FuelConsumption',InFieldTransportationTypes)
                                     + InFieldTransportationData('TractorFuelConsumption',InFieldTransportationTypes)
                                   )
                                 * DieselGHGEmissionFactor
                       )*card(HarvestingHorizonAggregationStep);
$offtext
Par_GHGEmissionInfieldTransportation(CountySelected,FarmNumber)$(CropSelection('EnergyCane')) =40;
$ontext
Par_GHGEmissionFarmBiomassHandling(CountySelected,FarmNumber) =
                       sum(LoaderTypes, BiomassHandlingTime.l(LoaderTypes)
                                 * LoaderData('FuelConsumption',LoaderTypes)
                                 * DieselGHGEmissionFactor
                       );
$offtext
Par_GHGEmissionFarmBiomassHandling(CountySelected,FarmNumber) =30;



$ontext
*not my comments
Par_EnergyConsumptionHarvesting(CountySelected,FarmNumber) =
                 sum((HarvestingHorizonAggregation,HarvesterTypes),
                         BiomassHarvest.l(HarvestingHorizonAggregation,HarvesterTypes)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (HarvesterData('Throughput',HarvesterTypes)*HarvesterData('Efficiency',HarvesterTypes))
                         * (HarvesterData('FuelConsumption',HarvesterTypes)+HarvesterData('TractorFuelConsumption',HarvesterTypes))
                         * 0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                         * HarvesterSelector.l(HarvesterTypes)
                 );


Par_EnergyConsumptionRaking(CountySelected,FarmNumber) =
                 sum((HarvestingHorizonAggregation,RakeTypes),
                         RakingInput.l(HarvestingHorizonAggregation)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (RakeData('Throughput',RakeTypes)*RakeData('Efficiency',RakeTypes))
                         * (RakeData('FuelConsumption',RakeTypes)+RakeData('TractorFuelConsumption',RakeTypes))
                         * 0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                         * RakerSelector.l(RakeTypes)
                 );

Par_EnergyConsumptionPacking(CountySelected,FarmNumber) =
                 sum((HarvestingHorizonAggregation,BalerTypes),
                         BalerInput.l(HarvestingHorizonAggregation,BalerTypes)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (BalerData('DesignCapacity',BalerTypes)*BalerData('Efficiency',BalerTypes))
                         * (BalerData('FuelConsumption',BalerTypes) + BalerData('TractorFuelConsumption',BalerTypes))
                         *0.00378 * DieselSpecificGravity * 1000 * DieselCalorificValue
                 )$PackingOption('Baling')
                 +
                 sum((HarvestingHorizonAggregation,PelletizerTypes),
                         PelletizerInput.l(HarvestingHorizonAggregation,PelletizerTypes)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (PelletizerData('DesignCapacity',PelletizerTypes)*PelletizerData('Efficiency',PelletizerTypes))
                         * PelletizerData('FuelConsumption',PelletizerTypes)
                         * 0.00378 * DieselSpecificGravity * 1000 * DieselCalorificValue
                 )$PackingOption('Pelletization')
                 +
                 sum((HarvestingHorizonAggregation,ChopperTypes),
                         ChopperInput.l(HarvestingHorizonAggregation,ChopperTypes)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (ChopperData('DesignCapacity',ChopperTypes)*ChopperData('Efficiency',ChopperTypes))
                         * ChopperData('FuelConsumption',ChopperTypes)
                         * 0.00378 * DieselSpecificGravity * 1000 * DieselCalorificValue
                 )$PackingOption('Chopping')
                 +
                 sum((HarvestingHorizonAggregation,GrinderTypes),
                         GrinderInput.l(HarvestingHorizonAggregation,GrinderTypes)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (GrinderData('DesignCapacity',GrinderTypes)*GrinderData('Efficiency',GrinderTypes))
                         * GrinderData('FuelConsumption',GrinderTypes)
                         * 0.00378 * DieselSpecificGravity * 1000 * DieselCalorificValue
                 )$PackingOption('Grinding');


Par_EnergyConsumptionInfieldTransportation(CountySelected,FarmNumber) =
                       sum((HarvestingHorizonAggregation,TransportationTypes),
                                 InFieldTransportationTime.l(HarvestingHorizonAggregation,TransportationTypes)
                                 * TransportationData('FuelConsumption',TransportationTypes)
                                 * 0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                       )*card(HarvestingHorizonAggregationStep);


Par_EnergyConsumptionFarmBiomassHandling(CountySelected,FarmNumber) =
                       sum(LoaderTypes, BiomassHandlingTime.l(LoaderTypes)
                                 * LoaderData('FuelConsumption',LoaderTypes)
                                 * 0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                       );


*
* The GHG emission is calculated by first computing the number of hours
* each equipment is operated. Then the rated power and the Nebrasta Tractor Test data is used to calculate the average fuel
* consumption for the equipment in gallons per hour. The multiplication of the two gives the total gallons used by that maching which
* is then converted into green house gas (CO2) emission by using the average GHG emission factor for diesel fuel.
*

Par_GHGEmissionHarvesting(CountySelected,FarmNumber) =
                 sum((HarvestingHorizonAggregation,HarvesterTypes),
                         BiomassHarvest.l(HarvestingHorizonAggregation,HarvesterTypes)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (HarvesterData('Throughput',HarvesterTypes)*HarvesterData('Efficiency',HarvesterTypes))
                         * (HarvesterData('FuelConsumption',HarvesterTypes)+HarvesterData('TractorFuelConsumption',HarvesterTypes))
                         * DieselGHGEmissionFactor
                         * HarvesterSelector.l(HarvesterTypes)
                 );


Par_GHGEmissionRaking(CountySelected,FarmNumber) =
                 sum((HarvestingHorizonAggregation,RakeTypes),
                         RakingInput.l(HarvestingHorizonAggregation)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (RakeData('Throughput',RakeTypes)*RakeData('Efficiency',RakeTypes))
                         * RakeData('TractorFuelConsumption',RakeTypes)
                         * DieselGHGEmissionFactor
                         * RakerSelector.l(RakeTypes)
                 );


Par_GHGEmissionPacking(CountySelected,FarmNumber) =
                 sum((HarvestingHorizonAggregation,BalerTypes),
                         BalerInput.l(HarvestingHorizonAggregation,BalerTypes)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (BalerData('DesignCapacity',BalerTypes)*BalerData('Efficiency',BalerTypes))
                         * (BalerData('FuelConsumption',BalerTypes) + BalerData('TractorFuelConsumption',BalerTypes))
                         * DieselGHGEmissionFactor
                 )$PackingOption('Baling')
                 +
                 sum((HarvestingHorizonAggregation,PelletizerTypes),
                         PelletizerInput.l(HarvestingHorizonAggregation,PelletizerTypes)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (PelletizerData('DesignCapacity',PelletizerTypes)*PelletizerData('Efficiency',PelletizerTypes))
                         * PelletizerData('FuelConsumption',PelletizerTypes)
                         * DieselGHGEmissionFactor
                 )$PackingOption('Pelletization')
                 +
                 sum((HarvestingHorizonAggregation,ChopperTypes),
                         ChopperInput.l(HarvestingHorizonAggregation,ChopperTypes)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (ChopperData('DesignCapacity',ChopperTypes)*ChopperData('Efficiency',ChopperTypes))
                         * ChopperData('FuelConsumption',ChopperTypes)
                         * DieselGHGEmissionFactor
                 )$PackingOption('Chopping')
                 +
                 sum((HarvestingHorizonAggregation,GrinderTypes),
                         GrinderInput.l(HarvestingHorizonAggregation,GrinderTypes)
                         * card(HarvestingHorizonAggregationStep)
                         /
                         (GrinderData('DesignCapacity',GrinderTypes)*GrinderData('Efficiency',GrinderTypes))
                         * GrinderData('FuelConsumption',GrinderTypes)
                         * DieselGHGEmissionFactor
                 )$PackingOption('Grinding');


Par_GHGEmissionInfieldTransportation(CountySelected,FarmNumber) =
                       sum((HarvestingHorizonAggregation,TransportationTypes),
                                 InFieldTransportationTime.l(HarvestingHorizonAggregation,TransportationTypes)
                                 * TransportationData('FuelConsumption',TransportationTypes)
                                 * DieselGHGEmissionFactor
                       )*card(HarvestingHorizonAggregationStep);


Par_GHGEmissionFarmBiomassHandling(CountySelected,FarmNumber) =
                       sum(LoaderTypes, BiomassHandlingTime.l(LoaderTypes)
                                 * LoaderData('FuelConsumption',LoaderTypes)
                                 * DieselGHGEmissionFactor
                       );

Par_HarvestToFarmGateTotal(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 =
                                         BiomassHarvestToFarmGate.l(HarvestingHorizonAggregation)
                                         +
                                         BiomassRakingToFarmGate.l(HarvestingHorizonAggregation)
                                         +
                                         BiomassOnFarmToFarmGate.l(HarvestingHorizonAggregation)
                                         +
                                         BiomassPackingToFarmGate.l(HarvestingHorizonAggregation)
                                         +
                                         BiomassLoadingToFarmGate.l(HarvestingHorizonAggregation)
                                 ;

Par_FarmCoveredStorageToFarmGateTotal(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                         =
                         sum((HarvestingHorizonAggregation2),
                                 FarmCoveredStorageOutput.l(HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
                         );

Par_FarmCoveredStorageToFarmGateTotal(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                         =
                         sum((HarvestingHorizonAggregation),
                                  FarmCoveredStorageOutput.l(NonHarvestingHorizonAggregation,HarvestingHorizonAggregation)
                         );

Par_FarmOpenStorageToFarmGateTotal(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                         =
                         sum((HarvestingHorizonAggregation2),
                                  FarmOpenStorageOutput.l(HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
                         );
Par_FarmOpenStorageToFarmGateTotal(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                         =
                         sum((HarvestingHorizonAggregation),
                                 FarmOpenStorageOutput.l(NonHarvestingHorizonAggregation,HarvestingHorizonAggregation)
                         );

Par_EnsilingToFarmGateTotal(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                         =
                         sum((HarvestingHorizonAggregation),
                                  FarmEnsilingOutput.l(NonHarvestingHorizonAggregation,HarvestingHorizonAggregation)
                         );

$offtext

*--------------------------------------------------------------------------------------------
* Storing the distribution of biomass among different streams
*--------------------------------------------------------------------------------------------
$ontext
Par_HarvestToFarmGateTotal(HarvestingHorizonAggregation,CountySelected,FarmNumber)$(ord(HarvestingHorizonAggregation)=1)
                                 =
                                 sum(HarvestingHorizonAggregation2,
                                         BiomassHarvestToFarmGate.l(HarvestingHorizonAggregation2)
                                         +
                                         BiomassRakingToFarmGate.l(HarvestingHorizonAggregation2)
                                         +
                                         BiomassOnFarmToFarmGate.l(HarvestingHorizonAggregation2)
                                         +
                                         BiomassPackingToFarmGate.l(HarvestingHorizonAggregation2)
                                         +
                                         BiomassLoadingToFarmGate.l(HarvestingHorizonAggregation2)
                                 )
                                 ;
$offtext
Par_HarvestToFarmGateTotal(HarvestingHorizonAggregation,CountySelected,FarmNumber)$(ord(HarvestingHorizonAggregation)=1)=1000;
$ontext
Par_FarmCoveredStorageToFarmGateTotal(HarvestingHorizonAggregation,CountySelected,FarmNumber)$(ord(HarvestingHorizonAggregation)=1)
                         =
                         sum((HarvestingHorizonAggregation2,HarvestingHorizonAggregation3),
                                 FarmCoveredStorageOutput.l(HarvestingHorizonAggregation3,HarvestingHorizonAggregation2)
                         );
$offtext
Par_FarmCoveredStorageToFarmGateTotal(HarvestingHorizonAggregation,CountySelected,FarmNumber)$(ord(HarvestingHorizonAggregation)=1)=250;
$ontext
Par_FarmCoveredStorageToFarmGateTotal(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)$(ord(NonHarvestingHorizonAggregation)=1)
                         =
                         sum((NonHarvestingHorizonAggregation2,HarvestingHorizonAggregation2),
                                  FarmCoveredStorageOutput.l(NonHarvestingHorizonAggregation2,HarvestingHorizonAggregation2)
                         );
$offtext
Par_FarmCoveredStorageToFarmGateTotal(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)$(ord(NonHarvestingHorizonAggregation)=1)=200;
$ontext
Par_FarmOpenStorageToFarmGateTotal(HarvestingHorizonAggregation,CountySelected,FarmNumber)$(ord(HarvestingHorizonAggregation)=1)
                         =
                         sum((HarvestingHorizonAggregation2,HarvestingHorizonAggregation3),
                                  FarmOpenStorageOutput.l(HarvestingHorizonAggregation3,HarvestingHorizonAggregation2)
                         );
$offtext
Par_FarmOpenStorageToFarmGateTotal(HarvestingHorizonAggregation,CountySelected,FarmNumber)$(ord(HarvestingHorizonAggregation)=1)=250;
$ontext
Par_FarmOpenStorageToFarmGateTotal(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)$(ord(NonHarvestingHorizonAggregation)=1)
                         =
                         sum((NonHarvestingHorizonAggregation2,HarvestingHorizonAggregation2),
                                 FarmOpenStorageOutput.l(NonHarvestingHorizonAggregation2,HarvestingHorizonAggregation2)
                         );
$offtext
Par_FarmOpenStorageToFarmGateTotal(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)$(ord(NonHarvestingHorizonAggregation)=1) =300;
$ontext
Par_EnsilingToFarmGateTotal(HarvestingHorizonAggregation,CountySelected,FarmNumber)$(ord(HarvestingHorizonAggregation)=1)
                         =
                         sum((NonHarvestingHorizonAggregation,HarvestingHorizonAggregation2),
                                  FarmEnsilingOutput.l(NonHarvestingHorizonAggregation,HarvestingHorizonAggregation2)
                         );
$offtext
Par_EnsilingToFarmGateTotal(HarvestingHorizonAggregation,CountySelected,FarmNumber)$(ord(HarvestingHorizonAggregation)=1)=350;
*Display HarvestRate.l, RakingOutput.l, PackingInput.l, PackingOutput.l, FarmGateTotalBiomass.l;
