# Hubble's law 

hubble = read.csv('https://raw.githubusercontent.com/jnaiman/is507_spring2021/master/week10/hubble.csv', 
                  stringsAsFactors = TRUE)

# from parsecs --> Mpc
distance = hubble[,1]/1e6 # Mpc (weird astro units)
# 1pc = 30 trillon km, 3.3 lightyears
# DISTANCE NOT TIME (sorry Star Wars)
velocity = hubble[,2] # km/s

# Plot and take a look:
plot(distance, velocity, pch=16, col=30,
     xlab='Distance to galaxy in Mpc',
     ylab='Recessional velocity in km/s')

# Questions:
# How linear is the relationship? (R)
# Fit a line
# Is our fit justified?
# Are there any outliers we should worry about?

# 1. Correlation coeffiecient
R = cor(distance,velocity)
print(R) # 0.86 -- fairly linear

# 2. Fit a line
myLine = lm(velocity~distance, 
            data=data.frame(distance,velocity))
summary(myLine)
# low p-value here --> evidence for a linear relationship
#  between distance and velocity

# look for evidence of features in residuals
par(mfrow=c(1,2))
myResiduals = resid(myLine)
plot(myResiduals)
abline(h=0,col='red')

# check out qqnorm/qqline
qqnorm(myResiduals)
qqline(myResiduals)

# We can also do our more complex diagnostic plots
par(mfrow=c(2,2))
x = seq(-0.25, 2.5) # note: negative is non-physical!
plot(distance, velocity, pch=16, col=30)
abline(myLine, col='green')

# residuals vs fitted
plot(myLine, which=1)

# qqnorm plot
plot(myLine, which=2)

# residuals vs. leverage
plot(myLine, which=5)

# Goodness of fit measurement:
R2 = R*R
print(R2) #74% of the variablity in this dataset
#  can be explained by the linear model

# Make a prediction -- calculate the beginning of time
# How long ago did the Big Bang happen?
# comes to us from Hubble's Law: V = H0 X D 
# Units of Hubble's constant, H0, are km/s/Mpc (weird)
hubbles_const = unname(myLine$coefficients[2])
print(hubbles_const) # 476 km/s/Mpc
# actual: 70 km/s/Mpc

# velocity = distance/time --> solve this eq for time:
# time = distance/velocity = D/V = 1/H0
beginning_of_time = 1/(hubbles_const*(1/3.08e19))
print(beginning_of_time) # seconds

beginning_of_time_years = beginning_of_time/3.15e7 # seconds/year
print(beginning_of_time_years)

# translate into Gyrs i.e. billions of years
beginning_of_time_Gyrs = beginning_of_time_years/1e9
print(beginning_of_time_Gyrs)
# we predict the universe started 2 billion years ago!
# (13.5 billion years)
# Nobel prized for everyone!  Telescope soon to come!