
Parameter FuelConsumptionFactor The average annual fuel consumption factor conversting the machine rated hp into fuel consumption in gal per hour /0.0438/
* Taken from ASAE EP496.3 (Nebraska Tractor Test data) and also used in IBSAL model
* Please note that the original equation uses 0.06 as the factor for gasoline and diesel consumption (assumed here) is 73% of gasoline consumption
          AverageBalingDensity The average of packing density for all options which is used as an approximation for central storage to refinery transportation constraint
          AverageBalingThroughput The average value of the packing machine throughput used to calculate the operating cost of tractors

          LoseBiomassDensity The average density of lose biomass

          MinimumHarvestingCutFraction The minimum harvesting cut fraction for the given harvesting machines

          TractorData Data for tractors used in farm operations
          HarvesterData  Data for harvesting operation
          FieldLoaderData Data associated with field loaders that are used for energy cane
          RakeData  Data for raking operation operation
          BalerData  Data for baling operation
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
          InFieldTransportationData Data for biomass in-field transportation
          TransportationData Data for biomass transportation;

*
* Note on the calculation of the costs:
* The total cost = Capital recovery + IHT + Labor + Repairs + Fuel
*  AnnualInterest = Represent the annual payment you make for the purchase of the equipment
*                 = (Purchase price + salvage value)/2 * discount rate
*  The AnnualInterest therefore is in $/year and fixed payment for each year.
*  IHT = Annualized insurance, housing and taxed.
*        Although, this is also annualized (line AnnualInterest) it is also a function of the number of hours of operation which is a variable
*        in our model. Hence, the total expense due to IHT is calculated as a function of the total number of hours.
*
* The operating cost in the IBSAL data sheet consists of:
* Operating cost = (repairs + fuel/lube + labor + Operating interest + capital - AnnualInterest/AnnualUse)
*   The last two terms in the calculation represent the capital recovery that is not covered by the AnnualInterest (i.e. which is a function
*   of the number of hours that the machine is operated for).
* The datasheet in IBSAL thus reports three important parameters that should be used:
*        AnnualInterest, IHT and OperatingCost
* Labor and fuel/lube is included or excluded depending on the machine. For example, baler does not include labor since it is hauled by the tractor
* and no human labor is required to bale. Hence one must be careful of including the tractor cost in the baler (and the tractor cost includes
* labor cost since you need someone to operater the tractor).
*
* Important Note: The calculations here, although based on the IBSAL datasheet, are modified a bit.
* The fuel consumption is calculated using the machine hp values and the Nebraska fuel consumption factor. The cost is calculated by using the
* fuel cost in $/gallon. However, the fuel cost can vary over time. Hence it is better to separate the fuel cost from the other operating
* costs calculated by IBSAL. Thus, the fuel consumption is calculated (using the Nebraska factor), but the actual cost is calculated as an
* independent value by using the current fuel cost (that is declared as a parameter in the model). The operating cost, therefore, considers
* all the categories mentioned above except the fuel cost.
*
* The Nebraska tractor function is:
* F = 0.06 * P, where, P is the rated pto power in hp and F is the average gasoline consumption in gallons per hour.
* The ASABE standard specifies that a diesel tractor will use approximately 73% as much fuel in volume as a gasoline tractor.
* So for diesel fuel tractor, the relationship is: F = 0.73 * 0.06 * P
*

*
* Importing data from excel file
*
*$CALL GDXXRW.EXE BioFeedAttributes-Switchgrass.xls DSet=TractorTypes rng=Tractor!B2:N2 Cdim=1 DSet=TractorAttributes rng=Tractor!A3:A9 Rdim=1 par=TractorData rng=Tractor!A2:K9 DSet=HarvesterTypes rng=Harvesting!B1:F1 Cdim=1 DSet=HarvesterAttributes rng=Harvesting!A2:A40 Rdim=1 par=HarvesterData rng=Harvesting!A1:F40 DSet=FieldLoaderTypes rng=FieldLoading!B1:D1 Cdim=1 DSet=FieldLoaderAttributes rng=FieldLoading!A2:A25 Rdim=1 par=FieldLoaderData rng=FieldLoading!A1:D25 DSet=RakeTypes rng=Raking!B1:C1 Cdim=1 DSet=RakeAttributes rng=Raking!A2:A23 Rdim=1 par=RakeData rng=Raking!A1:C23 DSet=BalerTypes rng=Baling!B1:D1 Cdim=1 DSet=BalerAttributes rng=Baling!A2:A35 Rdim=1 par=BalerData rng=Baling!A1:D35 DSet=PelletizerTypes rng=Pelletization!B1 Cdim=1 DSet=PelletizerAttributes rng=Pelletization!A2:A25 Rdim=1 par=PelletizerData rng=Pelletization!A1:B25 DSet=LoaderTypes rng=Loading!B1:I1 Cdim=1 DSet=LoaderAttributes rng=Loading!A2:A20 Rdim=1 par=LoaderData rng=Loading!A1:I20 DSet=HandlingMachineTypes rng=Handling!B1:H1 Cdim=1 DSet=HandlingMachineAttributes rng=Handling!A2:A15 Rdim=1 par=HandlingMachineData rng=Handling!A1:H15  DSet=GrinderTypes rng=Grinding!B1:G1 Cdim=1 DSet=GrinderAttributes rng=Grinding!A2:A30 Rdim=1 par=GrinderData rng=Grinding!A1:G30 DSet=ChopperTypes rng=Chopping!B1:G1 Cdim=1 DSet=ChopperAttributes rng=Chopping!A2:A35 Rdim=1 par=ChopperData rng=Chopping!A1:G35 DSet=StorageProcessorTypes rng=StorageProcessing!B1:G1 Cdim=1 DSet=StorageProcessorAttributes rng=StorageProcessing!A2:A35 Rdim=1 par=StorageProcessorData rng=StorageProcessing!A1:G35 DSet=DryerTypes rng=Drying!B1 Cdim=1 DSet=DryerAttributes rng=Drying!A2:A18 Rdim=1 par=DryerData rng=Drying!A1:B18 DSet=InFieldTransportationTypes rng=InFieldTransportation!B1:K1 Cdim=1 DSet=InFieldTransportationAttributes rng=InFieldTransportation!A2:A35 Rdim=1 par=InFieldTransportationData rng=InFieldTransportation!A1:K35 DSet=TransportationTypes rng=Transportation!B1:N1 Cdim=1 DSet=TransportationAttributes rng=Transportation!A2:A35 Rdim=1 par=TransportationData rng=Transportation!A1:N35 DSet=StorageTypes rng=Storage!B1:K1 Cdim=1 DSet=StorageAttributes rng=Storage!A2:A17 Rdim=1 par=StorageData rng=Storage!A1:K17;

$ CALL GDXXRW.EXE Grains_attributes.xlsx Dset=TractorTypes rng=Tractor!B2:N2 Cdim=1 Dset=TractorAttributes rng=Tractor!A3:A9 Rdim=1 par=TractorData rng=Tractor!A2:K9 Dset= FieldLoaderTypes rng=FieldLoading!B1:D1 Cdim=1 DSet=FieldLoaderAttributes rng=FieldLoading!A2:A25 Rdim=1 par=FieldLoaderData rng=FieldLoading!A1:D25 DSet=LoaderTypes rng=Loading!B1:I1 Cdim=1 DSet=LoaderAttributes rng=Loading!A2:A20 Rdim=1 par=LoaderData rng=Loading!A1:I20 DSet=HandlingMachineTypes rng=Handling!B1:H1 Cdim=1 DSet=HandlingMachineAttributes rng=Handling!A2:A15 Rdim=1 par=HandlingMachineData rng=Handling!A1:H15  DSet=GrinderTypes rng=Grinding!B1:G1 Cdim=1 DSet=GrinderAttributes rng=Grinding!A2:A30 Rdim=1 par=GrinderData rng=Grinding!A1:G30 DSet=ChopperTypes rng=Chopping!B1:G1 Cdim=1 DSet=ChopperAttributes rng=Chopping!A2:A35 Rdim=1 par=ChopperData rng=Chopping!A1:G35 DSet=StorageProcessorTypes rng=StorageProcessing!D10:F10 Cdim=1 DSet=StorageSmallScaleProcessorTypes rng=StorageSmallScaleProcessing!D10:F10 Cdim=1 DSet=StorageProcessorAttributes rng=StorageProcessing!C11:C40 Rdim=1 DSet=StorageSmallScaleProcessorAttributes rng=StorageSmallScaleProcessing!C11:C40 Rdim=1 par=StorageProcessorData rng=StorageProcessing!C9:H40 par=StorageSmallScaleProcessorData rng=StorageSmallScaleProcessing!C9:H40 DSet=DryerTypes rng=Drying!B1 Cdim=1 DSet=DryerAttributes rng=Drying!A2:A18 Rdim=1 par=DryerData rng=Drying!A1:B18 DSet=InFieldTransportationTypes rng=InFieldTransportation!B1:K1 Cdim=1 DSet=InFieldTransportationAttributes rng=InFieldTransportation!A2:A35 Rdim=1 par=InFieldTransportationData rng=InFieldTransportation!A1:K35 DSet=TransportationTypes rng=Transportation!B1:N1 Cdim=1 DSet=TransportationAttributes rng=Transportation!A2:A35 Rdim=1 par=TransportationData rng=Transportation!A1:N35 DSet=SmallScaleStorageTypes rng=StorageSmallScale!B2:E2 Cdim=1 DSet=SmallScaleStorageAttributes rng=StorageSmallScale!A3:A10 Rdim=1 par=SmallScaleStorageData rng=StorageSmallScale!A2:E10;

*DSet=StorageSmallScaleTypes rng=StorageSmallScale!E8:H8 Cdim=1 DSet=StorageAttributes rng=Storage!C7:C15 Rdim=1 DSet=StorageSmallScaleAttributes rng=*StorageSmallScale!D9:D16 Rdim=1 par=StorageData rng=Storage!C6:G14

$GDXIN Grains_attributes.gdx

Set TractorTypes(*) Type of Tractors
    TractorAttributes(*) Attributes associated with a tractor
    FieldLoaderTypes(*) Type of field loaders
    FieldLoaderAttributes(*) The attributes associated with field loaders
    LoaderTypes(*) The types of loading machiens available
    LoaderAttributes(*) The attributes associated with a loading machine
    HandlingMachineTypes(*) The types of biomass handling machines
    HandlingMachineAttributes(*) The attributes associates with a biomass handling machine
    GrinderTypes(*) The different types of size reduction machines available
    GrinderAttributes(*) The attributes associated with a size reduction machine
    ChopperTypes(*) The different types of chopping machines available
    ChopperAttributes(*) The attributes associated with a chopping machine
    StorageProcessorTypes(*) The different types of processing machines available at the centralized storage facility
    StorageSmallScaleProcessorTypes(*)
    StorageProcessorAttributes(*) The attributes associated with a processing machines at the centralized storage facility
    StorageSmallScaleProcessorAttributes(*)
    DryerTypes(*) The different types of drying machines available
    DryerAttributes(*) The attributes of a drying machine
    InFieldTransportationTypes(*) The types of transportation options available
    InFieldTransportationAttributes(*) The attributes of a transportation option
    TransportationTypes(*) The types of transportation options available
    TransportationAttributes(*) The attributes of a transportation option
    SmallScaleStorageTypes(*) The different types of storage options available
    SmallScaleStorageAttributes(*) The different attributes associated with each storage option;

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
*$LOAD StorageSmallScaleTypes = StorageSmallScaleTypes
*$LOAD StorageSmallScaleAttributes = StorageSmallScaleAttributes

*
* Assigning the parameter values imported from the Excel file to the attributes table in GAMS
*
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


Set
         PackingTypes The different types of packing options /Baling, Pelletization, Grinding, Chopping/
         CentralizedStorageProcessingTypes The different types of processing and packing options at the centralized storage facility /Pelletization, Grinding/;

Display TractorData, FieldLoaderData, LoaderData, GrinderData, ChopperData, StorageProcessorData,
        HandlingMachineData, DryerData, SmallScaleStorageData, InFieldTransportationData, TransportationData; 
