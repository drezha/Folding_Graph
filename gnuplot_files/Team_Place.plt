set term png enhanced size 800,430
set output 'Team_Place.png'
set title "Team Place Change in the Last 30 Days"
set xdata time
set timefmt "%m/%d/%Y"
set grid
set key left top
set ytics nomirror
set xtics nomirror
set ylabel "Team Position"
plot "30_Day_Data.dat" using 1:4 axis x1y1 title 'Place' with linespoints
