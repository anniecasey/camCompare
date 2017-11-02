timeRad <- function(dec)
{
  dec*2*pi
}

# Converting two different records of same species into Radians
t.warthogL <- timeRad(META2013_SORTED_DONE$ST.Dec[META2013_SORTED_DONE$Species1=="common_warthog"])
t.warthogA <- timeRad(All_Visit_Activity$ST.Dec[All_Visit_Activity$Species == "Common Warthog"])

## actmod objects
fwarthogL <- fitact(t.warthogL, reps=100)
fwarthogA <- fitact(t.warthogA, reps=100)

##test whether species have a significantly different activity level from each other
compareAct(list(fwarthogL,fwarthogA))
# 1. difference between estimates
# 2. SEs of the differences
# 3. Wald Statistics
# 4. p-values (H0 = no difference between estimates)

## PLOTS
#dcol  = data lines
#lcol  = PDF (probability density function) lines
plot(fwarthogA,
     xunit = "hours", yunit = "density",
     dat = "rug", add = FALSE,
     dcol = "black", lcol = "red")
# adding second plot only adds PDF lines, no data lines
plot(fwarthogL,
     xunit = "hours", yunit = "density",
     dat = "histogram", add = TRUE,
     lcol = "blue")

# plot(fwarthogL, xunit = "radians", yunit = "frequency", dat = "histogram")
# plot(fwarthogA, hrs=FALSE, frq=FALSE)
# plot(fwarthogL, hrs=FALSE, frq=FALSE)

compareCkern(t.warthogA, t.warthogL, reps = 100, "Dhat4")

# Is comareTimes relevant?
compareTimes(fwarthogA, c(5.5,6,0.5,1))
compareTimes(fwarthogL, c(5.5,6,0.5,1))

## overlap graph of warthogs between locations
## overlap graph of warthog and farmer @ all days
## overlap graph of warthog and leopard @ lajuma





