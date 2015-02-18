* This file includes the constraints on post harvest losses that may be included in the model

Variables
  LocalMarket_GrainDelivered Total grain delivered at the local market from all possible sources
  RegionalMarket_GrainDelivered Total grain delivered at the regional market from all possible sources
  FarmGate_GrainDelivered Total grain delivered (purchased) at the farm gate from all possible sources
  TotalGrainDelivered The total grain delivered to all possible markets
  TotalPHLLoss The total post harvest loss in the supply chain in percentage


  Miller_Transportation_Loss
  Retail_Transportation_Loss 
  RGY_Transportation_Loss 
  TPDS_Transportation_Loss 
  FCI_Transportation_Loss 
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

*miller loss

PHLConstraint10..
  Miller_Transportation_Loss =e=
  sum((HarvestingHorizonAggregation,MillerSet), MillerPurchase(HarvestingHorizonAggregation,MillerSet)*card(HarvestingHorizonAggregationStep)) +
    sum((NonHarvestingHorizonAggregation,MillerSet), MillerPurchase(NonHarvestingHorizonAggregation,MillerSet)*card(NonHarvestingHorizonAggregationStep))
  -
  sum((HarvestingHorizonAggregation,MillerSet), MillerInput(HarvestingHorizonAggregation,MillerSet)*card(HarvestingHorizonAggregationStep)) +
  sum((NonHarvestingHorizonAggregation,MillerSet),MillerInput(NonHarvestingHorizonAggregation,MillerSet)*card(NonHarvestingHorizonAggregationStep))
  ;

* Retail loss

PHLConstraint10..
  Retail_Transportation_Loss =e=
  sum((HarvestingHorizonAggregation,RetailSet), RetailPurchase(HarvestingHorizonAggregation,RetailSet)*card(HarvestingHorizonAggregationStep)) +
    sum((NonHarvestingHorizonAggregation,RetailSet), RetailPurchase(NonHarvestingHorizonAggregation,RetailSet)*card(NonHarvestingHorizonAggregationStep))
  -
  sum((HarvestingHorizonAggregation,RetailrSet), RetailInput(HarvestingHorizonAggregation,RetailSet)*card(HarvestingHorizonAggregationStep)) +
  sum((NonHarvestingHorizonAggregation,RetailSet),RetailInput(NonHarvestingHorizonAggregation,RetailSet)*card(NonHarvestingHorizonAggregationStep))
  ;

* TPDS loss
PHLConstraint10..
  TPDS_Transportation_Loss =e=
  sum((HarvestingHorizonAggregation,TPDSSet), TPDSPurchase(HarvestingHorizonAggregation,TPDSSet)*card(HarvestingHorizonAggregationStep)) +
    sum((NonHarvestingHorizonAggregation,TPDSSet), TPDSPurchase(NonHarvestingHorizonAggregation,TPDSSet)*card(NonHarvestingHorizonAggregationStep))
  -
  sum((HarvestingHorizonAggregation,TPDSSet), MillerInput(HarvestingHorizonAggregation,TPDSSet)*card(HarvestingHorizonAggregationStep)) +
  sum((NonHarvestingHorizonAggregation,TPDSSet),MillerInput(NonHarvestingHorizonAggregation,TPDSSet)*card(NonHarvestingHorizonAggregationStep))
  ;

* RGY loss
PHLConstraint10..
  RGY_Transportation_Loss =e=
  sum((HarvestingHorizonAggregation,RGYSet), RGYPurchase(HarvestingHorizonAggregation,RGYSet)*card(HarvestingHorizonAggregationStep)) +
    sum((NonHarvestingHorizonAggregation,RGYSet), RGYPurchase(NonHarvestingHorizonAggregation,RGYSet)*card(NonHarvestingHorizonAggregationStep))
  -
  sum((HarvestingHorizonAggregation,RGYSet), RGYInput(HarvestingHorizonAggregation,RGYSet)*card(HarvestingHorizonAggregationStep)) +
  sum((NonHarvestingHorizonAggregation,RGYSet),RGYInput(NonHarvestingHorizonAggregation,RGYSet)*card(NonHarvestingHorizonAggregationStep))
  ;

* FCI loss  
PHLConstraint10..
  FCI_Transportation_Loss =e=
  sum((HarvestingHorizonAggregation,FCIGodownSet), FCIPurchase(HarvestingHorizonAggregation,FCIGodownSet)*card(HarvestingHorizonAggregationStep)) +
    sum((NonHarvestingHorizonAggregation,FCIGodownSet), FCIPurchase(NonHarvestingHorizonAggregation,FCIGodownSet)*card(NonHarvestingHorizonAggregationStep))
  -
  sum((HarvestingHorizonAggregation,FCIGodownSet), FCIInput(HarvestingHorizonAggregation,FCIGodownSet)*card(HarvestingHorizonAggregationStep)) +
  sum((NonHarvestingHorizonAggregation,FCIGodownSet), FCIInput(NonHarvestingHorizonAggregation,FCIGodownSet)*card(NonHarvestingHorizonAggregationStep))
  ;

PHLConstraint11..
  RGY_Transportation_Loss =e=
    sum((HarvestingHorizonAggregation,RGYSet), 
      RGYPurchase(HarvestingHorizonAggregation,RGYSet)*card(HarvestingHorizonAggregationStep)
    ) +
    sum((NonHarvestingHorizonAggregation,RGYSet), 
      RGYPurchase(NonHarvestingHorizonAggregation,RGYSet)*card(NonHarvestingHorizonAggregationStep)
    ) -
    sum((HarvestingHorizonAggregation,RGYSet), 
      RGYInput(HarvestingHorizonAggregation,RGYSet)*card(HarvestingHorizonAggregationStep)
    ) +
    sum((NonHarvestingHorizonAggregation,RGYSet), 
      RGYInput(NonHarvestingHorizonAggregation,RGYSet)*card(NonHarvestingHorizonAggregationStep)
    )
  ;

PHLConstraint12..
  RGY_Storage_Loss =e=
    sum((HarvestingHorizonAggregation,RGYSet), 
      RGYInput(HarvestingHorizonAggregation,RGYSet)*card(HarvestingHorizonAggregationStep)
    ) +
    sum((NonHarvestingHorizonAggregation,RGYSet), 
      RGYInput(NonHarvestingHorizonAggregation,RGYSet)*card(NonHarvestingHorizonAggregationStep)
    ) -
    RGYTotalOutput
  ;
PHLConstraint1(HarvestingHorizonAggregation,LocalMarketSet)..
                         LocalMarket_GrainDelivered(HarvestingHorizonAggregation,LocalMarketSet) =e=
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
                         )*(1-TransportationDryMatterLossRate);


PHLConstraint2(NonHarvestingHorizonAggregation,LocalMarketSet)..
                         LocalMarket_GrainDelivered(NonHarvestingHorizonAggregation,LocalMarketSet) =e=
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
                         )*(1-TransportationDryMatterLossRate);


PHLConstraint3(HarvestingHorizonAggregation,RegionalMarketSet)..
                         RegionalMarket_GrainDelivered(HarvestingHorizonAggregation,RegionalMarketSet) =e=
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
                         )*(1-TransportationDryMatterLossRate);


PHLConstraint4(NonHarvestingHorizonAggregation,RegionalMarketSet)..
                         RegionalMarket_GrainDelivered(NonHarvestingHorizonAggregation,RegionalMarketSet) =e=
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
                         )*(1-TransportationDryMatterLossRate);


PHLConstraint5(HarvestingHorizonAggregation)..
                         FarmGate_GrainDelivered(HarvestingHorizonAggregation) =e= sum((DistrictSelected,FarmNumber),HarvestFarmGateDirectPurchaseGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber));

PHLConstraint6(NonHarvestingHorizonAggregation)..
                         FarmGate_GrainDelivered(NonHarvestingHorizonAggregation) =e= sum((DistrictSelected,FarmNumber),HarvestFarmGateDirectPurchaseGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber));


PHLConstraint7..      TotalGrainDelivered =e=
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
                      sum((NonHarvestingHorizonAggregation,RegionalMarketSet), RegionalMarket_GrainDelivered(NonHarvestingHorizonAggregation,RegionalMarketSet)*card(NonHarvestingHorizonAggregationStep));

PHLConstraint8..    TotalPHLLoss =e=   (Par_FarmGateTotalGrain - TotalGrainDelivered)*100/Par_FarmGateTotalGrain;

PHLConstraint9..    TotalPHLLoss =l= 3.5;

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
