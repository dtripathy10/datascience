$title Transportation Cost calculations using simplified model

Equations
                 TransportationCostConstraint7
                 TransportationCostConstraint8
                 TransportationCostConstraint9
                 TransportationCostConstraint10
                 TransportationCostConstraint11
                 TransportationCostConstraint12
                 TransportationCostConstraint13
                 TransportationCostConstraint14
                 TransportationCostConstraint15
                 TransportationCostConstraint16
                 TransportationCostConstraint17
                 TransportationCostConstraint18
                 TransportationCostConstraint19
                 TransportationCostConstraint20
                 TransportationCostConstraint21
                 TransportationCostConstraint22
                 TransportationCostConstraint23

                 TransportationCostConstraint24
                 TransportationCostConstraint25
                 TransportationCostConstraint26
                 ;



*---------------------------------------------------------------------------------------------------------
*
* Calculation of the transportation operating cost if the calculation depends on the cost rate given as Rs/(km-kg).
* The operating cost then is calculated by multiplying the amount transported and the distance transported. The number
* of trips and the operating costs of the trucks are not considered.
*
*---------------------------------------------------------------------------------------------------------
TransportationCostConstraint7..       FarmLocalCSPTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,TransportationTypes),
                                         HarvestFarmGateLocalCSPGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                         *FarmLocalCSPDistance(FarmNumber,LocalCSPCenterSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,TransportationTypes),
                                         HarvestFarmGateLocalCSPGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)
                                         *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                                         *FarmLocalCSPDistance(FarmNumber,LocalCSPCenterSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;


TransportationCostConstraint8..       FarmRegionalCSPTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,TransportationTypes),
                                         HarvestFarmGateRegionalCSPGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                         *FarmRegionalCSPDistance(FarmNumber,RegionalCSPCenterSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,TransportationTypes),
                                         HarvestFarmGateRegionalCSPGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
                                         *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                                         *FarmRegionalCSPDistance(FarmNumber,RegionalCSPCenterSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;

TransportationCostConstraint9..       FarmLocalMarketTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,FarmNumber,LocalMarketSet,TransportationTypes),
                                         HarvestFarmGateLocalMarketGrain(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                         *FarmLocalMarketDistance(FarmNumber,LocalMarketSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet,TransportationTypes),
                                         HarvestFarmGateLocalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
                                         *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                                         *FarmLocalMarketDistance(FarmNumber,LocalMarketSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;


TransportationCostConstraint10..       FarmRegionalMarketTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet,TransportationTypes),
                                         HarvestFarmGateRegionalMarketGrain(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                         *FarmRegionalMarketDistance(FarmNumber,RegionalMarketSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet,TransportationTypes),
                                         HarvestFarmGateRegionalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)
                                         *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                                         *FarmRegionalMarketDistance(FarmNumber,RegionalMarketSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;

TransportationCostConstraint11..      LocalCSPLocalMarketTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2,TransportationTypes),
                                         LocalCSPLocalMarketGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,LocalMarketSet,
                                                         HarvestingHorizonAggregation2)
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                         *LocalCSPLocalMarketDistance(LocalCSPCenterSet,LocalMarketSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation,TransportationTypes),
                                         LocalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,LocalMarketSet,
                                                         HarvestingHorizonAggregation)
                                         *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                                         *LocalCSPLocalMarketDistance(LocalCSPCenterSet,LocalMarketSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;

TransportationCostConstraint12..      LocalCSPRegionalMarketTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2,TransportationTypes),
                                         LocalCSPRegionalMarketGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,
                                                         HarvestingHorizonAggregation2)
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                         *LocalCSPRegionalMarketDistance(LocalCSPCenterSet,RegionalMarketSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation,TransportationTypes),
                                         LocalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,
                                                         HarvestingHorizonAggregation)
                                         *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                                         *LocalCSPRegionalMarketDistance(LocalCSPCenterSet,RegionalMarketSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;

TransportationCostConstraint13..      RegionalCSPLocalMarketTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2,TransportationTypes),
                                         RegionalCSPLocalMarketGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,
                                                         HarvestingHorizonAggregation2)
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                         *RegionalCSPLocalMarketDistance(RegionalCSPCenterSet,LocalMarketSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation,TransportationTypes),
                                         RegionalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,
                                                         HarvestingHorizonAggregation)
                                         *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                                         *RegionalCSPLocalMarketDistance(RegionalCSPCenterSet,LocalMarketSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;

TransportationCostConstraint14..      RegionalCSPRegionalMarketTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2,TransportationTypes),
                                         RegionalCSPRegionalMarketGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,
                                                         HarvestingHorizonAggregation2)
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                         *RegionalCSPRegionalMarketDistance(RegionalCSPCenterSet,RegionalMarketSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation,TransportationTypes),
                                         RegionalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,
                                                         HarvestingHorizonAggregation)
                                         *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                                         *RegionalCSPRegionalMarketDistance(RegionalCSPCenterSet,RegionalMarketSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;


TransportationCostConstraint15..      LocalMarketRGYTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,LocalMarketSet,RGYSet,TransportationTypes),
                                         LocalMarketPrivateTraderRGYGrain(HarvestingHorizonAggregation,LocalMarketSet,RGYSet)
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                         *LocalMarketRGYDistance(LocalMarketSet,RGYSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,LocalMarketSet,RGYSet,TransportationTypes),
                                         LocalMarketPrivateTraderRGYGrain(NonHarvestingHorizonAggregation,LocalMarketSet,RGYSet)
                                         *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                                         *LocalMarketRGYDistance(LocalMarketSet,RGYSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;

TransportationCostConstraint16..      RegionalMarketRGYTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,RegionalMarketSet,RGYSet,TransportationTypes),
                                         RegionalMarketPrivateTraderRGYGrain(HarvestingHorizonAggregation,RegionalMarketSet,RGYSet)
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                         *RegionalMarketRGYDistance(RegionalMarketSet,RGYSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,RegionalMarketSet,RGYSet,TransportationTypes),
                                         RegionalMarketPrivateTraderRGYGrain(NonHarvestingHorizonAggregation,RegionalMarketSet,RGYSet)
                                         *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                                         *RegionalMarketRGYDistance(RegionalMarketSet,RGYSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;


TransportationCostConstraint17..      RegionalMarketFCITransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet,TransportationTypes),
                                         RegionalMarketFCIGrain(HarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet)
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                         *RegionalMarketFCIDistance(RegionalMarketSet,FCIGodownSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet,TransportationTypes),
                                         RegionalMarketFCIGrain(NonHarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet)
                                         *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                                         *RegionalMarketFCIDistance(RegionalMarketSet,FCIGodownSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;


TransportationCostConstraint18..      RGYMillerTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,RGYSet,MillerSet,TransportationTypes),
                                         RGYMillerGrain(HarvestingHorizonAggregation,RGYSet,MillerSet)
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                         *RGYMillerDistance(RGYSet,MillerSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,RGYSet,MillerSet,TransportationTypes),
                                         RGYMillerGrain(NonHarvestingHorizonAggregation,RGYSet,MillerSet)
                                         *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                                         *RGYMillerDistance(RGYSet,MillerSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;

TransportationCostConstraint19..      RGYRetailerTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,RGYSet,RetailerSet,TransportationTypes),
                                         RGYRetailerGrain(HarvestingHorizonAggregation,RGYSet,RetailerSet)
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                         *RGYRetailerDistance(RGYSet,RetailerSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,RGYSet,RetailerSet,TransportationTypes),
                                         RGYRetailerGrain(NonHarvestingHorizonAggregation,RGYSet,RetailerSet)
                                         *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                                         *RGYRetailerDistance(RGYSet,RetailerSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;


TransportationCostConstraint20..      FCIMillerTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,FCIGodownSet,MillerSet,TransportationTypes),
                                         (FCICAPMillerGrain(HarvestingHorizonAggregation,FCIGodownSet,MillerSet)
                                                 + FCICoveredMillerGrain(HarvestingHorizonAggregation,FCIGodownSet,MillerSet)
                                         )
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                         *FCIMillerDistance(FCIGodownSet,MillerSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,FCIGodownSet,MillerSet,TransportationTypes),
                                         (FCICAPMillerGrain(NonHarvestingHorizonAggregation,FCIGodownSet,MillerSet)
                                                 + FCICoveredMillerGrain(NonHarvestingHorizonAggregation,FCIGodownSet,MillerSet)
                                         )
                                         *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                                         *FCIMillerDistance(FCIGodownSet,MillerSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;


TransportationCostConstraint21..      FCIRetailerTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,FCIGodownSet,RetailerSet,TransportationTypes),
                                         (FCICAPRetailerGrain(HarvestingHorizonAggregation,FCIGodownSet,RetailerSet)
                                                 + FCICoveredRetailerGrain(HarvestingHorizonAggregation,FCIGodownSet,RetailerSet)
                                         )
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                         *FCIRetailerDistance(FCIGodownSet,RetailerSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,FCIGodownSet,RetailerSet,TransportationTypes),
                                         (FCICAPRetailerGrain(NonHarvestingHorizonAggregation,FCIGodownSet,RetailerSet)
                                                 + FCICoveredRetailerGrain(NonHarvestingHorizonAggregation,FCIGodownSet,RetailerSet)
                                         )
                                         *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                                         *FCIRetailerDistance(FCIGodownSet,RetailerSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;


TransportationCostConstraint22..      FCIPDSTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,FCIGodownSet,PDSSet,TransportationTypes),
                                         (FCICAPPDSGrain(HarvestingHorizonAggregation,FCIGodownSet,PDSSet)
                                                 + FCICoveredPDSGrain(HarvestingHorizonAggregation,FCIGodownSet,PDSSet)
                                         )
                                         *(1+GrainMoisture(HarvestingHorizonAggregation))
                                         *FCIPDSDistance(FCIGodownSet,PDSSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,FCIGodownSet,PDSSet,TransportationTypes),
                                         (FCICAPPDSGrain(NonHarvestingHorizonAggregation,FCIGodownSet,PDSSet)
                                                 + FCICoveredPDSGrain(NonHarvestingHorizonAggregation,FCIGodownSet,PDSSet)
                                         )
                                         *(1+GrainMoisture(NonHarvestingHorizonAggregation))
                                         *FCIPDSDistance(FCIGodownSet,PDSSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;

TransportationCostConstraint23..      MillerRetailerTransportationOperatingCost
                                 =e=
                                 sum((HarvestingHorizonAggregation,MillerSet,RetailerSet,TransportationTypes),
                                         MillerRetailerGrain(HarvestingHorizonAggregation,MillerSet,RetailerSet)
                                         *MillerRetailerDistance(MillerSet,RetailerSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,MillerSet,RetailerSet,TransportationTypes),
                                         MillerRetailerGrain(NonHarvestingHorizonAggregation,MillerSet,RetailerSet)
                                         *MillerRetailerDistance(MillerSet,RetailerSet)
                                         *TransportationData('TransportCostRate',TransportationTypes)
                                 )
                                 *card(NonHarvestingHorizonAggregationStep)
                                 ;


*---------------------------------------------------------------------------------------------------------
*
* Calculating the total transportation cost based on the fleet distribution and transportation time from each field
*
*---------------------------------------------------------------------------------------------------------
TransportationCostConstraint24..      TransportationFixedCost =e= 0;

*---------------------------------------------------------------------------------------------------------
*
* This is a dummy variabe that is included in the objective function so that the exact number of trucks are used.
*
*---------------------------------------------------------------------------------------------------------
TransportationCostConstraint25..      TransportationTruckCharge =e= 0;

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
                                 LocalMarketRGYTransportationOperatingCost + RegionalMarketRGYTransportationOperatingCost +
                                 RegionalMarketFCITransportationOperatingCost + RGYRetailerTransportationOperatingCost + FCIMillerTransportationOperatingCost
                                 + FCIRetailerTransportationOperatingCost + FCIPDSTransportationOperatingCost + MillerRetailerTransportationOperatingCost
                                 ;






*
* Model that calculates the transportation cost based on the distance and Rs/km-kg cost
*
Model TransportationCostModel /
                 TransportationCostConstraint7
                 TransportationCostConstraint8
                 TransportationCostConstraint9
                 TransportationCostConstraint10
                 TransportationCostConstraint11
                 TransportationCostConstraint12
                 TransportationCostConstraint13
                 TransportationCostConstraint14
                 TransportationCostConstraint15
                 TransportationCostConstraint16
                 TransportationCostConstraint17
                 TransportationCostConstraint18
                 TransportationCostConstraint19
                 TransportationCostConstraint20
                 TransportationCostConstraint21
                 TransportationCostConstraint22
*                 TransportationCostConstraint23

                 TransportationCostConstraint24
                 TransportationCostConstraint25
                 TransportationCostConstraint26
                /;

