Parameter
         WorkingDayProbabilityProfile   The fraction of the total number of days during the harvesting horizon time-step that are available for field operations
         WorkingDayProbability
         WeatherData The fraction of the total number of days during the harvesting horizon time-step that are available for field operations;

* Based on the concept of probability of working day (pwd) reported on a biweekly basis in the ASABE standards (ASAE D495.5)

*$CALL GDXXRW.EXE WeatherProbability.xls DSet=pwd rng=WeatherData!B4 Cdim=1 DSet=Days rng=WeatherData!A5:A124 Rdim=1 par=WeatherData rng=WeatherData!A4:B124;
$GDXIN WeatherProbability.gdx

Set pwd(*)
    Days(*);

$LOAD pwd = pwd
$LOAD Days = Days
$LOAD WeatherData
$GDXIN


*##############################################################################################################
* Data manipulation and parameter computation: Calculation of parameters based on imported data
*##############################################################################################################
* Assigning the imported values to the appropriate paremeters
WorkingDayProbabilityProfile(HarvestingHorizon)=WeatherData(HarvestingHorizon,'pwd');

*##############################################################################################################
* Data manipulation to account for harvesting and nonharvesting horizon aggregation
*##############################################################################################################

WorkingDayProbability(HarvestingHorizonAggregation)=sum(HarvestingHorizon $(ord(HarvestingHorizon)>=
                                                 (ord(HarvestingHorizonAggregation)-1)*card(HarvestingHorizonAggregationStep)+1
                                                  and
                                                  ord(HarvestingHorizon)<=ord(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep)
                                                 ),
                                                 WorkingDayProbabilityProfile(HarvestingHorizon))
                                                 /
                                                 card(HarvestingHorizonAggregationStep);

WorkingDayProbability(HarvestingHorizonAggregation)=1;
*
* Data for Miscanthus
*
*
* Probability of working day for Miscanthus in Illinois between January and April
*
WorkingDayProbability('1')=0.32;
WorkingDayProbability('16')=0.38;
WorkingDayProbability('31')=0.23;
WorkingDayProbability('46')=0.28;
WorkingDayProbability('61')=0.29;
WorkingDayProbability('76')=0.27;
WorkingDayProbability('91')=0.34;
WorkingDayProbability('106')=0.29;

*
* Probability of working day for switchgrass in Illinois between September and December
*
WorkingDayProbability('1')=0.81;
WorkingDayProbability('16')=0.65;
WorkingDayProbability('31')=0.72;
WorkingDayProbability('46')=0.76;
WorkingDayProbability('61')=0.72;
WorkingDayProbability('76')=0.67;
WorkingDayProbability('91')=0.54;
WorkingDayProbability('106')=0.38;


Display  WorkingDayProbability;


$ontext

Table  WeatherData   The fraction of the total number of days during the harvesting horizon time-step that are available for field operations

          pwd


1         0.3
2         0.3
3         0.3
4         0.3
5         0.3
6         0.3
7         0.3
8         0.3
9         0.3
10        0.3
11        0.3
12        0.3
13        0.3
14        0.3
15        0.3
16        0.3
17        0.3
18        0.3
19        0.3
20        0.3
21        0.3
22        0.3
23        0.3
24        0.3
25        0.3
26        0.3
27        0.3
28        0.3
29        0.3
30        0.3
31        0.3
32        0.3
33        0.3
34        0.3
35        0.3
36        0.3
37        0.3
38        0.3
39        0.3
40        0.3
41        0.3
42        0.3
43        0.3
44        0.3
45        0.3
46        0.3
47        0.3
48        0.3
49        0.3
50        0.3
51        0.3
52        0.3
53        0.3
54        0.3
55        0.3
56        0.3
57        0.3
58        0.3
59        0.3
60        0.3
61        0.5
62        0.5
63        0.5
64        0.5
65        0.5
66        0.5
67        0.5
68        0.5
69        0.5
70        0.5
71        0.5
72        0.5
73        0.5
74        0.5
75        0.5
76        0.5
77        0.5
78        0.5
79        0.5
80        0.5
81        0.5
82        0.5
83        0.5
84        0.5
85        0.5
86        0.5
87        0.5
88        0.5
89        0.5
90        0.5
91        0.75
92        0.75
93        0.75
94        0.75
95        0.75
96        0.75
97        0.75
98        0.75
99        0.75
100       0.75
101       0.75
102       0.75
103       0.75
104       0.75
105       0.75
106       0.75
107       0.75
108       0.75
109       0.75
110       0.75
111       0.75
112       0.75
113       0.75
114       0.75
115       0.75
116       0.75
117       0.75
118       0.75
119       0.75
120       0.75;
$offtext
