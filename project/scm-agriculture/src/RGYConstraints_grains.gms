$title "Contains the costraint related to RGY"

*----------------------------------------------------------------------------------------------
* RGY: a storage where inputs are not processed.
*----------------------------------------------------------------------------------------------

Positive variable
  RGYInput(SimulationHorizon,RGYSet) "The total input to a particular RGY during a given time-step"
  RGYPurchase(SimulationHorizon,RGYSet)
  RGYTotalOutput
  ;

Equations
  RGYBalance1 "Input calculation in Harvesting Horizon"
  RGYBalance2 "Input calculation in Non-Harvesting Horizon"
  RGYBalance3 "Calculating RGY stored grain in Harvesting Horizon"
  RGYBalance4 "constrain(less) output < stored in harvesting horizon"
  RGYBalance5 "Calculating RGY stored grain in Non-Harvesting Horizon(=1)"
  RGYBalance6 "Calculating RGY stored grain in Non-Harvesting Horizon(>1)"
  RGYBalance7 "constrain(less) output < stored in non-harvesting horizon"
  RGYBalance8 "constrain(less) stored_grain < capacity in harvesting horizon"
  RGYBalance9 "constrain(less) stored_grain < capacity in non-harvesting horizon"
  RGYBalance10 "constrain(less) capacity < max"
  RGYBalance11 "constrain(greater) selection and capacity constriant"
  RGYBalance12 "constrain(greater) selection and capacity constriant"
  RGYBalance13 "Purchase calculation in Harvesting Horizon"
  RGYBalance14 "Purchase calculation in Non-Harvesting Horizon"
  RGYBalance15 "Total Ouput calculation"
  ;

RGYBalance1(HarvestingHorizonAggregation,RGYSet)..
  RGYInput(HarvestingHorizonAggregation,RGYSet) =e=
    sum(LocalMarketSet,
      LocalMarketPrivateTraderRGYGrain(HarvestingHorizonAggregation,LocalMarketSet,RGYSet)
    ) * (1-TransportationDryMatterLossRate) +
    sum(RegionalMarketSet,
      RegionalMarketPrivateTraderRGYGrain(HarvestingHorizonAggregation,RegionalMarketSet,RGYSet)
    ) * (1-TransportationDryMatterLossRate)
  ;

RGYBalance2(NonHarvestingHorizonAggregation,RGYSet)..
  RGYInput(NonHarvestingHorizonAggregation,RGYSet) =e=
    sum(LocalMarketSet,
      LocalMarketPrivateTraderRGYGrain(NonHarvestingHorizonAggregation,LocalMarketSet,RGYSet)
    ) * (1-TransportationDryMatterLossRate) +
    sum(RegionalMarketSet,
      RegionalMarketPrivateTraderRGYGrain(NonHarvestingHorizonAggregation,RegionalMarketSet,RGYSet)
    ) * (1-TransportationDryMatterLossRate)
  ;

RGYBalance3(HarvestingHorizonAggregation,RGYSet)..
  RGYStoredGrain(HarvestingHorizonAggregation,RGYSet) =e=
    sum(HarvestingHorizonAggregation2 $(ord(HarvestingHorizonAggregation2) = ord(HarvestingHorizonAggregation)-1),
      RGYStoredGrain(HarvestingHorizonAggregation2,RGYSet) -
      sum(MillerSet,
        RGYMillerGrain(HarvestingHorizonAggregation2,RGYSet,MillerSet)
      ) * card(HarvestingHorizonAggregationStep) -
      sum(RetailerSet,
        RGYRetailerGrain(HarvestingHorizonAggregation2,RGYSet,RetailerSet)
      ) * card(HarvestingHorizonAggregationStep)
    ) * (1-(RGYDryMatterLossRate/365) * card(HarvestingHorizonAggregationStep)) + 
          RGYInput(HarvestingHorizonAggregation,RGYSet) * card(HarvestingHorizonAggregationStep)
  ;

RGYBalance4(HarvestingHorizonAggregation,RGYSet)..
  sum(MillerSet,RGYMillerGrain(HarvestingHorizonAggregation,RGYSet,MillerSet)) * card(HarvestingHorizonAggregationStep) +
  sum(RetailerSet,RGYRetailerGrain(HarvestingHorizonAggregation,RGYSet,RetailerSet)) * card(HarvestingHorizonAggregationStep)
  =l= RGYStoredGrain(HarvestingHorizonAggregation,RGYSet)
  ;

RGYBalance5(NonHarvestingHorizonAggregation,RGYSet)$(ord(NonHarvestingHorizonAggregation)=1)..
  RGYStoredGrain(NonHarvestingHorizonAggregation,RGYSet) =e=
    sum(HarvestingHorizonAggregation $(ord(HarvestingHorizonAggregation)= card(HarvestingHorizonAggregation)),
      RGYStoredGrain(HarvestingHorizonAggregation,RGYSet) -
      sum(MillerSet,
        RGYMillerGrain(HarvestingHorizonAggregation,RGYSet,MillerSet)
      ) * card(HarvestingHorizonAggregationStep) -
      sum(RetailerSet,
        RGYRetailerGrain(HarvestingHorizonAggregation,RGYSet,RetailerSet)
      ) * card(HarvestingHorizonAggregationStep)
    )*(1-(RGYDryMatterLossRate/365)*card(HarvestingHorizonAggregationStep)) +
      RGYInput(NonHarvestingHorizonAggregation,RGYSet) * card(NonHarvestingHorizonAggregationStep)
  ;

RGYBalance6(NonHarvestingHorizonAggregation,RGYSet)$(ord(NonHarvestingHorizonAggregation)>1)..
  RGYStoredGrain(NonHarvestingHorizonAggregation,RGYSet) =e=
    sum(NonHarvestingHorizonAggregation2 $(ord(NonHarvestingHorizonAggregation2)= ord(NonHarvestingHorizonAggregation)-1),
      RGYStoredGrain(NonHarvestingHorizonAggregation2,RGYSet) -
      sum(MillerSet,
        RGYMillerGrain(NonHarvestingHorizonAggregation2,RGYSet,MillerSet)
      ) * card(NonHarvestingHorizonAggregationStep) -
      sum(RetailerSet,
        RGYRetailerGrain(NonHarvestingHorizonAggregation2,RGYSet,RetailerSet)
      ) * card(NonHarvestingHorizonAggregationStep)
    )*(1-(RGYDryMatterLossRate/365) * card(NonHarvestingHorizonAggregationStep)) +
      RGYInput(NonHarvestingHorizonAggregation,RGYSet) * card(NonHarvestingHorizonAggregationStep)
  ;

RGYBalance7(NonHarvestingHorizonAggregation,RGYSet)..
  sum(MillerSet,
    RGYMillerGrain(NonHarvestingHorizonAggregation,RGYSet,MillerSet)
  ) * card(NonHarvestingHorizonAggregationStep) +
  sum(RetailerSet,
    RGYRetailerGrain(NonHarvestingHorizonAggregation,RGYSet,RetailerSet)
  ) * card(NonHarvestingHorizonAggregationStep)
  =l= RGYStoredGrain(NonHarvestingHorizonAggregation,RGYSet)
  ;

RGYBalance8(HarvestingHorizonAggregation,RGYSet)..
  RGYStoredGrain(HarvestingHorizonAggregation,RGYSet)
  =l= RGYCapacity(RGYSet)
  ;

RGYBalance9(NonHarvestingHorizonAggregation,RGYSet)..
  RGYStoredGrain(NonHarvestingHorizonAggregation,RGYSet)
  =l= RGYCapacity(RGYSet)
  ;

RGYBalance10(RGYSet)..    
  RGYCapacity(RGYSet) =l= RGY_Max
  ;

RGYBalance11(RGYSet)..    
  RGYSelector(RGYSet) =g= RGYCapacity(RGYSet)/RGY_Max
  ;

RGYBalance12(RGYSet)..    
  RGYCapacity(RGYSet) =g= RGYSelector(RGYSet)*RGY_Min
  ;

RGYBalance13(HarvestingHorizonAggregation,RGYSet)..
  RGYPurchase(HarvestingHorizonAggregation,RGYSet) =e=
    sum(LocalMarketSet,
      LocalMarketPrivateTraderRGYGrain(HarvestingHorizonAggregation,LocalMarketSet,RGYSet)
    ) +
    sum(RegionalMarketSet,
      RegionalMarketPrivateTraderRGYGrain(HarvestingHorizonAggregation,RegionalMarketSet,RGYSet)
    )
  ;

RGYBalance14(NonHarvestingHorizonAggregation,RGYSet)..
  RGYPurchase(NonHarvestingHorizonAggregation,RGYSet) =e=
    sum(LocalMarketSet,
      LocalMarketPrivateTraderRGYGrain(NonHarvestingHorizonAggregation,LocalMarketSet,RGYSet)
    ) +
    sum(RegionalMarketSet,
      RegionalMarketPrivateTraderRGYGrain(NonHarvestingHorizonAggregation,RegionalMarketSet,RGYSet)
    )
  ;

RGYBalance15(RGYSet)..
  RGYTotalOutput =e=
    sum(HarvestingHorizonAggregation,
      sum(MillerSet,
        RGYMillerGrain(HarvestingHorizonAggregation,RGYSet,MillerSet)
      ) * card(HarvestingHorizonAggregationStep) +
      sum(RetailerSet,
        RGYRetailerGrain(HarvestingHorizonAggregation,RGYSet,RetailerSet)
      ) * card(HarvestingHorizonAggregationStep)
    ) +
    sum(NonHarvestingHorizonAggregation,
      sum(MillerSet,
        RGYMillerGrain(NonHarvestingHorizonAggregation,RGYSet,MillerSet)
      ) * card(NonHarvestingHorizonAggregationStep) +
      sum(RetailerSet,
        RGYRetailerGrain(NonHarvestingHorizonAggregation,RGYSet,RetailerSet)
      ) * card(NonHarvestingHorizonAggregationStep)
    )
  ;

Model RGYModel /
  RGYBalance1
  RGYBalance2
  RGYBalance3
  RGYBalance4
  RGYBalance5
  RGYBalance6
  RGYBalance7
  RGYBalance8
  RGYBalance9
  RGYBalance10
  RGYBalance11
  RGYBalance12
  RGYBalance13
  RGYBalance14
  RGYBalance15
  /;
