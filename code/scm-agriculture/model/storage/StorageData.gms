*
* Common parameters for storage
*
Parameters
         EnsilingParticleSizeRequirement The maximum particle size of the biomass that is permitted for biomass ensiling in meters /0.05/
* **** Assumed
         StorageBuffer Storage buffer space indicating the unused space necessary at each storage facility in terms of fraction of the total space /0.1/
* **** Assumed.
         CriticalFarmSize The minimum farm size in square kilometers that is required for a farm to have an on-farm covered storage facility /1/
* **** Assumed.
         StorageLandRent The cost of farm land allocated for storage represented as the land rent in $ per square meter /0.0395/
* Taken from Wilkerson ASABE 08 presentation
         StorageLandCost The purchase cost of land to build a centralized storage facility in $ per square meter /1.099/
* Taken from the USDA documents on the land cash rent and costs
         FarmCoveredStorageMinimumResidenceTime The minimum number of days for which the biomass must be stored in the storage before it can be transported to the refinery (used to model the time required for drying) /2/
*Assumed
         FarmOpenStorageTimeLimit The number of days beyond the harvesting horizon for which the open on farm stored biomass can be kept (number of days) /1/
* Assumed
         BiomassStorageTimeLimit The number of days after harvesting within which the harvested biomass must be sent to the biorefinery for processing (number of days) /2/;
* This parameter is used to model Type I energy cane scenario with high sugar content.
