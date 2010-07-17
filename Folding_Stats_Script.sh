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
echo "Backing up data with todays date"
cp data.dat ./Backup/data_$(date +20%y-%m-%d).dat
echo "Complete"

# Download data from EOC
echo "Downloading Data from Extreme Overclocking"
wget http://folding.extremeoverclocking.com/csv/user_csv.php?u=$EOC
echo "Complete"

# Rename the file to a Windows compatible name
# Not needed for Linux but kept in to keep both scripts similar
echo "Renaming the downloaded data"
mv ./user_csv.php?u=$EOC ./user.csv
echo "Complete"

# Remove the column headers
echo "Removing column headers"
sed /TimeStamp/d user.csv > output.csv
echo "Complete"

# Calculate work unit averages
echo "Calculating averages and replacing commas in file with tabs"
sed s/,/\\t/g output.csv | awk '$3!=0 || $2!=0{gsub(/\r/,"",$4);print $1"\t"$2"\t"$3"\t"$4"\t"$3/$2}' > data.dat
echo "Complete"

# Delete the user.csv so that next run the file can be renamed
# Again, not needed in Linux but kept in to keep the scripts the same
# and provide cross compatibily if being used across OS's.
echo "Removing user.csv"
rm "user.csv"
echo "Complete"

# Tail to get the last 30 lines of data from data.dat
# Used to create summary graph for the last x day of returns
echo "Getting the last 30 days of data from data.dat"
tail -30 data.dat > 30_Day_Data.dat
echo "Complete"

# Create gnuplot graphs
echo "Creating graphs"
gnuplot Points.plt
gnuplot Points_Team_Place.plt
gnuplot Points_WUs.plt
gnuplot Team_Place.plt
gnuplot Average_WU.plt
gnuplot Overall.plt
echo "Complete"

# Upload graphs to server
echo "Uploading to FTP server"
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
