set datafile separator ","
set multiplot layout 3, 1 title "Senta 2013" font ",20"
set xtics ("Jan" 0, "Feb" 745, "Mar" 1416, "Apr" 2160, "Maj" 2880,"Jun" 3623,"Jul" 4343,"Avg" 5087,"Sep" 5831, "Okto" 6550,"Nov" 7293, "Dec" 8014)
set yrange[0:30]
set grid
set tmargin 2
set title "Padavine[mm]"
unset key
plot "Padavine2013.csv" with lines

set title "LCL visina[m]"
unset key
set yrange[0:4000]
set grid
plot "2013.csv" using 1:2 with lines

set title "Bovenov kolicnik"
unset key
set yrange[-5:5]
set grid
plot "Boven.csv" with lines

unset multiplot
pause -1



