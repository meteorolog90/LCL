set datafile separator ","
set multiplot layout 3, 1 title "Divoš 2013" font ",20"

set yrange[0:40]
set xtic auto
set ytic auto
set grid
set tmargin 2
set title "Padavine[mm]"
set xtics ("Jan" 0, "Feb" 775, "Mar" 1416, "Apr" 2160, "Maj" 2880,"Jun" 3623,"Jul" 4343,"Avg" 5087,"Sep" 5831, "Okto" 6550,"Nov" 7293, "Dec" 8014)

unset key
plot "Padavine.csv" with lines

set title "LCL visina[m]"
unset key
set yrange[0:3500]

set grid
plot "LCL.csv" with lines

set title "Bovenov kolicnik"
unset key
set yrange[-4:4]

set grid
plot "Boven.csv" with lines

unset multiplot
pause -1



