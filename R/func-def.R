#
# func-def.R, 13 Nov 25

library("colorspace")
library("plyr")


par(bty="l")
par(las=1)
par(pch="+")
pal_col=rainbow(2)


func_def=read.csv("csv/func-def-QuantLib.cpp_db.csv")

func_def$lines=func_def$curlend-func_def$curlstart-1 # +1-2 to remove { } from count

line_cnt=count(func_def$lines)

plot(line_cnt, log="xy",
	xlab="Lines", ylab="Functions")

points(count(func_def$nLOC), col="red")
points(count(func_def$nlines), col="blue")


smoothScatter(log(1e-1+func_def$lines), func_def$nparams,
	xlim=c(0, 6),
	xlab="Lines", ylab="Parameters")


