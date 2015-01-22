$title Refinery variables and constraints

Equations
                 DemandConstraint1
                 DemandConstraint2
                 DemandConstraint3
                 DemandConstraint4
                 DemandConstraint5
                 DemandConstraint6
                 DemandConstraint7
                 DemandConstraint8
                 DemandConstraint9
                 DemandConstraint10

                 DemandConstraint11
                 DemandConstraint12
                 DemandConstraint13
                 DemandConstraint14

                 RefineryCapacityConstraint1
                 RefineryCapacityConstraint2
                 RefineryCapacityConstraint3
                 RefineryCapacityConstraint4
                 RefineryCapacityConstraint5
                 RefineryCapacityConstraint6
                 ;

*
* Demand constraints:
* The bimoass transported to the refinery is split into two part: The first one is used to meet the processing demend
* represented as BiorefineryCapacity and must be met; while the second part goes to the storage buffer at the refinery.
* Demand Constraint 1: This constraint ensure that the biorefinery processing demand is satisfied at all times.
* The demand (BiorefineryCapacity) is optimized.
*
DemandConstraint1(HarvestingHorizonAggregation)$(not(CentralStorageProcessing))..
                         sum((CountySelected,FarmNumber),
                                 HarvestFarmGateRefineryBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 HarvestFarmGateRegionalBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 HarvestFarmGateDirectPurchaseBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmCoveredStorageFarmGateRefineryBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmCoveredStorageFarmGateRegionalBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmCoveredStorageFarmGateDirectPurchaseBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmOpenStorageFarmGateRefineryBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmOpenStorageFarmGateRegionalBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmOpenStorageFarmGateDirectPurchaseBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((CentralizedStorageLocations,CountySelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 CentralStorageOutputToRefinery(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((CentralizedStorageLocations,CountySelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 CentralStorageOutputToRegional(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((CentralizedStorageSmallScaleLocations,CountySelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 CentralStorageSmallScaleOutputToRefinery(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((CentralizedStorageSmallScaleLocations,CountySelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 CentralStorageSmallScaleOutputToRegional(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                        + ( BiomassBufferToRefinery(HarvestingHorizonAggregation) + BiomassBufferToRegional(HarvestingHorizonAggregation) + BiomassBufferToDirectPurchase(HarvestingHorizonAggregation) - BiomassToBuffer(HarvestingHorizonAggregation))$(BiomassStorageTimeLimitSelector)
                        =g=
                        RegionalMarketDemand + LocalMarketDemand + OnFarmPurchaseDemand;

DemandConstraint2(HarvestingHorizonAggregation)$(not(CentralStorageProcessing))..
                         sum((CountySelected,FarmNumber),
                                 HarvestFarmGateRefineryBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 HarvestFarmGateRegionalBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 HarvestFarmGateDirectPurchaseBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmCoveredStorageFarmGateRefineryBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmCoveredStorageFarmGateRegionalBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmCoveredStorageFarmGateDirectPurchaseBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmOpenStorageFarmGateRefineryBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmOpenStorageFarmGateRegionalBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmOpenStorageFarmGateDirectPurchaseBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                         )*(1-TransportationDryMatterLossRate)
                         +
                          sum((CentralizedStorageLocations,CountySelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 CentralStorageOutputToRefinery(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((CentralizedStorageLocations,CountySelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 CentralStorageOutputToRegional(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((CentralizedStorageSmallScaleLocations,CountySelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 CentralStorageSmallScaleOutputToRefinery(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((CentralizedStorageSmallScaleLocations,CountySelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 CentralStorageSmallScaleOutputToRegional(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                        + ( BiomassBufferToRefinery(HarvestingHorizonAggregation) + BiomassBufferToRegional(HarvestingHorizonAggregation) + BiomassBufferToDirectPurchase(HarvestingHorizonAggregation) - BiomassToBuffer(HarvestingHorizonAggregation))$(BiomassStorageTimeLimitSelector)
                        =l=
                        (RegionalMarketDemand + LocalMarketDemand + OnFarmPurchaseDemand)*1.1;

DemandConstraint3(NonHarvestingHorizonAggregation)$(not(CentralStorageProcessing))..
                         sum((CountySelected,FarmNumber),
                                 HarvestFarmGateRefineryBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 HarvestFarmGateRegionalBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmCoveredStorageFarmGateRefineryBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmCoveredStorageFarmGateRegionalBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmOpenStorageFarmGateRefineryBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmOpenStorageFarmGateRegionalBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((CountySelected,FarmNumber),
                                 EnsilingFarmGateRefineryBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                         )
                         +
                         sum((CentralizedStorageLocations,CountySelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 CentralStorageOutputToRegional(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((CentralizedStorageSmallScaleLocations,CountySelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 CentralStorageSmallScaleOutputToRefinery(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((CentralizedStorageSmallScaleLocations,CountySelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 CentralStorageSmallScaleOutputToRegional(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                        + BiomassBufferToRefinery(HarvestingHorizonAggregation) + BiomassBufferToRegional(HarvestingHorizonAggregation) + BiomassBufferToDirectPurchase(HarvestingHorizonAggregation)
                         =g=
                         RegionalMarketDemand + LocalMarketDemand + OnFarmPurchaseDemand;


DemandConstraint4(NonHarvestingHorizonAggregation)$(not(CentralStorageProcessing))..
                         sum((CountySelected,FarmNumber),
                                 HarvestFarmGateRefineryBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 HarvestFarmGateRegionalBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmCoveredStorageFarmGateRefineryBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmCoveredStorageFarmGateRegionalBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmOpenStorageFarmGateRefineryBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmOpenStorageFarmGateRegionalBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((CountySelected,FarmNumber),
                                 EnsilingFarmGateRefineryBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                         )
                         +
                          sum((CentralizedStorageLocations,CountySelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 CentralStorageOutputToRegional(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((CentralizedStorageLocations,CountySelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 CentralStorageOutputToRefinery(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((CentralizedStorageSmallScaleLocations,CountySelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 CentralStorageSmallScaleOutputToRefinery(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((CentralizedStorageSmallScaleLocations,CountySelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 CentralStorageSmallScaleOutputToRegional(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                        + BiomassBufferToRefinery(HarvestingHorizonAggregation) + BiomassBufferToRegional(HarvestingHorizonAggregation) + BiomassBufferToDirectPurchase(HarvestingHorizonAggregation)
                         =l=
                         (RegionalMarketDemand + LocalMarketDemand)*1.1;

RefineryCapacityConstraint1$(BiorefineryCapacitySelection)..
                                 LocalMarketDemand =g= LocalMarketDemandTarget;

RefineryCapacityConstraint2$(BiorefineryCapacitySelection)..
                                 RegionalMarketDemand =g= RegionalMarketDemandTarget;

RefineryCapacityConstraint3$(BiorefineryCapacitySelection)..
                                 OnFarmPurchaseDemand =g= OnFarmPurchaseDemandTarget;


RefineryCapacityConstraint4$(BiorefineryCapacitySelection)..
                                 LocalMarketDemand =l= LocalMarketDemandTarget*1.05;

RefineryCapacityConstraint5$(BiorefineryCapacitySelection)..
                                 RegionalMarketDemand =l= RegionalMarketDemandTarget*1.05;

RefineryCapacityConstraint6$(BiorefineryCapacitySelection)..
                                 OnFarmPurchaseDemand =l= OnFarmPurchaseDemandTarget*1.05;

*
* Including constraints for the scenario where the centralized storage facility also includes biomass processing
*
DemandConstraint5(HarvestingHorizonAggregation)$(CentralStorageProcessing and CentralStorageProcessingMandatory and ord(HarvestingHorizonAggregation)=1)..
                         sum((CountySelected,FarmNumber),
                                 HarvestFarmGateRefineryBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 HarvestFarmGateRegionalBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 HarvestFarmGateDirectPurchaseBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageProcessingOutput(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageOutputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleProcessingOutput(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleOutputProcessing)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageOutputToRefineryProcessed(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageInputProcessing)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageOutputToRegionalProcessed(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageInputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleOutputToRefineryProcessed(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleInputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleOutputToRegionalProcessed(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleInputProcessing)
                         + ( BiomassBufferToRefinery(HarvestingHorizonAggregation) + BiomassBufferToRegional(HarvestingHorizonAggregation) + BiomassBufferToDirectPurchase(HarvestingHorizonAggregation) - BiomassToBuffer(HarvestingHorizonAggregation))$(BiomassStorageTimeLimitSelector)
                        =g=
                        RegionalMarketDemand + LocalMarketDemand + OnFarmPurchaseDemand;

DemandConstraint6(HarvestingHorizonAggregation)$(CentralStorageProcessing and CentralStorageProcessingMandatory and ord(HarvestingHorizonAggregation)=1)..
                         sum((CountySelected,FarmNumber),
                                 HarvestFarmGateRefineryBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 HarvestFarmGateRegionalBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 HarvestFarmGateDirectPurchaseBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageProcessingOutput(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageOutputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleProcessingOutput(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleOutputProcessing)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageOutputToRefineryProcessed(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageInputProcessing)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageOutputToRegionalProcessed(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageInputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleOutputToRefineryProcessed(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleInputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleOutputToRegionalProcessed(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleInputProcessing)
                         + ( BiomassBufferToRefinery(HarvestingHorizonAggregation) + BiomassBufferToRegional(HarvestingHorizonAggregation) + BiomassBufferToDirectPurchase(HarvestingHorizonAggregation) - BiomassToBuffer(HarvestingHorizonAggregation))$(BiomassStorageTimeLimitSelector)
                        =l=
                        (RegionalMarketDemand + LocalMarketDemand + OnFarmPurchaseDemand)*1.1;


DemandConstraint7(HarvestingHorizonAggregation)$(CentralStorageProcessing and CentralStorageProcessingMandatory and ord(HarvestingHorizonAggregation)>=1)..
                         sum(CentralizedStorageLocations,
                                CentralStorageProcessingOutput(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageOutputProcessing)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageOutputToRefineryProcessed(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageInputProcessing)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageOutputToRegionalProcessed(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageInputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleProcessingOutput(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleOutputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleOutputToRefineryProcessed(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleInputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleOutputToRegionalProcessed(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleInputProcessing)
                        + (BiomassBufferToRefinery(HarvestingHorizonAggregation) + BiomassBufferToRegional(HarvestingHorizonAggregation) + BiomassBufferToDirectPurchase(HarvestingHorizonAggregation) - BiomassToBuffer(HarvestingHorizonAggregation))$(BiomassStorageTimeLimitSelector)
                        =g=
                         (RegionalMarketDemand + LocalMarketDemand);

DemandConstraint8(HarvestingHorizonAggregation)$(CentralStorageProcessing and CentralStorageProcessingMandatory and ord(HarvestingHorizonAggregation)>=1)..
                         sum(CentralizedStorageLocations,
                                CentralStorageProcessingOutput(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageOutputProcessing)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageOutputToRefineryProcessed(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageInputProcessing)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageOutputToRegionalProcessed(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageInputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleProcessingOutput(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleOutputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleOutputToRefineryProcessed(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleInputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleOutputToRegionalProcessed(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleInputProcessing)
                        + (BiomassBufferToRefinery(HarvestingHorizonAggregation) + BiomassBufferToRegional(HarvestingHorizonAggregation) + BiomassBufferToDirectPurchase(HarvestingHorizonAggregation) - BiomassToBuffer(HarvestingHorizonAggregation))$(BiomassStorageTimeLimitSelector)
                        =l=
                        (RegionalMarketDemand + LocalMarketDemand)*1.1;

DemandConstraint9(NonHarvestingHorizonAggregation)$(CentralStorageProcessing and CentralStorageProcessingMandatory)..
                         sum(CentralizedStorageLocations,
                                CentralStorageProcessingOutput(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageOutputProcessing)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageOutputToRefineryProcessed(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageInputProcessing)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageOutputToRegionalProcessed(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageInputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleProcessingOutput(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleOutputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleOutputToRefineryProcessed(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleInputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleOutputToRegionalProcessed(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleInputProcessing)
                         + (BiomassBufferToRefinery(NonHarvestingHorizonAggregation) + BiomassBufferToRegional(NonHarvestingHorizonAggregation))$(BiomassStorageTimeLimitSelector)
                         =g=
                         RegionalMarketDemand + LocalMarketDemand;

DemandConstraint10(NonHarvestingHorizonAggregation)$(CentralStorageProcessing and CentralStorageProcessingMandatory)..
                         sum(CentralizedStorageLocations,
                                CentralStorageProcessingOutput(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageOutputProcessing)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageOutputToRefineryProcessed(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageInputProcessing)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageOutputToRegionalProcessed(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageInputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleProcessingOutput(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleOutputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleOutputToRefineryProcessed(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleInputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleOutputToRegionalProcessed(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleInputProcessing)
                         + ( BiomassBufferToRefinery(NonHarvestingHorizonAggregation) + BiomassBufferToRegional(NonHarvestingHorizonAggregation))$(BiomassStorageTimeLimitSelector)
                         =l=
                         (RegionalMarketDemand + LocalMarketDemand)*1.1;


*=================================================================================================================================
* Alternate constraints for the case where there is centralized storage processing but all farms are not required to send biomass
* to the central storage facility. Thus, whatever biomass comes to the central storage is processed, but the farms are decide
* to store biomass on-farm and then transport directly to the refinery.
*=================================================================================================================================

DemandConstraint11(HarvestingHorizonAggregation)$(CentralStorageProcessing and not(CentralStorageProcessingMandatory))..
                         sum((CountySelected,FarmNumber)$(Par_FarmGrinderSelection(CountySelected,FarmNumber,'Tub_Grinder')),
                                 HarvestFarmGateRefineryBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 HarvestFarmGateRegionalBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 HarvestFarmGateDirectPurchaseBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmCoveredStorageFarmGateRefineryBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmCoveredStorageFarmGateRegionalBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmCoveredStorageFarmGateDirectPurchaseBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmOpenStorageFarmGateRefineryBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmOpenStorageFarmGateRegionalBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmOpenStorageFarmGateDirectPurchaseBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageProcessingOutput(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageOutputProcessing)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageOutputToRefineryProcessed(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageInputProcessing)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageOutputToRegionalProcessed(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageInputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleProcessingOutput(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleOutputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleOutputToRefineryProcessed(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleInputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleOutputToRegionalProcessed(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleInputProcessing)
                        + ( BiomassBufferToRefinery(HarvestingHorizonAggregation) + BiomassBufferToRegional(HarvestingHorizonAggregation) + + BiomassBufferToDirectPurchase(HarvestingHorizonAggregation))$(BiomassStorageTimeLimitSelector)
                         =g=
                         (RegionalMarketDemand + LocalMarketDemand + OnFarmPurchaseDemand);


DemandConstraint12(HarvestingHorizonAggregation)$(CentralStorageProcessing and not(CentralStorageProcessingMandatory))..
                         sum((CountySelected,FarmNumber)$(Par_FarmGrinderSelection(CountySelected,FarmNumber,'Tub_Grinder')),
                                 HarvestFarmGateRefineryBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 HarvestFarmGateRegionalBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 HarvestFarmGateDirectPurchaseBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmCoveredStorageFarmGateRefineryBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmCoveredStorageFarmGateRegionalBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmCoveredStorageFarmGateDirectPurchaseBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmOpenStorageFarmGateRefineryBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmOpenStorageFarmGateRegionalBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmOpenStorageFarmGateDirectPurchaseBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageProcessingOutput(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageOutputProcessing)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageOutputToRefineryProcessed(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageInputProcessing)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageOutputToRegionalProcessed(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageInputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleProcessingOutput(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleOutputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleOutputToRefineryProcessed(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleInputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleOutputToRegionalProcessed(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleInputProcessing)
                        + ( BiomassBufferToRefinery(HarvestingHorizonAggregation) + BiomassBufferToRegional(HarvestingHorizonAggregation) + BiomassBufferToDirectPurchase(HarvestingHorizonAggregation))$(BiomassStorageTimeLimitSelector)
                         =l=
                         (RegionalMarketDemand + LocalMarketDemand + OnFarmPurchaseDemand)*1.1;


DemandConstraint13(NonHarvestingHorizonAggregation)$(CentralStorageProcessing and not(CentralStorageProcessingMandatory))..
                        sum((CountySelected,FarmNumber)$(Par_FarmGrinderSelection(CountySelected,FarmNumber,'Tub_Grinder')),
                                 HarvestFarmGateRefineryBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 HarvestFarmGateRegionalBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmCoveredStorageFarmGateRefineryBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmCoveredStorageFarmGateRegionalBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmOpenStorageFarmGateRefineryBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmOpenStorageFarmGateRegionalBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageProcessingOutput(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageOutputProcessing)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageOutputToRefineryProcessed(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageInputProcessing)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageOutputToRegionalProcessed(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageInputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleProcessingOutput(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleOutputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleOutputToRefineryProcessed(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleInputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleOutputToRegionalProcessed(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleInputProcessing)
                        + (BiomassBufferToRefinery(NonHarvestingHorizonAggregation) + BiomassBufferToRegional(NonHarvestingHorizonAggregation))$(BiomassStorageTimeLimitSelector)
                         =g=
                         RegionalMarketDemand + LocalMarketDemand;



DemandConstraint14(NonHarvestingHorizonAggregation)$(CentralStorageProcessing and not(CentralStorageProcessingMandatory))..
                         sum((CountySelected,FarmNumber)$(Par_FarmGrinderSelection(CountySelected,FarmNumber,'Tub_Grinder')),
                                 sum((CountySelected,FarmNumber)$(Par_FarmGrinderSelection(CountySelected,FarmNumber,'Tub_Grinder')),
                                 HarvestFarmGateRefineryBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 HarvestFarmGateRegionalBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmCoveredStorageFarmGateRefineryBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmCoveredStorageFarmGateRegionalBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmOpenStorageFarmGateRefineryBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                                 +
                                 FarmOpenStorageFarmGateRegionalBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageProcessingOutput(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageOutputProcessing)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageOutputToRefineryProcessed(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageInputProcessing)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageOutputToRegionalProcessed(NonHarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageInputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleProcessingOutput(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleOutputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleOutputToRefineryProcessed(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleInputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleOutputToRegionalProcessed(NonHarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleInputProcessing)
                        + ( BiomassBufferToRefinery(NonHarvestingHorizonAggregation) + BiomassBufferToRegional(NonHarvestingHorizonAggregation))$(BiomassStorageTimeLimitSelector)
                         =l=
                         BiorefineryCapacity*1.1;


Model RefineryModel /
                 DemandConstraint1
                 DemandConstraint2
*                 DemandConstraint3
*                 DemandConstraint4
                 RefineryCapacityConstraint1
                 RefineryCapacityConstraint2
                 RefineryCapacityConstraint3
                 RefineryCapacityConstraint4
                 RefineryCapacityConstraint5
                 RefineryCapacityConstraint6
                 /;

Model RefineryModelConstrained /
                 DemandConstraint1
                 DemandConstraint2
                 DemandConstraint3
                 DemandConstraint4
                 DemandConstraint5
                 DemandConstraint6
                 DemandConstraint7
                 DemandConstraint8
                 DemandConstraint9
                 DemandConstraint10
                 DemandConstraint11
                 DemandConstraint12
                 DemandConstraint13
                 DemandConstraint14
                 RefineryCapacityConstraint1
                 RefineryCapacityConstraint2
                 RefineryCapacityConstraint3
                 RefineryCapacityConstraint4
                 RefineryCapacityConstraint5
                 RefineryCapacityConstraint6
                 /;
