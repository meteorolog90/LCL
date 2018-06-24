set datafile separator ","
set multiplot layout 3, 1 title "Stara Pazova 2017" font ",20"
set xtics ("Feb" 0, "Mar" 443, "Apr" 681, "Maj" 775,"Jun" 1438,"Jul" 1771)

set yrange[0:30]
set xr[0:1800]
set grid
set tmargin 2
set title "Padavine[mm]"
unset key
plot "Padavine.csv" with lines

set title "LCL visina[m]"
unset key
set yrange[0:4000]
set xr[0:1800]
set grid
plot "LCL.csv" with lines

set title "Bovenov kolicnik"
unset key
set yrange[-5:5]
set xr[0:1800]
set grid
plot "Bowen.csv" with lines

unset multiplot
pause -1



