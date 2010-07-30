set term png enhanced size 800,430
set output 'Overall.png'
set title "Points since Start of Project"
set xdata time
set timefmt "%m/%d/%Y"
set grid
set key left top
set ytics nomirror
set xtics nomirror
set ylabel "Points"
plot "data.dat" using 1:3 axis x1y1 title 'Points' with linespoints
