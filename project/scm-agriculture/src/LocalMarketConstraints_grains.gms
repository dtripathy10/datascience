$title Constraints relevant to the local market of grains

Equations
                 LocalMarketConstraint1
                 LocalMarketConstraint2
                 LocalMarketConstraint3
                 LocalMarketConstraint4
                 LocalMarketConstraint5
                 LocalMarketConstraint6
                 ;

LocalMarketConstraint1(HarvestingHorizonAggregation,LocalMarketSet)..
                         LocalMarketTotalGrain(HarvestingHorizonAggregation,LocalMarketSet)
                         =e=
                         sum((DistrictSelected,FarmNumber),
                                 HarvestFarmGateLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((LocalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 LocalCSPLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((RegionalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)
                                        $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 RegionalCSPLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                         ;

LocalMarketConstraint2(NonHarvestingHorizonAggregation,LocalMarketSet)..
                         LocalMarketTotalGrain(NonHarvestingHorizonAggregation,LocalMarketSet)
                         =e=
                         sum((DistrictSelected,FarmNumber),
                                 HarvestFarmGateLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((LocalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation),
                                 LocalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((RegionalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation),
                                 RegionalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)
                         ;


LocalMarketConstraint3(HarvestingHorizonAggregation,LocalMarketSet)..
                         LocalMarketTotalGrain(HarvestingHorizonAggregation,LocalMarketSet) =l= LocalMarketCapacity(LocalMarketSet);

LocalMarketConstraint4(NonHarvestingHorizonAggregation,LocalMarketSet)..
                         LocalMarketTotalGrain(NonHarvestingHorizonAggregation,LocalMarketSet) =l= LocalMarketCapacity(LocalMarketSet);



*=======================================================================================
* Constraints pertaining to the distribution of the grain sold at a regoinal market (mandi)
*=======================================================================================

LocalMarketConstraint5(HarvestingHorizonAggregation,LocalMarketSet)..
                        LocalMarketTotalGrain(HarvestingHorizonAggregation,LocalMarketSet)
                        =e=
                        LocalMarketPrivateTraderGrain(HarvestingHorizonAggregation,LocalMarketSet)
                        ;

LocalMarketConstraint6(NonHarvestingHorizonAggregation,LocalMarketSet)..
                        LocalMarketTotalGrain(NonHarvestingHorizonAggregation,LocalMarketSet)
                        =e=
                        LocalMarketPrivateTraderGrain(NonHarvestingHorizonAggregation,LocalMarketSet)
                        ;



*
* Defining the model if the constraints are on the total grain that can be delivered at a particular market as a function of time.
* The contribution of individual farms is not considered in that case.
*
Model LocalMarketModel /
                 LocalMarketConstraint1
                 LocalMarketConstraint2
                 LocalMarketConstraint3
                 LocalMarketConstraint4
                 LocalMarketConstraint5
                 LocalMarketConstraint6
                 /;
