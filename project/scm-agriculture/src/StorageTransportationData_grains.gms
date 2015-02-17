
Parameter
  HoursPerDay "Number of hours operations take place per day" /10/
  DieselFuelCost "The cost of diesel in $ per gallon used to run the machines which is used to calculate the fuel consumption cost" /2.20/
  ;

Parameter
  RGYDryMatterLossRate  "The dry matter loss rate for RGY"
  RGYCapitalCostRate "The cost of setting up am RGY in terms of Rs per kg" /4/
  RGYRentalRate "The rate of storing grains in an RGY on a rental basis in terms of Rs per 50 kg bag per month" /2/
  ;

Parameter
  FCIGodownCAPLossRate "The dry matter loss rate for biomass stored in FCI godowns using the covered and plith method"
  FCIGodownCoveredLossRate "The dry matter loss rate for biomass stored in FCI godowns using the covered (indoor) method"
  FCIStorageCostRate "The rate of storage of grains in FCI in Rs per kg"
  FCIStorageCostRateMonthly "The rate of storage of grains in FCI in Rs per kg per month"
  FCIMandiCostRate "The rate of payment by FCI for different operations at the Mandi in Rs per kg"
  NumberOfMonthsInFCIStorage "The cost of storage in FCI godowns on a monthly basis"
  ;

Parameter
  FarmOpenStorageDryMatterLossRate "The dry matter loss rate of grains on an annual basis when stored in open on the farm"
  LocalCSPDryMatterLossRate "The dry matter loss rate for local CSP facility on an annual basis"
  RegionalCSPDryMatterLossRate "The dry matter loss rate for regional CSP facility on an annual basis"
  MillerStorageDryMatterLossRate "The dry matter loss rate for milled material stored in the storage facility of the millers"
  LocalCSPFacilityHeight "The height of the facility for local CSP facility in meters" /10/
  RegionalCSPFacilityHeight "The height of the facility for regional CSP facility in meters" /10/
  LocalCSPFacilityAreaLimit "The maximum permitted area for the local CSP facility in square meteres" /1000000/
  RegionalCSPFacilityAreaLimit "The maximum permitted area for the regional CSP facility in square meteres" /1000000/
  ;

Parameters
  StorageLandRent "The cost of farm land allocated for storage represented as the land rent in $ per square meter" /0.0395/
  StorageLandCost "The purchase cost of land to build a centralized storage facility in $ per square meter" /1.099/
  BiomassStorageTimeLimit "The number of days after harvesting within which the harvested biomass must be sent to the biorefinery for processing (number of days)" /2/
  ;

Parameter
  StorageStackingCost "Cost of stacking (which includes unloading from the short range bale wagon and stacking at the storage facility) a bale or loaf (at either storage locations) in $ per dry tonne" /1.19/
  StorageLoadingCost "Cost of loading the bales or loafs onto truck for long range transportation in $ per dry tonne" /1.61/
  GrainUnloadingCost "Cost of unloading the bales or loafs onto truck for long range transportation in $ per dry tonne" /1.46/
  GroundBiomassStorageLoadingCost "Cost of loading ground biomass onto truck (for ensiling operation) for long range transportation in $ per dry tonne" /3.62/
  GroundBiomassRefineryUnloadingCost "Cost of unloading ground biomass onto truck (for ensiling operation) for long range transportation in $ per dry tonne" /0.93/
  ;

Parameters
  MaximumTransportationFleetSize "Total number of trucks available for all farms for biomass transportation on a day" /100000000000000000000000000/
  RailTransportationCost "The operating cost of rail transportation given in Rs per kg per km" /0.001015149/
  FCITransportationDryMatterLossRate "Fraction of dry matter lost during transportation related to FCI operations" /0.003267513/
  TransportationDryMatterLossRate "Fraction of dry matter lost during transportation" /0.025/
  MaximumTripsPerDay "The maximum number of trips that a truck can make between different destination in a single day" /10/
  TruckLoadingTime "Average loading time for a truck at the farm or the centralized storage location in hours" /0.5/
  TransportationMoistureLossRate "Fraction of moisture reduction during transportatation" /0.01/
  TruckWaitingTime "Average waiting time for a truck at the refinery for unloading in hours" /0.5/
  TruckFuelEfficiency "The average fuel efficiency of a transportation truck of class 7-8 in kilometers per gallon" /10.78/
  TruckIdlingFuelConsumption "The typical fuel consumption by transportation truck for class 7-8 in gallons per hour" /1/
  ;
