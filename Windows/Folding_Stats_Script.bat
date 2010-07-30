::::::::::::::::::::::::::::::::::::::::::::
:: Personal Folding at Home Stats Script
:: Written by - Chris Salter (aka Drezha)
:: Last Updated - 30/07/10
::::::::::::::::::::::::::::::::::::::::::::
@echo off
::Set Variables
set EOC=xxxxxx
set Host=hostname.me.uk

::Set Date
for /f "tokens=1-3 delims=/ " %%a in ('date /T') do set year=%%c
for /f "tokens=1-3 delims=/ " %%a in ('date /T') do set month=%%b
for /f "tokens=1-3 delims=/ " %%a in ('date /T') do set day=%%a
set temp=%year%-%month%-%day%

::Backup Yesterday's Data
copy data.dat .\Backup\data_%temp%.dat

::Download data from EOC
wget http://folding.extremeoverclocking.com/csv/user_csv.php?u=%EOC%

::Rename the file to a Windows compatible name
rename "user_csv.php@u=%EOC%" "user.csv"

::Remove the column headers
sed /TimeStamp/d user.csv > output.csv

::Replace comma's with tabs so that gnuplot can read the data
::Calculate work unit averages
sed s/,/\t/g output.csv | sed 1d | awk " {print $1,\"\t\",$2,\"\t\",$3,\"\t\",$4,\"\t\",$3/$2}" > data.dat

::Delete the user.csv so that next run the file can be renamed
del "user.csv"

::Tail to get the last 30 lines of data from data.dat
::Used to create summary graph for the last 30 day of returns
::Needs the Windows Server 2003 Resource Kit Tools for tail - available from Microsoft
tail -30 data.dat > 30_Day_Data.dat

::Create gnuplot graphs
::Relies on gnuplot path being added to windows path - in my case C:\Program Files\gnuplot\binary
gnuplot Points.plt
gnuplot Points_Team_Place.plt
gnuplot Points_WUs.plt
gnuplot Team_Place.plt
gnuplot Average_WU.plt
gnuplot Overall.plt

::Upload data to Webserver
ftp -s:FTP.txt %Host%
