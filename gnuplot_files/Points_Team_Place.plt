set term png enhanced size 800,430
set output 'Points_Team_Place.png'
set title "Total Points and Change in Team Place in the Last 30 Days"
set xdata time
set timefmt "%m/%d/%Y"
set grid
set key left top
set y2tics nomirror
set ytics nomirror
set xtics nomirror
set ylabel "Points"
set y2label "Team Position"
plot "30_Day_Data.dat" using 1:3 axis x1y1 title 'Points' with linespoints, \
	 "30_Day_Data.dat" using 1:4 axis x1y2 title 'Team Place' with linespoints
