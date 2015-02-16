Positive variables
  FCIPurchase
  ;
  
Equations
  FCIBalance1
  FCIBalance2
  FCIBalance3
  FCIBalance4
  FCIBalance5
  FCIBalance6
  FCIBalance7
  FCIBalance8
  FCIBalance9
  FCIBalance10
  FCIBalance11
  FCIBalance12
  FCIBalance13
  FCIBalance14
  FCIBalance15
  FCIBalance16
  FCIBalance17
  FCIBalance18
  FCIBalance19
  FCIBalance20
  FCIBalance21
  FCIBalance22

  FCIBalance23
  FCIBalance24
  ;
* #########################################################################################################################
* FCI total purchase

FCIBalance23(HarvestingHorizonAggregation,FCIGodownSet)..
  FCIPurchase(HarvestingHorizonAggregation,FCIGodownSet)
  =e=
  sum(RegionalMarketSet,RegionalMarketFCIGrain(HarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet))
  ;

FCIBalance24(NonHarvestingHorizonAggregation,FCIGodownSet)..
  FCIPurchase(NonHarvestingHorizonAggregation,FCIGodownSet)
  =e=
  sum(RegionalMarketSet,RegionalMarketFCIGrain(NonHarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet))
  ;

* #########################################################################################################################
* First calculating the total input to the FCI excluded the loss due to transportaion

FCIBalance1(HarvestingHorizonAggregation,FCIGodownSet)..
  FCIInput(HarvestingHorizonAggregation,FCIGodownSet)
  =e=
  sum(RegionalMarketSet,RegionalMarketFCIGrain(HarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet))
  *(1-TransportationDryMatterLossRate)
  ;

FCIBalance2(NonHarvestingHorizonAggregation,FCIGodownSet)..
  FCIInput(NonHarvestingHorizonAggregation,FCIGodownSet)
  =e=
  sum(RegionalMarketSet,RegionalMarketFCIGrain(NonHarvestingHorizonAggregation,RegionalMarketSet,FCIGodownSet))
  *(1-TransportationDryMatterLossRate)
  ;
*##########################################################################################################################
FCIBalance3(HarvestingHorizonAggregation,FCIGodownSet)..
  FCIInput(HarvestingHorizonAggregation,FCIGodownSet)
  =e=
  FCICAPStorageInput(HarvestingHorizonAggregation,FCIGodownSet)
  +
  FCICoveredStorageInput(HarvestingHorizonAggregation,FCIGodownSet)
  ;

FCIBalance4(NonHarvestingHorizonAggregation,FCIGodownSet)..
  FCIInput(NonHarvestingHorizonAggregation,FCIGodownSet)
  =e=
  FCICAPStorageInput(NonHarvestingHorizonAggregation,FCIGodownSet)
  +
  FCICoveredStorageInput(NonHarvestingHorizonAggregation,FCIGodownSet)
  ;

*##########################################################################################################################

*===============================================================================================
* Doing the accounting for the FCI storage facility for biomass stored in buildings (covered)
*===============================================================================================
FCIBalance5(HarvestingHorizonAggregation,FCIGodownSet)..
  FCICoveredStoredGrain(HarvestingHorizonAggregation,FCIGodownSet)
  =e=
  sum(HarvestingHorizonAggregation2
     $(ord(HarvestingHorizonAggregation2)=ord(HarvestingHorizonAggregation)-1),
     FCICoveredStoredGrain(HarvestingHorizonAggregation2,FCIGodownSet)
  -
  sum(MillerSet,FCICoveredMillerGrain(HarvestingHorizonAggregation2,FCIGodownSet,MillerSet))
  *card(HarvestingHorizonAggregationStep)
  -
  sum(RetailerSet,FCICoveredRetailerGrain(HarvestingHorizonAggregation2,FCIGodownSet,RetailerSet))
  *card(HarvestingHorizonAggregationStep)
  -
  sum(PDSSet,FCICoveredPDSGrain(HarvestingHorizonAggregation2,FCIGodownSet,PDSSet))
  *card(HarvestingHorizonAggregationStep)
  )*(1-(FCIGodownCoveredLossRate)*card(HarvestingHorizonAggregationStep)/30)
  +
  FCICoveredStorageInput(HarvestingHorizonAggregation,FCIGodownSet)
  *card(HarvestingHorizonAggregationStep)
  ;

FCIBalance6(HarvestingHorizonAggregation,FCIGodownSet)..
  sum(MillerSet,FCICoveredMillerGrain(HarvestingHorizonAggregation,FCIGodownSet,MillerSet))
  *card(HarvestingHorizonAggregationStep)
  +
  sum(RetailerSet,FCICoveredRetailerGrain(HarvestingHorizonAggregation,FCIGodownSet,RetailerSet))
  *card(HarvestingHorizonAggregationStep)
  +
  sum(PDSSet,FCICoveredPDSGrain(HarvestingHorizonAggregation,FCIGodownSet,PDSSet))
  *card(HarvestingHorizonAggregationStep)
  =l=
  FCICoveredStoredGrain(HarvestingHorizonAggregation,FCIGodownSet);


FCIBalance7(NonHarvestingHorizonAggregation,FCIGodownSet)$(ord(NonHarvestingHorizonAggregation)=1)..
  FCICoveredStoredGrain(NonHarvestingHorizonAggregation,FCIGodownSet)
  =e=
  sum(HarvestingHorizonAggregation
     $(ord(HarvestingHorizonAggregation)=card(HarvestingHorizonAggregation)),
     FCICoveredStoredGrain(HarvestingHorizonAggregation,FCIGodownSet)
     -
     sum(MillerSet,FCICoveredMillerGrain(HarvestingHorizonAggregation,FCIGodownSet,MillerSet))
     *card(HarvestingHorizonAggregationStep)
     -
     sum(RetailerSet,FCICoveredRetailerGrain(HarvestingHorizonAggregation,FCIGodownSet,RetailerSet))
     *card(HarvestingHorizonAggregationStep)
     -
     sum(PDSSet,FCICoveredPDSGrain(HarvestingHorizonAggregation,FCIGodownSet,PDSSet))
     *card(HarvestingHorizonAggregationStep)
  )*(1-(FCIGodownCoveredLossRate)*card(HarvestingHorizonAggregationStep)/30)
  +
  FCICoveredStorageInput(NonHarvestingHorizonAggregation,FCIGodownSet)
  *card(NonHarvestingHorizonAggregationStep)
  ;

FCIBalance8(NonHarvestingHorizonAggregation,FCIGodownSet)$(ord(NonHarvestingHorizonAggregation)>1)..
  FCICoveredStoredGrain(NonHarvestingHorizonAggregation,FCIGodownSet)
  =e=
  sum(NonHarvestingHorizonAggregation2
     $(ord(NonHarvestingHorizonAggregation2)=ord(NonHarvestingHorizonAggregation)-1),
     FCICoveredStoredGrain(NonHarvestingHorizonAggregation2,FCIGodownSet)
     -
     sum(MillerSet,FCICoveredMillerGrain(NonHarvestingHorizonAggregation2,FCIGodownSet,MillerSet))
     *card(NonHarvestingHorizonAggregationStep)
     -
     sum(RetailerSet,FCICoveredRetailerGrain(NonHarvestingHorizonAggregation2,FCIGodownSet,RetailerSet))
     *card(NonHarvestingHorizonAggregationStep)
     -
     sum(PDSSet,FCICoveredPDSGrain(NonHarvestingHorizonAggregation2,FCIGodownSet,PDSSet))
     *card(NonHarvestingHorizonAggregationStep)
  )*(1-(FCIGodownCoveredLossRate)*card(NonHarvestingHorizonAggregationStep)/30)
  +
  FCICoveredStorageInput(NonHarvestingHorizonAggregation,FCIGodownSet)
  *card(NonHarvestingHorizonAggregationStep)
  ;

FCIBalance9(NonHarvestingHorizonAggregation,FCIGodownSet)..
  sum(MillerSet,FCICoveredMillerGrain(NonHarvestingHorizonAggregation,FCIGodownSet,MillerSet))
  *card(NonHarvestingHorizonAggregationStep)
  +
  sum(RetailerSet,FCICoveredRetailerGrain(NonHarvestingHorizonAggregation,FCIGodownSet,RetailerSet))
  *card(NonHarvestingHorizonAggregationStep)
  +
  sum(PDSSet,FCICoveredPDSGrain(NonHarvestingHorizonAggregation,FCIGodownSet,PDSSet))
  *card(NonHarvestingHorizonAggregationStep)
  =l=
  FCICoveredStoredGrain(NonHarvestingHorizonAggregation,FCIGodownSet)
  ;


FCIBalance10(HarvestingHorizonAggregation,FCIGodownSet)..
  FCICoveredStoredGrain(HarvestingHorizonAggregation,FCIGodownSet)
  =l=
  FCICoveredCapacity(FCIGodownSet)
  ;

FCIBalance11(NonHarvestingHorizonAggregation,FCIGodownSet)..
  FCICoveredStoredGrain(NonHarvestingHorizonAggregation,FCIGodownSet)
  =l=
  FCICoveredCapacity(FCIGodownSet)
  ;

*================================================================================================
* Doing the accounting for the FCI storage facility for biomass stored in open using Cover and Plinth (CAP) method
*================================================================================================
FCIBalance12(HarvestingHorizonAggregation,FCIGodownSet)..
  FCICAPStoredGrain(HarvestingHorizonAggregation,FCIGodownSet)
  =e=
  sum(HarvestingHorizonAggregation2
     $(ord(HarvestingHorizonAggregation2)=ord(HarvestingHorizonAggregation)-1),
     FCICAPStoredGrain(HarvestingHorizonAggregation2,FCIGodownSet)
  -
  sum(MillerSet,FCICAPMillerGrain(HarvestingHorizonAggregation2,FCIGodownSet,MillerSet))
  *card(HarvestingHorizonAggregationStep)
  -
  sum(RetailerSet,FCICAPRetailerGrain(HarvestingHorizonAggregation2,FCIGodownSet,RetailerSet))
  *card(HarvestingHorizonAggregationStep)
  -
  sum(PDSSet,FCICAPPDSGrain(HarvestingHorizonAggregation2,FCIGodownSet,PDSSet))
  *card(HarvestingHorizonAggregationStep)
  )*(1-(FCIGodownCAPLossRate)*card(HarvestingHorizonAggregationStep)/30)
  +
  FCICAPStorageInput(HarvestingHorizonAggregation,FCIGodownSet)
  *card(HarvestingHorizonAggregationStep)
  ;

FCIBalance13(HarvestingHorizonAggregation,FCIGodownSet)..
  sum(MillerSet,FCICAPMillerGrain(HarvestingHorizonAggregation,FCIGodownSet,MillerSet))
  *card(HarvestingHorizonAggregationStep)
  +
  sum(RetailerSet,FCICAPRetailerGrain(HarvestingHorizonAggregation,FCIGodownSet,RetailerSet))
  *card(HarvestingHorizonAggregationStep)
  +
  sum(PDSSet,FCICAPPDSGrain(HarvestingHorizonAggregation,FCIGodownSet,PDSSet))
  *card(HarvestingHorizonAggregationStep)
  =l=
  FCICAPStoredGrain(HarvestingHorizonAggregation,FCIGodownSet);


FCIBalance14(NonHarvestingHorizonAggregation,FCIGodownSet)$(ord(NonHarvestingHorizonAggregation)=1)..
  FCICAPStoredGrain(NonHarvestingHorizonAggregation,FCIGodownSet)
  =e=
  sum(HarvestingHorizonAggregation
     $(ord(HarvestingHorizonAggregation)=card(HarvestingHorizonAggregation)),
     FCICAPStoredGrain(HarvestingHorizonAggregation,FCIGodownSet)
     -
     sum(MillerSet,FCICAPMillerGrain(HarvestingHorizonAggregation,FCIGodownSet,MillerSet))
     *card(HarvestingHorizonAggregationStep)
     -
     sum(RetailerSet,FCICAPRetailerGrain(HarvestingHorizonAggregation,FCIGodownSet,RetailerSet))
     *card(HarvestingHorizonAggregationStep)
     -
     sum(PDSSet,FCICAPPDSGrain(HarvestingHorizonAggregation,FCIGodownSet,PDSSet))
     *card(HarvestingHorizonAggregationStep)
  )*(1-(FCIGodownCAPLossRate)*card(HarvestingHorizonAggregationStep)/30)
  +
  FCICAPStorageInput(NonHarvestingHorizonAggregation,FCIGodownSet)
  *card(NonHarvestingHorizonAggregationStep)
  ;

FCIBalance15(NonHarvestingHorizonAggregation,FCIGodownSet)$(ord(NonHarvestingHorizonAggregation)>1)..
  FCICAPStoredGrain(NonHarvestingHorizonAggregation,FCIGodownSet)
  =e=
  sum(NonHarvestingHorizonAggregation2
     $(ord(NonHarvestingHorizonAggregation2)=ord(NonHarvestingHorizonAggregation)-1),
     FCICAPStoredGrain(NonHarvestingHorizonAggregation2,FCIGodownSet)
     -
     sum(MillerSet,FCICAPMillerGrain(NonHarvestingHorizonAggregation2,FCIGodownSet,MillerSet))
     *card(NonHarvestingHorizonAggregationStep)
     -
     sum(RetailerSet,FCICAPRetailerGrain(NonHarvestingHorizonAggregation2,FCIGodownSet,RetailerSet))
     *card(NonHarvestingHorizonAggregationStep)
     -
     sum(PDSSet,FCICAPPDSGrain(NonHarvestingHorizonAggregation2,FCIGodownSet,PDSSet))
     *card(NonHarvestingHorizonAggregationStep)
  )*(1-(FCIGodownCAPLossRate)*card(NonHarvestingHorizonAggregationStep)/30)
  +
  FCICAPStorageInput(NonHarvestingHorizonAggregation,FCIGodownSet)
  *card(NonHarvestingHorizonAggregationStep)
  ;


FCIBalance16(NonHarvestingHorizonAggregation,FCIGodownSet)..
  sum(MillerSet,FCICAPMillerGrain(NonHarvestingHorizonAggregation,FCIGodownSet,MillerSet))
  *card(NonHarvestingHorizonAggregationStep)
  +
  sum(RetailerSet,FCICAPRetailerGrain(NonHarvestingHorizonAggregation,FCIGodownSet,RetailerSet))
  *card(NonHarvestingHorizonAggregationStep)
  +
  sum(PDSSet,FCICAPPDSGrain(NonHarvestingHorizonAggregation,FCIGodownSet,PDSSet))
  *card(NonHarvestingHorizonAggregationStep)
  =l=
  FCICAPStoredGrain(NonHarvestingHorizonAggregation,FCIGodownSet)
  ;


FCIBalance17(HarvestingHorizonAggregation,FCIGodownSet)..
  FCICAPStoredGrain(HarvestingHorizonAggregation,FCIGodownSet)
  =l=
  FCICAPCapacity(FCIGodownSet)
  ;

FCIBalance18(NonHarvestingHorizonAggregation,FCIGodownSet)..
  FCICAPStoredGrain(NonHarvestingHorizonAggregation,FCIGodownSet)
  =l=
  FCICAPCapacity(FCIGodownSet)
  ;
*================================================================================================

FCIBalance19(FCIGodownSet)..    
  FCICAPCapacity(FCIGodownSet) + FCICoveredCapacity(FCIGodownSet) =l= FCI_Max(FCIGodownSet)
  ;

FCIBalance20(FCIGodownSet)..    
  FCISelector(FCIGodownSet) =g= (FCICAPCapacity(FCIGodownSet) + FCICoveredCapacity(FCIGodownSet))/FCI_Max(FCIGodownSet)
  ;

FCIBalance21(FCIGodownSet)..    
  FCICAPCapacity(FCIGodownSet) + FCICoveredCapacity(FCIGodownSet) =g= FCISelector(FCIGodownSet)*FCI_Min(FCIGodownSet)
  ;


FCIBalance22.. 
  sum((HarvestingHorizonAggregation,FCIGodownSet), FCICAPStorageInput(HarvestingHorizonAggregation,FCIGodownSet))
    +  sum((NonHarvestingHorizonAggregation,FCIGodownSet), FCICAPStorageInput(NonHarvestingHorizonAggregation,FCIGodownSet)) =g= 0
  ;

Model FCIModel /
  FCIBalance1
  FCIBalance2
  FCIBalance3
  FCIBalance4
  FCIBalance5
  FCIBalance6
  FCIBalance7
  FCIBalance8
  FCIBalance9
  FCIBalance10
  FCIBalance11
  FCIBalance12
  FCIBalance13
  FCIBalance14
  FCIBalance15
  FCIBalance16
  FCIBalance17
  FCIBalance18
  FCIBalance19
  FCIBalance20
  FCIBalance21
  FCIBalance22

  FCIBalance23
  FCIBalance24
  /;
