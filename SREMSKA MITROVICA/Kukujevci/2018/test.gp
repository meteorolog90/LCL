set datafile separator ","
set multiplot layout 3, 1 title "Kukujevci 2018" font ",20"
set xtics ("Jan" 0, "Feb" 745, "Mar" 1417, "Apr" 2161)

set yrange[0:10]
set xr[0:2200]
set grid
set tmargin 2
set title "Padavine[mm]"
unset key
plot "Padavine.csv" with lines

set title "LCL visina[m]"
unset key
set yrange[0:2500]
set xr[0:2200]
set grid
plot "LCL.csv" with lines

set title "Bovenov kolicnik"
unset key
set yrange[-5:5]
set xr[0:2200]
set grid
plot "Bowen.csv" with lines

unset multiplot
pause -1



