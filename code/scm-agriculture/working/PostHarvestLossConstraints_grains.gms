* This file includes the constraints on post harvest losses that may be included in the model

Variables
  LocalMarket_GrainDelivered Total grain delivered at the local market from all possible sources
  RegionalMarket_GrainDelivered Total grain delivered at the regional market from all possible sources
  FarmGate_GrainDelivered Total grain delivered (purchased) at the farm gate from all possible sources

  RGY_GrainDelivered Total grain delivered at the local market from all possible sources
  FCICovered_GrainDelivered Total grain delivered at the regional market from all possible sources
  FCICAP_GrainDelivered Total grain delivered (purchased) at the farm gate from all possible sources

*  LocalMarket_GrainDelivered(SimulationHorizon,LocalMarketSet) Total grain delivered at the local market from all possible sources
*  RegionalMarket_GrainDelivered(SimulationHorizon,RegionalMarketSet) Total grain delivered at the regional market from all possible sources
*  FarmGate_GrainDelivered(FarmNumber) Total grain delivered (purchased) at the farm gate from all possible sources
  TotalGrainDelivered The total grain delivered to all possible markets

*  LocalMarketLoss
*  RegionalMarketLoss
*  FarmGateLoss
*  RGYLoss
*  FCICoveredLoss
*  FCICAPLoss
*  FCITotalLoss
  TotalPHLLoss The total post harvest loss in the supply chain in percentage
  ;

Equations
  PHLConstraint1
  PHLConstraint2
  PHLConstraint3
  PHLConstraint4
  PHLConstraint5
  PHLConstraint6
  PHLConstraint7
  PHLConstraint8
  PHLConstraint9
  ;

PHLConstraint1(HarvestingHorizonAggregation,LocalMarketSet)..
  LocalMarket_GrainDelivered(HarvestingHorizonAggregation,LocalMarketSet) =e=
  sum((FarmNumber),
    HarvestFarmGateLocalMarketGrain(HarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
  )*(1-TransportationDryMatterLossRate)
  +
  sum((LocalCSPCenterSet,FarmNumber,HarvestingHorizonAggregation2)
    $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
    LocalCSPLocalMarketGrain(HarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
  )*(1-TransportationDryMatterLossRate)
  +
  sum((RegionalCSPCenterSet,FarmNumber,HarvestingHorizonAggregation2)
    $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
    RegionalCSPLocalMarketGrain(HarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
  )*(1-TransportationDryMatterLossRate)
  ;


PHLConstraint2(NonHarvestingHorizonAggregation,LocalMarketSet)..
  LocalMarket_GrainDelivered(NonHarvestingHorizonAggregation,LocalMarketSet) =e=
  sum((FarmNumber),
    HarvestFarmGateLocalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalMarketSet)
  )*(1-TransportationDryMatterLossRate)
  +
  sum((LocalCSPCenterSet,FarmNumber,HarvestingHorizonAggregation),
    LocalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
  )*(1-TransportationDryMatterLossRate)
  +
  sum((RegionalCSPCenterSet,FarmNumber,HarvestingHorizonAggregation),
    RegionalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
  )*(1-TransportationDryMatterLossRate)
  ;


PHLConstraint3(HarvestingHorizonAggregation,RegionalMarketSet)..
  RegionalMarket_GrainDelivered(HarvestingHorizonAggregation,RegionalMarketSet) =e=
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


PHLConstraint4(NonHarvestingHorizonAggregation,RegionalMarketSet)..
  RegionalMarket_GrainDelivered(NonHarvestingHorizonAggregation,RegionalMarketSet) =e=
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


PHLConstraint5(HarvestingHorizonAggregation)..
  FarmGate_GrainDelivered(HarvestingHorizonAggregation) =e= sum(FarmNumber, HarvestFarmGateDirectPurchaseGrain(HarvestingHorizonAggregation,FarmNumber));

PHLConstraint6(NonHarvestingHorizonAggregation)..
  FarmGate_GrainDelivered(NonHarvestingHorizonAggregation) =e= sum(FarmNumber, HarvestFarmGateDirectPurchaseGrain(NonHarvestingHorizonAggregation,FarmNumber));


PHLConstraint7..
  TotalGrainDelivered =e=
  sum(HarvestingHorizonAggregation, FarmGate_GrainDelivered(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep))
  +
  sum(NonHarvestingHorizonAggregation, FarmGate_GrainDelivered(NonHarvestingHorizonAggregation)*card(NonHarvestingHorizonAggregationStep))
  +
  sum((HarvestingHorizonAggregation,LocalMarketSet), LocalMarket_GrainDelivered(HarvestingHorizonAggregation,LocalMarketSet)*card(HarvestingHorizonAggregationStep))
  +
  sum((NonHarvestingHorizonAggregation,LocalMarketSet), LocalMarket_GrainDelivered(NonHarvestingHorizonAggregation,LocalMarketSet)*card(NonHarvestingHorizonAggregationStep))
  +
  sum((HarvestingHorizonAggregation,RegionalMarketSet), RegionalMarket_GrainDelivered(HarvestingHorizonAggregation,RegionalMarketSet)*card(HarvestingHorizonAggregationStep))
  +
  sum((NonHarvestingHorizonAggregation,RegionalMarketSet), RegionalMarket_GrainDelivered(NonHarvestingHorizonAggregation,RegionalMarketSet)*card(NonHarvestingHorizonAggregationStep))
  ;

PHLConstraint8..
  TotalPHLLoss =e=   (Par_FarmGateTotalGrain - TotalGrainDelivered)*100/Par_FarmGateTotalGrain;

PHLConstraint9..
  TotalPHLLoss =l= 3.5;

Model PHLConstraints /
  PHLConstraint1
  PHLConstraint2
  PHLConstraint3
  PHLConstraint4
  PHLConstraint5
  PHLConstraint6
  PHLConstraint7
  PHLConstraint8
  PHLConstraint9
  /;
