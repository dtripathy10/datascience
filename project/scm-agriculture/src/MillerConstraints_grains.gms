$title "The file that includes the constraints associated with miller"

Equations
  MillerConstraint1
  MillerConstraint2
  MillerConstraint3
  MillerConstraint4
  MillerConstraint5
  MillerConstraint6
  MillerConstraint7
  MillerConstraint8
  MillerConstraint9
  MillerConstraint10
  MillerConstraint11
  MillerConstraint12
  MillerConstraint13
  MillerConstraint14
  MillerConstraint15
  MillerConstraint16
  MillerConstraint17
  MillerConstraint18
  MillerConstraint19
  ;

MillerConstraint1(HarvestingHorizonAggregation,MillerSet)..
  MillerInput(HarvestingHorizonAggregation,MillerSet) =e=
    sum(FCIGodownSet,
      FCICAPMillerGrain(HarvestingHorizonAggregation,FCIGodownSet,MillerSet)
    ) +
    sum(FCIGodownSet,
      FCICoveredMillerGrain(HarvestingHorizonAggregation,FCIGodownSet,MillerSet)
    ) +
    sum(RGYSet,
      RGYMillerGrain(HarvestingHorizonAggregation,RGYSet,MillerSet)
    )
  ;

MillerConstraint2(HarvestingHorizonAggregation,MillerSet)..   
  MillerInput(HarvestingHorizonAggregation,MillerSet) 
  =l= MillerProcessingCapacity(MillerSet)
  ;

MillerConstraint3(NonHarvestingHorizonAggregation,MillerSet)..
  MillerInput(NonHarvestingHorizonAggregation,MillerSet) =e=
    sum(FCIGodownSet,
      FCICAPMillerGrain(NonHarvestingHorizonAggregation,FCIGodownSet,MillerSet)
    ) +
    sum(FCIGodownSet,
      FCICoveredMillerGrain(NonHarvestingHorizonAggregation,FCIGodownSet,MillerSet)
    ) +
    sum(RGYSet,
      RGYMillerGrain(NonHarvestingHorizonAggregation,RGYSet,MillerSet)
    )
  ;

MillerConstraint4(NonHarvestingHorizonAggregation,MillerSet)..   
  MillerInput(NonHarvestingHorizonAggregation,MillerSet) 
  =l= MillerProcessingCapacity(MillerSet)
  ;

MillerConstraint5(MillerSet).. 
  MillerProcessingCapacity(MillerSet)
  =l= MillerProcessingCapacity_Max(MillerSet)
  ;

MillerConstraint6(MillerSet).. 
  MillerProcessingCapacity(MillerSet)
  =g= MillerProcessingCapacity_Min(MillerSet)
  ;

MillerConstraint7(HarvestingHorizonAggregation,MillerSet)..   
  MilledGrainOutput(HarvestingHorizonAggregation,MillerSet) =e=
    MillerInput(HarvestingHorizonAggregation,MillerSet)*(1-MillingLoss(MillerSet))
  ;

MillerConstraint8(HarvestingHorizonAggregation,MillerSet)..
  MillerStoredGrain(HarvestingHorizonAggregation,MillerSet) =e=
    sum(HarvestingHorizonAggregation2$(ord(HarvestingHorizonAggregation2)=ord(HarvestingHorizonAggregation)-1),
      MillerStoredGrain(HarvestingHorizonAggregation2,MillerSet) -
      MillerOutput(HarvestingHorizonAggregation,MillerSet)*card(HarvestingHorizonAggregationStep)
    )*(1-(MillerStorageDryMatterLossRate/365)*card(HarvestingHorizonAggregationStep)) +
        MilledGrainOutput(HarvestingHorizonAggregation,MillerSet)*card(HarvestingHorizonAggregationStep)
  ;

MillerConstraint9(HarvestingHorizonAggregation,MillerSet)..
  MilledGrainOutput(HarvestingHorizonAggregation,MillerSet)*card(HarvestingHorizonAggregationStep)
  =l= MillerStoredGrain(HarvestingHorizonAggregation,MillerSet)
  ;

MillerConstraint10(HarvestingHorizonAggregation,MillerSet)..
  MilledGrainOutput(HarvestingHorizonAggregation,MillerSet) =e=
    sum(RetailerSet, 
      MillerRetailerGrain(HarvestingHorizonAggregation,MillerSet,RetailerSet)
    )
  ;

MillerConstraint11(NonHarvestingHorizonAggregation,MillerSet)..   
  MilledGrainOutput(NonHarvestingHorizonAggregation,MillerSet) =e=
    MillerInput(NonHarvestingHorizonAggregation,MillerSet)*(1-MillingLoss(MillerSet));

MillerConstraint12(NonHarvestingHorizonAggregation,MillerSet)$(ord(NonHarvestingHorizonAggregation)=1)..
  MillerStoredGrain(NonHarvestingHorizonAggregation,MillerSet) =e=
    sum(HarvestingHorizonAggregation $(ord(HarvestingHorizonAggregation)=card(HarvestingHorizonAggregation)),
      MillerStoredGrain(HarvestingHorizonAggregation,MillerSet) -
      MillerOutput(HarvestingHorizonAggregation,MillerSet)*card(HarvestingHorizonAggregationStep)
    )*(1-(MillerStorageDryMatterLossRate/365)*card(HarvestingHorizonAggregationStep)) +
        MilledGrainOutput(NonHarvestingHorizonAggregation,MillerSet)*card(NonHarvestingHorizonAggregationStep)
  ;

MillerConstraint13(NonHarvestingHorizonAggregation,MillerSet)$(ord(NonHarvestingHorizonAggregation)>1)..
  MillerStoredGrain(NonHarvestingHorizonAggregation,MillerSet) =e=
    sum(NonHarvestingHorizonAggregation2 $(ord(NonHarvestingHorizonAggregation2) = ord(NonHarvestingHorizonAggregation)-1),
      MillerStoredGrain(NonHarvestingHorizonAggregation2,MillerSet) -
      MillerOutput(NonHarvestingHorizonAggregation2,MillerSet)*card(NonHarvestingHorizonAggregationStep)
    )*(1-(MillerStorageDryMatterLossRate/365)*card(NonHarvestingHorizonAggregationStep)) +
      MilledGrainOutput(NonHarvestingHorizonAggregation,MillerSet)*card(NonHarvestingHorizonAggregationStep)
  ;


MillerConstraint14(NonHarvestingHorizonAggregation,MillerSet)..
  MilledGrainOutput(NonHarvestingHorizonAggregation,MillerSet)*card(NonHarvestingHorizonAggregation)
  =l= MillerStoredGrain(NonHarvestingHorizonAggregation,MillerSet)
  ;

MillerConstraint15(NonHarvestingHorizonAggregation,MillerSet)..
  MilledGrainOutput(NonHarvestingHorizonAggregation,MillerSet) =e=
  sum(RetailerSet, 
    MillerRetailerGrain(NonHarvestingHorizonAggregation,MillerSet,RetailerSet)
  )
  ;

MillerConstraint16(HarvestingHorizonAggregation,MillerSet)..
  MillerStoredGrain(HarvestingHorizonAggregation,MillerSet)
  =l= MillerStorageCapacity(MillerSet)
  ;

MillerConstraint17(NonHarvestingHorizonAggregation,MillerSet)..
  MillerStoredGrain(NonHarvestingHorizonAggregation,MillerSet)
  =l= MillerStorageCapacity(MillerSet)
  ;

MillerConstraint18(MillerSet)..   
  MillerStorageCapacity(MillerSet) 
  =l= MillerStorageCapacity_Max(MillerSet)
  ;

MillerConstraint19(MillerSet)..    
  MillerSelector(MillerSet) 
  =g= MillerProcessingCapacity(MillerSet)/MillerProcessingCapacity_Max(MillerSet)
  ;


Model MillerModel /
  MillerConstraint1
  MillerConstraint2
  MillerConstraint3
  MillerConstraint4
  MillerConstraint5
  MillerConstraint6
  MillerConstraint7
  MillerConstraint9
  MillerConstraint10
  MillerConstraint11
  MillerConstraint12
  MillerConstraint13
  MillerConstraint14
  MillerConstraint15
  MillerConstraint16
  MillerConstraint17
  MillerConstraint18
  MillerConstraint19
  /;


