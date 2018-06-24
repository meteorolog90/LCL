set datafile separator ","
set multiplot layout 3, 1 title "Divoš 2017" font ",15"
set xtics ("Jan" 0, "Feb" 745, "Mar" 1286, "Apr" 1574,"Jun" 2010,"Jul" 2017,"Avg" 2268,"Sep" 2747, "Okt" 2970,"Nov" 3374, "Dec" 3951)
set yrange[0:35]
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



