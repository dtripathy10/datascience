Parameter BiomassInput Biomass growth model data (biomass in tons and moisture content)
          MinimumPlantMoisture Minimum moisture of the plant resulting from natural drying
          BiomassSupply(SimulationHorizon) Standing biomass in dry tons per acre during each day of the simulation horizon
          BiomassMoisture(SimulationHorizon) Moisture content of biomass in fraction
          BiomassSupplyAggregation(HarvestingHorizonAggregation) Standing biomass in dry tons per acre aggregated for each simulation step (multiple years)
          HarvestedBiomassMoisture Parameter to store the moisture of the harvested biomass (later used to quantify the moisture related costs)
          AverageBiomassYield The average biomass yield per unit area (square kilometeres);


Table  BiomassInput Data input related to biomass suppy in dry Mg per hectare and moisture content in fraction

          Supply       Moisture
1         12           0.6
2         11.96        0.597
3         11.92        0.594
4         11.88        0.591
5         11.84        0.588
6         11.8         0.585
7         11.76        0.582
8         11.72        0.579
9         11.68        0.576
10        11.64        0.573
11        11.6         0.57
12        11.56        0.567
13        11.52        0.564
14        11.48        0.561
15        11.44        0.558
16        11.4         0.555
17        11.36        0.552
18        11.32        0.549
19        11.28        0.546
20        11.24        0.543
21        11.2         0.54
22        11.16        0.537
23        11.12        0.534
24        11.08        0.531
25        11.04        0.528
26        11           0.525
27        10.96        0.522
28        10.92        0.519
29        10.88        0.516
30        10.84        0.513
31        10.8         0.51
32        10.76        0.507
33        10.72        0.504
34        10.68        0.501
35        10.64        0.498
36        10.6         0.495
37        10.56        0.492
38        10.52        0.489
39        10.48        0.486
40        10.44        0.483
41        10.4         0.48
42        10.36        0.477
43        10.32        0.474
44        10.28        0.471
45        10.24        0.468
46        10.2         0.465
47        10.16        0.462
48        10.12        0.459
49        10.08        0.456
50        10.04        0.453
51        10           0.45
52        9.96         0.447
53        9.92         0.444
54        9.88         0.441
55        9.84         0.438
56        9.8          0.435
57        9.76         0.432
58        9.72         0.429
59        9.68         0.426
60        9.64         0.423
61        9.6          0.42
62        9.56         0.417
63        9.52         0.414
64        9.48         0.411
65        9.44         0.408
66        9.4          0.405
67        9.36         0.402
68        9.32         0.399
69        9.28         0.396
70        9.24         0.393
71        9.2          0.39
72        9.16         0.387
73        9.12         0.384
74        9.08         0.381
75        9.04         0.378
76        9            0.375
77        8.96         0.372
78        8.92         0.369
79        8.88         0.366
80        8.84         0.363
81        8.8          0.36
82        8.76         0.357
83        8.72         0.354
84        8.68         0.351
85        8.64         0.348
86        8.6          0.345
87        8.56         0.342
88        8.52         0.339
89        8.48         0.336
90        8.44         0.333
91        8.4          0.33
92        8.36         0.327
93        8.32         0.324
94        8.28         0.321
95        8.24         0.318
96        8.2          0.315
97        8.16         0.312
98        8.12         0.309
99        8.08         0.306
100       8.04         0.303
101       8            0.3
102       7.96         0.297
103       7.92         0.294
104       7.88         0.291
105       7.84         0.288
106       7.8          0.285
107       7.76         0.282
108       7.72         0.279
109       7.68         0.276
110       7.64         0.273
111       7.6          0.27
112       7.56         0.267
113       7.52         0.264
114       7.48         0.261
115       7.44         0.258
116       7.4          0.255
117       7.36         0.252
118       7.32         0.249
119       7.28         0.246
120       7.24         0.243;


*##############################################################################################################
* Data manipulation and parameter computation: Calculation of parameters based on imported data
*##############################################################################################################
* Assigning the imported values to the appropriate paremeters
BiomassSupply(HarvestingHorizon)=BiomassInput(HarvestingHorizon,'Supply')/0.01;
* The factor of 0.01 is used to convert the biomass supply from Mg/hectare into Mg/square km
BiomassMoisture(HarvestingHorizon)=BiomassInput(HarvestingHorizon,'Moisture');
* Biomass supply and moisture value imported from ALMANAC model simulation

*##############################################################################################################
* Data manipulation to account for harvesting and nonharvesting horizon aggregation
*##############################################################################################################

BiomassSupplyAggregation(HarvestingHorizonAggregation)=sum(HarvestingHorizon $(ord(HarvestingHorizon)>=
                                                 (ord(HarvestingHorizonAggregation)-1)*card(HarvestingHorizonAggregationStep)+1
                                                  and
                                                  ord(HarvestingHorizon)<=ord(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep)
                                                 ),
                                                 BiomassSupply(HarvestingHorizon))
                                                 /
                                                 card(HarvestingHorizonAggregationStep);


MinimumPlantMoisture=smin(SimulationHorizon,BiomassMoisture(SimulationHorizon));

HarvestedBiomassMoisture(HarvestingHorizonAggregation)=sum(HarvestingHorizon $(ord(HarvestingHorizon)>=
                                                 (ord(HarvestingHorizonAggregation)-1)*card(HarvestingHorizonAggregationStep)+1
                                                  and
                                                  ord(HarvestingHorizon)<=ord(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep)
                                                 ),
                                                 BiomassMoisture(HarvestingHorizon))
                                                 /
                                                 card(HarvestingHorizonAggregationStep);

HarvestedBiomassMoisture(NonHarvestingHorizonAggregation)=smin(HarvestingHorizon, BiomassInput(HarvestingHorizon,'Moisture'));

AverageBiomassYield=sum(HarvestingHorizonAggregation,BiomassSupplyAggregation(HarvestingHorizonAggregation))/card(HarvestingHorizonAggregation);

*AverageBiomassYield=sum(HarvestingHorizonAggregation $(ord(HarvestingHorizonAggregation)=card(HarvestingHorizonAggregation)),BiomassSupplyAggregation(HarvestingHorizonAggregation));

*AverageBiomassYield=sum(HarvestingHorizonAggregation $(ord(HarvestingHorizonAggregation)=1),BiomassSupplyAggregation(HarvestingHorizonAggregation));

Display AverageBiomassYield;


Display  BiomassSupplyAggregation, HarvestedBiomassMoisture;




$ontext
Table  BiomassInput Data input related to biomass suppy in dry Mg per hectare and moisture content in fraction

          Supply       Moisture

1         23.8         0.42
2         23.73        0.417
3         23.66        0.414
4         23.59        0.411
5         23.52        0.408
6         23.45        0.405
7         23.38        0.402
8         23.31        0.399
9         23.24        0.396
10        23.17        0.393
11        23.1         0.39
12        23.03        0.387
13        22.96        0.384
14        22.89        0.381
15        22.82        0.378
16        22.75        0.375
17        22.68        0.372
18        22.61        0.369
19        22.54        0.366
20        22.47        0.363
21        22.4         0.36
22        22.33        0.357
23        22.26        0.354
24        22.19        0.351
25        22.12        0.348
26        22.05        0.345
27        21.98        0.342
28        21.91        0.339
29        21.84        0.336
30        21.77        0.333
31        21.7         0.33
32        21.63        0.327
33        21.56        0.324
34        21.49        0.321
35        21.42        0.318
36        21.35        0.315
37        21.28        0.312
38        21.21        0.309
39        21.14        0.306
40        21.07        0.303
41        21           0.3
42        20.93        0.297
43        20.86        0.294
44        20.79        0.291
45        20.72        0.288
46        20.65        0.285
47        20.58        0.282
48        20.51        0.279
49        20.44        0.276
50        20.37        0.273
51        20.3         0.27
52        20.23        0.267
53        20.16        0.264
54        20.09        0.261
55        20.02        0.258
56        19.95        0.255
57        19.88        0.252
58        19.81        0.249
59        19.74        0.246
60        19.67        0.243
61        19.6         0.24
62        19.53        0.237
63        19.46        0.234
64        19.39        0.231
65        19.32        0.228
66        19.25        0.225
67        19.18        0.222
68        19.11        0.219
69        19.04        0.216
70        18.97        0.213
71        18.9         0.21
72        18.83        0.207
73        18.76        0.204
74        18.69        0.201
75        18.62        0.198
76        18.55        0.195
77        18.48        0.192
78        18.41        0.189
79        18.34        0.186
80        18.27        0.183
81        18.2         0.18
82        18.13        0.177
83        18.06        0.174
84        17.99        0.171
85        17.92        0.168
86        17.85        0.165
87        17.78        0.162
88        17.71        0.159
89        17.64        0.156
90        17.57        0.153
91        17.5         0.15
92        17.43        0.15
93        17.36        0.15
94        17.29        0.15
95        17.22        0.15
96        17.15        0.15
97        17.08        0.15
98        17.01        0.15
99        16.94        0.15
100       16.87        0.15
101       16.8         0.15
102       16.73        0.15
103       16.66        0.15
104       16.59        0.15
105       16.52        0.15
106       16.45        0.15
107       16.38        0.15
108       16.31        0.15
109       16.24        0.15
110       16.17        0.15
111       16.1         0.15
112       16.03        0.15
113       15.96        0.15
114       15.89        0.15
115       15.82        0.15
116       15.75        0.15
117       15.68        0.15
118       15.61        0.15
119       15.54        0.15
120       15.47        0.15
121       15.4         0.15
122       15.33        0.15
123       15.26        0.15
124       15.19        0.15
125       15.12        0.15
126       15.05        0.15
127       14.98        0.15
128       14.91        0.15
129       14.84        0.15
130       14.77        0.15
131       14.7         0.15
132       14.63        0.15
133       14.56        0.15
134       14.49        0.15
135       14.42        0.15
136       14.35        0.15
137       14.28        0.15
138       14.21        0.15
139       14.14        0.15
140       14.07        0.15
141       14           0.15
142       13.93        0.15
143       13.86        0.15
144       13.79        0.15
145       13.72        0.15
146       13.65        0.15
147       13.58        0.15
148       13.51        0.15
149       13.44        0.15
150       13.37        0.15
151       13.3         0.15
152       13.23        0.15
153       13.16        0.15
154       13.09        0.15
155       13.02        0.15
156       12.95        0.15
157       12.88        0.15
158       12.81        0.15
159       12.74        0.15
160       12.67        0.15
161       12.6         0.15
162       12.53        0.15
163       12.46        0.15
164       12.39        0.15
165       12.32        0.15
166       12.25        0.15
167       12.18        0.15
168       12.11        0.15
169       12.04        0.15
170       11.97        0.15
171       11.9         0.15
172       11.83        0.15
173       11.76        0.15
174       11.69        0.15
175       11.62        0.15
176       11.55        0.15
177       11.48        0.15
178       11.41        0.15
179       11.34        0.15
180       11.27        0.15;


1         12           0.6
2         11.99        0.597
3         11.98        0.594
4         11.97        0.591
5         11.96        0.588
6         11.95        0.585
7         11.94        0.582
8         11.93        0.579
9         11.92        0.576
10        11.91        0.573
11        11.9         0.57
12        11.89        0.567
13        11.88        0.564
14        11.87        0.561
15        11.86        0.558
16        11.85        0.555
17        11.84        0.552
18        11.83        0.549
19        11.82        0.546
20        11.81        0.543
21        11.8         0.54
22        11.79        0.537
23        11.78        0.534
24        11.77        0.531
25        11.76        0.528
26        11.75        0.525
27        11.74        0.522
28        11.73        0.519
29        11.72        0.516
30        11.71        0.513
31        11.7         0.51
32        11.69        0.507
33        11.68        0.504
34        11.67        0.501
35        11.66        0.498
36        11.65        0.495
37        11.64        0.492
38        11.63        0.489
39        11.62        0.486
40        11.61        0.483
41        11.6         0.48
42        11.59        0.477
43        11.58        0.474
44        11.57        0.471
45        11.56        0.468
46        11.55        0.465
47        11.54        0.462
48        11.53        0.459
49        11.52        0.456
50        11.51        0.453
51        11.5         0.45
52        11.49        0.447
53        11.48        0.444
54        11.47        0.441
55        11.46        0.438
56        11.45        0.435
57        11.44        0.432
58        11.43        0.429
59        11.42        0.426
60        11.41        0.423
61        11.4         0.42
62        11.39        0.417
63        11.38        0.414
64        11.37        0.411
65        11.36        0.408
66        11.35        0.405
67        11.34        0.402
68        11.33        0.399
69        11.32        0.396
70        11.31        0.393
71        11.3         0.39
72        11.29        0.387
73        11.28        0.384
74        11.27        0.381
75        11.26        0.378
76        11.25        0.375
77        11.24        0.372
78        11.23        0.369
79        11.22        0.366
80        11.21        0.363
81        11.2         0.36
82        11.19        0.357
83        11.18        0.354
84        11.17        0.351
85        11.16        0.348
86        11.15        0.345
87        11.14        0.342
88        11.13        0.339
89        11.12        0.336
90        11.11        0.333
91        11.1         0.33
92        11.09        0.327
93        11.08        0.324
94        11.07        0.321
95        11.06        0.318
96        11.05        0.315
97        11.04        0.312
98        11.03        0.309
99        11.02        0.306
100       11.01        0.303
101       11           0.3
102       10.99        0.297
103       10.98        0.294
104       10.97        0.291
105       10.96        0.288
106       10.95        0.285
107       10.94        0.282
108       10.93        0.279
109       10.92        0.276
110       10.91        0.273
111       10.9         0.27
112       10.89        0.267
113       10.88        0.264
114       10.87        0.261
115       10.86        0.258
116       10.85        0.255
117       10.84        0.252
118       10.83        0.249
119       10.82        0.246
120       10.81        0.243;

$offtext
