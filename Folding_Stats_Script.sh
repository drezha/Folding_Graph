#!/bin/sh
############################################
# Personal Folding at Home Stats Script
# Written by - Chris Salter (aka Drezha)
# Last Updated - 10/07/10
############################################
# Variables

EOC='EOC User Number'
HOST='hostname.com'
USER='username'
PASSWD='password'

############################################

# Backup Yesterday's Data with date
cp data.dat ./Backup/data_$(date +20%y-%m-%d).dat

# Download data from EOC
wget http://folding.extremeoverclocking.com/csv/user_csv.php?u=$EOC

# Rename the file to a Windows compatible name
# Not needed for Linux but kept in to keep both scripts similar
mv ./user_csv.php?u=$EOC ./user.csv

# Remove the column headers
sed /TimeStamp/d user.csv > output.csv

# Calculate work unit averages
#wine ./Averages.exe

# Replace comma's with tabs so that gnuplot can read the data
sed s/,/\\t/g output.csv > data.dat

# Delete the user.csv so that next run the file can be renamed
# Again, not needed in Linux but kept in to keep the scripts the same
# and provide cross compatibily if being used across OS's.
rm "user.csv"

# Tail to get the last 30 lines of data from data.dat
# Used to create summary graph for the last 30 day of returns
tail -30 data.dat > 30_Day_Data.dat

# Create gnuplot graphs
gnuplot Points.plt
gnuplot Points_Team_Place.plt
gnuplot Points_WUs.plt
gnuplot Team_Place.plt
# gnuplot Average_WU.plt
gnuplot Overall.plt

# Upload graphs to server
if [ $HOST = 'hostname.com' ]
then echo "FTP not setup"
else
ftp -n $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
cd ./public_html/stats/stats
put Points.png
put Points_Team_Place.png
put Points_WU.png
put Team_Place.png
put Average_WU.png
put Overall.png
put Average_TPF.png
put Points_Per_Month.png
quit
END_SCRIPT
exit 0
fi
