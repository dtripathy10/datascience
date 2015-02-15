* Post optimization calculations

Set
         GrainMarkets /Production, FarmGate, LocalMarket, RegionalMarket/;
Parameter
         FarmGateLocalMarket_GrainDelivered The total grain delivered from the farm gate to a particular local market
         FarmGateRegionalMarket_GrainDelivered The total grain delivered from the farm gate to a particular Regional market
         LocalCSPLocalMarket_GrainDelivered The total grain delivered from a particular local CSP to a particular local market
         LocalCSPRegionalMarket_GrainDelivered The total grain delivered from a particular local CSP to a particular regional market
         RegionalCSPLocalMarket_GrainDelivered The total grain delivered from a particular regional CSP to a particular local market
         RegionalCSPRegionalMarket_GrainDelivered The total grain delivered from a particular regional CSP to a particular regional market
         TotalBags The total number of bags required for the transportation and storage of grains
         Farm_GrainSalePattern(TotalFarmNumber,GrainMarkets) The total grain delivered from a particular farm to a particular market during the entire simulation horizon
         Farm_GrainSalePatternFraction(TotalFarmNumber,GrainMarkets) The fraction of total grain delivered from a particular farm to a particular market during the entire simulation horizon
         ;


LocalCSPLocalMarket_GrainDelivered(HarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet) =
                         sum((FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 LocalCSPLocalMarketGrain.l(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate);
LocalCSPLocalMarket_GrainDelivered(NonHarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet) =
                         sum((FarmNumber,HarvestingHorizonAggregation),
                                 LocalCSPLocalMarketGrain.l(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate);

RegionalCSPLocalMarket_GrainDelivered(HarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet) =
                         sum((FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 RegionalCSPLocalMarketGrain.l(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate);
RegionalCSPLocalMarket_GrainDelivered(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet) =
                         sum((FarmNumber,HarvestingHorizonAggregation),
                                 RegionalCSPLocalMarketGrain.l(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate);
FarmGateLocalMarket_GrainDelivered(HarvestingHorizonAggregation,LocalMarketSet) =
                         sum(FarmNumber,
                                 HarvestFarmGateLocalMarketGrain.l(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
                         )*(1-TransportationDryMatterLossRate);
FarmGateLocalMarket_GrainDelivered(NonHarvestingHorizonAggregation,LocalMarketSet) =
                         sum(FarmNumber,
                                 HarvestFarmGateLocalMarketGrain.l(NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
                         )*(1-TransportationDryMatterLossRate);




TotalBags =                    sum((HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet),
                                         FarmLocalCSPGunnyBags.l(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)
                                )
                                +
                                sum((NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet),
                                         FarmLocalCSPGunnyBags.l(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet)
                                )
                                +
                                sum((HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet),
                                         FarmRegionalCSPGunnyBags.l(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
                                )
                                +
                                sum((NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet),
                                         FarmRegionalCSPGunnyBags.l(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet)
                                )
                                +
                                sum((HarvestingHorizonAggregation,FarmNumber,LocalMarketSet),
                                         FarmLocalMarketGunnyBags.l(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
                                )
                                +
                                sum((NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet),
                                         FarmLocalMarketGunnyBags.l(NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
                                )
                                +
                                sum((HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet),
                                         FarmRegionalMarketGunnyBags.l(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)
                                )
                                +
                                sum((NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet),
                                         FarmRegionalMarketGunnyBags.l(NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)
                                )
                                +
                                sum((HarvestingHorizonAggregation,FarmNumber),
                                         FarmDirectPurchaseGunnyBags.l(HarvestingHorizonAggregation,FarmNumber)
                                )
                                +
                                sum((NonHarvestingHorizonAggregation,FarmNumber),
                                         FarmDirectPurchaseGunnyBags.l(NonHarvestingHorizonAggregation,FarmNumber)
                                );



Farm_GrainSalePattern(FarmNumber,'LocalMarket') =
                         sum((HarvestingHorizonAggregation,LocalMarketSet),
                                 HarvestFarmGateLocalMarketGrain.l(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
                         )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep)
                         +
                         sum((NonHarvestingHorizonAggregation,LocalMarketSet),
                                 HarvestFarmGateLocalMarketGrain.l(NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
                         )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep)
                         +
                         sum((LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 LocalCSPLocalMarketGrain.l(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep)
                         +
                         sum((RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 RegionalCSPLocalMarketGrain.l(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep)
                         +
                         sum((LocalCSPCenterSet,LocalMarketSet,NonHarvestingHorizonAggregation,HarvestingHorizonAggregation),
                                 LocalCSPLocalMarketGrain.l(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep)
                         +
                         sum((RegionalCSPCenterSet,LocalMarketSet,NonHarvestingHorizonAggregation,HarvestingHorizonAggregation),
                                 RegionalCSPLocalMarketGrain.l(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep)
                         ;

Farm_GrainSalePattern(FarmNumber,'RegionalMarket') =
                         sum((HarvestingHorizonAggregation,RegionalMarketSet),
                                 HarvestFarmGateRegionalMarketGrain.l(HarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)
                         )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep)
                         +
                         sum((NonHarvestingHorizonAggregation,RegionalMarketSet),
                                 HarvestFarmGateRegionalMarketGrain.l(NonHarvestingHorizonAggregation,FarmNumber,RegionalMarketSet)
                         )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep)
                         +
                         sum((LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 LocalCSPRegionalMarketGrain.l(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep)
                         +
                         sum((RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 RegionalCSPRegionalMarketGrain.l(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep)
                         +
                         sum((LocalCSPCenterSet,RegionalMarketSet,NonHarvestingHorizonAggregation,HarvestingHorizonAggregation),
                                 LocalCSPRegionalMarketGrain.l(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep)
                         +
                         sum((RegionalCSPCenterSet,RegionalMarketSet,NonHarvestingHorizonAggregation,HarvestingHorizonAggregation),
                                 RegionalCSPRegionalMarketGrain.l(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep)
                         ;

Farm_GrainSalePattern(FarmNumber,'FarmGate') =
                         sum(HarvestingHorizonAggregation,
                                 HarvestFarmGateDirectPurchaseGrain.l(HarvestingHorizonAggregation,FarmNumber)*card(HarvestingHorizonAggregationStep)
                         )
                         +
                         sum(NonHarvestingHorizonAggregation,
                                 HarvestFarmGateDirectPurchaseGrain.l(NonHarvestingHorizonAggregation,FarmNumber)*card(NonHarvestingHorizonAggregationStep)
                         )
                         ;

Farm_GrainSalePattern(FarmNumber,'Production') = GrainAvailable(FarmNumber);


Farm_GrainSalePatternFraction(FarmNumber,GrainMarkets) = Farm_GrainSalePattern(FarmNumber,GrainMarkets)/Farm_GrainSalePattern(FarmNumber,'Production');

Display LocalCSPLocalMarket_GrainDelivered, RegionalCSPLocalMarket_GrainDelivered, FarmGateLocalMarket_GrainDelivered, TotalBags, Farm_GrainSalePattern, Farm_GrainSalePatternFraction;

