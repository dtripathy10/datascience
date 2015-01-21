Equations
                 ProvisionEnergyConstraint1
                 ProvisionEnergyConstraint2
                 ProvisionEnergyConstraint3;

Positive variables
                 CentralStorageProcessingEnergyConsumption The total energy consumption associated with biomass processing at the centralized storage facility
                 CentralStorageSmallScaleProcessingEnergyConsumption The total energy consumption associated with biomass processing at the small scale centralized storage facility
                 TransportationEnergyConsumption The total energy consumption during long distance biomass transportation operation;



ProvisionEnergyConstraint1..     TransportationEnergyConsumption
                                 =e=
                                 sum((HarvestingHorizonAggregation,CountySelected,FarmNumber,TransportationTypes)
                                                                 $(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                         FarmRefineryTruckTripRequirement(HarvestingHorizonAggregation,CountySelected,FarmNumber,TransportationTypes)
                                         *
                                         (FarmData(CountySelected,FarmNumber,'RefineryDistance')/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
                                         *0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                                 )*card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((HarvestingHorizonAggregation,CountySelected,FarmNumber,TransportationTypes)
                                                                 $(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                         FarmRegionalTruckTripRequirement(HarvestingHorizonAggregation,CountySelected,FarmNumber,TransportationTypes)
                                         *
                                         (FarmData(CountySelected,FarmNumber,'RegionalDistance')/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
                                         *0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                                 )*card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((HarvestingHorizonAggregation,CountySelected,FarmNumber,TransportationTypes)
                                                                 $(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                         FarmDirectPurchaseTruckTripRequirement(HarvestingHorizonAggregation,CountySelected,FarmNumber,TransportationTypes)
                                         *
                                         (FarmData(CountySelected,FarmNumber,'DirectPurchaseDistance')/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
                                         *0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                                 )*card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,TransportationTypes)
                                                                 $(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                         FarmCentralStorageTruckTripRequirement(HarvestingHorizonAggregation,CountySelected,FarmNumber,
                                                                                         CentralizedStorageLocations,TransportationTypes)
                                         *
                                         (FarmDistanceData(CountySelected,FarmNumber,CentralizedStorageLocations)/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
                                         *0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                                 )*card(HarvestingHorizonAggregationStep)
                                 +
                                 sum((HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,TransportationTypes)
                                                                 $(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                         FarmCentralStorageSmallScaleTruckTripRequirement(HarvestingHorizonAggregation,CountySelected,FarmNumber,
                                                                                         CentralizedStorageSmallScaleLocations,TransportationTypes)
                                         *
                                         (FarmDistanceData(CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations)/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
                                         *0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                                 )*card(HarvestingHorizonAggregationStep)
                                 +
                                 ( sum((HarvestingHorizonAggregation,CentralizedStorageLocations,TransportationTypes)
                                                                 $(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                         CentralStorageRefineryTruckTripRequirement(HarvestingHorizonAggregation,CentralizedStorageLocations,
                                                                                         TransportationTypes)
                                         *
                                         (StorageRefineryDistanceData(CentralizedStorageLocations)/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
                                         *0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                                   )*card(HarvestingHorizonAggregationStep)
                                 )$(not(CentralStorageRefineryRailTransport))
                                 +
                                 ( sum((HarvestingHorizonAggregation,CentralizedStorageLocations,TransportationTypes)
                                                                 $(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                         CentralStorageRegionalTruckTripRequirement(HarvestingHorizonAggregation,CentralizedStorageLocations,
                                                                                         TransportationTypes)
                                         *
                                         (StorageRegionalDistanceData(CentralizedStorageLocations)/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
                                         *0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                                   )*card(HarvestingHorizonAggregationStep)
                                 )$(not(CentralStorageRefineryRailTransport))
                                 +
                                 ( sum((HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,TransportationTypes)
                                                                 $(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                         CentralStorageSmallScaleRefineryTruckTripRequirement(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,
                                                                                         TransportationTypes)
                                         *
                                         (StorageSmallScaleRefineryDistanceData(CentralizedStorageSmallScaleLocations)/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
                                         *0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                                   )*card(HarvestingHorizonAggregationStep)
                                 )$(not(CentralStorageRefineryRailTransport))
                                 +
                                 ( sum((HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,TransportationTypes)
                                                                 $(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                         CentralStorageSmallScaleRegionalTruckTripRequirement(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,
                                                                                         TransportationTypes)
                                         *
                                         (StorageSmallScaleRegionalDistanceData(CentralizedStorageSmallScaleLocations)/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
                                         *0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                                   )*card(HarvestingHorizonAggregationStep)
                                 )$(not(CentralStorageRefineryRailTransport))
                                 +
                                 sum((NonHarvestingHorizonAggregation,CountySelected,FarmNumber,TransportationTypes)
                                                                 $(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                         FarmRefineryTruckTripRequirement(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,TransportationTypes)
                                         *
                                         (FarmData(CountySelected,FarmNumber,'RefineryDistance')/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
                                         *0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                                 )*card(NonHarvestingHorizonAggregationStep)
                                 +
                                 sum((NonHarvestingHorizonAggregation,CountySelected,FarmNumber,TransportationTypes)
                                                                 $(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                         FarmRegionalTruckTripRequirement(NonHarvestingHorizonAggregation,CountySelected,FarmNumber,TransportationTypes)
                                         *
                                         (FarmData(CountySelected,FarmNumber,'RefineryDistance')/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
                                         *0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                                 )*card(NonHarvestingHorizonAggregationStep)
                                 +
                                 ( sum((NonHarvestingHorizonAggregation,CentralizedStorageLocations,TransportationTypes)
                                                                 $(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                         CentralStorageRefineryTruckTripRequirement(NonHarvestingHorizonAggregation,CentralizedStorageLocations,
                                                                                         TransportationTypes)
                                         *
                                         (StorageRefineryDistanceData(CentralizedStorageLocations)/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
                                         *0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                                    )*card(NonHarvestingHorizonAggregationStep)
                                 )$(not(CentralStorageRefineryRailTransport))
                                 +
                                 ( sum((NonHarvestingHorizonAggregation,CentralizedStorageLocations,TransportationTypes)
                                                                 $(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                         CentralStorageRegionalTruckTripRequirement(NonHarvestingHorizonAggregation,CentralizedStorageLocations,
                                                                                         TransportationTypes)
                                         *
                                         (StorageRegionalDistanceData(CentralizedStorageLocations)/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
                                         *0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                                    )*card(NonHarvestingHorizonAggregationStep)
                                 )$(not(CentralStorageRefineryRailTransport))
                                 +
                                 ( sum((NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,TransportationTypes)
                                                                 $(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                         CentralStorageSmallScaleRefineryTruckTripRequirement(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,
                                                                                         TransportationTypes)
                                         *
                                         (StorageSmallScaleRefineryDistanceData(CentralizedStorageSmallScaleLocations)/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
                                         *0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                                    )*card(NonHarvestingHorizonAggregationStep)
                                 )$(not(CentralStorageRefineryRailTransport))
                                 +
                                 ( sum((NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,TransportationTypes)
                                                                 $(TransportationData('LongDistanceIndicator',TransportationTypes)),
                                         CentralStorageSmallScaleRegionalTruckTripRequirement(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations,
                                                                                         TransportationTypes)
                                         *
                                         (StorageSmallScaleRegionalDistanceData(CentralizedStorageSmallScaleLocations)/TruckFuelEfficiency
                                           + TruckIdlingTimePerTrip(TransportationTypes)*TruckIdlingFuelConsumption)
                                         *0.00378*DieselSpecificGravity*1000*DieselCalorificValue
                                    )*card(NonHarvestingHorizonAggregationStep)
                                 )$(not(CentralStorageRefineryRailTransport));



ProvisionEnergyConstraint2$(CentralStorageProcessing)..
                         CentralStorageProcessingEnergyConsumption
                         =e=
                         sum((HarvestingHorizonAggregation,CentralizedStorageLocations),
                                 CentralStorageProcessingInput(HarvestingHorizonAggregation,CentralizedStorageLocations)
                                 * card(HarvestingHorizonAggregationStep)
                                 /
                                 (CentralStorageProcessingData('DesignCapacity')*CentralStorageProcessingData('Efficiency'))
                                 * (CentralStorageProcessingData('FuelConsumption')
                                     * 0.00378*DieselSpecificGravity*1000*DieselCalorificValue * CentralStorageProcessingData('Mobile')
                                     +
                                     CentralStorageProcessingData('CorrectedEMPower')*0.001*3600*CentralStorageProcessingData('Stationary')
                                   )
                         )
                         +
                         sum((NonHarvestingHorizonAggregation,CentralizedStorageLocations),
                                 CentralStorageProcessingInput(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                                 * card(HarvestingHorizonAggregationStep)
                                 /
                                 (CentralStorageProcessingData('DesignCapacity')*CentralStorageProcessingData('Efficiency'))
                                 * (CentralStorageProcessingData('FuelConsumption')
                                     * 0.00378*DieselSpecificGravity*1000*DieselCalorificValue * CentralStorageProcessingData('Mobile')
                                     +
                                     CentralStorageProcessingData('CorrectedEMPower')*0.001*3600*CentralStorageProcessingData('Stationary')
                                   )
                         );

ProvisionEnergyConstraint2$(CentralStorageSmallScaleProcessing)..
                         CentralStorageSmallScaleProcessingEnergyConsumption
                         =e=
                         sum((HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations),
                                 CentralStorageSmallScaleProcessingInput(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                                 * card(HarvestingHorizonAggregationStep)
                                 /
                                 (CentralStorageSmallScaleProcessingData('DesignCapacity')*CentralStorageSmallScaleProcessingData('Efficiency'))
                                 * (CentralStorageProcessingData('FuelConsumption')
                                     * 0.00378*DieselSpecificGravity*1000*DieselCalorificValue * CentralStorageSmallScaleProcessingData('Mobile')
                                     +
                                     CentralStorageSmallScaleProcessingData('CorrectedEMPower')*0.001*3600*CentralStorageSmallScaleProcessingData('Stationary')
                                   )
                         )
                         +
                         sum((NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations),
                                 CentralStorageSmallScaleProcessingInput(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                                 * card(HarvestingHorizonAggregationStep)
                                 /
                                 (CentralStorageSmallScaleProcessingData('DesignCapacity')*CentralStorageSmallScaleProcessingData('Efficiency'))
                                 * (CentralStorageSmallScaleProcessingData('FuelConsumption')
                                     * 0.00378*DieselSpecificGravity*1000*DieselCalorificValue * CentralStorageSmallScaleProcessingData('Mobile')
                                     +
                                     CentralStorageSmallScaleProcessingData('CorrectedEMPower')*0.001*3600*CentralStorageSmallScaleProcessingData('Stationary')
                                   )
                         );


Model ProvisionEnergyModel /
                 ProvisionEnergyConstraint1
                 ProvisionEnergyConstraint2
                 ProvisionEnergyConstraint3
                 /;
