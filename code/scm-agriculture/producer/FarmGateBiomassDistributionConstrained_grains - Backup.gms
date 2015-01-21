Equations
                 BiomassDivisionC1
                 BiomassDivisionC2
                 BiomassDivisionC3
                 BiomassDivisionC4
                 BiomassDivisionC5
                 BiomassDivisionC6
                 BiomassDivisionC7
                 BiomassDivisionC8
                 BiomassDivisionC9
                 BiomassDivisionC10
                 BiomassDivisionC11
                 BiomassDivisionC12
                 BiomassDivisionC13
                 BiomassDivisionC14
                 BiomassDivisionC15
                 BiomassDivisionC16


                 BiomassDivisionC18
                 BiomassDivisionC19
                 BiomassDivisionC20
                 BiomassDivisionC21
                 BiomassDivisionC22
                 BiomassDivisionC24
                 BiomassDivisionC25
                 BiomassDivisionC26
                 BiomassDivisionC27
                 BiomassDivisionC28
                 BiomassDivisionC29
                 BiomassDivisionC30
                 BiomassDivisionC31
                 ;

*
* First calculating the biomass made available at the farm gate by the farm and tagging it to the
* availiability date as done for the storage constraints
*
*------------------------------------------------------------------------
* Constraints related to harvested biomass
*------------------------------------------------------------------------


BiomassDivisionC1(HarvestingHorizonAggregation,CountySelected,FarmNumber)..
         Par_HarvestToFarmGate(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         =g=
         HarvestFarmGateRefineryBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         +
         HarvestFarmGateRegionalBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         +
         HarvestFarmGateDirectPurchaseBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         +
         sum(CentralizedStorageLocations$(CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
                 ),
                 HarvestFarmGateCentralStorageBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations)
         )
         +
          sum(CentralizedStorageSmallScaleLocations$(CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations)
                                                 and FarmStorageLocationCorrelationSmallScale(FarmNumber,CentralizedStorageSmallScaleLocations)
                                                 ),
                                                 HarvestFarmGateCentralStorageSmallScaleBiomass(HarvestingHorizonAggregation2,CountySelected,
                                                         FarmNumber,CentralizedStorageSmallScaleLocations)
          );

*------------------------------------------------------------------------
* Constraints for biomass made available from the farm covered storage
*------------------------------------------------------------------------

BiomassDivisionC2(HarvestingHorizonAggregation,CountySelected,FarmNumber)..
         Par_FarmCoveredStorageToFarmGate(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         =g=
         FarmCoveredStorageFarmGateRefineryBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         +
         FarmCoveredStorageFarmGateRegionalBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         +
         FarmCoveredStorageFarmGateDirectPurchaseBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
*         sum(CentralizedStorageLocations$(CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations)
*                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
*                 ),
*                 FarmCoveredStorageFarmGateCentralStorageBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations)
*         )
         ;


*------------------------------------------------------------------------
* Constraints for biomass made available from the farm open storage
*------------------------------------------------------------------------

BiomassDivisionC3(HarvestingHorizonAggregation,CountySelected,FarmNumber)..
         Par_FarmOpenStorageToFarmGate(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         =g=
         FarmOpenStorageFarmGateRefineryBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         +
         FarmOpenStorageFarmGateRegionalBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         +
         FarmOpenStorageFarmGateDirectPurchaseBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
*         sum(CentralizedStorageLocations$(CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations)
*                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
*                 ),
*                 FarmOpenStorageFarmGateCentralStorageBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations)
*         )
         ;


*##############################################################################################################
* Constraints for the non-harvesting horizon
*##############################################################################################################

*------------------------------------------------------------------------
* Constraints for biomass made available from the farm covered storage
*------------------------------------------------------------------------

BiomassDivisionC4(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)..
         Par_FarmCoveredStorageToFarmGate(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
         =g=
         FarmCoveredStorageFarmGateRefineryBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
         + FarmCoveredStorageFarmGateRegionalBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber);

*------------------------------------------------------------------------
* Constraints for biomass made available from the farm open storage
*------------------------------------------------------------------------

BiomassDivisionC5(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)..
         Par_FarmOpenStorageToFarmGate(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
         =g=
         FarmOpenStorageFarmGateRefineryBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
         + FarmOpenStorageFarmGateRegionalBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber);


*-------------------------------------------------------------------------------------------------------------
* Constraints related to on-farm ensiling
*-------------------------------------------------------------------------------------------------------------
BiomassDivisionC6(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)..
         Par_EnsilingToFarmGate(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
         =g=
         EnsilingFarmGateRefineryBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber);


*########################################################################################################################
* Calculating the volumes of different streams after the division
*########################################################################################################################
*
* Harvest to refinery
*
BiomassDivisionC7(HarvestingHorizonAggregation,CountySelected,FarmNumber)$(Par_FarmPackingDensity(CountySelected,FarmNumber))..
         HarvestFarmGateRefineryBiomassVolume(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         =e=
         HarvestFarmGateRefineryBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         /Par_FarmPackingDensity(CountySelected,FarmNumber);

BiomassDivisionC8(HarvestingHorizonAggregation,CountySelected,FarmNumber)$(Par_FarmPackingDensity(CountySelected,FarmNumber))..
         HarvestFarmGateRegionalBiomassVolume(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         =e=
         HarvestFarmGateRegionalBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         /Par_FarmPackingDensity(CountySelected,FarmNumber);

BiomassDivisionC9(HarvestingHorizonAggregation,CountySelected,FarmNumber)$(Par_FarmPackingDensity(CountySelected,FarmNumber))..
         HarvestFarmGateDirectPurchaseBiomassVolume(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         =e=
         HarvestFarmGateDirectPurchaseBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         /Par_FarmPackingDensity(CountySelected,FarmNumber);

BiomassDivisionC10(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations)
         $(Par_FarmPackingDensity(CountySelected,FarmNumber) and CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
         )..
         HarvestFarmGateCentralStorageBiomassVolume(HarvestingHorizonAggregation,CountySelected,FarmNumber,
                         CentralizedStorageLocations)
         =e=
         HarvestFarmGateCentralStorageBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,
                                 CentralizedStorageLocations)
         /Par_FarmPackingDensity(CountySelected,FarmNumber);

BiomassDivisionConstraintC11(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations)
         $(Par_FarmPackingDensity(CountySelected,FarmNumber) and CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations)
                                                 and FarmStorageLocationSmallScaleCorrelation(FarmNumber,CentralizedStorageSmallScaleLocations)
         )..
         HarvestFarmGateCentralStorageSmallScaleBiomassVolume(HarvestingHorizonAggregation,CountySelected,FarmNumber,
                         CentralizedStorageSmallScaleLocations)
         =e=
         HarvestFarmGateCentralStorageSmallScaleBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,
                                 CentralizedStorageSmallScaleLocations)
         /Par_FarmPackingDensity(CountySelected,FarmNumber);
*
* Farm Open Storage To refinery
*
BiomassDivisionC12(HarvestingHorizonAggregation,CountySelected,FarmNumber)$(Par_FarmPackingDensity(CountySelected,FarmNumber))..
         FarmOpenStorageFarmGateRefineryBiomassVolume(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         =e=
         FarmOpenStorageFarmGateRefineryBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         /Par_FarmPackingDensity(CountySelected,FarmNumber);

BiomassDivisionC13(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)$(Par_FarmPackingDensity(CountySelected,FarmNumber))..
         FarmOpenStorageFarmGateRefineryBiomassVolume(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
         =e=
         FarmOpenStorageFarmGateRefineryBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
         /Par_FarmPackingDensity(CountySelected,FarmNumber);

BiomassDivisionC14(HarvestingHorizonAggregation,CountySelected,FarmNumber)$(Par_FarmPackingDensity(CountySelected,FarmNumber))..
         FarmOpenStorageFarmGateRegionalBiomassVolume(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         =e=
         FarmOpenStorageFarmGateRegionalBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         /Par_FarmPackingDensity(CountySelected,FarmNumber);

BiomassDivisionC15(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)$(Par_FarmPackingDensity(CountySelected,FarmNumber))..
         FarmOpenStorageFarmGateRegionalBiomassVolume(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
         =e=
         FarmOpenStorageFarmGateRegionalBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
         /Par_FarmPackingDensity(CountySelected,FarmNumber);

BiomassDivisionC16(HarvestingHorizonAggregation,CountySelected,FarmNumber)$(Par_FarmPackingDensity(CountySelected,FarmNumber))..
         FarmOpenStorageFarmGateDirectPurchaseBiomassVolume(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         =e=
         FarmOpenStorageFarmGateDirectPurchaseBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         /Par_FarmPackingDensity(CountySelected,FarmNumber);

BiomassDivisionC17(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)$(Par_FarmPackingDensity(CountySelected,FarmNumber))..
         FarmOpenStorageFarmGateDirectPurchaseBiomassVolume(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
         =e=
         FarmOpenStorageFarmGateDirectPurchaseBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
         /Par_FarmPackingDensity(CountySelected,FarmNumber);

*
* Farm Covered Storage To refinery
*
BiomassDivisionC18(HarvestingHorizonAggregation,CountySelected,FarmNumber)$(Par_FarmPackingDensity(CountySelected,FarmNumber))..
         FarmCoveredStorageFarmGateRefineryBiomassVolume(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         =e=
         FarmCoveredStorageFarmGateRefineryBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         /Par_FarmPackingDensity(CountySelected,FarmNumber);

BiomassDivisionC19(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)$(Par_FarmPackingDensity(CountySelected,FarmNumber))..
         FarmCoveredStorageFarmGateRefineryBiomassVolume(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
         =e=
         FarmCoveredStorageFarmGateRefineryBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
         /Par_FarmPackingDensity(CountySelected,FarmNumber);

BiomassDivisionC20(HarvestingHorizonAggregation,CountySelected,FarmNumber)$(Par_FarmPackingDensity(CountySelected,FarmNumber))..
         FarmCoveredStorageFarmGateRegionalBiomassVolume(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         =e=
         FarmCoveredStorageFarmGateRegionalBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         /Par_FarmPackingDensity(CountySelected,FarmNumber);

BiomassDivisionC21(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)$(Par_FarmPackingDensity(CountySelected,FarmNumber))..
         FarmCoveredStorageFarmGateRegionalBiomassVolume(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
         =e=
         FarmCoveredStorageFarmGateRegionalBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
         /Par_FarmPackingDensity(CountySelected,FarmNumber);

BiomassDivisionC22(HarvestingHorizonAggregation,CountySelected,FarmNumber)$(Par_FarmPackingDensity(CountySelected,FarmNumber))..
         FarmCoveredStorageFarmGateDirectPurchaseBiomassVolume(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         =e=
         FarmCoveredStorageFarmGateDirectPurchaseBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
         /Par_FarmPackingDensity(CountySelected,FarmNumber);

BiomassDivisionC23(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)$(Par_FarmPackingDensity(CountySelected,FarmNumber))..
         FarmCoveredStorageFarmGateDirectPurchaseBiomassVolume(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
         =e=
         FarmCoveredStorageFarmGateDirectPurchaseBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
         /Par_FarmPackingDensity(CountySelected,FarmNumber);

*
* Farm Silage pit to refinery
*
BiomassDivisionC24(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)..
         EnsilingFarmGateRefineryBiomassVolume(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
         =e=
         EnsilingFarmGateRefineryBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)
         /
         EnsilingBulkDensity;



BiomassDivisionC25(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)..
         HarvestFarmGateRefineryBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)=e=0;

BiomassDivisionC26(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)..
         HarvestFarmGateRegionalBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)=e=0;

BiomassDivisionC27(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)..
         HarvestFarmGateDirectPurchaseBiomass(NonHarvestingHorizonAggregation,CountySelected,FarmNumber)=e=0;

*##############################################################################
* Additional constraint to reflect movement of biomass from farm storage to centralized storage during the harvesting horizon
*
BiomassDivisionC28(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations)
         $(Par_FarmPackingDensity(CountySelected,FarmNumber) and CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
         )..
         FarmOpenStorageFarmGateCentralStorageBiomassVolume(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations)
         =e=
         FarmOpenStorageFarmGateCentralStorageBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations)
         /Par_FarmPackingDensity(CountySelected,FarmNumber);

BiomassDivisionC29(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations)
         $(Par_FarmPackingDensity(CountySelected,FarmNumber) and CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations)
                                                 and FarmStorageLocationSmallScaleCorrelation(FarmNumber,CentralizedStorageSmallScaleLocations)
         )..
         FarmOpenStorageFarmGateCentralStorageSmallScaleBiomassVolume(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations)
         =e=
         FarmOpenStorageFarmGateCentralStorageSmallScaleBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations)
         /Par_FarmPackingDensity(CountySelected,FarmNumber);

*
* Farm Covered Storage To refinery
*
BiomassDivisionC30(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations)
         $(Par_FarmPackingDensity(CountySelected,FarmNumber) and CountyStorageLocationCorrelation(CountySelected,CentralizedStorageLocations)
                                                 and FarmStorageLocationCorrelation(FarmNumber,CentralizedStorageLocations)
         )..
         FarmCoveredStorageFarmGateCentralStorageBiomassVolume(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations)
         =e=
         FarmCoveredStorageFarmGateCentralStorageBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations)
         /Par_FarmPackingDensity(CountySelected,FarmNumber);

BiomassDivisionC31(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations)
         $(Par_FarmPackingDensity(CountySelected,FarmNumber) and CountyStorageLocationCorrelationSmallScale(CountySelected,CentralizedStorageSmallScaleLocations)
                                                 and FarmStorageLocationCorrelationSmallScale(FarmNumber,CentralizedStorageSmallScaleLocations)
         )..
         FarmCoveredStorageFarmGateCentralStorageSmallScaleBiomassVolume(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations)
         =e=
         FarmCoveredStorageFarmGateCentralStorageSmallScaleBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations)
         /Par_FarmPackingDensity(CountySelected,FarmNumber);


*=================================================================================================================================================
* Constraints that limit which biomass (in which physical form) can be sent to the refinery and which cannot. These constraints are used
* to model a test scenario and generally are not included in the model.
*=================================================================================================================================================
BiomassDivisionC32(HarvestingHorizonAggregation,CountySelected,FarmNumber)$(Par_FarmGrinderSelection(CountySelected,FarmNumber,'Tub_Grinder'))..
         sum(CentralizedStorageLocations,
                 HarvestFarmGateCentralStorageBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations)
                 + FarmCoveredStorageFarmGateCentralStorageBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations)
                 + FarmOpenStorageFarmGateCentralStorageBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageLocations)
         )
         =l=
         0;

BiomassDivisionC33(HarvestingHorizonAggregation,CountySelected,FarmNumber)$(Par_FarmGrinderSelection(CountySelected,FarmNumber,'Tub_Grinder'))..
         sum(CentralizedStorageSmallScaleLocations,
                 HarvestFarmGateCentralStorageSmallScaleBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations)
                 + FarmCoveredStorageFarmGateCentralStorageSmallScaleBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations)
                 + FarmOpenStorageFarmGateCentralStorageSmallScaleBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber,CentralizedStorageSmallScaleLocations)
         )
         =l=
         0;


BiomassDivisionC34(HarvestingHorizonAggregation,CountySelected,FarmNumber)$(sum(BalerTypes,Par_FarmBalerSelection(CountySelected,FarmNumber,BalerTypes)))..
                 HarvestFarmGateRefineryBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                 + HarvestFarmGateRegionalBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                 + HarvestFarmGateDirectPurchaseBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                 + FarmCoveredStorageFarmGateRefineryBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                 + FarmOpenStorageFarmGateRefineryBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                 + FarmCoveredStorageFarmGateRegionalBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                 + FarmOpenStorageFarmGateRegionalBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                 + FarmCoveredStorageFarmGateDirectPurchaseBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                 + FarmOpenStorageFarmGateDirectPurchaseBiomass(HarvestingHorizonAggregation,CountySelected,FarmNumber)
                 =l=
                 0;


Model FarmGateBiomassDistributionModelConstrained /
                 BiomassDivisionC1
                 BiomassDivisionC2
                 BiomassDivisionC3
                 BiomassDivisionC4
                 BiomassDivisionC5
                 BiomassDivisionC6
                 BiomassDivisionC7
                 BiomassDivisionC8
                 BiomassDivisionC9
                 BiomassDivisionC10
                 BiomassDivisionC11
                 BiomassDivisionC12
                 BiomassDivisionC13
                 BiomassDivisionC14
                 BiomassDivisionC15
                 BiomassDivisionC16

*                 BiomassDivisionC17
                 BiomassDivisionC18
                 BiomassDivisionC19
                 BiomassDivisionC20
                 BiomassDivisionC21
                 BiomassDivisionC22
*                 BiomassDivisionC23
                 BiomassDivisionC24
                 BiomassDivisionC25
                 BiomassDivisionC26
                 BiomassDivisionC27
                 BiomassDivisionC28
                 BiomassDivisionC29

                 BiomassDivisionC30
                 BiomassDivisionC31
*                 BiomassDivisionC32
*                 BiomassDivisionC33
*                 BiomassDivisionC34
                 /;
