$title "Post optimization calculations"

Set
  GrainMarkets /Production, FarmGate, LocalMarket, RegionalMarket/
  ;
Parameter
  FarmGateLocalMarket_GrainDelivered "The total grain delivered from the farm gate to a particular local market"
  FarmGateRegionalMarket_GrainDelivered "The total grain delivered from the farm gate to a particular Regional market"
  LocalCSPLocalMarket_GrainDelivered "The total grain delivered from a particular local CSP to a particular local market"
  LocalCSPRegionalMarket_GrainDelivered "The total grain delivered from a particular local CSP to a particular regional market"
  RegionalCSPLocalMarket_GrainDelivered "The total grain delivered from a particular regional CSP to a particular local market"
  RegionalCSPRegionalMarket_GrainDelivered "The total grain delivered from a particular regional CSP to a particular regional market"
  TotalBags "The total number of bags required for the transportation and storage of grains"
  Farm_GrainSalePattern(DistrictSelected,TotalFarmNumber,GrainMarkets) "The total grain delivered from a particular farm to a particular market during the entire simulation horizon"
  Farm_GrainSalePatternFraction(DistrictSelected,TotalFarmNumber,GrainMarkets) "The fraction of total grain delivered from a particular farm to a particular market during the entire simulation horizon"
  ;

LocalCSPLocalMarket_GrainDelivered(HarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet) =
  sum((DistrictSelected,FarmNumber,HarvestingHorizonAggregation2) $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
    LocalCSPLocalMarketGrain.l(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
  )*(1-TransportationDryMatterLossRate)
  ;

LocalCSPLocalMarket_GrainDelivered(NonHarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet) =
  sum((DistrictSelected,FarmNumber,HarvestingHorizonAggregation),
    LocalCSPLocalMarketGrain.l(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
  )*(1-TransportationDryMatterLossRate)
  ;

RegionalCSPLocalMarket_GrainDelivered(HarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet) =
  sum((DistrictSelected,FarmNumber,HarvestingHorizonAggregation2) $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
    RegionalCSPLocalMarketGrain.l(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
  )*(1-TransportationDryMatterLossRate)
  ;

RegionalCSPLocalMarket_GrainDelivered(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet) =
  sum((DistrictSelected,FarmNumber,HarvestingHorizonAggregation),
    RegionalCSPLocalMarketGrain.l(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
  )*(1-TransportationDryMatterLossRate)
  ;

FarmGateLocalMarket_GrainDelivered(HarvestingHorizonAggregation,LocalMarketSet) =
  sum(DistrictSelected,sum(FarmNumber,
    HarvestFarmGateLocalMarketGrain.l(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
  ))*(1-TransportationDryMatterLossRate)
  ;

FarmGateLocalMarket_GrainDelivered(NonHarvestingHorizonAggregation,LocalMarketSet) =
  sum(DistrictSelected,sum(FarmNumber,
    HarvestFarmGateLocalMarketGrain.l(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
  ))*(1-TransportationDryMatterLossRate)
  ;
  
TotalBags =                     
  sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet),
    FarmLocalCSPGunnyBags.l(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet)
  ) +
  sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet),
    FarmLocalCSPGunnyBags.l(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet)
  ) +
  sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet),
    FarmRegionalCSPGunnyBags.l(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet)
  ) +
  sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet),
    FarmRegionalCSPGunnyBags.l(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet)
  ) +
  sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet),
    FarmLocalMarketGunnyBags.l(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
  ) +
  sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet),
    FarmLocalMarketGunnyBags.l(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
  ) +
  sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)$(connectselected(DistrictSelected,RegionalMarketSet)),
    FarmRegionalMarketGunnyBags.l(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)
  ) +
  sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)$(connectselected(DistrictSelected,RegionalMarketSet)),
    FarmRegionalMarketGunnyBags.l(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)
  ) +
  sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber),
    FarmDirectPurchaseGunnyBags.l(HarvestingHorizonAggregation,DistrictSelected,FarmNumber)
  ) +
  sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber),
    FarmDirectPurchaseGunnyBags.l(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber)
  )
  ;

Farm_GrainSalePattern(DistrictSelected,FarmNumber,'LocalMarket') =
  sum((HarvestingHorizonAggregation,LocalMarketSet),
    HarvestFarmGateLocalMarketGrain.l(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
  )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep) +
  sum((NonHarvestingHorizonAggregation,LocalMarketSet),
    HarvestFarmGateLocalMarketGrain.l(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
  )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep) +
  sum((LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
  $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
    LocalCSPLocalMarketGrain.l(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
  )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep) +
  sum((RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
  $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
    RegionalCSPLocalMarketGrain.l(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
  )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep) +
  sum((LocalCSPCenterSet,LocalMarketSet,NonHarvestingHorizonAggregation,HarvestingHorizonAggregation),
    LocalCSPLocalMarketGrain.l(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
  )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep) +
  sum((RegionalCSPCenterSet,LocalMarketSet,NonHarvestingHorizonAggregation,HarvestingHorizonAggregation),
    RegionalCSPLocalMarketGrain.l(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
  )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep)
  ;

Farm_GrainSalePattern(DistrictSelected,FarmNumber,'RegionalMarket') =
  sum((HarvestingHorizonAggregation,RegionalMarketSet)$(connectselected(DistrictSelected,RegionalMarketSet)),
    HarvestFarmGateRegionalMarketGrain.l(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)
  )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep) +
  sum((NonHarvestingHorizonAggregation,RegionalMarketSet)$(connectselected(DistrictSelected,RegionalMarketSet)),
    HarvestFarmGateRegionalMarketGrain.l(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)
  )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep) +
  sum((LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
  $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and connectselected(DistrictSelected,RegionalMarketSet)),
    LocalCSPRegionalMarketGrain.l(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
  )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep) +
  sum((RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation,HarvestingHorizonAggregation2)
  $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and connectselected(DistrictSelected,RegionalMarketSet)),
    RegionalCSPRegionalMarketGrain.l(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
  )*(1-TransportationDryMatterLossRate)*card(HarvestingHorizonAggregationStep) +
  sum((LocalCSPCenterSet,RegionalMarketSet,NonHarvestingHorizonAggregation,HarvestingHorizonAggregation)$(connectselected(DistrictSelected,RegionalMarketSet)),
    LocalCSPRegionalMarketGrain.l(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
  )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep) +
  sum((RegionalCSPCenterSet,RegionalMarketSet,NonHarvestingHorizonAggregation,HarvestingHorizonAggregation)$(connectselected(DistrictSelected,RegionalMarketSet)),
    RegionalCSPRegionalMarketGrain.l(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
  )*(1-TransportationDryMatterLossRate)*card(NonHarvestingHorizonAggregationStep)
  ;

Farm_GrainSalePattern(DistrictSelected,FarmNumber,'FarmGate') =
  sum(HarvestingHorizonAggregation,
    HarvestFarmGateDirectPurchaseGrain.l(HarvestingHorizonAggregation,DistrictSelected,FarmNumber)*card(HarvestingHorizonAggregationStep)
  ) +
  sum(NonHarvestingHorizonAggregation,
    HarvestFarmGateDirectPurchaseGrain.l(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber)*card(NonHarvestingHorizonAggregationStep)
  )
  ;

Farm_GrainSalePattern(DistrictSelected,FarmNumber,'Production') = 
  GrainAvailable(DistrictSelected,FarmNumber)
  ;


Farm_GrainSalePatternFraction(DistrictSelected,FarmNumber,GrainMarkets) = 
  Farm_GrainSalePattern(DistrictSelected,FarmNumber,GrainMarkets)/Farm_GrainSalePattern(DistrictSelected,FarmNumber,'Production')
  ;

Display 
  LocalCSPLocalMarket_GrainDelivered, RegionalCSPLocalMarket_GrainDelivered, FarmGateLocalMarket_GrainDelivered, 
  TotalBags, Farm_GrainSalePattern, Farm_GrainSalePatternFraction
  ;

