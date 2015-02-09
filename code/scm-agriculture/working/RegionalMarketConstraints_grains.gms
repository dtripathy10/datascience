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
                         sum((FarmNumber),
                                 HarvestFarmGateRegionalMarketGrain(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((LocalCSPCenterSet,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 LocalCSPRegionalMarketGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((RegionalCSPCenterSet,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 RegionalCSPRegionalMarketGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                         ;

RegionalMarketConstraint2(NonHarvestingHorizonAggregation,RegionalMarketSet)$(not(CentralStorageProcessing))..
                         RegionalMarketTotalGrain(NonHarvestingHorizonAggregation,RegionalMarketSet)
                         =e=
                         sum((FarmNumber),
                                 HarvestFarmGateRegionalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((LocalCSPCenterSet,FarmNumber,HarvestingHorizonAggregation),
                                 LocalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((RegionalCSPCenterSet,FarmNumber,HarvestingHorizonAggregation),
                                 RegionalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
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
