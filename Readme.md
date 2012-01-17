# Personal Folding Stats Site Scripts

#### Updated 10/07/10 - Drezha

## README
### Contents
----
1. Aim
2. Requirements
3. Usage

## i. Aim
This script is to allow users to create and maintain their own graphs for Folding@home stats. Various reasons occur for someone wanting to keep stats for themselves - sometimes stats sites go offline for various reasons or a site may not cater for the stats the user requires. The aim of this script file is that users can download data themselves and edit it as they see fit.

Unfortunately, at the time being, data is gathered from the Extreme Overclocking site and takes data from them. Whilst they continue to offer this service, these stats will work but if they remove it for any reason, then these scripts will not work. Until I can program them to store data itself, it is reliant on EOC offering CSV file downloads of data and the EOC site being up.

As such, these scripts should *not* be run more than once ever hour. EOC only updates every 3 hours so ideally these should only be run about that - note that the CSV show the values for the day so technically running these scripts once a day would suffice.

## ii. Requirements
All requirements should be fulfilled on Linux.

## iii. Usage
1.	Download the script
2.	Replace the variables with your own data
3.a	EOC can be found on your profile page on EOC - it's the numbers at the end of the URL
3. b	If you don't want to upload to FTP, leave the hostname, USER and PASSWD variable as is.
NOTE	I'm looking at changing the script to not store the password in plain text.
4.	Chmod the script (chmod +x ./Folding_Stats_Script.sh) to allow it to run
5.	Ensure the .plt files (gnuplot instraction files) are in the same directory as the script
6.	Run the script, either by double clicking in nautilus or from the command line
