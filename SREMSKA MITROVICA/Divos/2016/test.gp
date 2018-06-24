set datafile separator ","
set multiplot layout 3, 1 title "Divoš 2016" font ",20"
set xtics ("Jan" 0, "Feb" 394, "Mar" 877, "Apr" 1220, "Maj" 1882,"Jun" 2148,"Jul" 2399,"Avg" 2587, "Okto" 2600,"Nov" 2817, "Dec" 3122)
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



