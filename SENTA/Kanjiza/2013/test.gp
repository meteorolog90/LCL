set datafile separator ","
set multiplot layout 3, 1 title "Kanjiza 2013" font ",20"
set xtics ("Jan" 0, "Feb" 745, "Mar" 1403, "Apr" 2133, "Maj" 2849,"Jun" 3570,"Jul" 4290,"Avg" 5034,"Sep" 5777, "Okt" 6497,"Nov" 7241, "Dec" 7961)
set yrange[0:40]
set grid
set tmargin 2
set title "Padavine[mm]"
unset key
plot "Padavine.csv" with lines

set title "LCL visina[m]"
unset key
set yrange[0:4500]
set grid
plot "LCL.csv" with lines

set title "Bovenov kolicnik"
unset key
set yrange[-5:5]
set grid
plot "Bowen.csv" with lines

unset multiplot
pause -1



