set term png enhanced size 800,430
set output 'Points.png'
set title "Total Points in the Last 30 Days"
set xdata time
set timefmt "%m/%d/%Y"
set grid
set key left top
set ytics nomirror
set xtics nomirror
set ylabel "Points"
plot "30_Day_Data.dat" using 1:3 axis x1y1 title 'Points' with linespoints
