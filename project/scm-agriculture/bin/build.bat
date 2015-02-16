
@echo off

PATH=%PATH%;C:\Program Files\GAMS23.3

chdir project/scm-agriculture/src/

gams ModelAssembly_test.gms lo=3 ERRMSG=1