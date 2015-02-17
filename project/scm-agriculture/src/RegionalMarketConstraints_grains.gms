$title Constraints relevant to the regional market of grains (Mandi)

Equations
                 RegionalMarketConstraint1
                 RegionalMarketConstraint2
                 RegionalMarketConstraint3
                 RegionalMarketConstraint4
                 RegionalMarketConstraint5
                 RegionalMarketConstraint6
                 RegionalMarketConstraint7
                 ;

RegionalMarketConstraint1(HarvestingHorizonAggregation,RegionalMarketSet)$(not(CentralStorageProcessing))..
                         RegionalMarketTotalGrain(HarvestingHorizonAggregation,RegionalMarketSet)
                         =e=
                         sum((DistrictSelected,FarmNumber)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 HarvestFarmGateRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((LocalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and connectselected(DistrictSelected,RegionalMarketSet)),
                                 LocalCSPRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((RegionalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and connectselected(DistrictSelected,RegionalMarketSet)),
                                 RegionalCSPRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                         ;

RegionalMarketConstraint2(NonHarvestingHorizonAggregation,RegionalMarketSet)$(not(CentralStorageProcessing))..
                         RegionalMarketTotalGrain(NonHarvestingHorizonAggregation,RegionalMarketSet)
                         =e=
                         sum((DistrictSelected,FarmNumber)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 HarvestFarmGateRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((LocalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 LocalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((RegionalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 RegionalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)
                         ;



RegionalMarketConstraint3(HarvestingHorizonAggregation,RegionalMarketSet)..
                         RegionalMarketTotalGrain(HarvestingHorizonAggregation,RegionalMarketSet) =l= RegionalMarketCapacity(RegionalMarketSet);

RegionalMarketConstraint4(NonHarvestingHorizonAggregation,RegionalMarketSet)..
                         RegionalMarketTotalGrain(NonHarvestingHorizonAggregation,RegionalMarketSet) =l= RegionalMarketCapacity(RegionalMarketSet);



*=======================================================================================
* Constraints pertaining to the distribution of the grain sold at a regoinal market (mandi)
*=======================================================================================

RegionalMarketConstraint5(HarvestingHorizonAggregation,RegionalMarketSet)$(not(CentralStorageProcessing))..
                        RegionalMarketTotalGrain(HarvestingHorizonAggregation,RegionalMarketSet)
                        =e=
                        sum(FCIGodownSet,RegionalMarketFCIGrain(HarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet))
                        +
                        RegionalMarketPrivateTraderGrain(HarvestingHorizonAggregation,RegionalMarketSet)
                        ;

RegionalMarketConstraint6(NonHarvestingHorizonAggregation,RegionalMarketSet)$(not(CentralStorageProcessing))..
                        RegionalMarketTotalGrain(NonHarvestingHorizonAggregation,RegionalMarketSet)
                        =e=
                        sum(FCIGodownSet,RegionalMarketFCIGrain(NonHarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet))
                        +
                        RegionalMarketPrivateTraderGrain(NonHarvestingHorizonAggregation,RegionalMarketSet)
                        ;


RegionalMarketConstraint7(RegionalMarketSet)..
                         sum((HarvestingHorizonAggregation,FCIGodownSet), RegionalMarketFCIGrain(HarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet))
                         +
                         sum((NonHarvestingHorizonAggregation,FCIGodownSet), RegionalMarketFCIGrain(NonHarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet))
                         =g=
                         0;

*
* Defining the model if the constraints are on the total grain that can be delivered at a particular market as a function of time.
* The contribution of individual farms is not considered in that case.
*
Model RegionalMarketModel /
                 RegionalMarketConstraint1
                 RegionalMarketConstraint2
                 RegionalMarketConstraint3
                 RegionalMarketConstraint4
                 RegionalMarketConstraint5
                 RegionalMarketConstraint6
                 RegionalMarketConstraint7
                 /;
