$title Transportation Cost calculations using detailed calculations

Equations
                 TransportationCostConstraint7A
                 TransportationCostConstraint8A
                 TransportationCostConstraint9A
                 TransportationCostConstraint10A
                 TransportationCostConstraint11A
                 TransportationCostConstraint12A
                 TransportationCostConstraint13A
                 TransportationCostConstraint14A
                 TransportationCostConstraint15A
                 TransportationCostConstraint16A
                 TransportationCostConstraint17A
                 TransportationCostConstraint18A
                 TransportationCostConstraint19A
                 TransportationCostConstraint20A
                 TransportationCostConstraint21A
                 TransportationCostConstraint22A
                 TransportationCostConstraint23A

                 TransportationCostConstraint24
                 TransportationCostConstraint25
                 TransportationCostConstraint26
                 ;


*---------------------------------------------------------------------------------------------------------
* Calculating the total transportation cost based on the fleet distribution and transportation time from each field.
* The transportation cost includes the operating cost (which is a function of the transportation time) and
* annual fixed cost which represents the discounted cost for the purchase of the vehicle.
*
* Calculation of the transportation operating cost if the calculation depends on the total number of truck/trips between different
* locations and the opearting cost for truck on an hourly basis. The total grain transported is not directly considered in the
* calculations and it has an impact indirectly by affecting the total number of trips.
*
*---------------------------------------------------------------------------------------------------------
TransportationCostConstraint7A..      FarmLocalCSPTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,TransportationTypes),
                                         FarmLocalCSPTruckTripRequirement(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,TransportationTypes)
                                         *FarmLocalCSPTransportationTime(FarmNumber,LocalCSPCenterSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         FarmLocalCSPTruckTripRequirement(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,TransportationTypes)
*                                         *
*                                         (FarmLocalCSPDistance(FarmNumber,LocalCSPCenterSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,TransportationTypes),
                                         FarmLocalCSPTruckTripRequirement(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,TransportationTypes)
                                         *FarmLocalCSPTransportationTime(FarmNumber,LocalCSPCenterSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         FarmLocalCSPTruckTripRequirement(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,TransportationTypes)
*                                         *
*                                         (FarmLocalCSPDistance(FarmNumber,LocalCSPCenterSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(NonHarvestingHorizonAggregationStep);

TransportationCostConstraint8A..      FarmRegionalCSPTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,TransportationTypes),
                                         FarmRegionalCSPTruckTripRequirement(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,TransportationTypes)
                                         *FarmRegionalCSPTransportationTime(FarmNumber,RegionalCSPCenterSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         FarmRegionalCSPTruckTripRequirement(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,TransportationTypes)
*                                         *
*                                         (FarmRegionalCSPDistance(FarmNumber,RegionalCSPCenterSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,TransportationTypes),
                                         FarmRegionalCSPTruckTripRequirement(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,TransportationTypes)
                                         *FarmRegionalCSPTransportationTime(FarmNumber,RegionalCSPCenterSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         FarmRegionalCSPTruckTripRequirement(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,TransportationTypes)
*                                         *
*                                         (FarmRegionalCSPDistance(FarmNumber,RegionalCSPCenterSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(NonHarvestingHorizonAggregationStep);

TransportationCostConstraint9A..      FarmLocalMarketTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,FarmNumber,LocalMarketSet,TransportationTypes),
                                         FarmLocalMarketTruckTripRequirement(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet,TransportationTypes)
                                         *FarmLocalMarketTransportationTime(FarmNumber,LocalMarketSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                        FarmLocalMarketTruckTripRequirement(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet,TransportationTypes)
*                                         *
*                                         (FarmLocalMarketDistance(FarmNumber,LocalMarketSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet,TransportationTypes),
                                         FarmLocalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet,TransportationTypes)
                                         *FarmLocalMarketTransportationTime(FarmNumber,LocalMarketSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         FarmLocalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet,TransportationTypes)
*                                         *
*                                         (FarmLocalMarketDistance(FarmNumber,LocalMarketSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(NonHarvestingHorizonAggregationStep);

TransportationCostConstraint10A..     FarmRegionalMarketTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet,TransportationTypes),
                                         FarmRegionalMarketTruckTripRequirement(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet,TransportationTypes)
                                         *FarmRegionalMarketTransportationTime(FarmNumber,RegionalMarketSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         FarmRegionalMarketTruckTripRequirement(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet,TransportationTypes)
*                                         *
*                                         (FarmRegionalMarketDistance(FarmNumber,RegionalMarketSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet,TransportationTypes),
                                         FarmRegionalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet,TransportationTypes)
                                         *FarmRegionalMarketTransportationTime(FarmNumber,RegionalMarketSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         FarmRegionalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet,TransportationTypes)
*                                         *
*                                         (FarmRegionalMarketDistance(FarmNumber,RegionalMarketSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(NonHarvestingHorizonAggregationStep);


TransportationCostConstraint11A..     LocalCSPLocalMarketTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,LocalMarketSet,TransportationTypes),
                                         LocalCSPLocalMarketTruckTripRequirement(HarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,TransportationTypes)
                                         *LocalCSPLocalMarketTransportationTime(LocalCSPCenterSet,LocalMarketSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         LocalCSPLocalMarketTruckTripRequirement(HarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,TransportationTypes)
*                                         *
*                                         (LocalCSPLocalMarketDistance(LocalCSPCenterSet,LocalMarketSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,LocalMarketSet,TransportationTypes),
                                         LocalCSPLocalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,TransportationTypes)
                                         *LocalCSPLocalMarketTransportationTime(LocalCSPCenterSet,LocalMarketSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         LocalCSPLocalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,TransportationTypes)
*                                         *
*                                         (LocalCSPLocalMarketDistance(LocalCSPCenterSet,LocalMarketSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(NonHarvestingHorizonAggregationStep);

TransportationCostConstraint12A..     LocalCSPRegionalMarketTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes),
                                         LocalCSPRegionalMarketTruckTripRequirement(HarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)
                                         *LocalCSPRegionalMarketTransportationTime(LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         LocalCSPRegionalMarketTruckTripRequirement(HarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)
*                                         *
*                                         (LocalCSPRegionalMarketDistance(LocalCSPCenterSet,RegionalMarketSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes),
                                         LocalCSPRegionalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)
                                         *LocalCSPRegionalMarketTransportationTime(LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         LocalCSPRegionalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)
*                                         *
*                                         (LocalCSPRegionalMarketDistance(LocalCSPCenterSet,RegionalMarketSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(NonHarvestingHorizonAggregationStep);


TransportationCostConstraint13A..     RegionalCSPLocalMarketTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes),
                                         RegionalCSPLocalMarketTruckTripRequirement(HarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes)
                                         *RegionalCSPLocalMarketTransportationTime(RegionalCSPCenterSet,LocalMarketSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         RegionalCSPLocalMarketTruckTripRequirement(HarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes)
*                                         *
*                                         (RegionalCSPLocalMarketDistance(RegionalCSPCenterSet,LocalMarketSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes),
                                         RegionalCSPLocalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes)
                                         *RegionalCSPLocalMarketTransportationTime(RegionalCSPCenterSet,LocalMarketSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         RegionalCSPLocalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes)
*                                         *
*                                         (RegionalCSPLocalMarketDistance(RegionalCSPCenterSet,LocalMarketSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(NonHarvestingHorizonAggregationStep);


TransportationCostConstraint14A..     RegionalCSPRegionalMarketTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes),
                                         RegionalCSPRegionalMarketTruckTripRequirement(HarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)
                                         *RegionalCSPRegionalMarketTransportationTime(RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         RegionalCSPRegionalMarketTruckTripRequirement(HarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)
*                                         *
*                                         (RegionalCSPRegionalMarketDistance(RegionalCSPCenterSet,RegionalMarketSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes),
                                         RegionalCSPRegionalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)
                                         *RegionalCSPRegionalMarketTransportationTime(RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         RegionalCSPRegionalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)
*                                         *
*                                         (RegionalCSPRegionalMarketDistance(RegionalCSPCenterSet,RegionalMarketSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;

TransportationCostConstraint15A..     LocalMarketRGYTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,LocalMarketSet,RGYSet,TransportationTypes),
                                         LocalMarketRGYTruckTripRequirement(HarvestingHorizonAggregation,LocalMarketSet,RGYSet,TransportationTypes)
                                         *LocalMarketRGYTransportationTime(LocalMarketSet,RGYSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         LocalMarketRGYTruckTripRequirement(HarvestingHorizonAggregation,LocalMarketSet,RGYSet,TransportationTypes)
*                                         *
*                                         (LocalMarketRGYDistance(LocalMarketSet,RGYSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,LocalMarketSet,RGYSet,TransportationTypes),
                                         LocalMarketRGYTruckTripRequirement(NonHarvestingHorizonAggregation,LocalMarketSet,RGYSet,TransportationTypes)
                                         *LocalMarketRGYTransportationTime(LocalMarketSet,RGYSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         LocalMarketRGYTruckTripRequirement(NonHarvestingHorizonAggregation,LocalMarketSet,RGYSet,TransportationTypes)
*                                         *
*                                         (LocalMarketRGYDistance(LocalMarketSet,RGYSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;

TransportationCostConstraint16A..     RegionalMarketRGYTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,RegionalMarketSet,RGYSet,TransportationTypes),
                                         RegionalMarketRGYTruckTripRequirement(HarvestingHorizonAggregation,RegionalMarketSet,RGYSet,TransportationTypes)
                                         *RegionalMarketRGYTransportationTime(RegionalMarketSet,RGYSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         RegionalMarketRGYTruckTripRequirement(HarvestingHorizonAggregation,RegionalMarketSet,RGYSet,TransportationTypes)
*                                         *
*                                         (RegionalMarketRGYDistance(RegionalMarketSet,RGYSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,RegionalMarketSet,RGYSet,TransportationTypes),
                                         RegionalMarketRGYTruckTripRequirement(NonHarvestingHorizonAggregation,RegionalMarketSet,RGYSet,TransportationTypes)
                                         *RegionalMarketRGYTransportationTime(RegionalMarketSet,RGYSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         RegionalMarketRGYTruckTripRequirement(NonHarvestingHorizonAggregation,RegionalMarketSet,RGYSet,TransportationTypes)
*                                         *
*                                         (RegionalMarketRGYDistance(RegionalMarketSet,RGYSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;


TransportationCostConstraint17A..     RegionalMarketFCITransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet,TransportationTypes),
                                         RegionalMarketFCITruckTripRequirement(HarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet,TransportationTypes)
                                         *RegionalMarketFCITransportationTime(RegionalMarketSet,FCIGodownSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         RegionalMarketFCITruckTripRequirement(HarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet,TransportationTypes)
*                                         *
*                                         (RegionalMarketFCIDistance(RegionalMarketSet,FCIGodownSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet,TransportationTypes),
                                         RegionalMarketFCITruckTripRequirement(NonHarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet,TransportationTypes)
                                         *RegionalMarketFCITransportationTime(RegionalMarketSet,FCIGodownSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         RegionalMarketFCITruckTripRequirement(NonHarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet,TransportationTypes)
*                                         *
*                                         (RegionalMarketFCIDistance(RegionalMarketSet,FCIGodownSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;

TransportationCostConstraint18A..     RGYMillerTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,RGYSet,MillerSet,TransportationTypes),
                                         RGYMillerTruckTripRequirement(HarvestingHorizonAggregation,RGYSet,MillerSet,TransportationTypes)
                                         *RGYMillerTransportationTime(RGYSet,MillerSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         RGYMillerTruckTripRequirement(HarvestingHorizonAggregation,RGYSet,MillerSet,TransportationTypes)
*                                         *
*                                         (RGYMillerDistance(RGYSet,MillerSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,RGYSet,MillerSet,TransportationTypes),
                                         RGYMillerTruckTripRequirement(NonHarvestingHorizonAggregation,RGYSet,MillerSet,TransportationTypes)
                                         *RGYMillerTransportationTime(RGYSet,MillerSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         RGYMillerTruckTripRequirement(NonHarvestingHorizonAggregation,RGYSet,MillerSet,TransportationTypes)
*                                         *
*                                         (RGYMillerDistance(RGYSet,MillerSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;

TransportationCostConstraint19A..     RGYRetailerTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,RGYSet,RetailerSet,TransportationTypes),
                                         RGYRetailerTruckTripRequirement(HarvestingHorizonAggregation,RGYSet,RetailerSet,TransportationTypes)
                                         *RGYRetailerTransportationTime(RGYSet,RetailerSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         RGYRetailerTruckTripRequirement(HarvestingHorizonAggregation,RGYSet,RetailerSet,TransportationTypes)
*                                         *
*                                         (RGYRetailerDistance(RGYSet,RetailerSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,RGYSet,RetailerSet,TransportationTypes),
                                         RGYRetailerTruckTripRequirement(NonHarvestingHorizonAggregation,RGYSet,RetailerSet,TransportationTypes)
                                         *RGYRetailerTransportationTime(RGYSet,RetailerSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         RGYRetailerTruckTripRequirement(NonHarvestingHorizonAggregation,RGYSet,RetailerSet,TransportationTypes)
*                                         *
*                                         (RGYRetailerDistance(RGYSet,RetailerSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;


TransportationCostConstraint20A..     FCIMillerTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,FCIGodownSet,MillerSet,TransportationTypes),
                                         FCIMillerTruckTripRequirement(HarvestingHorizonAggregation,FCIGodownSet,MillerSet,TransportationTypes)
                                         *FCIMillerTransportationTime(FCIGodownSet,MillerSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         FCIMillerTruckTripRequirement(HarvestingHorizonAggregation,FCIGodownSet,MillerSet,TransportationTypes)
*                                         *
*                                         (FCIMillerDistance(FCIGodownSet,MillerSet)/TruckFuelEfficiency
*                                          + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,FCIGodownSet,MillerSet,TransportationTypes),
                                         FCIMillerTruckTripRequirement(NonHarvestingHorizonAggregation,FCIGodownSet,MillerSet,TransportationTypes)
                                         *FCIMillerTransportationTime(FCIGodownSet,MillerSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         FCIMillerTruckTripRequirement(NonHarvestingHorizonAggregation,FCIGodownSet,MillerSet,TransportationTypes)
*                                         *
*                                         (FCIMillerDistance(FCIGodownSet,MillerSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;

TransportationCostConstraint21A..     FCIRetailerTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,FCIGodownSet,RetailerSet,TransportationTypes),
                                         FCIRetailerTruckTripRequirement(HarvestingHorizonAggregation,FCIGodownSet,RetailerSet,TransportationTypes)
                                         *FCIRetailerTransportationTime(FCIGodownSet,RetailerSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         FCIRetailerTruckTripRequirement(HarvestingHorizonAggregation,FCIGodownSet,RetailerSet,TransportationTypes)
*                                         *
*                                         (FCIRetailerDistance(FCIGodownSet,RetailerSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,FCIGodownSet,RetailerSet,TransportationTypes),
                                         FCIRetailerTruckTripRequirement(NonHarvestingHorizonAggregation,FCIGodownSet,RetailerSet,TransportationTypes)
                                         *FCIRetailerTransportationTime(FCIGodownSet,RetailerSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         FCIRetailerTruckTripRequirement(NonHarvestingHorizonAggregation,FCIGodownSet,RetailerSet,TransportationTypes)
*                                         *
*                                         (FCIRetailerDistance(FCIGodownSet,RetailerSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;

TransportationCostConstraint22A..     FCIPDSTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,FCIGodownSet,PDSSet,TransportationTypes),
                                         FCIPDSTruckTripRequirement(HarvestingHorizonAggregation,FCIGodownSet,PDSSet,TransportationTypes)
                                         *FCIPDSTransportationTime(FCIGodownSet,PDSSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         FCIPDSTruckTripRequirement(HarvestingHorizonAggregation,FCIGodownSet,PDSSet,TransportationTypes)
*                                         *
*                                         (FCIPDSDistance(FCIGodownSet,PDSSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,FCIGodownSet,PDSSet,TransportationTypes),
                                         FCIPDSTruckTripRequirement(NonHarvestingHorizonAggregation,FCIGodownSet,PDSSet,TransportationTypes)
                                         *FCIPDSTransportationTime(FCIGodownSet,PDSSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         FCIPDSTruckTripRequirement(NonHarvestingHorizonAggregation,FCIGodownSet,PDSSet,TransportationTypes)
*                                         *
*                                         (FCIPDSDistance(FCIGodownSet,PDSSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;

TransportationCostConstraint23A..
                                 MillerRetailerTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,MillerSet,RetailerSet,TransportationTypes),
                                         MillerRetailerTruckTripRequirement(HarvestingHorizonAggregation,MillerSet,RetailerSet,TransportationTypes)
                                         *MillerRetailerTransportationTime(MillerSet,RetailerSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         MillerRetailerTruckTripRequirement(HarvestingHorizonAggregation,MillerSet,RetailerSet,TransportationTypes)
*                                         *
*                                         (MillerRetailerDistance(MillerSet,RetailerSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,MillerSet,RetailerSet,TransportationTypes),
                                         MillerRetailerTruckTripRequirement(NonHarvestingHorizonAggregation,MillerSet,RetailerSet,TransportationTypes)
                                         *MillerRetailerTransportationTime(MillerSet,RetailerSet,TransportationTypes)
                                         *TransportationData('OperatingCost',TransportationTypes)
*                                         +
*                                         MillerRetailerTruckTripRequirement(NonHarvestingHorizonAggregation,MillerSet,RetailerSet,TransportationTypes)
*                                         *
*                                         (MillerRetailerDistance(MillerSet,RetailerSet)/TruckFuelEfficiency
*                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
*                                         *DieselFuelCost
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;


*---------------------------------------------------------------------------------------------------------
*
* Calculating the total transportation cost based on the fleet distribution and transportation time from each field
*
*---------------------------------------------------------------------------------------------------------
TransportationCostConstraint24..      TransportationFixedCost
                                 =e=
                                 sum(TransportationTypes$(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                         TransportationFleetSize(TransportationTypes)*
                                         TransportationData('AnnualFixedCost',TransportationTypes)
                                 );

*---------------------------------------------------------------------------------------------------------
*
* This is a dummy variabe that is included in the objective function so that the exact number of trucks are used.
*
*---------------------------------------------------------------------------------------------------------
TransportationCostConstraint25..      TransportationTruckCharge
                                 =e=
                                 sum((HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,TransportationTypes),
                                         FarmLocalCSPTruckRequirement(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,TransportationTypes)
                                 )
                                 +
                                 sum((NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,TransportationTypes),
                                         FarmLocalCSPTruckRequirement(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,TransportationTypes)
                                 )
                                 +
                                 sum((HarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,TransportationTypes),
                                         LocalCSPLocalMarketTruckRequirement(HarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,TransportationTypes)
                                 )
                                 +
                                 sum((NonHarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,TransportationTypes),
                                         LocalCSPLocalMarketTruckRequirement(NonHarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,TransportationTypes)
                                 )
                                 +
                                 sum((HarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes),
                                         LocalCSPRegionalMarketTruckRequirement(HarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)
                                 )
                                 +
                                 sum((NonHarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes),
                                         LocalCSPRegionalMarketTruckRequirement(NonHarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)
                                 )
                                 +
                                 sum((HarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes),
                                         RegionalCSPLocalMarketTruckRequirement(HarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes)
                                 )
                                 +
                                 sum((NonHarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes),
                                         RegionalCSPLocalMarketTruckRequirement(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes)
                                 )
                                 +
                                 sum((HarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes),
                                         RegionalCSPRegionalMarketTruckRequirement(HarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)
                                 )
                                 +
                                 sum((NonHarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes),
                                         RegionalCSPRegionalMarketTruckRequirement(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)
                                 )
                                 +
                                 sum(TransportationTypes,
                                         TransportationFleetSize(TransportationTypes)
                                 );


*---------------------------------------------------------------------------------------------------------
* Calculating the cost for each category
*---------------------------------------------------------------------------------------------------------

TransportationCostConstraint26..
                                 TransportationOperatingCost
                                 =e=
                                 FarmLocalCSPTransportationOperatingCost + FarmRegionalCSPTransportationOperatingCost +
                                 FarmLocalMarketTransportationOperatingCost + FarmRegionalMarketTransportationOperatingCost +
                                 LocalCSPLocalMarketTransportationOperatingCost + RegionalCSPLocalMarketTransportationOperatingCost +
                                 LocalCSPRegionalMarketTransportationOperatingCost + RegionalCSPRegionalMarketTransportationOperatingCost +
                                 LocalMarketRGYTransportationOperatingCost + RegionalMarketRGYTransportationOperatingCost
                                 + RGYRetailerTransportationOperatingCost + FCIMillerTransportationOperatingCost
                                  + MillerRetailerTransportationOperatingCost + RegionalMarketFCITransportationOperatingCost
                                 + FCIRetailerTransportationOperatingCost + FCIPDSTransportationOperatingCost
                                 ;


*---------------------------------------------------------------------------------------------------------
* Model that calculates the transportation cost based on the number of trucks and so on.
*---------------------------------------------------------------------------------------------------------
Model TransportationCostModel /
                 TransportationCostConstraint7A
                 TransportationCostConstraint8A
                 TransportationCostConstraint9A
                 TransportationCostConstraint10A
                 TransportationCostConstraint11A
                 TransportationCostConstraint12A
                 TransportationCostConstraint13A
                 TransportationCostConstraint14A
                 TransportationCostConstraint15A
                 TransportationCostConstraint16A
                 TransportationCostConstraint17A
                 TransportationCostConstraint18A
                 TransportationCostConstraint19A
                 TransportationCostConstraint20A
                 TransportationCostConstraint21A
                 TransportationCostConstraint22A
*                 TransportationCostConstraint23A

                 TransportationCostConstraint24
                 TransportationCostConstraint25
                 TransportationCostConstraint26
                /;
