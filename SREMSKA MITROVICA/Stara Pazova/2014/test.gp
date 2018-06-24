set datafile separator ","
set multiplot layout 3, 1 title "Stara Pazova 2014" font ",20"
set xtics ("Jan" 0, "Feb" 720, "Mar" 1392, "Apr" 2135, "Maj" 2855,"Jun" 3534,"Jul" 4247,)

set yrange[0:30]
set xr[0:4300]
set grid
set tmargin 2
set title "Padavine[mm]"
unset key
plot "Padavine.csv" with lines

set title "LCL visina[m]"
unset key
set yrange[0:4000]
set xr[0:4300]
set grid
plot "LCL.csv" with lines

set title "Bovenov kolicnik"
unset key
set yrange[-5:5]
set xr[0:4300]
set grid
plot "Bowen.csv" with lines

unset multiplot
pause -1



