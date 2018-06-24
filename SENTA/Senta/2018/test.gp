set datafile separator ","
set multiplot layout 3, 1 title "Senta 2018" font ",20"
set xtics ("Jan" 0, "Feb" 745, "Mar" 1417, "Apr" 2161)
set yrange[0:10]
set xrange[0:2200]
set grid
set tmargin 2
set title "Padavine[mm]"
unset key
plot "padavine.csv" with lines

set title "LCL visina[m]"
unset key
set yrange[0:3000]
set xrange[0:2200]
set grid
plot "LCL.csv" with lines

set title "Bovenov kolicnik"
unset key
set yrange[-5:5]
set xrange[0:2200]
set grid
plot "Boven.csv" with lines

unset multiplot
pause -1



