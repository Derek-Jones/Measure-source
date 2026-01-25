#
# callgraph.R, 25 Jan 26
#
# Data:
# CodeQL 100 variant analysis repos

library("colorspace")
library("plyr")


par(bty="l")
par(las=1)
par(pch="+")
pal_col=rainbow(2)


# Plot and fit regression model to data from one repo
num_calls_fit=function(file_str)
{
ft=read.csv(file_str)

# A stab at removing the test cases
pz=subset(ft, !grepl("test/", filepath))

# Ignore non-large projects
if (nrow(pz) < 500)
   return(NULL)

proj_func=unique(pz$enclosingfunc)
pz$proj_call=pz$cname %in% proj_func

# Number of calls in each function
nc_proj=ddply(subset(pz, proj_call==TRUE), .(enclosingfunc), function(df) nrow(df))
proj_cnt=count(nc_proj$V1)
nc_lib=ddply(subset(pz, proj_call==FALSE), .(enclosingfunc), function(df) nrow(df))
lib_cnt=count(nc_lib$V1)

plot(proj_cnt, log="xy", col=pal_col[2],
	xlab="Calls from", ylab="Functions")
points(lib_cnt, col=pal_col[1])


proj_mod=glm(log(freq) ~ log(x), data=proj_cnt, subset=(x <= 50))
summary(proj_mod)

xbounds=1:50
pred=predict(proj_mod, newdata=data.frame(x=xbounds))

lines(xbounds, exp(pred), col=pal_col[2])

lib_mod=glm(log(freq) ~ log(x), data=lib_cnt, subset=(x > 1) & (x <= 50))
summary(lib_mod)

pred=predict(lib_mod, newdata=data.frame(x=xbounds))

lines(xbounds, exp(pred), col=pal_col[1])

return(data.frame(proj_int=coef(proj_mod)[1], proj_pow=coef(proj_mod)[2],
			lib_int=coef(lib_mod)[1], lib_pow=coef(lib_mod)[2]))
}


# Called for each function defined in the repo
call_to_from=function(from_func)
{
# calls from
cf=which(pz$enclosingfunc == from_func)
filepath=pz$filepath[cf][1]

# calls to
ct=which(pz$cname == from_func)

if (length(ct) == 0)
   return(NULL)

# print(c(func_str, length(ct), length(cf)))

t=data.frame(from_func,
		ct_same_file=length(which(pz$filepath[ct] == filepath)),
		ct_diff_file=length(which(pz$filepath[ct] != filepath)),
		calls_from=length(cf),
		LOC=pz$nLOC[cf][1],
		stmts=pz$nstmts[cf][1],
		filepath)
return(t)
}


# Called for each source filepath in the repo
file_calls_to_from=function(df)
{
t=data.frame(filepath=df$filepath[1],
		ct_same_file=sum(df$ct_same_file),
		ct_diff_file=sum(df$ct_diff_file),
		calls_from=sum(df$calls_from),
		num_funcs=nrow(df))

return(t)
}


# ft=read.csv("indygreg/python-zstandard.csv")

cg=read.csv("cg100.csv.xz") # takes a while, and it's big

# Code for blog post

ft=subset(cg, repo == "torvalds/linux")

pz=subset(ft, !grepl("test/", filepath))

proj_func=unique(pz$enclosingfunc)
pz$proj_call=pz$cname %in% proj_func
called_func=unique(pz$cname)

func_calls=adply(proj_func, .mar=1, call_to_from)

plot(func_calls$LOC, func_calls$calls_from, log="xy", col=pal_col[2],
		xlab="LOC", ylab="Calls from")
# call_mod=glm(log(calls_from) ~ log(LOC)+I(log(LOC)^2), data=func_calls) # a better fit
call_mod=glm(log(calls_from) ~ log(LOC), data=func_calls) # , subset=(LOC > 20))
summary(call_mod)
xbounds=1:1e3
pred=predict(call_mod, newdata=data.frame(LOC=xbounds))
lines(xbounds, exp(pred), col=pal_col[1])

dev.copy(dev=png, file="LOC-fun-from-calls.png")
dev.off()

plot(func_calls$LOC, 0.95*func_calls$ct_diff_file, log="xy", col=pal_col[1],
		xlab="LOC", ylab="Calls to")
points(0.95*func_calls$LOC, func_calls$ct_same_file, log="xy", col=pal_col[2])

LOCd4=subset(func_calls, (LOC >= 4) & (ct_diff_file > 0))
loess_mod=loess.smooth(log(LOCd4$LOC), log(LOCd4$ct_diff_file), span=0.3)
lines(exp(loess_mod$x), exp(loess_mod$y), col=pal_col[1])

LOCs4=subset(func_calls, (LOC >= 4) & (ct_same_file > 0))
loess_mod=loess.smooth(log(LOCs4$LOC), log(LOCs4$ct_same_file), span=0.3)
lines(exp(loess_mod$x), exp(loess_mod$y), col=pal_col[2])

legend("topright", legend=c("Function in different file to caller", "Function in same file as caller"),
                        fill=pal_col, border="white", bty="n", cex=1.2)

dev.copy(dev=png, file="LOC-fun-to-calls.png")
dev.off()


# Calls from function to funstions in the same file or not
plot(func_calls$calls_from, func_calls$ct_diff_file, log="xy", col="blue",
		xlab="Calls from", ylab="Calls to")
points(func_calls$calls_from, func_calls$ct_same_file, col="red")
lines(c(1, 1e3), c(1, 1e3), col="grey")
smoothScatter(log(func_calls$calls_from), log(func_calls$calls_to+1e-1),
		xlab="Calls from", ylab="Calls to")

file_calls=ddply(func_calls, .(filepath), file_calls_to_from)
plot(file_calls$calls_from, file_calls$ct_diff_file, log="xy", col=pal_col[2],
		xlab="Calls from file", ylab="Calls to file")
points(file_calls$calls_from, file_calls$ct_same_file, col=pal_col[1])
lines(c(1, 1e3), c(1, 1e3), col="grey")


# Number of calls in each function
nc_proj=ddply(subset(pz, proj_call==TRUE), .(enclosingfunc), function(df) nrow(df))
proj_cnt=count(nc_proj$V1)
nc_lib=ddply(subset(pz, proj_call==FALSE), .(enclosingfunc), function(df) nrow(df))
lib_cnt=count(nc_lib$V1)

plot(proj_cnt, log="xy", col=pal_col[2],
	xlab="Calls from", ylab="Functions")
points(lib_cnt, col=pal_col[1])


proj_mod=glm(log(freq) ~ log(x), data=proj_cnt, subset=(x <= 50))
summary(proj_mod)

xbounds=1:50
pred=predict(proj_mod, newdata=data.frame(x=xbounds))

lines(xbounds, exp(pred), col=pal_col[2])

lib_mod=glm(log(freq) ~ log(x), data=lib_cnt, subset=(x > 1) & (x <= 50))
summary(lib_mod)

xbounds=1:50
pred=predict(lib_mod, newdata=data.frame(x=xbounds))

lines(xbounds, exp(pred), col=pal_col[1])


# Number of times each name is called
par(mfcol=c(1, 1))
par(mar=c(5, 4, 4, 2))

nf_proj=ddply(subset(pz, proj_call==TRUE), .(cname), function(df) nrow(df))
proj_cnt=count(nf_proj$V1)
nf_lib=ddply(subset(pz, proj_call==FALSE), .(cname), function(df) nrow(df))
lib_cnt=count(nf_lib$V1)

plot(proj_cnt, log="xy", col=pal_col[2],
	xlab="Calls to", ylab="Named functions")
points(lib_cnt, col=pal_col[1])


proj_mod=glm(log(freq) ~ log(x), data=proj_cnt, subset=(x <= 50))
summary(proj_mod)

xbounds=1:50
pred=predict(proj_mod, newdata=data.frame(x=xbounds))

lines(xbounds, exp(pred), col=pal_col[2])

lib_mod=glm(log(freq) ~ log(x), data=lib_cnt, subset=(x > 1) & (x <= 30))
summary(lib_mod)

xbounds=1:50
pred=predict(lib_mod, newdata=data.frame(x=xbounds))

lines(xbounds, exp(pred), col=pal_col[1])



par(mfcol=c(10, 10))
# mar=c(5, 4, 4, 2)
par(mar=c(2, 2, 2, 1))
par(oma=c(1, 1, 1, 1))

csvs=list.files(path=".", pattern="*.csv", recursive=TRUE, full.names=TRUE)

calls_fit=adply(csvs, .mar=1, num_calls_fit)


# Number of calls in each function
nc=ddply(pz, .(enclosingfunc), function(df) nrow(df))
c_cnt=count(nc$V1)

plot(c_cnt, log="xy", col=pal_col[2],
	xlab="Calls", ylab="Functions")


call_mod=glm(log(freq) ~ log(x), data=c_cnt)
summary(call_mod)

xbounds=1:50
pred=predict(call_mod, newdata=data.frame(x=xbounds))

lines(xbounds, exp(pred), col=pal_col[1])


# Plot all 100 repos (actually 98 because 2 did not finish)
par(mfcol=c(10, 10))
# mar=c(5, 4, 4, 2)
par(mar=c(2, 2, 2, 1))
par(oma=c(1, 1, 1, 1))

csvs=list.files(path=".", pattern="*.csv", recursive=TRUE, full.names=TRUE)

calls_fit=adply(csvs, .mar=1, num_calls_fit)

mean(calls_fit$proj_pow)
#  -1.513082
mean(calls_fit$lib_pow)
#  -1.510442
sd(calls_fit$proj_pow)
# .3796197
sd(calls_fit$lib_pow)
#  0.4508333


# Build a call graph

library("igraph")

all_funcs=unique(c(pz$cname, pz$enclosingfunc))

# Connections between the nodes in a directed graph
gr_df=data.frame(from=pz$enclosingfunc,
			to=pz$cname)
call_gr=graph_from_data_frame(gr_df)

root_node = V(call_gr)[degree(call_gr, mode = "in") == 0]

# Returns the number of nodes reachable from each in-degree-0 "root",
# one element per root.
root_subgraph_sizes=function(g)
{
# All functions that are not called
roots=V(g)[degree(g, mode = "in") == 0]
if (length(roots) == 0L)
   return(setNames(integer(0L), character(0L)))

# How many nodes in each disjoint graph?
sizes=vapply(roots, function(v)
			{
			r=subcomponent(g, v, mode = "out")  # all nodes reachable from v
			return(length(r))
			},
		integer(1L))

names(sizes)=as_ids(roots)  # vertex names if present, else ids
return(sizes)
}

root_gr_cnt=root_subgraph_sizes(call_gr)

plot(sort(root_gr_cnt), log="xy",
	xlab="root index", ylab="Calls")


