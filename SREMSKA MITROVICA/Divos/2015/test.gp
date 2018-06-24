set datafile separator ","
set multiplot layout 3, 1 title "Divoš 2015" font ",20"
set xtics ("Jan" 0, "Feb" 431, "Mar" 869, "Apr" 1543, "Maj" 2263,"Jun" 2782,"Jul" 3230,"Avg" 3362,"Sep" 3550, "Okto" 3643,"Nov" 3722, "Dec" 4176)
set yrange[0:20]
set grid
set tmargin 2
set title "Padavine[mm]"
unset key
plot "Padavine.csv" with lines

set title "LCL visina[m]"
unset key
set yrange[0:4000]
set grid
plot "LCL.csv" with lines

set title "Bovenov kolicnik"
unset key
set yrange[-5:5]
set grid
plot "Boven.csv" with lines

unset multiplot
pause -1



