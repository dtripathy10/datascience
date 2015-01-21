*
* Parameters for transportation
*
Parameters TransportationDryMatterLossRate Fraction of dry matter lost during transportation /0.025/
* Taken from kumar & Sokhansanj (2007) which gives loss between 2-3%
           TransportationMoistureLossRate Fraction of moisture reduction during transportatation /0.01/
* Assumed due to lack of data in literature
           TruckWaitingTime Average waiting time for a truck at the refinery for unloading in hours /0.5/
           MaximumTripsPerDay The maximum number of trips that a truck can make between different destination in a single day /10/
* Taken from Mukunda et al. 2006.
           TruckLoadingTime Average loading time for a truck at the farm or the centralized storage location in hours /0.5/
* Taken from Mukunda et al. 2006. They report an average loading time to be 20 minutes for 17 dry tons per truck. The truck considered
* in this model has higher capacity and hence the time is approximated as 30 minutes (0.5 hours). This time includes the actual loading
* time as well as the time spent in the queue for loading (which is expected to be much smaller than at the refinery).

           MaximumTransportationFleetSize Total number of trucks available for all farms for biomass transportation on a day /1000/
* Assumed due to lack of data in literature
           TruckFuelEfficiency The average fuel efficiency of a transportation truck of class 7-8 in kilometers per gallon /10.78/
* Taken from a technical report by Argonne National Lab on heavy vehicles
           TruckIdlingFuelConsumption The typical fuel consumption by transportation truck for class 7-8 in gallons per hour /1/
* Taken from the presentation given by people from Argonne National Lab
           DieselCalorificValue The calorific value of diesel (transrportation truck fuel) in MJ per kg /43.333/
           DieselSpecificGravity The typical specific gravity of a diesel fuel (used to calculate density) /0.85/
* The last two values are taken from internet and probably dont need to be cited since they are of common knowledge
           DieselGHGEmissionFactor The amount of CO2 (Greenhouse gas) emission in kg per gallon of diesel consumed /10.1/
* Taken from the EPA website (http://www.epa.gov/oms/climate/420f05001.htm). The calculation is based on first assuming the
* average concent of 2.778 kg of C per gallon of diesel and then assuming 99% combustion to get the CO2 equivalent

          RailTransportationCost The operating cost of rail transportation given in $ per Mg per km /0.027/;
* Look at the paper by Mahmudi and Flynn (2006) for some estimates (based on north american case for straw transport).
