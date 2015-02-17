$title "Transportation Cost calculations using detailed calculations"

Equations
  TransportationCostConstraint7A
  TransportationCostConstraint8A
  TransportationCostConstraint9A
  TransportationCostConstraint10A
  TransportationCostConstraint11A
  TransportationCostConstraint12A
  TransportationCostConstraint13A
  TransportationCostConstraint14A
  TransportationCostConstraint15A
  TransportationCostConstraint16A
  TransportationCostConstraint17A
  TransportationCostConstraint18A
  TransportationCostConstraint19A
  TransportationCostConstraint20A
  TransportationCostConstraint21A
  TransportationCostConstraint22A
  TransportationCostConstraint23A
  TransportationCostConstraint24
  TransportationCostConstraint25
  TransportationCostConstraint26
  ;

*---------------------------------------------------------------------------------------------------------
* Calculating the total transportation cost based on the fleet distribution and transportation time from each field.
* The transportation cost includes the operating cost (which is a function of the transportation time) and
* annual fixed cost which represents the discounted cost for the purchase of the vehicle.
*
* Calculation of the transportation operating cost if the calculation depends on the total number of truck/trips between different
* locations and the opearting cost for truck on an hourly basis. The total grain transported is not directly considered in the
* calculations and it has an impact indirectly by affecting the total number of trips.
*
*---------------------------------------------------------------------------------------------------------
TransportationCostConstraint7A..      
  FarmLocalCSPTransportationOperatingCost =e=
    sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,TransportationTypes),
      FarmLocalCSPTruckTripRequirement(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,TransportationTypes)
      * FarmLocalCSPTransportationTime(DistrictSelected,FarmNumber,LocalCSPCenterSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)                                   
    ) * card(HarvestingHorizonAggregationStep) +
    sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,TransportationTypes),
      FarmLocalCSPTruckTripRequirement(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,TransportationTypes)
      * FarmLocalCSPTransportationTime(DistrictSelected,FarmNumber,LocalCSPCenterSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)                                  
    ) *card(NonHarvestingHorizonAggregationStep)
  ;

TransportationCostConstraint8A..      
  FarmRegionalCSPTransportationOperatingCost =e=
    sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,TransportationTypes),
      FarmRegionalCSPTruckTripRequirement(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,TransportationTypes)
      * FarmRegionalCSPTransportationTime(DistrictSelected,FarmNumber,RegionalCSPCenterSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(HarvestingHorizonAggregationStep) +
    sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,TransportationTypes),
      FarmRegionalCSPTruckTripRequirement(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,TransportationTypes)
      * FarmRegionalCSPTransportationTime(DistrictSelected,FarmNumber,RegionalCSPCenterSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(NonHarvestingHorizonAggregationStep)
  ;

TransportationCostConstraint9A..      
  FarmLocalMarketTransportationOperatingCost =e=
    sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet,TransportationTypes),
      FarmLocalMarketTruckTripRequirement(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet,TransportationTypes)
      * FarmLocalMarketTransportationTime(DistrictSelected,FarmNumber,LocalMarketSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(HarvestingHorizonAggregationStep) +
    sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet,TransportationTypes),
      FarmLocalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet,TransportationTypes)
      * FarmLocalMarketTransportationTime(DistrictSelected,FarmNumber,LocalMarketSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(NonHarvestingHorizonAggregationStep)
  ;

TransportationCostConstraint10A..     
  FarmRegionalMarketTransportationOperatingCost =e=
    sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet,TransportationTypes)$(connectselected(DistrictSelected,RegionalMarketSet)),
      FarmRegionalMarketTruckTripRequirement(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet,TransportationTypes)
      * FarmRegionalMarketTransportationTime(DistrictSelected,FarmNumber,RegionalMarketSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(HarvestingHorizonAggregationStep) +
    sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet,TransportationTypes)$(connectselected(DistrictSelected,RegionalMarketSet)),
      FarmRegionalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet,TransportationTypes)
      * FarmRegionalMarketTransportationTime(DistrictSelected,FarmNumber,RegionalMarketSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(NonHarvestingHorizonAggregationStep)
  ;

TransportationCostConstraint11A..     
  LocalCSPLocalMarketTransportationOperatingCost =e=
    sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,TransportationTypes),
      LocalCSPLocalMarketTruckTripRequirement(HarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,TransportationTypes)
      * LocalCSPLocalMarketTransportationTime(LocalCSPCenterSet,LocalMarketSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(HarvestingHorizonAggregationStep) +
    sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,TransportationTypes),
      LocalCSPLocalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,TransportationTypes)
      * LocalCSPLocalMarketTransportationTime(LocalCSPCenterSet,LocalMarketSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(NonHarvestingHorizonAggregationStep)
  ;

TransportationCostConstraint12A..     
  LocalCSPRegionalMarketTransportationOperatingCost =e=
    sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)$(connectselected(DistrictSelected,RegionalMarketSet)),
      LocalCSPRegionalMarketTruckTripRequirement(HarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)
      * LocalCSPRegionalMarketTransportationTime(LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(HarvestingHorizonAggregationStep) +
    sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)$(connectselected(DistrictSelected,RegionalMarketSet)),
      LocalCSPRegionalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)
      * LocalCSPRegionalMarketTransportationTime(LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(NonHarvestingHorizonAggregationStep)
  ;

TransportationCostConstraint13A..     
  RegionalCSPLocalMarketTransportationOperatingCost =e=
    sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes),
      RegionalCSPLocalMarketTruckTripRequirement(HarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes)
      * RegionalCSPLocalMarketTransportationTime(RegionalCSPCenterSet,LocalMarketSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(HarvestingHorizonAggregationStep) +
    sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes),
      RegionalCSPLocalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes)
      * RegionalCSPLocalMarketTransportationTime(RegionalCSPCenterSet,LocalMarketSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    )* card(NonHarvestingHorizonAggregationStep) 
  ;

TransportationCostConstraint14A..     
  RegionalCSPRegionalMarketTransportationOperatingCost =e=
    sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)$(connectselected(DistrictSelected,RegionalMarketSet)),
      RegionalCSPRegionalMarketTruckTripRequirement(HarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)
      * RegionalCSPRegionalMarketTransportationTime(RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(HarvestingHorizonAggregationStep) +
    sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)$(connectselected(DistrictSelected,RegionalMarketSet)),
      RegionalCSPRegionalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)
      * RegionalCSPRegionalMarketTransportationTime(RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(NonHarvestingHorizonAggregationStep)
  ;

TransportationCostConstraint15A..     
  LocalMarketRGYTransportationOperatingCost =e=
    sum((HarvestingHorizonAggregation,LocalMarketSet,RGYSet,TransportationTypes),
      LocalMarketRGYTruckTripRequirement(HarvestingHorizonAggregation,LocalMarketSet,RGYSet,TransportationTypes)
      * LocalMarketRGYTransportationTime(LocalMarketSet,RGYSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(HarvestingHorizonAggregationStep) +
    sum((NonHarvestingHorizonAggregation,LocalMarketSet,RGYSet,TransportationTypes),
      LocalMarketRGYTruckTripRequirement(NonHarvestingHorizonAggregation,LocalMarketSet,RGYSet,TransportationTypes)
      *LocalMarketRGYTransportationTime(LocalMarketSet,RGYSet,TransportationTypes)
      *TransportationData('OperatingCost',TransportationTypes)
    ) * card(NonHarvestingHorizonAggregationStep)
  ;

TransportationCostConstraint16A..     
  RegionalMarketRGYTransportationOperatingCost =e=
    sum((HarvestingHorizonAggregation,RegionalMarketSet,RGYSet,TransportationTypes),
      RegionalMarketRGYTruckTripRequirement(HarvestingHorizonAggregation,RegionalMarketSet,RGYSet,TransportationTypes)
      * RegionalMarketRGYTransportationTime(RegionalMarketSet,RGYSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
      ) * card(HarvestingHorizonAggregationStep) +
      sum((NonHarvestingHorizonAggregation,RegionalMarketSet,RGYSet,TransportationTypes),
      RegionalMarketRGYTruckTripRequirement(NonHarvestingHorizonAggregation,RegionalMarketSet,RGYSet,TransportationTypes)
      * RegionalMarketRGYTransportationTime(RegionalMarketSet,RGYSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(NonHarvestingHorizonAggregationStep)
  ;


TransportationCostConstraint17A..     
  RegionalMarketFCITransportationOperatingCost =e=
    sum((HarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet,TransportationTypes),
      RegionalMarketFCITruckTripRequirement(HarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet,TransportationTypes)
      * RegionalMarketFCITransportationTime(RegionalMarketSet,FCIGodownSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(HarvestingHorizonAggregationStep) +
    sum((NonHarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet,TransportationTypes),
      RegionalMarketFCITruckTripRequirement(NonHarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet,TransportationTypes)
      * RegionalMarketFCITransportationTime(RegionalMarketSet,FCIGodownSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(NonHarvestingHorizonAggregationStep)
  ;

TransportationCostConstraint18A..     
  RGYMillerTransportationOperatingCost =e=
    sum((HarvestingHorizonAggregation,RGYSet,MillerSet,TransportationTypes),
      RGYMillerTruckTripRequirement(HarvestingHorizonAggregation,RGYSet,MillerSet,TransportationTypes)
      * RGYMillerTransportationTime(RGYSet,MillerSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(HarvestingHorizonAggregationStep) +
    sum((NonHarvestingHorizonAggregation,RGYSet,MillerSet,TransportationTypes),
      RGYMillerTruckTripRequirement(NonHarvestingHorizonAggregation,RGYSet,MillerSet,TransportationTypes)
      * RGYMillerTransportationTime(RGYSet,MillerSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(NonHarvestingHorizonAggregationStep)
  ;

TransportationCostConstraint19A..    
  RGYRetailerTransportationOperatingCost =e=
    sum((HarvestingHorizonAggregation,RGYSet,RetailerSet,TransportationTypes),
      RGYRetailerTruckTripRequirement(HarvestingHorizonAggregation,RGYSet,RetailerSet,TransportationTypes)
      * RGYRetailerTransportationTime(RGYSet,RetailerSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(HarvestingHorizonAggregationStep) +
    sum((NonHarvestingHorizonAggregation,RGYSet,RetailerSet,TransportationTypes),
      RGYRetailerTruckTripRequirement(NonHarvestingHorizonAggregation,RGYSet,RetailerSet,TransportationTypes)
      * RGYRetailerTransportationTime(RGYSet,RetailerSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(NonHarvestingHorizonAggregationStep)
  ;

TransportationCostConstraint20A..     
  FCIMillerTransportationOperatingCost =e=
    sum((HarvestingHorizonAggregation,FCIGodownSet,MillerSet,TransportationTypes),
      FCIMillerTruckTripRequirement(HarvestingHorizonAggregation,FCIGodownSet,MillerSet,TransportationTypes)
      * FCIMillerTransportationTime(FCIGodownSet,MillerSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(HarvestingHorizonAggregationStep) +
    sum((NonHarvestingHorizonAggregation,FCIGodownSet,MillerSet,TransportationTypes),
      FCIMillerTruckTripRequirement(NonHarvestingHorizonAggregation,FCIGodownSet,MillerSet,TransportationTypes)
      * FCIMillerTransportationTime(FCIGodownSet,MillerSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(NonHarvestingHorizonAggregationStep)
  ;

TransportationCostConstraint21A..     
  FCIRetailerTransportationOperatingCost =e=
    sum((HarvestingHorizonAggregation,FCIGodownSet,RetailerSet,TransportationTypes),
      FCIRetailerTruckTripRequirement(HarvestingHorizonAggregation,FCIGodownSet,RetailerSet,TransportationTypes)
      * FCIRetailerTransportationTime(FCIGodownSet,RetailerSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(HarvestingHorizonAggregationStep) +
    sum((NonHarvestingHorizonAggregation,FCIGodownSet,RetailerSet,TransportationTypes),
      FCIRetailerTruckTripRequirement(NonHarvestingHorizonAggregation,FCIGodownSet,RetailerSet,TransportationTypes)
      * FCIRetailerTransportationTime(FCIGodownSet,RetailerSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(NonHarvestingHorizonAggregationStep)
  ;

TransportationCostConstraint22A..     
  FCIPDSTransportationOperatingCost =e=
    sum((HarvestingHorizonAggregation,FCIGodownSet,PDSSet,TransportationTypes),
      FCIPDSTruckTripRequirement(HarvestingHorizonAggregation,FCIGodownSet,PDSSet,TransportationTypes)
      * FCIPDSTransportationTime(FCIGodownSet,PDSSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(HarvestingHorizonAggregationStep) +
    sum((NonHarvestingHorizonAggregation,FCIGodownSet,PDSSet,TransportationTypes),
      FCIPDSTruckTripRequirement(NonHarvestingHorizonAggregation,FCIGodownSet,PDSSet,TransportationTypes)
      * FCIPDSTransportationTime(FCIGodownSet,PDSSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(NonHarvestingHorizonAggregationStep)
  ;

TransportationCostConstraint23A..
  MillerRetailerTransportationOperatingCost =e=
    sum((HarvestingHorizonAggregation,MillerSet,RetailerSet,TransportationTypes),
      MillerRetailerTruckTripRequirement(HarvestingHorizonAggregation,MillerSet,RetailerSet,TransportationTypes)
      * MillerRetailerTransportationTime(MillerSet,RetailerSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(HarvestingHorizonAggregationStep) +
    sum((NonHarvestingHorizonAggregation,MillerSet,RetailerSet,TransportationTypes),
      MillerRetailerTruckTripRequirement(NonHarvestingHorizonAggregation,MillerSet,RetailerSet,TransportationTypes)
      * MillerRetailerTransportationTime(MillerSet,RetailerSet,TransportationTypes)
      * TransportationData('OperatingCost',TransportationTypes)
    ) * card(NonHarvestingHorizonAggregationStep)
  ;

* Calculating the total transportation cost based on the fleet distribution and transportation time from each field
TransportationCostConstraint24..      
  TransportationFixedCost =e=
    sum(TransportationTypes$(TransportationData('LongDistanceIndicator',TransportationTypes)),
      TransportationFleetSize(TransportationTypes)*
      TransportationData('AnnualFixedCost',TransportationTypes)
    )
  ;

* This is a dummy variabe that is included in the objective function so that the exact number of trucks are used.
TransportationCostConstraint25..      
  TransportationTruckCharge =e=
    sum((HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,TransportationTypes),
      FarmLocalCSPTruckRequirement(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,TransportationTypes)
    ) +
    sum((NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,TransportationTypes),
      FarmLocalCSPTruckRequirement(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,TransportationTypes)
    ) +
    sum((HarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,TransportationTypes),
      LocalCSPLocalMarketTruckRequirement(HarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,TransportationTypes)
    ) +
    sum((NonHarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,TransportationTypes),
      LocalCSPLocalMarketTruckRequirement(NonHarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,TransportationTypes)
    ) +
    sum((HarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes),
      LocalCSPRegionalMarketTruckRequirement(HarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)
    ) +
    sum((NonHarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes),
      LocalCSPRegionalMarketTruckRequirement(NonHarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)
    ) +
    sum((HarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes),
      RegionalCSPLocalMarketTruckRequirement(HarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes)
    ) +
    sum((NonHarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes),
      RegionalCSPLocalMarketTruckRequirement(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes)
    ) +
    sum((HarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes),
      RegionalCSPRegionalMarketTruckRequirement(HarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)
    ) +
    sum((NonHarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes),
      RegionalCSPRegionalMarketTruckRequirement(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)
    ) +
    sum(TransportationTypes,
      TransportationFleetSize(TransportationTypes)
    )
  ;

* Calculating the cost for each category
TransportationCostConstraint26..
  TransportationOperatingCost =e=
    FarmLocalCSPTransportationOperatingCost + FarmRegionalCSPTransportationOperatingCost +
    FarmLocalMarketTransportationOperatingCost + FarmRegionalMarketTransportationOperatingCost +
    LocalCSPLocalMarketTransportationOperatingCost + RegionalCSPLocalMarketTransportationOperatingCost +
    LocalCSPRegionalMarketTransportationOperatingCost + RegionalCSPRegionalMarketTransportationOperatingCost +
    LocalMarketRGYTransportationOperatingCost + RegionalMarketRGYTransportationOperatingCost + 
    RGYRetailerTransportationOperatingCost + FCIMillerTransportationOperatingCost + MillerRetailerTransportationOperatingCost + 
    RegionalMarketFCITransportationOperatingCost + FCIRetailerTransportationOperatingCost + FCIPDSTransportationOperatingCost
  ;

Model TransportationCostModel /
  TransportationCostConstraint7A
  TransportationCostConstraint8A
  TransportationCostConstraint9A
  TransportationCostConstraint10A
  TransportationCostConstraint11A
  TransportationCostConstraint12A
  TransportationCostConstraint13A
  TransportationCostConstraint14A
  TransportationCostConstraint15A
  TransportationCostConstraint16A
  TransportationCostConstraint17A
  TransportationCostConstraint18A
  TransportationCostConstraint19A
  TransportationCostConstraint20A
  TransportationCostConstraint21A
  TransportationCostConstraint22A
  TransportationCostConstraint24
  TransportationCostConstraint25
  TransportationCostConstraint26
  /;
