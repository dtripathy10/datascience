$title the file that includes constraints for private traders

Equations
         PrivateTraderBalance1
         PrivateTraderBalance2
         PrivateTraderBalance3
         PrivateTraderBalance4
         PrivateTraderBalance5
         PrivateTraderBalance6
         PrivateTraderBalance7
         ;


PrivateTraderBalance1(HarvestingHorizonAggregation)..
                 PrivateTraderPurchaseTotal(HarvestingHorizonAggregation)
                 =e=
                 sum(LocalMarketSet, LocalMarketPrivateTraderGrain(HarvestingHorizonAggregation,LocalMarketSet))
                 +
                 sum(RegionalMarketSet,RegionalMarketPrivateTraderGrain(HarvestingHorizonAggregation,RegionalMarketSet));

PrivateTraderBalance2(NonHarvestingHorizonAggregation)..
                 PrivateTraderPurchaseTotal(NonHarvestingHorizonAggregation)
                 =e=
                 sum(LocalMarketSet, LocalMarketPrivateTraderGrain(NonHarvestingHorizonAggregation,LocalMarketSet))
                 +
                 sum(RegionalMarketSet,RegionalMarketPrivateTraderGrain(NonHarvestingHorizonAggregation,RegionalMarketSet));


PrivateTraderBalance3(HarvestingHorizonAggregation,LocalMarketSet)..
                       LocalMarketPrivateTraderGrain(HarvestingHorizonAggregation,LocalMarketSet)
                       =e=
                       sum(RGYSet,LocalMarketPrivateTraderRGYGrain(HarvestingHorizonAggregation,LocalMarketSet,RGYSet))
                       +
                       sum(RetailerSet,LocalMarketPrivateTraderRetailerGrain(HarvestingHorizonAggregation,LocalMarketSet,RetailerSet))
                       ;

PrivateTraderBalance4(NonHarvestingHorizonAggregation,LocalMarketSet)..
                       LocalMarketPrivateTraderGrain(NonHarvestingHorizonAggregation,LocalMarketSet)
                       =e=
                       sum(RGYSet,LocalMarketPrivateTraderRGYGrain(NonHarvestingHorizonAggregation,LocalMarketSet,RGYSet))
                       +
                       sum(RetailerSet,LocalMarketPrivateTraderRetailerGrain(NonHarvestingHorizonAggregation,LocalMarketSet,RetailerSet))
                       ;

PrivateTraderBalance5(HarvestingHorizonAggregation,RegionalMarketSet)..
                       RegionalMarketPrivateTraderGrain(HarvestingHorizonAggregation,RegionalMarketSet)
                       =e=
                       sum(RGYSet,RegionalMarketPrivateTraderRGYGrain(HarvestingHorizonAggregation,RegionalMarketSet,RGYSet))
                       +
                       sum(RetailerSet,RegionalMarketPrivateTraderRetailerGrain(HarvestingHorizonAggregation,RegionalMarketSet,RetailerSet))
                       ;

PrivateTraderBalance6(NonHarvestingHorizonAggregation,RegionalMarketSet)..
                       RegionalMarketPrivateTraderGrain(NonHarvestingHorizonAggregation,RegionalMarketSet)
                       =e=
                       sum(RGYSet,RegionalMarketPrivateTraderRGYGrain(NonHarvestingHorizonAggregation,RegionalMarketSet,RGYSet))
                       +
                       sum(RetailerSet,RegionalMarketPrivateTraderRetailerGrain(NonHarvestingHorizonAggregation,RegionalMarketSet,RetailerSet))
                       ;

PrivateTraderBalance7..
                         sum((HarvestingHorizonAggregation,LocalMarketSet,RetailerSet),LocalMarketPrivateTraderRetailerGrain(HarvestingHorizonAggregation,LocalMarketSet,RetailerSet))
                         +
                         sum((NonHarvestingHorizonAggregation,LocalMarketSet,RetailerSet),LocalMarketPrivateTraderRetailerGrain(NonHarvestingHorizonAggregation,LocalMarketSet,RetailerSet))
                         +
                         sum((HarvestingHorizonAggregation,RegionalMarketSet,RetailerSet),RegionalMarketPrivateTraderRetailerGrain(HarvestingHorizonAggregation,RegionalMarketSet,RetailerSet))
                         +
                         sum((NonHarvestingHorizonAggregation,RegionalMarketSet,RetailerSet),RegionalMarketPrivateTraderRetailerGrain(NonHarvestingHorizonAggregation,RegionalMarketSet,RetailerSet))
                         =g=
                         0;



Model PrivateTraderModel/
         PrivateTraderBalance1
         PrivateTraderBalance2
         PrivateTraderBalance3
         PrivateTraderBalance4
         PrivateTraderBalance5
         PrivateTraderBalance6
         PrivateTraderBalance7
         /;


$ontext
PrivateTraderBalance3(HarvestingHorizonAggregation)..
                       PrivateTraderPurchaseTotal(HarvestingHorizonAggregation)
                       =e=
                       sum(RGYSet,PrivateTraderRGYGrain(HarvestingHorizonAggregation,RGYSet))
                       +
                       sum(RetailerSet,PrivateTraderRetailerGrain(HarvestingHorizonAggregation,RetailerSet))
                       ;

PrivateTraderBalance4(NonHarvestingHorizonAggregation)..
                       PrivateTraderPurchaseTotal(NonHarvestingHorizonAggregation)
                       =e=
                       sum(RGYSet,PrivateTraderRGYGrain(NonHarvestingHorizonAggregation,RGYSet))
                       +
                       sum(RetailerSet,PrivateTraderRetailerGrain(NonHarvestingHorizonAggregation,RetailerSet))
                       ;

PrivateTraderBalance5..
                         sum((NonHarvestingHorizonAggregation,RetailerSet),PrivateTraderRetailerGrain(NonHarvestingHorizonAggregation,RetailerSet))
                         +
                         sum((HarvestingHorizonAggregation,RetailerSet),PrivateTraderRetailerGrain(HarvestingHorizonAggregation,RetailerSet))
                         =g=
                         0;
$offtext
