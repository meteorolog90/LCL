set datafile separator ","
set multiplot layout 3, 1 title "Divoš 2018" font ",20"
set xtics ("Jan" 0, "Feb" 631, "Mar" 936)

set yrange[0:8]
set grid
set tmargin 2
set title "Padavine[mm]"
unset key
plot "Padavine.csv" with lines

set title "LCL visina[m]"
unset key
set yrange[0:3000]
set grid
plot "LCL.csv" with lines

set title "Bovenov kolicnik"
unset key
set yrange[-5:5]
set grid
plot "Boven.csv" with lines

unset multiplot
pause -1



