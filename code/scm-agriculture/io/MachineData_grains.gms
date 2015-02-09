
Set
  PackingTypes  /Baling, Pelletization, Grinding, Chopping/
  CentralizedStorageProcessingTypes /Pelletization, Grinding/;

Set 
  TractorTypes(*)
  TractorAttributes(*)
  FieldLoaderTypes(*)
  FieldLoaderAttributes(*)
  LoaderTypes(*)
  LoaderAttributes(*)
  HandlingMachineTypes(*)
  HandlingMachineAttributes(*)
  GrinderTypes(*)
  GrinderAttributes(*)
  ChopperTypes(*)
  ChopperAttributes(*)
  StorageProcessorTypes(*)
  StorageSmallScaleProcessorTypes(*)
  StorageProcessorAttributes(*)
  StorageSmallScaleProcessorAttributes(*)
  DryerTypes(*)
  DryerAttributes(*)
  InFieldTransportationTypes(*)
  InFieldTransportationAttributes(*)
  TransportationTypes(*)
  TransportationAttributes(*)
  SmallScaleStorageTypes(*)
  SmallScaleStorageAttributes(*);

Parameter 
  FuelConsumptionFactor /0.0438/
  AverageBalingDensity 
  AverageBalingThroughput
  LoseBiomassDensity 
  MinimumHarvestingCutFraction 
  TractorData 
  HarvesterData  
  FieldLoaderData 
  RakeData
  BalerData
  PelletizerData
  LoaderData
  GrinderData
  ChopperData
  HandlingMachineData
  StorageProcessorData
  StorageSmallScaleProcessorData
  DryerData
  StorageData
  SmallScaleStorageData
  StorageRefineryDistanceData
  StorageRegionalDistanceData
  StorageSmallScaleRefineryData
  StorageSmallScaleRegionalData
  InFieldTransportationData
  TransportationData;

* Importing data from excel file
$ CALL GDXXRW.EXE Grains_attributes.xlsx Dset=TractorTypes rng=Tractor!B2:N2 Cdim=1 
  Dset=TractorAttributes rng=Tractor!A3:A9 Rdim=1 par=TractorData rng=Tractor!A2:K9 
  Dset= FieldLoaderTypes rng=FieldLoading!B1:D1 Cdim=1 DSet=FieldLoaderAttributes 
  rng=FieldLoading!A2:A25 Rdim=1 par=FieldLoaderData rng=FieldLoading!A1:D25 DSet=LoaderTypes 
  rng=Loading!B1:I1 Cdim=1 DSet=LoaderAttributes rng=Loading!A2:A20 Rdim=1 par=LoaderData 
  rng=Loading!A1:I20 DSet=HandlingMachineTypes rng=Handling!B1:H1 Cdim=1 
  DSet=HandlingMachineAttributes rng=Handling!A2:A15 Rdim=1 par=HandlingMachineData 
  rng=Handling!A1:H15  DSet=GrinderTypes rng=Grinding!B1:G1 Cdim=1 DSet=GrinderAttributes 
  rng=Grinding!A2:A30 Rdim=1 par=GrinderData rng=Grinding!A1:G30 DSet=ChopperTypes 
  rng=Chopping!B1:G1 Cdim=1 DSet=ChopperAttributes rng=Chopping!A2:A35 Rdim=1 par=ChopperData 
  rng=Chopping!A1:G35 DSet=StorageProcessorTypes rng=StorageProcessing!D10:F10 Cdim=1 
  DSet=StorageSmallScaleProcessorTypes rng=StorageSmallScaleProcessing!D10:F10 Cdim=1 
  DSet=StorageProcessorAttributes rng=StorageProcessing!C11:C40 Rdim=1 
  DSet=StorageSmallScaleProcessorAttributes rng=StorageSmallScaleProcessing!C11:C40 
  Rdim=1 par=StorageProcessorData rng=StorageProcessing!C9:H40 par=StorageSmallScaleProcessorData 
  rng=StorageSmallScaleProcessing!C9:H40 DSet=DryerTypes rng=Drying!B1 Cdim=1 DSet=DryerAttributes 
  rng=Drying!A2:A18 Rdim=1 par=DryerData rng=Drying!A1:B18 DSet=InFieldTransportationTypes 
  rng=InFieldTransportation!B1:K1 Cdim=1 DSet=InFieldTransportationAttributes 
  rng=InFieldTransportation!A2:A35 Rdim=1 par=InFieldTransportationData 
  rng=InFieldTransportation!A1:K35 DSet=TransportationTypes rng=Transportation!B1:N1 Cdim=1 
  DSet=TransportationAttributes rng=Transportation!A2:A35 Rdim=1 par=TransportationData 
  rng=Transportation!A1:N35 DSet=SmallScaleStorageTypes rng=StorageSmallScale!B2:E2 Cdim=1 
  DSet=SmallScaleStorageAttributes rng=StorageSmallScale!A3:A10 Rdim=1 par=SmallScaleStorageData 
  rng=StorageSmallScale!A2:E10;


$GDXIN Grains_attributes.gdx


* Assigning the sets imported from the GDX (Excel) file to the sets in GAMS code
*
$LOAD TractorTypes = TractorTypes
$LOAD TractorAttributes = TractorAttributes
$LOAD FieldLoaderTypes = FieldLoaderTypes
$LOAD FieldLoaderAttributes = FieldLoaderAttributes
$LOAD LoaderTypes = LoaderTypes
$LOAD LoaderAttributes = LoaderAttributes
$LOAD HandlingMachineTypes = HandlingMachineTypes
$LOAD HandlingMachineAttributes = HandlingMachineAttributes
$LOAD GrinderTypes = GrinderTypes
$LOAD GrinderAttributes = GrinderAttributes
$LOAD ChopperTypes = ChopperTypes
$LOAD ChopperAttributes = ChopperAttributes
$LOAD StorageProcessorTypes = StorageProcessorTypes
$LOAD StorageSmallScaleProcessorTypes = StorageSmallScaleProcessorTypes
$LOAD StorageProcessorAttributes = StorageProcessorAttributes
$LOAD StorageSmallScaleProcessorAttributes = StorageSmallScaleProcessorAttributes
$LOAD DryerTypes = DryerTypes
$LOAD DryerAttributes = DryerAttributes
$LOAD InFieldTransportationTypes = InFieldTransportationTypes
$LOAD InFieldTransportationAttributes = InFieldTransportationAttributes
$LOAD TransportationTypes = TransportationTypes
$LOAD TransportationAttributes = TransportationAttributes
$LOAD SmallScaleStorageTypes = SmallScaleStorageTypes
$LOAD SmallScaleStorageAttributes = SmallScaleStorageAttributes
$LOAD TractorData
$LOAD FieldLoaderData
$LOAD LoaderData
$LOAD GrinderData
$LOAD ChopperData
$LOAD StorageProcessorData
$LOAD StorageSmallScaleProcessorData
$LOAD HandlingMachineData
$LOAD DryerData
$LOAD SmallScaleStorageData
$LOAD InFieldTransportationData
$LOAD TransportationData
$GDXIN


Display TractorData, FieldLoaderData, LoaderData, GrinderData, ChopperData, StorageProcessorData,
  HandlingMachineData, DryerData, SmallScaleStorageData, 
  InFieldTransportationData, TransportationData;
