$Ontext
Note on the calculation of the costs:
The total cost = Capital recovery + IHT + Labor + Repairs + Fuel
AnnualInterest = Represent the annual payment you make for the purchase of the equipment
  = (Purchase price + salvage value)/2 * discount rate
The AnnualInterest therefore is in $/year and fixed payment for each year.
IHT = Annualized insurance, housing and taxed.
Although, this is also annualized (line AnnualInterest) it is also a function of the number of hours of operation which is a variable
in our model. Hence, the total expense due to IHT is calculated as a function of the total number of hours.

 The operating cost in the IBSAL data sheet consists of:
 Operating cost = (repairs + fuel/lube + labor + Operating interest + capital - AnnualInterest/AnnualUse)
   The last two terms in the calculation represent the capital recovery that is not covered by the AnnualInterest (i.e. which is a function
   of the number of hours that the machine is operated for).
 The datasheet in IBSAL thus reports three important parameters that should be used:
        AnnualInterest, IHT and OperatingCost
 Labor and fuel/lube is included or excluded depending on the machine. For example, baler does not include labor since it is hauled by the tractor
 and no human labor is required to bale. Hence one must be careful of including the tractor cost in the baler (and the tractor cost includes
 labor cost since you need someone to operater the tractor).

 Important Note: The calculations here, although based on the IBSAL datasheet, are modified a bit.
 The fuel consumption is calculated using the machine hp values and the Nebraska fuel consumption factor. The cost is calculated by using the
 fuel cost in $/gallon. However, the fuel cost can vary over time. Hence it is better to separate the fuel cost from the other operating
 costs calculated by IBSAL. Thus, the fuel consumption is calculated (using the Nebraska factor), but the actual cost is calculated as an
 independent value by using the current fuel cost (that is declared as a parameter in the model). The operating cost, therefore, considers
 all the categories mentioned above except the fuel cost.

 The Nebraska tractor function is:
 F = 0.06  P, where, P is the rated pto power in hp and F is the average gasoline consumption in gallons per hour.
 The ASABE standard specifies that a diesel tractor will use approximately 73% as much fuel in volume as a gasoline tractor.
 So for diesel fuel tractor, the relationship is: F = 0.73 * 0.06 * P
$offtext

Parameter 
  FuelConsumptionFactor "The average annual fuel consumption factor conversting the machine rated hp into fuel consumption in gal per hour" /0.0438/
  AverageBalingDensity "The average of packing density for all options which is used as an approximation for central storage to refinery transportation constraint"
  AverageBalingThroughput "The average value of the packing machine throughput used to calculate the operating cost of tractors"
  LoseBiomassDensity "The average density of lose biomass"
  MinimumHarvestingCutFraction "The minimum harvesting cut fraction for the given harvesting machines"
  TractorData "Data for tractors used in farm operations"
  HarvesterData  "Data for harvesting operation"
  FieldLoaderData "Data associated with field loaders that are used for energy cane"
  RakeData  "Data for raking operation operation"
  BalerData  "Data for baling operation"
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
  InFieldTransportationData "Data for biomass in-field transportation"
  TransportationData "Data for biomass transportation"
  ;

$GDXIN "data/Grains_attributes.gdx"
Set 
  TractorTypes(*) "Type of Tractors"
  TractorAttributes(*) "Attributes associated with a tractor"
  FieldLoaderTypes(*) "Type of field loaders"
  FieldLoaderAttributes(*) "The attributes associated with field loaders"
  LoaderTypes(*) "The types of loading machiens available"
  LoaderAttributes(*) "The attributes associated with a loading machine"
  HandlingMachineTypes(*) "The types of biomass handling machines"
  HandlingMachineAttributes(*) "The attributes associates with a biomass handling machine"
  GrinderTypes(*) "The different types of size reduction machines available"
  GrinderAttributes(*) "The attributes associated with a size reduction machine"
  ChopperTypes(*) "The different types of chopping machines available"
  ChopperAttributes(*) "The attributes associated with a chopping machine"
  StorageProcessorTypes(*) "The different types of processing machines available at the centralized storage facility"
  StorageSmallScaleProcessorTypes(*)
  StorageProcessorAttributes(*) "The attributes associated with a processing machines at the centralized storage facility"
  StorageSmallScaleProcessorAttributes(*)
  DryerTypes(*) "The different types of drying machines available"
  DryerAttributes(*) "The attributes of a drying machine"
  InFieldTransportationTypes(*) "The types of transportation options available"
  InFieldTransportationAttributes(*) "The attributes of a transportation option"
  TransportationTypes(*) "The types of transportation options available"
  TransportationAttributes(*) "The attributes of a transportation option"
  SmallScaleStorageTypes(*) "The different types of storage options available"
  SmallScaleStorageAttributes(*) "The different attributes associated with each storage option"
  ;
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

Set
  PackingTypes "The different types of packing options" /Baling, Pelletization, Grinding, Chopping/
  CentralizedStorageProcessingTypes "The different types of processing and packing options at the centralized storage facility" /Pelletization, Grinding/
  ;

Display 
  TractorData, FieldLoaderData, LoaderData, GrinderData, ChopperData, StorageProcessorData,
  HandlingMachineData, DryerData, SmallScaleStorageData, InFieldTransportationData, TransportationData
  ;
