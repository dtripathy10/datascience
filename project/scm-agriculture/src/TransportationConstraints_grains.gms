$title "Based on the truck trip requirement, this file models the truck requirement"

Equations
  TransportationConstraint1
  TransportationConstraint2
  TransportationConstraint3
  TransportationConstraint4
  TransportationConstraint5
  TransportationConstraint6
  TransportationConstraint7
  TransportationConstraint8
  TransportationConstraint9
  TransportationConstraint10
  TransportationConstraint11
  TransportationConstraint12
  TransportationConstraint13
  TransportationConstraint14
  TransportationConstraint15
  TransportationConstraint16
  TransportationConstraint17
  TransportationConstraint18
  TransportationConstraint1A
  TransportationConstraint2A
  TransportationConstraint3A
  TransportationConstraint4A
  TransportationConstraint5A
  TransportationConstraint6A
  TransportationConstraint7A
  TransportationConstraint8A
  TransportationConstraint9A
  TransportationConstraint10A
  TransportationConstraint11A
  TransportationConstraint12A
  TransportationConstraint13A
  TransportationConstraint14A
  TransportationConstraint15A
  TransportationConstraint16A
  TransportationConstraint17A
  TransportationConstraint18A
  ;

* Total biomass weight transported from the farm to the refinery on a given day must not exceed the total capacity of the
* transportation fleet dedicated to the farm. The total transported weight is calculated as the sum of the dry weight (which
* is given by the Biomass variables, and the additional weight due to the moisture content.
* Similarly, the total volume of biomass transported per truck should not exceed the volumetric capacity of the truck. Hence a similar
* constraint (like the weight constraint) is also applied for volume. The constraint for volume is expected to be binding one.

*============================================================================================================================================
* The number of trips are translated into the number of trucks required. The total transportation (round trip) time between different
* locations and the total number of hours per day available are used to do this calculation.
*=======================================================================================================================================
TransportationConstraint1(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,TransportationTypes)..
  FarmLocalCSPTruckRequirement(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,TransportationTypes) =g=
    FarmLocalCSPTruckTripRequirement(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,TransportationTypes) *
    FarmLocalCSPTransportationTime(DistrictSelected,FarmNumber,LocalCSPCenterSet,TransportationTypes)/ HoursPerDay
  ;

TransportationConstraint2(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,TransportationTypes)..
  FarmRegionalCSPTruckRequirement(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,TransportationTypes) =g=
    FarmRegionalCSPTruckTripRequirement(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,TransportationTypes) *
    FarmRegionalCSPTransportationTime(DistrictSelected,FarmNumber,RegionalCSPCenterSet,TransportationTypes) / HoursPerDay
  ;

TransportationConstraint3(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet,TransportationTypes)..
  FarmLocalMarketTruckRequirement(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet,TransportationTypes) =g=
    FarmLocalMarketTruckTripRequirement(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet,TransportationTypes) *
    FarmLocalMarketTransportationTime(DistrictSelected,FarmNumber,LocalMarketSet,TransportationTypes) / HoursPerDay
  ;

TransportationConstraint4(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet,TransportationTypes)$(connectselected(DistrictSelected,RegionalMarketSet))..
  FarmRegionalMarketTruckRequirement(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet,TransportationTypes) =g=
    FarmRegionalMarketTruckTripRequirement(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet,TransportationTypes)*
    FarmRegionalMarketTransportationTime(DistrictSelected,FarmNumber,RegionalMarketSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint5(HarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,TransportationTypes)..
  LocalCSPLocalMarketTruckRequirement(HarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,TransportationTypes) =g=
    LocalCSPLocalMarketTruckTripRequirement(HarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,TransportationTypes)*
    LocalCSPLocalMarketTransportationTime(LocalCSPCenterSet,LocalMarketSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint6(HarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)..
  LocalCSPRegionalMarketTruckRequirement(HarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes) =g=
    LocalCSPRegionalMarketTruckTripRequirement(HarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)*
    LocalCSPRegionalMarketTransportationTime(LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint7(HarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes)..
  RegionalCSPLocalMarketTruckRequirement(HarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes) =g=
    RegionalCSPLocalMarketTruckTripRequirement(HarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes)*
    RegionalCSPLocalMarketTransportationTime(RegionalCSPCenterSet,LocalMarketSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint8(HarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)..
  RegionalCSPRegionalMarketTruckRequirement(HarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes) =g=
    RegionalCSPRegionalMarketTruckTripRequirement(HarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)*
    RegionalCSPRegionalMarketTransportationTime(RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint9(HarvestingHorizonAggregation,LocalMarketSet,RGYSet,TransportationTypes)..
  LocalMarketRGYTruckRequirement(HarvestingHorizonAggregation,LocalMarketSet,RGYSet,TransportationTypes) =g=
    LocalMarketRGYTruckTripRequirement(HarvestingHorizonAggregation,LocalMarketSet,RGYSet,TransportationTypes)*
    LocalMarketRGYTransportationTime(LocalMarketSet,RGYSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint10(HarvestingHorizonAggregation,RegionalMarketSet,RGYSet,TransportationTypes)..
  RegionalMarketRGYTruckRequirement(HarvestingHorizonAggregation,RegionalMarketSet,RGYSet,TransportationTypes) =g=
    RegionalMarketRGYTruckTripRequirement(HarvestingHorizonAggregation,RegionalMarketSet,RGYSet,TransportationTypes)*
    RegionalMarketRGYTransportationTime(RegionalMarketSet,RGYSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint11(HarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet,TransportationTypes)..
  RegionalMarketFCITruckRequirement(HarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet,TransportationTypes) =g=
    RegionalMarketFCITruckTripRequirement(HarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet,TransportationTypes)*
    RegionalMarketFCITransportationTime(RegionalMarketSet,FCIGodownSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint12(HarvestingHorizonAggregation,RGYSet,MillerSet,TransportationTypes)..
  RGYMillerTruckRequirement(HarvestingHorizonAggregation,RGYSet,MillerSet,TransportationTypes) =g=
    RGYMillerTruckTripRequirement(HarvestingHorizonAggregation,RGYSet,MillerSet,TransportationTypes) *
    RGYMillerTransportationTime(RGYSet,MillerSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint13(HarvestingHorizonAggregation,RGYSet,RetailerSet,TransportationTypes)..
  RGYRetailerTruckRequirement(HarvestingHorizonAggregation,RGYSet,RetailerSet,TransportationTypes) =g=
    RGYRetailerTruckTripRequirement(HarvestingHorizonAggregation,RGYSet,RetailerSet,TransportationTypes) *
    RGYRetailerTransportationTime(RGYSet,RetailerSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint14(HarvestingHorizonAggregation,FCIGodownSet,MillerSet,TransportationTypes)..
  FCIMillerTruckRequirement(HarvestingHorizonAggregation,FCIGodownSet,MillerSet,TransportationTypes) =g=
    FCIMillerTruckTripRequirement(HarvestingHorizonAggregation,FCIGodownSet,MillerSet,TransportationTypes)   *
    FCIMillerTransportationTime(FCIGodownSet,MillerSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint15(HarvestingHorizonAggregation,FCIGodownSet,RetailerSet,TransportationTypes)..
  FCIRetailerTruckRequirement(HarvestingHorizonAggregation,FCIGodownSet,RetailerSet,TransportationTypes) =g=
    FCIRetailerTruckTripRequirement(HarvestingHorizonAggregation,FCIGodownSet,RetailerSet,TransportationTypes)   *
    FCIRetailerTransportationTime(FCIGodownSet,RetailerSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint16(HarvestingHorizonAggregation,FCIGodownSet,PDSSet,TransportationTypes)..
  FCIPDSTruckRequirement(HarvestingHorizonAggregation,FCIGodownSet,PDSSet,TransportationTypes) =g=
    FCIPDSTruckTripRequirement(HarvestingHorizonAggregation,FCIGodownSet,PDSSet,TransportationTypes)   *
    FCIPDSTransportationTime(FCIGodownSet,PDSSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint17(HarvestingHorizonAggregation,MillerSet,RetailerSet,TransportationTypes) $(TransportationData('LongDistanceIndicator',TransportationTypes))..
  MillerRetailerTruckRequirement(HarvestingHorizonAggregation,MillerSet,RetailerSet,TransportationTypes) =g=
    MillerRetailerTruckTripRequirement(HarvestingHorizonAggregation,MillerSet,RetailerSet,TransportationTypes)   *
    MillerRetailerTransportationTime(MillerSet,RetailerSet,TransportationTypes)/HoursPerDay
  ;

* The total transportation fleet in use on a particular day (sum of all possible transportation links) must not exceed the
* total available transportation units.
TransportationConstraint18(HarvestingHorizonAggregation,TransportationTypes)..
  sum((DistrictSelected,FarmNumber,LocalCSPCenterSet),
    FarmLocalCSPTruckRequirement(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,TransportationTypes)
  ) +
  sum((DistrictSelected,FarmNumber,RegionalCSPCenterSet),
    FarmRegionalCSPTruckRequirement(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,TransportationTypes)
  ) +
  sum((DistrictSelected,FarmNumber,LocalMarketSet),
    FarmLocalMarketTruckRequirement(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet,TransportationTypes)
  ) +
  sum((DistrictSelected,FarmNumber,RegionalMarketSet)$(connectselected(DistrictSelected,RegionalMarketSet)),
    FarmRegionalMarketTruckRequirement(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet,TransportationTypes)
  ) +
  sum((LocalCSPCenterSet,LocalMarketSet),
    LocalCSPLocalMarketTruckRequirement(HarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,TransportationTypes)
  ) +
  sum((LocalCSPCenterSet,RegionalMarketSet),
    LocalCSPRegionalMarketTruckRequirement(HarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)
  ) +
  sum((RegionalCSPCenterSet,LocalMarketSet),
    RegionalCSPLocalMarketTruckRequirement(HarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes)
  ) +
  sum((RegionalCSPCenterSet,RegionalMarketSet),
    RegionalCSPRegionalMarketTruckRequirement(HarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)
  ) +
  sum((LocalMarketSet,RGYSet),
    LocalMarketRGYTruckRequirement(HarvestingHorizonAggregation,LocalMarketSet,RGYSet,TransportationTypes)
  ) +
  sum((RegionalMarketSet,RGYSet),
    RegionalMarketRGYTruckRequirement(HarvestingHorizonAggregation,RegionalMarketSet,RGYSet,TransportationTypes)
  ) +
  sum((RegionalMarketSet,FCIGodownSet),
    RegionalMarketFCITruckRequirement(HarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet,TransportationTypes)
  ) +
  sum((RGYSet,MillerSet),
    RGYMillerTruckRequirement(HarvestingHorizonAggregation,RGYSet,MillerSet,TransportationTypes)
  ) +
  sum((RGYSet,RetailerSet),
    RGYRetailerTruckRequirement(HarvestingHorizonAggregation,RGYSet,RetailerSet,TransportationTypes)
  ) +
  sum((FCIGodownSet,MillerSet),
    FCIMillerTruckRequirement(HarvestingHorizonAggregation,FCIGodownSet,MillerSet,TransportationTypes)
  ) +
  sum((FCIGodownSet,RetailerSet),
    FCIRetailerTruckRequirement(HarvestingHorizonAggregation,FCIGodownSet,RetailerSet,TransportationTypes)
  ) +
  sum((FCIGodownSet,PDSSet),
    FCIPDSTruckRequirement(HarvestingHorizonAggregation,FCIGodownSet,PDSSet,TransportationTypes)
  ) +
  sum((MillerSet,RetailerSet),
    MillerRetailerTruckRequirement(HarvestingHorizonAggregation,MillerSet,RetailerSet,TransportationTypes)
  )
  =l= TransportationFleetSize(TransportationTypes)
  ;

* Repeating the same constraints for the non-harvesting horizon

*=====================================================================================================================================
* The number of trips are translated into the number of trucks required. The total transportation (round trip) time between different
* locations and the total number of hours per day available are used to do this calculation.
*=====================================================================================================================================
TransportationConstraint1A(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,TransportationTypes)..
  FarmLocalCSPTruckRequirement(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,TransportationTypes) =g=
    FarmLocalCSPTruckTripRequirement(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,TransportationTypes)*
    FarmLocalCSPTransportationTime(DistrictSelected,FarmNumber,LocalCSPCenterSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint2A(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,TransportationTypes)..
  FarmRegionalCSPTruckRequirement(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,TransportationTypes) =g=
    FarmRegionalCSPTruckTripRequirement(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,TransportationTypes)*
    FarmRegionalCSPTransportationTime(DistrictSelected,FarmNumber,RegionalCSPCenterSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint3A(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet,TransportationTypes)..
  FarmLocalMarketTruckRequirement(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet,TransportationTypes) =g=
    FarmLocalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet,TransportationTypes)*
    FarmLocalMarketTransportationTime(DistrictSelected,FarmNumber,LocalMarketSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint4A(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet,TransportationTypes)$(connectselected(DistrictSelected,RegionalMarketSet))..
  FarmRegionalMarketTruckRequirement(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet,TransportationTypes) =g=
    FarmRegionalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet,TransportationTypes)*
    FarmRegionalMarketTransportationTime(DistrictSelected,FarmNumber,RegionalMarketSet,TransportationTypes)/HoursPerDay
  ;


TransportationConstraint5A(NonHarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,TransportationTypes)..
  LocalCSPLocalMarketTruckRequirement(NonHarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,TransportationTypes) =g=
    LocalCSPLocalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,TransportationTypes)*
    LocalCSPLocalMarketTransportationTime(LocalCSPCenterSet,LocalMarketSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint6A(NonHarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)..
  LocalCSPRegionalMarketTruckRequirement(NonHarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes) =g=
    LocalCSPRegionalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)*
    LocalCSPRegionalMarketTransportationTime(LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint7A(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes)..
  RegionalCSPLocalMarketTruckRequirement(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes) =g=
    RegionalCSPLocalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes)*
    RegionalCSPLocalMarketTransportationTime(RegionalCSPCenterSet,LocalMarketSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint8A(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)..
  RegionalCSPRegionalMarketTruckRequirement(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes) =g=
    RegionalCSPRegionalMarketTruckTripRequirement(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)*
    RegionalCSPRegionalMarketTransportationTime(RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)/HoursPerDay
  ;


TransportationConstraint9A(NonHarvestingHorizonAggregation,LocalMarketSet,RGYSet,TransportationTypes)..
  LocalMarketRGYTruckRequirement(NonHarvestingHorizonAggregation,LocalMarketSet,RGYSet,TransportationTypes) =g=
    LocalMarketRGYTruckTripRequirement(NonHarvestingHorizonAggregation,LocalMarketSet,RGYSet,TransportationTypes)*
    LocalMarketRGYTransportationTime(LocalMarketSet,RGYSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint10A(NonHarvestingHorizonAggregation,RegionalMarketSet,RGYSet,TransportationTypes)..
  RegionalMarketRGYTruckRequirement(NonHarvestingHorizonAggregation,RegionalMarketSet,RGYSet,TransportationTypes) =g=
    RegionalMarketRGYTruckTripRequirement(NonHarvestingHorizonAggregation,RegionalMarketSet,RGYSet,TransportationTypes)*
    RegionalMarketRGYTransportationTime(RegionalMarketSet,RGYSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint11A(NonHarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet,TransportationTypes)..
  RegionalMarketFCITruckRequirement(NonHarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet,TransportationTypes) =g=
    RegionalMarketFCITruckTripRequirement(NonHarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet,TransportationTypes)*
    RegionalMarketFCITransportationTime(RegionalMarketSet,FCIGodownSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint12A(NonHarvestingHorizonAggregation,RGYSet,MillerSet,TransportationTypes)..
  RGYMillerTruckRequirement(NonHarvestingHorizonAggregation,RGYSet,MillerSet,TransportationTypes) =g=
    RGYMillerTruckTripRequirement(NonHarvestingHorizonAggregation,RGYSet,MillerSet,TransportationTypes) *
    RGYMillerTransportationTime(RGYSet,MillerSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint13A(NonHarvestingHorizonAggregation,RGYSet,RetailerSet,TransportationTypes)..
  RGYRetailerTruckRequirement(NonHarvestingHorizonAggregation,RGYSet,RetailerSet,TransportationTypes) =g=
    RGYRetailerTruckTripRequirement(NonHarvestingHorizonAggregation,RGYSet,RetailerSet,TransportationTypes) *
    RGYRetailerTransportationTime(RGYSet,RetailerSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint14A(NonHarvestingHorizonAggregation,FCIGodownSet,MillerSet,TransportationTypes)..
  FCIMillerTruckRequirement(NonHarvestingHorizonAggregation,FCIGodownSet,MillerSet,TransportationTypes) =g=
    FCIMillerTruckTripRequirement(NonHarvestingHorizonAggregation,FCIGodownSet,MillerSet,TransportationTypes)   *
    FCIMillerTransportationTime(FCIGodownSet,MillerSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint15A(NonHarvestingHorizonAggregation,FCIGodownSet,RetailerSet,TransportationTypes)..
  FCIRetailerTruckRequirement(NonHarvestingHorizonAggregation,FCIGodownSet,RetailerSet,TransportationTypes) =g=
    FCIRetailerTruckTripRequirement(NonHarvestingHorizonAggregation,FCIGodownSet,RetailerSet,TransportationTypes)   *
    FCIRetailerTransportationTime(FCIGodownSet,RetailerSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint16A(NonHarvestingHorizonAggregation,FCIGodownSet,PDSSet,TransportationTypes)..
  FCIPDSTruckRequirement(NonHarvestingHorizonAggregation,FCIGodownSet,PDSSet,TransportationTypes) =g=
    FCIPDSTruckTripRequirement(NonHarvestingHorizonAggregation,FCIGodownSet,PDSSet,TransportationTypes)   *
    FCIPDSTransportationTime(FCIGodownSet,PDSSet,TransportationTypes)/HoursPerDay
  ;

TransportationConstraint17A(NonHarvestingHorizonAggregation,MillerSet,RetailerSet,TransportationTypes) $(TransportationData('LongDistanceIndicator',TransportationTypes))..
  MillerRetailerTruckRequirement(NonHarvestingHorizonAggregation,MillerSet,RetailerSet,TransportationTypes) =g=
    MillerRetailerTruckTripRequirement(NonHarvestingHorizonAggregation,MillerSet,RetailerSet,TransportationTypes)   *
    MillerRetailerTransportationTime(MillerSet,RetailerSet,TransportationTypes)/HoursPerDay
  ;

* The total transportation fleet in use on a particular day (sum of all possible transportation links) must not exceed the
* total available transportation units.
TransportationConstraint18A(NonHarvestingHorizonAggregation,TransportationTypes)..
  sum((DistrictSelected,FarmNumber,LocalCSPCenterSet),
    FarmLocalCSPTruckRequirement(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,TransportationTypes)
  ) +
  sum((DistrictSelected,FarmNumber,RegionalCSPCenterSet),
    FarmRegionalCSPTruckRequirement(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,TransportationTypes)
  ) +
  sum((DistrictSelected,FarmNumber,LocalMarketSet),
    FarmLocalMarketTruckRequirement(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet,TransportationTypes)
  ) +
  sum((DistrictSelected,FarmNumber,RegionalMarketSet)$(connectselected(DistrictSelected,RegionalMarketSet)),
    FarmRegionalMarketTruckRequirement(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet,TransportationTypes)
  ) +
  sum((LocalCSPCenterSet,LocalMarketSet),
    LocalCSPLocalMarketTruckRequirement(NonHarvestingHorizonAggregation,LocalCSPCenterSet,LocalMarketSet,TransportationTypes)
  ) +
  sum((LocalCSPCenterSet,RegionalMarketSet),
    LocalCSPRegionalMarketTruckRequirement(NonHarvestingHorizonAggregation,LocalCSPCenterSet,RegionalMarketSet,TransportationTypes)
  ) +
  sum((RegionalCSPCenterSet,LocalMarketSet),
    RegionalCSPLocalMarketTruckRequirement(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,LocalMarketSet,TransportationTypes)
  ) +
  sum((RegionalCSPCenterSet,RegionalMarketSet),
    RegionalCSPRegionalMarketTruckRequirement(NonHarvestingHorizonAggregation,RegionalCSPCenterSet,RegionalMarketSet,TransportationTypes)
  ) +
  sum((LocalMarketSet,RGYSet),
    LocalMarketRGYTruckRequirement(NonHarvestingHorizonAggregation,LocalMarketSet,RGYSet,TransportationTypes)
  ) +
  sum((RegionalMarketSet,RGYSet),
    RegionalMarketRGYTruckRequirement(NonHarvestingHorizonAggregation,RegionalMarketSet,RGYSet,TransportationTypes)
  ) +
  sum((RegionalMarketSet,FCIGodownSet),
    RegionalMarketFCITruckRequirement(NonHarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet,TransportationTypes)
  ) +
  sum((RGYSet,MillerSet),
    RGYMillerTruckRequirement(NonHarvestingHorizonAggregation,RGYSet,MillerSet,TransportationTypes)
  ) +
  sum((RGYSet,RetailerSet),
    RGYRetailerTruckRequirement(NonHarvestingHorizonAggregation,RGYSet,RetailerSet,TransportationTypes)
  ) +
  sum((FCIGodownSet,MillerSet),
    FCIMillerTruckRequirement(NonHarvestingHorizonAggregation,FCIGodownSet,MillerSet,TransportationTypes)
  ) +
  sum((FCIGodownSet,RetailerSet),
    FCIRetailerTruckRequirement(NonHarvestingHorizonAggregation,FCIGodownSet,RetailerSet,TransportationTypes)
  ) +
  sum((FCIGodownSet,PDSSet),
    FCIPDSTruckRequirement(NonHarvestingHorizonAggregation,FCIGodownSet,PDSSet,TransportationTypes)
  ) +
  sum((MillerSet,RetailerSet),
    MillerRetailerTruckRequirement(NonHarvestingHorizonAggregation,MillerSet,RetailerSet,TransportationTypes)
  )
  =l= TransportationFleetSize(TransportationTypes)
  ;

Model TransportationModel /
  TransportationConstraint1
  TransportationConstraint2
  TransportationConstraint3
  TransportationConstraint4
  TransportationConstraint5
  TransportationConstraint6
  TransportationConstraint7
  TransportationConstraint8
  TransportationConstraint9
  TransportationConstraint10
  TransportationConstraint11
  TransportationConstraint12
  TransportationConstraint13
  TransportationConstraint14
  TransportationConstraint15
  TransportationConstraint16
  TransportationConstraint17
  TransportationConstraint18

  TransportationConstraint1A
  TransportationConstraint2A
  TransportationConstraint3A
  TransportationConstraint4A
  TransportationConstraint5A
  TransportationConstraint6A
  TransportationConstraint7A
  TransportationConstraint8A
  TransportationConstraint9A
  TransportationConstraint10A
  TransportationConstraint11A
  TransportationConstraint12A
  TransportationConstraint13A
  TransportationConstraint14A
  TransportationConstraint15A
  TransportationConstraint16A
  TransportationConstraint17A
  TransportationConstraint18A
  /;
