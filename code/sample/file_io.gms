$title Reading Excel file using GDX

$Ontext
  Author: Debabrata Tripathy
  Email: dtripathy10@gmail.com
  Problem Refernce:https: http//www.youtube.com/watch?v=5PEjOUOL3sU
$offtext

set
    r number of rows
    c number of columns;

Parameter data(r,c) data from the excel;

*****************************************************
*      Reading data form file and save into table
****************************************************
* gdx file create

$onecho > tasks.txt
dset=r rng a1 rdim=1
dset=c rng=a1:c1 cdim=1
par=data rng=Sheet1!a1 rdim=1 cdim=1
$offecho

$call GDXXRW "../../data/io.xlsx" trace=3 @tasks.txt
* read into gdx file
$GDXIN io.gdx
$LOAD r c
$LOADDC data
$GDXIN

*****************************************************
*      Writing data form file and save into table
****************************************************
*dump excel file to gdx file
$call XLSDUMP  "../../data/io.xlsx" mydump.gdx

data(r,c) = data(r,c) * 2
Execute_Unload 'outdata.gdx';
Execute 'GDXXRW outdata.gdx par=data rng=Sheet2!a1'

*****************************************************
*      Display Table
****************************************************
Display data,r,c





