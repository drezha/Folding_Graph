set term png enhanced size 800,430
set output 'Points_Per_Month.png'
set title "Points Gained Each Month"
set xdata time
set timefmt "%d/%m/%Y"
set format x "%m/%y"
set grid
set key left top
set ytics nomirror
set xtics nomirror
set ylabel "Points"
plot "./Monthly_Data/Monthly.dat" using 1:3 axis x1y1 title 'Points' with boxes fs solid
