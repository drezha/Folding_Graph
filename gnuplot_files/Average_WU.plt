set term png enhanced size 800,430
set output 'Average_WU.png'
set title "Number of WU's Returned and the Change in Average Points Per WU"
set xdata time
set timefmt "%m/%d/%Y"
set grid
set key left top
set ytics nomirror
set y2tics nomirror
set xtics nomirror
set ylabel "Average Points Per WU"
set y2label "Work Units"
plot "30_Day_Data.dat" using 1:5 axis x1y1 title 'Points Per WU' with linespoints, \
	 "30_Day_Data.dat" using 1:2 axis x1y2 title 'Work Units' with linespoints
