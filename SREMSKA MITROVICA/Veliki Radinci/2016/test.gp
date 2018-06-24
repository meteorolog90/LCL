set datafile separator ","
set multiplot layout 3, 1 title "Veliki Radinci 2016" font ",20"
set xtics ("Jan" 0, "Feb" 744, "Mar" 1440, "Apr" 2184, "Maj" 2904,"Jun" 3650,"Jul" 4380,"Avg" 5112,"Sep" 5856, "Okt" 6576,"Nov" 7320, "Dec" 8040)

set yrange[0:25]
set xr[0:9000]
set grid
set tmargin 2
set title "Padavine[mm]"
unset key
plot "Padavine.csv" with lines

set title "LCL visina[m]"
unset key
set yrange[0:5000]
set xr[0:9000]
set grid
plot "LCL.csv" with lines

set title "Bovenov kolicnik"
unset key
set yrange[-5:5]
set xr[0:9000]
set grid
plot "Bowen.csv" with lines

unset multiplot
pause -1



