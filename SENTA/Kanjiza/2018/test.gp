set datafile separator ","
set multiplot layout 3, 1 title "Kanjiza 2018" font ",20"
set xtics ("Jan" 0, "Feb" 744, "Mar" 1416, "Apr" 2159)
set yrange[0:8]
set xrange[0:2300]
set grid
set tmargin 2
set title "Padavine[mm]"
unset key
plot "Padavine.csv" with lines

set title "LCL visina[m]"
unset key
set yrange[0:2000]
set xrange[0:2300]
set grid
plot "LCL.csv" with lines

set title "Bovenov kolicnik"
unset key
set yrange[-5:5]
set xrange[0:2300]
set grid
plot "Bowen.csv" with lines

unset multiplot
pause -1



