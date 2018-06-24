set datafile separator ","
set multiplot layout 3, 1 title "Stara Pazova 2016" font ",20"
set xtics ("Jan" 0, "Feb" 745, "Mar" 1441, "Apr" 2161, "Maj" 2881,"Jun" 3617)

set yrange[0:20]
set xr[0:4000]
set grid
set tmargin 2
set title "Padavine[mm]"
unset key
plot "Padavine.csv" with lines

set title "LCL visina[m]"
unset key
set yrange[0:5000]
set xr[0:4000]
set grid
plot "LCL.csv" with lines

set title "Bovenov kolicnik"
unset key
set yrange[-5:5]
set xr[0:4000]
set grid
plot "Bowen.csv" with lines

unset multiplot
pause -1



