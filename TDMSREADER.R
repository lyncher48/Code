#라이브러리 설치
if(!length("devtools" %in% installed.packages()[,"Package"])) install.packages(new.packages)
install.packages("R6", type="source")
devtools::install_github('msuefishlab/tdmsreader')
install.packages()

library(tdmsreader)
f = file('D:/Documents/20170112102357_GR-J297WSBU_701KREL19340.tdms', 'rb')
main = TdmsFile$new(f)
main$read_data(f, 0, 1)
r = main$objects[[ "/'Untitled'/'Dev1/ai0'"]]
t = r$time_track(start = 0, end = 1)
s = r$data
png('out.png')
plot(t, s, xlab = 'Time', ylab = 'Volts')
title('TDMS reader')
dev.off()
close(f)

devtools::install_github('msuefishlab/tdmsviewer')
X.k <- fft(trajectory)