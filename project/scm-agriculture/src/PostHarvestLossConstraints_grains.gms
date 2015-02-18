$title "loss calculation in percentage"

Variables
  FarmGate_GrainDelivered "Total grain delivered (purchased) at the farm gate from all possible sources"
  TotalPHLLoss "The total post harvest loss in the supply chain in percentage"

  Miller_Transportation_Loss
  Retail_Transportation_Loss
  TPDS_Transportation_Loss 
  RGY_Transportation_Loss 
  FCI_Transportation_Loss 
  Market_Transportation_Loss

  Miller_Storage_Loss
  Retail_Storage_Loss
  TPDS_Storage_Loss 
  RGY_Storage_Loss 
  FCI_Storage_Loss
  LocalCSP_Storage_Loss
  RegionalCSP_Storage_Loss
  ;

Equations
  PHLConstraint1
  PHLConstraint2
  PHLConstraint3 "total loss calculation"
  PHLConstraint4 "maximum total loss constraint"

  PHLConstraint1TL "transportation loss by miller in percentage"
  PHLConstraint2TL "transportation loss by retailer in percentage"
  PHLConstraint3TL "transportation loss by tpds in percentage"
  PHLConstraint4TL "transportation loss by RGY in percentage"
  PHLConstraint5TL "transportation loss by FCI in percentage"
  PHLConstraint6TL "transportation loss from farmer-storage-market in percentage"

  PHLConstraint1SL "storage loss by miller in percentage"
  PHLConstraint2SL "loss by retailer in percentage"
  PHLConstraint3SL "loss by tpds in percentage"
  PHLConstraint4SL "loss by RGY in percentage"
  PHLConstraint5SL "loss by FCI in percentage"
  PHLConstraint6SL "loss by RGY in percentage"
  PHLConstraint7SL "loss by FCI in percentage"
  ;

PHLConstraint1(HarvestingHorizonAggregation)..
  FarmGate_GrainDelivered(HarvestingHorizonAggregation) =e= 
    sum((DistrictSelected,FarmNumber),
      HarvestFarmGateDirectPurchaseGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber)
    )
  ;

PHLConstraint2(NonHarvestingHorizonAggregation)..
  FarmGate_GrainDelivered(NonHarvestingHorizonAggregation) =e= 
    sum((DistrictSelected,FarmNumber),
      HarvestFarmGateDirectPurchaseGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber)
    )
  ;

PHLConstraint1TL..
  Miller_Transportation_Loss =e=
    ((sum((HarvestingHorizonAggregation,MillerSet), 
          MillerPurchase(HarvestingHorizonAggregation,MillerSet) * card(HarvestingHorizonAggregationStep)
      ) +
      sum((NonHarvestingHorizonAggregation,MillerSet), 
        MillerPurchase(NonHarvestingHorizonAggregation,MillerSet) * card(NonHarvestingHorizonAggregationStep)
      ) -
      sum((HarvestingHorizonAggregation,MillerSet), 
        MillerInput(HarvestingHorizonAggregation,MillerSet) * card(HarvestingHorizonAggregationStep)
      ) +
      sum((NonHarvestingHorizonAggregation,MillerSet),
        MillerInput(NonHarvestingHorizonAggregation,MillerSet) * card(NonHarvestingHorizonAggregationStep)
      )) /
    (
      sum((HarvestingHorizonAggregation,MillerSet), 
        MillerPurchase(HarvestingHorizonAggregation,MillerSet) * card(HarvestingHorizonAggregationStep)
      ) +
      sum((NonHarvestingHorizonAggregation,MillerSet), 
        MillerPurchase(NonHarvestingHorizonAggregation,MillerSet) * card(NonHarvestingHorizonAggregationStep)
      ) 
    ))*100
  ;

PHLConstraint2TL..
  Retail_Transportation_Loss =e=
    ((
        sum((HarvestingHorizonAggregation,RetailSet), 
          RetailPurchase(HarvestingHorizonAggregation,RetailSet) * card(HarvestingHorizonAggregationStep)
        ) +
        sum((NonHarvestingHorizonAggregation,RetailSet), 
          RetailPurchase(NonHarvestingHorizonAggregation,RetailSet) * card(NonHarvestingHorizonAggregationStep)
        ) -
        sum((HarvestingHorizonAggregation,RetailSet), 
          RetailInput(HarvestingHorizonAggregation,RetailSet) * card(HarvestingHorizonAggregationStep)
        ) +
        sum((NonHarvestingHorizonAggregation,RetailSet),
          RetailInput(NonHarvestingHorizonAggregation,RetailSet) * card(NonHarvestingHorizonAggregationStep)
        )
    ) /
    (
      sum((HarvestingHorizonAggregation,RetailSet), 
        RetailPurchase(HarvestingHorizonAggregation,RetailSet) * card(HarvestingHorizonAggregationStep)
      ) +
      sum((NonHarvestingHorizonAggregation,RetailSet), 
        RetailPurchase(NonHarvestingHorizonAggregation,RetailSet) * card(NonHarvestingHorizonAggregationStep)
      ) 
    ))*100
  ;

PHLConstraint3TL..
  TPDS_Transportation_Loss =e=
    ((
        sum((HarvestingHorizonAggregation,TPDSSet), 
          TPDSPurchase(HarvestingHorizonAggregation,TPDSSet) * card(HarvestingHorizonAggregationStep)
        ) +
        sum((NonHarvestingHorizonAggregation,TPDSSet), 
          TPDSPurchase(NonHarvestingHorizonAggregation,TPDSSet) * card(NonHarvestingHorizonAggregationStep)
        ) -
        sum((HarvestingHorizonAggregation,TPDSSet), 
          TPDSInput(HarvestingHorizonAggregation,TPDSSet) * card(HarvestingHorizonAggregationStep)
        ) +
        sum((NonHarvestingHorizonAggregation,TPDSSet),
          TPDSInput(NonHarvestingHorizonAggregation,TPDSSet) * card(NonHarvestingHorizonAggregationStep)
        )
    ) /
    (
      sum((HarvestingHorizonAggregation,TPDSSet), 
        TPDSPurchase(HarvestingHorizonAggregation,TPDSSet) * card(HarvestingHorizonAggregationStep)
      ) +
      sum((NonHarvestingHorizonAggregation,TPDSSet), 
        TPDSPurchase(NonHarvestingHorizonAggregation,TPDSSet) * card(NonHarvestingHorizonAggregationStep)
      ) 
    ))*100
  ;

PHLConstraint4TL..
  RGY_Transportation_Loss =e=
    ((
        sum((HarvestingHorizonAggregation,RGYSet), 
          RGYPurchase(HarvestingHorizonAggregation,RGYSet) * card(HarvestingHorizonAggregationStep)
        ) +
        sum((NonHarvestingHorizonAggregation,RGYSet), 
          RGYPurchase(NonHarvestingHorizonAggregation,RGYSet) * card(NonHarvestingHorizonAggregationStep)
        ) -
        sum((HarvestingHorizonAggregation,RGYSet), 
          RGYInput(HarvestingHorizonAggregation,RGYSet) * card(HarvestingHorizonAggregationStep)
        ) +
        sum((NonHarvestingHorizonAggregation,RGYSet),
          RGYInput(NonHarvestingHorizonAggregation,RGYSet) * card(NonHarvestingHorizonAggregationStep)
        )
    ) /
    (
      sum((HarvestingHorizonAggregation,RGYSet), 
        RGYPurchase(HarvestingHorizonAggregation,RGYSet) * card(HarvestingHorizonAggregationStep)
      ) +
      sum((NonHarvestingHorizonAggregation,RGYSet), 
        RGYPurchase(NonHarvestingHorizonAggregation,RGYSet) * card(NonHarvestingHorizonAggregationStep)
      ) 
    ))*100
  ;

PHLConstraint5TL..
  FCI_Transportation_Loss =e=
    ((
        sum((HarvestingHorizonAggregation,FCIGodownSet), 
          FCIPurchase(HarvestingHorizonAggregation,FCIGodownSet) * card(HarvestingHorizonAggregationStep)
        ) +
        sum((NonHarvestingHorizonAggregation,FCIGodownSet), 
          FCIPurchase(NonHarvestingHorizonAggregation,FCIGodownSet) * card(NonHarvestingHorizonAggregationStep)
        ) -
        sum((HarvestingHorizonAggregation,FCIGodownSet), 
          FCIInput(HarvestingHorizonAggregation,FCIGodownSet) * card(HarvestingHorizonAggregationStep)
        ) +
        sum((NonHarvestingHorizonAggregation,FCIGodownSet),
          FCIInput(NonHarvestingHorizonAggregation,FCIGodownSet) * card(NonHarvestingHorizonAggregationStep)
        )
    ) /
    (
      sum((HarvestingHorizonAggregation,FCIGodownSet), 
        FCIPurchase(HarvestingHorizonAggregation,FCIGodownSet) * card(HarvestingHorizonAggregationStep)
      ) +
      sum((NonHarvestingHorizonAggregation,FCIGodownSet), 
        FCIPurchase(NonHarvestingHorizonAggregation,FCIGodownSet) * card(NonHarvestingHorizonAggregationStep)
      ) 
    ))*100
  ;

PHLConstraint6TL..      
  Market_Transportation_Loss  =e=
    ( 
      Par_FarmGateTotalGrain -  ( 
        sum(HarvestingHorizonAggregation, 
          FarmGate_GrainDelivered(HarvestingHorizonAggregation) * card(HarvestingHorizonAggregationStep)
        ) +
        sum(NonHarvestingHorizonAggregation, 
          FarmGate_GrainDelivered(NonHarvestingHorizonAggregation) * card(NonHarvestingHorizonAggregationStep)
        ) + 
        sum((HarvestingHorizonAggregation,LocalMarketSet), 
          LocalMarketTotalGrain(HarvestingHorizonAggregation,LocalMarketSet) * card(HarvestingHorizonAggregationStep)
        ) +
        sum((NonHarvestingHorizonAggregation,LocalMarketSet), 
          LocalMarketTotalGrain(NonHarvestingHorizonAggregation,LocalMarketSet) * card(NonHarvestingHorizonAggregationStep)
        ) +
        sum((HarvestingHorizonAggregation,RegionalMarketSet), 
          RegionalMarketTotalGrain(HarvestingHorizonAggregation,RegionalMarketSet)*card(HarvestingHorizonAggregationStep)
        )
        +
        sum((NonHarvestingHorizonAggregation,RegionalMarketSet), 
          RegionalMarketTotalGrain(NonHarvestingHorizonAggregation,RegionalMarketSet)*card(NonHarvestingHorizonAggregationStep)
        )
      ) / Par_FarmGateTotalGrain
    ) * 100
    ;

PHLConstraint1SL..
  Miller_Storage_Loss =e=
    ((sum((HarvestingHorizonAggregation,MillerSet), 
      MillerInput(HarvestingHorizonAggregation,MillerSet) * card(HarvestingHorizonAggregationStep)
    ) +
    sum((NonHarvestingHorizonAggregation,MillerSet), 
      MillerInput(NonHarvestingHorizonAggregation,MillerSet) * card(NonHarvestingHorizonAggregationStep)
    ) -
    MillerTotalOutput)/
    (sum((HarvestingHorizonAggregation,MillerSet), 
      MillerInput(HarvestingHorizonAggregation,MillerSet) * card(HarvestingHorizonAggregationStep)
    ) +
    sum((NonHarvestingHorizonAggregation,MillerSet), 
      MillerInput(NonHarvestingHorizonAggregation,MillerSet) * card(NonHarvestingHorizonAggregationStep)
    ))*100
  ;

PHLConstraint2SL..
  Retail_Storage_Loss =e=
    ((sum((HarvestingHorizonAggregation,RetailSet), 
      RetailInput(HarvestingHorizonAggregation,RetailSet) * card(HarvestingHorizonAggregationStep)
    ) +
    sum((NonHarvestingHorizonAggregation,RetailSet), 
      RetailInput(NonHarvestingHorizonAggregation,RetailSet) * card(NonHarvestingHorizonAggregationStep)
    ) -
    RetailTotalOutput)/
    (sum((HarvestingHorizonAggregation,RetailSet), 
      RetailInput(HarvestingHorizonAggregation,RetailSet) * card(HarvestingHorizonAggregationStep)
    ) +
    sum((NonHarvestingHorizonAggregation,RetailSet), 
      RetailInput(NonHarvestingHorizonAggregation,RetailSet) * card(NonHarvestingHorizonAggregationStep)
    ))*100
  ;

PHLConstraint3SL..
  TPDS_Storage_Loss =e=
    ((sum((HarvestingHorizonAggregation,TPDSSet), 
      TPDSInput(HarvestingHorizonAggregation,TPDSSet) * card(HarvestingHorizonAggregationStep)
    ) +
    sum((NonHarvestingHorizonAggregation,TPDSSet), 
      TPDSInput(NonHarvestingHorizonAggregation,TPDSSet) * card(NonHarvestingHorizonAggregationStep)
    ) -
    TPDSTotalOutput)/
    (sum((HarvestingHorizonAggregation,TPDSSet), 
      TPDSInput(HarvestingHorizonAggregation,TPDSSet) * card(HarvestingHorizonAggregationStep)
    ) +
    sum((NonHarvestingHorizonAggregation,TPDSSet), 
      TPDSInput(NonHarvestingHorizonAggregation,TPDSSet) * card(NonHarvestingHorizonAggregationStep)
    ))*100
  ;
 
 PHLConstraint4SL..
  RGY_Storage_Loss =e=
    ((sum((HarvestingHorizonAggregation,RGYSet), 
      RGYInput(HarvestingHorizonAggregation,RGYSet) * card(HarvestingHorizonAggregationStep)
    ) +
    sum((NonHarvestingHorizonAggregation,RGYSet), 
      RGYInput(NonHarvestingHorizonAggregation,RGYSet) * card(NonHarvestingHorizonAggregationStep)
    ) -
    RGYTotalOutput)/
    (sum((HarvestingHorizonAggregation,RGYSet), 
      RGYInput(HarvestingHorizonAggregation,RGYSet) * card(HarvestingHorizonAggregationStep)
    ) +
    sum((NonHarvestingHorizonAggregation,RGYSet), 
      RGYInput(NonHarvestingHorizonAggregation,RGYSet) * card(NonHarvestingHorizonAggregationStep)
    ))*100
  ;
 
 PHLConstraint5SL..
  FCI_Storage_Loss =e=
    ((sum((HarvestingHorizonAggregation,FCIGodownSet), 
      FCIInput(HarvestingHorizonAggregation,FCIGodownSet) * card(HarvestingHorizonAggregationStep)
    ) +
    sum((NonHarvestingHorizonAggregation,FCIGodownSet), 
      FCIInput(NonHarvestingHorizonAggregation,FCIGodownSet) * card(NonHarvestingHorizonAggregationStep)
    ) -
    FCITotalOutput)/
    (sum((HarvestingHorizonAggregation,FCIGodownSet), 
      FCIInput(HarvestingHorizonAggregation,FCIGodownSet) * card(HarvestingHorizonAggregationStep)
    ) +
    sum((NonHarvestingHorizonAggregation,FCIGodownSet), 
      FCIInput(NonHarvestingHorizonAggregation,FCIGodownSet) * card(NonHarvestingHorizonAggregationStep)
    ))*100
  ;

PHLConstraint6SL..
  LocalCSP_Storage_Loss =e=
    ((sum((HarvestingHorizonAggregation,LocalCSPCenterSet), 
      LocalCSPInput(HarvestingHorizonAggregation,LocalCSPCenterSet) * card(HarvestingHorizonAggregationStep)
    ) +
    sum((NonHarvestingHorizonAggregation,LocalCSPCenterSet), 
      LocalCSPInput(NonHarvestingHorizonAggregation,LocalCSPCenterSet) * card(NonHarvestingHorizonAggregationStep)
    ) -
    LocalCSPTotalOutput)/
    (sum((HarvestingHorizonAggregation,LocalCSPCenterSet), 
      LocalCSPInput(HarvestingHorizonAggregation,LocalCSPCenterSet) * card(HarvestingHorizonAggregationStep)
    ) +
    sum((NonHarvestingHorizonAggregation,LocalCSPCenterSet), 
      LocalCSPInput(NonHarvestingHorizonAggregation,LocalCSPCenterSet) * card(NonHarvestingHorizonAggregationStep)
    ))*100
  ;

PHLConstraint7SL..
  RegionalCSP_Storage_Loss =e=
    ((sum((HarvestingHorizonAggregation,RegionalCSPCenterSet), 
      RegionalCSPInput(HarvestingHorizonAggregation,RegionalCSPCenterSet) * card(HarvestingHorizonAggregationStep)
    ) +
    sum((NonHarvestingHorizonAggregation,RegionalCSPCenterSet), 
      RegionalCSPInput(NonHarvestingHorizonAggregation,RegionalCSPCenterSet) * card(NonHarvestingHorizonAggregationStep)
    ) -
    RegionalCSPTotalOutput)/
    (sum((HarvestingHorizonAggregation,RegionalCSPCenterSet), 
      RegionalCSPInput(HarvestingHorizonAggregation,RegionalCSPCenterSet) * card(HarvestingHorizonAggregationStep)
    ) +
    sum((NonHarvestingHorizonAggregation,RegionalCSPCenterSet), 
      RegionalCSPInput(NonHarvestingHorizonAggregation,RegionalCSPCenterSet) * card(NonHarvestingHorizonAggregationStep)
    ))*100
  ;

PHLConstraint3..    
  TotalPHLLoss =e= Miller_Transportation_Loss + Retail_Transportation_Loss + TPDS_Transportation_Loss +
    RGY_Transportation_Loss + FCI_Transportation_Loss + Market_Transportation_Loss +  Miller_Storage_Loss +
    Retail_Storage_Loss + TPDS_Storage_Loss + RGY_Storage_Loss + FCI_Storage_Loss + LocalCSP_Storage_Loss +
    RegionalCSP_Storage_Loss
  ;

PHLConstraint4.. 
  TotalPHLLoss =l= 3.5
  ;

Model PHLConstraints /
  PHLConstraint1
  PHLConstraint2
  PHLConstraint3
  PHLConstraint4

  PHLConstraint1TL
  PHLConstraint2TL
  PHLConstraint3TL
  PHLConstraint4TL
  PHLConstraint5TL
  PHLConstraint6TL

  PHLConstraint1SL
  PHLConstraint2SL
  PHLConstraint3SL
  PHLConstraint4SL
  PHLConstraint5SL
  PHLConstraint6SL
  PHLConstraint7SL
  /;
