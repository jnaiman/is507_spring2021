# Multiple Linear Regression (MLR)

snotel_s = read.csv('https://raw.githubusercontent.com/jnaiman/is507_spring2021/master/week10/snotel_s.csv')
head(snotel_s)
# Measuring the snow depth (inches) on 1 day in April
# from 25 locations and also recording the min/max temperature 
# (in F) and elevation of the location (feet)

# reorder columns for nicer display
snotel = snotel_s[,c(1:2,4:6,3)]
head(snotel)

# use psych library to plot stuff
require(psych)

# do pairs-panels plot to look at relationships
pairs.panels(snotel[,-c(1:2)],ellipse=FALSE,
             main='SNOTEL data matrix plots', lm=TRUE)

# What questions would we like to build a predictive 
#  model to try to answer with this dataset?
# Are there relationships between depth and temperature?
# How does max temperature affect the depth of the snow?
# Predict snow depth based on temp range (max & min)?
# Elevation & snow depth?
# Which of Max Temp, Min Temp and Elevation is important
#  for predicting snow depth? (stay tuned!)
# Could we infer what station we are on from a min/max
#  temp, elevation, depth? (What we happen if we added data?)
# Can we preidct the range in temperature at a station? (collect more days of data?)

# Let's fit some single linear models using 
#  snow depth as the response and other as individual
#  explanatory:
m1 = lm(Snow.Depth~Elevation, data=snotel)
m2 = lm(Snow.Depth~Min.Temp, data=snotel)
m3 = lm(Snow.Depth~Max.Temp, data=snotel)
summary(m1) # looks like good fit!
summary(m2) # also good fit!
summary(m3) # and yet another good fit!

# let's also plot the relationships between these
#  variables and snow depth:
par(mfrow=c(3,1))

plot(snotel$Elevation, snotel$Snow.Depth, 
     xlab='Elevation', ylab='Snow Depth')
abline(m1,col='blue')

plot(snotel$Min.Temp, snotel$Snow.Depth, 
     xlab='Min temperature', ylab='Snow Depth')
abline(m2, col='red')

plot(snotel$Max.Temp, snotel$Snow.Depth,
     xlab='Max Temp', ylab='Snow Depth')
abline(m3, col='green')