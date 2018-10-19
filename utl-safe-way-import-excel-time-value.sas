Safe way import excel time values

github
https://github.com/rogerjdeangelis/utl-safe-way-import-excel-time-value

see SAS Forum
https://tinyurl.com/y9kycv3f
https://communities.sas.com/t5/SAS-Programming/Problems-with-time-variable-when-SAS-import-data-from-Excel-file/m-p/506125


INPUT
=====

github or SAS forum link
https://tinyurl.com/y7544scv
https://github.com/rogerjdeangelis/utl-safe-way-import-excel-time-value/blob/master/fixtime.xlsx


 d:/xls/fixtime.xlsx (also in github)

   +---------------------------------------+
   |     A       |    B       |     C      |
   +---------------------------------------+
1  | STUDY ID    |Static Test1|Static Test1|
   +-------------+------------+------------+
2  |     1       | 11:23:30   |  11:25:00  |
   +-------------+------------+------------+
2  |     2       |  9:10:39   |   9:10:39  |
   +-------------+------------+------------+
    ...
   +-------------+------------+------------+
13 |    13       |  8:42:52   |   8:44:49  |
   +-------------+------------+------------+


EXAMPLE OUTPUT
--------------

 WORK.WANT total obs=9

              STATIC_     STATIC_
   STUDYID     TEST_1      TEST_2

       1      11:23:30    11:25:00
       2       9:10:39     9:12:25
       3       9:18:56     9:20:48
       4       9:42:07     9:44:08
       7       7:47:40     7:55:09
       8       9:35:55     9:38:13
      10       8:11:09     8:15:01
      11       9:38:28     9:41:38
      13       8:42:52     8:44:49


 #    Variable         Type    Len    Format

 1    STUDYID          Num       8
 2    STATIC_TEST_1    Num       8    TIME.
 3    STATIC_TEST_2    Num       8    TIME.


PROCESS
=======

* this changes time to character;
proc sql dquote=ansi;
 connect to excel
    (Path="d:/xls/fixtime.xlsx" );
    create
        table hav2nd as
    select
        *
        from connection to Excel
        (
         Select
            [Study ID]  as studyId
            ,format([Static test 1],'h:mm:ss') as tym1st
            ,format([Static test 2],'h:mm:ss') as tym2nd
         from
           [VERDICTVitalitiVerif_DATA_LABEL$]
        );
    disconnect from Excel;
Quit;

* character to numeric SAS time;
data want ;
  retain studyid;
  format
    Static_test_1
    Static_test_2 time.;
  set hav2nd;
  Static_test_1 = input(tym1st,hhmmss8.);
  Static_test_2 = input(tym2nd,hhmmss8.);
  drop tym:;
run;quit;

*                _               _       _
 _ __ ___   __ _| | _____     __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \   / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/  | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|   \__,_|\__,_|\__\__,_|

;

Download

https://tinyurl.com/y9kycv3f
https://tinyurl.com/y7544scv


