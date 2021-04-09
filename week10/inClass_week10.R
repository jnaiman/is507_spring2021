# In class, week 10!! (2/3 of the way there!)
#install.packages("manipulate")
#install.packages("tigerstats")
require(manipulate)
require(tigerstats)

FindRegLine()


#### Now with real data! #####
# How a person's blood alcohol level (BAC) is related to how many beers they 
#   have consumed (Beers).
# Here this is an experiment (without a control) -- 
#  16 students drank a randomly assigned number of beers
#  30 minutes later they had their blood alcohol level (BAC) measured 
BB = read.csv('https://raw.githubusercontent.com/jnaiman/is507_fall2020/master/week10/beersbac.csv')

# Make a plot of this relationship
plot(BB$Beers, BB$BAC, pch=16, col=30)

# another way we can plot:
plot(BAC~Beers, data=BB, pch=16, col=30)

# What kinds of questions do we think we can answer with this 
#  dataset?
# Is there a positive correlation between # of 
#   beers consumed and BAC?
# What is the strength of the relationship between Beers & BAC?
# How many Beers does someone have to consume before they reach 
#  a dangerous BAC?
# Follow up: how confident are we about answering any of these
#   questions?

# 1. Calculate the correlation coefficient:
R = cor(BAC~Beers, data=BB)
print(R) # 0.9 -- fairly linear relationship

# 2. Fit a line!
myLine = lm(formula = BAC~Beers, data=BB)

summary(myLine)

# Slope along "Beers" is 0.018, so this means that 
#  for every beer we consume our BAC should increase by 
#  0.018

# use abline to over plot this line
abline(myLine, col="blue")

# we can plot this line in a few ways, one way is to 
#  get the coefficients and use them in a plot
b0 = myLine$coefficients[1] # intercept
b1 = myLine$coefficients[2] # slope

# more info about picking the "best" model later in course!

# plotting using these coefficients
num_of_beers = seq(0, 100) # number of beers consumed
myNewLine = b0 + b1*num_of_beers
plot(num_of_beers, myNewLine, type='l', col='green')

# fatal (lethal) BAC is ~0.4 (dependent on drink history)
abline(h=0.4, col='blue')
# we did extrapolation!  People would probably be dead after 40!

num_of_beers = seq(0,20)
myNewLine = b0 + b1*num_of_beers
plot(num_of_beers, myNewLine, type='l', col='green')

# example of where our intercept doesn't make any physical sense

# let's re-overplot our data
points(BAC~Beers, data=BB, pch=16,col=30)

# we can make a function with our coefficients to make predictions
myLineFunction = function(nBeers){
  return(unname(b0) + unname(b1)*nBeers)
}

# 3. Check out our residuals
myResiduals = resid(myLine)
plot(myResiduals)
abline(h=0, col='red')
# MAYBE there is some underlying structure, but it is hard
#  to tell.

# Look at the normality of our residiuals
qqnorm(myResiduals)
qqline(myResiduals)
# looks fairly normal, but maybe some features

# Yet another way to plot models + data + diagnostics
par(mfrow=c(2,2))
num_of_beers = seq(1,10)
myNewLine = b0 + b1*num_of_beers
plot(num_of_beers, myNewLine, type='l', col='green', 
     xlab='Number of Beers', ylab='BAC', 
     ylim=c(0,0.2))
points(BAC~Beers, data=BB, pch=16, col=30)

# plot residuals using "for free" diagnostic plots 
plot(myLine, which=1)

# qqnorm/qqline plot
plot(myLine, which=2)

# 4. "Goodness of fit measurement"
R2 = R*R
print(R2) # 80%
# Roughly 80% of the variation in our data is because 
#  our data is lying on a line.
# Roughly 20% due to other things.


###### Let's look at possible outliers ####

# one other possibly useful diagnositic plot
plot(myLine, which=4) # cooks distance plot


# yet another plot
par(mfrow=c(2,2))
num_of_beers = seq(1,10)
myNewLine = b0 + b1*num_of_beers
plot(num_of_beers, myNewLine, type='l', col='green', 
     xlab='Number of Beers', ylab='BAC', 
     ylim=c(0,0.2))
points(BAC~Beers, data=BB, pch=16, col=30)

# plot residuals using "for free" diagnostic plots 
plot(myLine, which=1)

# qqnorm/qqline plot
plot(myLine, which=2)

plot(myLine, which=5) # residuals vs. leverage

# the point with #Beers = 9 is a high leverage & 
#  influential point -- may/may not want to remove it!

# Let's add a clear outlier and see how it changes our plots
newBeers = c(BB$Beers, 10)
newBAC = c(BB$BAC, 0.01)
newBB = data.frame(newBeers, newBAC)

# plot this new data with the old linear fit
par(mfrow=c(1,1))
plot(num_of_beers, myNewLine, type='l', 
     col='green', xlab='Number of Beers', 
     ylab='BAC', ylim=c(0,0.2))
points(newBAC~newBeers, data=newBB, pch=16,col=30)

# Let's see how this changes the fit of our line
new_myLine = lm(formula=newBAC~newBeers, data=newBB)
newb0 = new_myLine$coefficients[1] # new intercept
newb1 = new_myLine$coefficients[2] # new slope
# lets do lines!
lines(num_of_beers, newb0 + newb1*num_of_beers, 
      col='red')

# see the fact that this new point is high leverage/
#  influential:
plot(new_myLine, which=5) # residuals vs. leverage

# Correlation and "goodness" of fit of our new model
newR = cor(newBAC~newBeers,data=newBB)
print(newR) # R = 0.89
newR2 = newR*newR
print(newR2) # only 30.3% of the variation can be 
#  explained by our linear model

# It is tempting to take out outliers but we have to 
#  be careful when we do so!
