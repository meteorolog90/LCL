set datafile separator ","
set multiplot layout 3, 1 title "Veliki Radinci 2018" font ",20"
set xtics ("Jan" 0, "Feb" 745, "Mar" 1417, "Apr" 2160, )

set yrange[0:6]
set xr[0:2000]
set grid
set tmargin 2
set title "Padavine[mm]"
unset key
plot "Padavine.csv" with lines

set title "LCL visina[m]"
unset key
set yrange[0:3000]
set xr[0:2000]
set grid
plot "LCL.csv" with lines

set title "Bovenov kolicnik"
unset key
set yrange[-5:5]
set xr[0:2000]
set grid
plot "Bowen.csv" with lines

unset multiplot
pause -1



