set datafile separator ","
set multiplot layout 3, 1 title "Bogaraš 2014" font ",20"
set xtics ("Jan" 0, "Feb" 745, "Mar" 1417, "Apr" 2160, "Maj" 2880,"Jun" 3624,"Jul" 4344,"Avg" 4353,"Sep" 5014, "Okt" 5734,"Nov" 6478, "Dec" 7198)

set yrange[0:20]
set xr[0:8000]
set grid
set tmargin 2
set title "Padavine[mm]"
unset key
plot "Padavine.csv" with lines

set title "LCL visina[m]"
unset key
set yrange[0:6000]
set xr[0:8000]
set grid
plot "LCL.csv" with lines

set title "Bovenov kolicnik"
unset key
set yrange[-5:5]
set xr[0:8000]
set grid
plot "Bowen.csv" with lines

unset multiplot
pause -1



