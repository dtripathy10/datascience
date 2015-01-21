Equations
                 BufferConstraint1
                 BufferConstraint2
                 BufferConstraint3
                 BufferConstraint4
                 BufferConstraint5
                 BufferConstraint6
                 BufferConstraint7
                 BufferConstraint8
                 BufferConstraint9
                 BufferConstraint10;

*------------------------------------------------------------------------
* Constraints related to biomass buffer storage capacity at the refinery
*------------------------------------------------------------------------
* Calculating the biomass moved to buffer at every time step using the difference between the transported biomass
* and the biorefinery demand (any excess is moved to buffer)
BufferConstraint1(HarvestingHorizonAggregation)..
                 BiomassToBuffer(HarvestingHorizonAggregation) =g=
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
                         )*(1-TransportationDryMatterLossRate)$(not(CentralStorageProcessing))
                         +
                          sum((CentralizedStorageLocations,CountySelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 CentralStorageOutputToRegional(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)$(not(CentralStorageProcessing))
                         +
                         sum((CentralizedStorageSmallScaleLocations,CountySelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 CentralStorageSmallScaleOutputToRefinery(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)$(not(CentralStorageSmallScaleProcessing))
                         +
                         sum((CentralizedStorageSmallScaleLocations,CountySelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 CentralStorageSmallScaleOutputToRegional(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)$(not(CentralStorageSmallScaleProcessing))
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageProcessingOutput(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageProcessing and CentralStorageOutputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleProcessingOutput(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleProcessing and CentralStorageSmallScaleOutputProcessing)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageOutputToRefineryProcessed(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageProcessing and CentralStorageInputProcessing)
                         +
                         sum(CentralizedStorageLocations,
                                CentralStorageOutputToRegionalProcessed(HarvestingHorizonAggregation,CentralizedStorageLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageProcessing and CentralStorageInputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleOutputToRefineryProcessed(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleProcessing and CentralStorageSmallScaleInputProcessing)
                         +
                         sum(CentralizedStorageSmallScaleLocations,
                                CentralStorageSmallScaleOutputToRegionalProcessed(HarvestingHorizonAggregation,CentralizedStorageSmallScaleLocations)
                         )*(1-TransportationDryMatterLossRate)$(CentralStorageSmallScaleProcessing and CentralStorageSmallScaleInputProcessing)
                         + BiomassBufferToRefinery(HarvestingHorizonAggregation)
                         + BiomassBufferToRegional(HarvestingHorizonAggregation)
                         + BiomassBufferToDirectPurchase(HarvestingHorizonAggregation)
                         - LocalMarketDemand
                         - RegionalMarketDemand
                         - OnFarmPurchaseDemand;
*
* Note that as compared to the storage facilities, the stored biomass volume in buffer is calculated at the end of the time sub-unit of the
* aggregation time step (for example, at then end of the fifth year if the aggregation time is five years. The other stored volumes are calculated
* at the start of the first year of the five year aggregation). This difference is because for the other stored volumes, the goal is to constrain
* the outflow by the available biomass. However, for the buffer storage, it is important to MAINTAIN the biomass at a particular level. Hence the
* biomass at the end is calculated and it is bounded by the lower minimum requirement. If such modification is not made, then the problem will
* take out biomass from the buffer in the final aggregated time step.
*
BufferConstraint2(HarvestingHorizonAggregation)..
                                 TotalBiomassBuffer(HarvestingHorizonAggregation)
                                 =e=
                                 sum(HarvestingHorizonAggregation2 $(ord(HarvestingHorizonAggregation2)=ord(HarvestingHorizonAggregation)-1),
                                     TotalBiomassBuffer(HarvestingHorizonAggregation2)
                                     -
                                     BiomassBufferToRefinery(HarvestingHorizonAggregation2)*card(HarvestingHorizonAggregationStep)
                                     -
                                     BiomassBufferToRegional(HarvestingHorizonAggregation2)*card(HarvestingHorizonAggregationStep)
                                     -
                                     BiomassBufferToDirectPurchase(HarvestingHorizonAggregation2)*card(HarvestingHorizonAggregationStep)

                                 )*(1-(CentralStorageDryMatterLossRate/365)*card(HarvestingHorizonAggregationStep))
                                 +
                                 BiomassToBuffer(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep)
                                 ;


* The the biomass moved from the buffer to the refinery processing must be less than the total biomass available in the buffer
BufferConstraint3(HarvestingHorizonAggregation)..
                         BiomassBufferToRefinery(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep)
                         =l=
                         TotalBiomassBuffer(HarvestingHorizonAggregation);


* The constraint limits the capacity of the biomass buffer to 10% over the desired buffer at any time
BufferConstraint4(HarvestingHorizonAggregation)..   TotalBiomassBuffer(HarvestingHorizonAggregation) =l=
                                                 (LocalMarketDemand+RegionalMarketDemand+OnFarmPurchaseDemand)*BiomassBufferDays*(1+BufferVariation);


* The constraint limits the capacity of the biomass buffer to 10% over the desired buffer at any time
BufferConstraint5(HarvestingHorizonAggregation)$(ord(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep)>BufferBuildupLimit)..
                                 TotalBiomassBuffer(HarvestingHorizonAggregation) =g=
                                 (LocalMarketDemand+RegionalMarketDemand+OnFarmPurchaseDemand)*BiomassBufferDays*(1-BufferVariation);


*##############################################################################################################
* Connecting constraints to connect the harvesting and non-harvesting horizons
*##############################################################################################################

BufferConstraint6(NonHarvestingHorizonAggregation)$(ord(NonHarvestingHorizonAggregation)=1)..
                 TotalBiomassBuffer(NonHarvestingHorizonAggregation)
                 =e=
                 sum(HarvestingHorizonAggregation $(ord(HarvestingHorizonAggregation)=card(HarvestingHorizonAggregation)),
                         TotalBiomassBuffer(HarvestingHorizonAggregation)
                         -
                         BiomassBufferToRefinery(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep)
                         -
                         BiomassBufferToRegional(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep)
                         -
                         BiomassBufferToDirectPurchase(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep)
                 )
                 *(1-(FarmCoveredStorageDryMatterLossRate/365)*card(HarvestingHorizonAggregationStep));



*##############################################################################################################
* Constraints for the non-harvesting horizon
*##############################################################################################################

BufferConstraint7(NonHarvestingHorizonAggregation)$(ord(NonHarvestingHorizonAggregation)>1)..
                         TotalBiomassBuffer(NonHarvestingHorizonAggregation) =l=
                         sum(NonHarvestingHorizonAggregation2 $(ord(NonHarvestingHorizonAggregation2)=ord(NonHarvestingHorizonAggregation)-1),
                                 TotalBiomassBuffer(NonHarvestingHorizonAggregation2)
                                 -
                                 BiomassBufferToRefinery(NonHarvestingHorizonAggregation2)*card(NonHarvestingHorizonAggregationStep)
                                 -
                                 BiomassBufferToRegional(NonHarvestingHorizonAggregation2)*card(NonHarvestingHorizonAggregationStep)
                                 -
                                 BiomassBufferToDirectPurchase(NonHarvestingHorizonAggregation2)*card(NonHarvestingHorizonAggregationStep)
                         )
                         *(1-(CentralStorageDryMatterLossRate/365)*card(NonHarvestingHorizonAggregationStep));


* The the biomass moved from the buffer to the refinery processing must be less than the total biomass available in the buffer
BufferConstraint8(NonHarvestingHorizonAggregation)..
                         BiomassBufferToRefinery(NonHarvestingHorizonAggregation)*card(NonHarvestingHorizonAggregationStep)
                         +
                         BiomassBufferToRegional(NonHarvestingHorizonAggregation)*card(NonHarvestingHorizonAggregationStep)
                         +
                         BiomassBufferToDirectPurchase(NonHarvestingHorizonAggregation)*card(NonHarvestingHorizonAggregationStep)
                         =l=
                         TotalBiomassBuffer(NonHarvestingHorizonAggregation);

* The constraint limits the capacity of the biomass buffer to 10% over the desired buffer at any time
BufferConstraint9(NonHarvestingHorizonAggregation)..
                 TotalBiomassBuffer(NonHarvestingHorizonAggregation) =l= (LocalMarketDemand+RegionalMarketDemand+OnFarmPurchaseDemand)*BiomassBufferDays*(1+BufferVariation);


* The constraint limits the capacity of the biomass buffer to 10% over the desired buffer at any time
BufferConstraint10(NonHarvestingHorizonAggregation)..
                 TotalBiomassBuffer(NonHarvestingHorizonAggregation) =g=  (LocalMarketDemand+RegionalMarketDemand+OnFarmPurchaseDemand)*BiomassBufferDays*(1-BufferVariation);


Model RefineryBufferModel
                 /
                 BufferConstraint1
                 BufferConstraint2
                 BufferConstraint3
*                 BufferConstraint4
*                 BufferConstraint5
                 BufferConstraint6
                 BufferConstraint7
                 BufferConstraint8
*                 BufferConstraint9
*                 BufferConstraint10
                 /;
