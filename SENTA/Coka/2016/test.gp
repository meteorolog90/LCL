set datafile separator ","
set multiplot layout 3, 1 title "Coka 2016" font ",20"
set xtics ("Jan" 0, "Feb" 726, "Mar" 1247, "Apr" 1990, "Maj" 2704,"Jun" 3448,"Jul" 4168,"Avg" 4909,"Sep" 5647, "Okto" 6367,"Nov" 7108, "Dec" 7708)
set yrange[0:6.5]
set grid
set tmargin 2
set title "Padavine[mm]"
unset key
plot "Padavine.csv" with lines

set title "LCL visina[m]"
unset key
set yrange[0:5000]
set grid
plot "LCL.csv" with lines

set title "Bovenov kolicnik"
unset key
set yrange[-5:5]
set grid
plot "Bowen.csv" with lines

unset multiplot
pause -1



