set datafile separator ","
set multiplot layout 3, 1 title "Divoš 2014" font ",20"
set xtics ("Jan" 0, "Feb" 710, "Mar" 1380, "Apr" 2005, "Maj" 2535,"Jun" 2626,"Avg" 3197,"Sep" 3514, "Okto" 3611,"Nov" 3779, "Dec" 4217)
set yrange[0:15]
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



