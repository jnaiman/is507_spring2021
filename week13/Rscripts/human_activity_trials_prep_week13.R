# startup, just in case:
library(dplyr)
library(mvtnorm)
library(flexclust)
library(class)
library(tidyverse)
library(stringr)
library("e1071")


# just to set everything right
par(mfrow=c(1,1))

# use some helpful R scripts from github
source('https://raw.githubusercontent.com/idc9/stor390/master/notes/cross_validation/synthetic_distributions.R')
source('https://raw.githubusercontent.com/idc9/stor390/master/notes/cross_validation/knn_functions.R')



# read more about this dataset here: https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# essentially, it was a test to see if smart phones can distinguish human
#  activities like walking, standing, laying down and walking up & down stairs

# Each person performed six activities:
# (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
#  wearing a smartphone (Samsung Galaxy S II) on the waist. 
# Using its embedded accelerometer and gyroscope, they captured 3-axial 
# linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
# The experiments have been video-recorded to label the data manually. 
# The obtained dataset has been randomly partitioned into two sets, 
# where 70% of the volunteers was selected for generating the training data 
# and 30% the test data.

# you should probably use the downloaded datasets, but you can also use links like:
# train = read_csv('https://raw.githubusercontent.com/idc9/stor390/master/data/human_activity_train.csv')
# easier:
train = read_csv('~/Downloads/human_activity_train.csv')

# lets look at some examples
# lets first look at the difference between the distributions of the means of the X-direction
#  accleration for the WALKING (activity #1) and LAYING (activity #2)
activity1_accx = subset(train$`tBodyAcc-mean()-X`, train$activity==1)
activity2_accx = subset(train$`tBodyAcc-mean()-X`, train$activity==6)
boxplot(activity1_accx, activity2_accx)
# we can seee that while the means are about the same, certainly the distribuitions look
# very different

# if we plot a histogram, its a bit hard to tell
hist(activity1_accx,plot=TRUE, ylim=c(0,700), xlim=c(-1,2.5))
par(new=T)
hist(activity2_accx,plot=T,border='green', ylim=c(0,700), xlim=c(-1,2.5))

# lets cacluate average overall acclerations as sq sums of the x/y/z components
#  for each activity
## **MAYBE SKIP?**
activity1_accy = subset(train$`tBodyAcc-mean()-Y`, train$activity==1)
activity1_accz = subset(train$`tBodyAcc-mean()-Z`, train$activity==1)

acc_act1 = (activity1_accz**2 + activity1_accx**2 + activity1_accy**2)**0.5

activity2_accy = subset(train$`tBodyAcc-mean()-Y`, train$activity==6)
activity2_accz = subset(train$`tBodyAcc-mean()-Z`, train$activity==6)
acc_act2 = (activity2_accz**2 + activity2_accx**2 + activity2_accy**2)**0.5

hist(acc_act1,plot=TRUE, ylim=c(0,5), xlim=c(-1,2.5), prob=T)
par(new=T)
hist(acc_act2,plot=T,border='green', ylim=c(0,5), xlim=c(-1,2.5), prob=T)
# when we plot these normalized, we see that indeed it looks
#  like the means are the same, BUT the distribtuions have different shapes

## SKIP ABOVE

# this tells us that the other parameters like the STD of each 
#  might tell us more about the differences in each of these activities:
activity1_accsx = subset(train$`tBodyAcc-std()-X`, train$activity==1)
activity2_accsx = subset(train$`tBodyAcc-std()-X`, train$activity==6)
boxplot(activity1_accsx, activity2_accsx)
# this lets us know that we really want to use ALL of the different
#   data to classify, not just rely on simple measurements like
#  MEAN or MIN & MAX

# lets start with 2 activities:
# lets just select for 2 activities: walking upstairs & walking downstairs
####train2 = train %>% filter(activity == 2 | activity == 3)
train2 = subset(train, train$activity == 2 | train$activity==3)
train2
# if we look at this dataset, there is ALOT going on - lots of different x/y/z
#  measurments from various different sensors in a smart phone


# now, lets use KNN to see if we can tell these 2 activities apart

## read in the test data
#test = read_csv('https://raw.githubusercontent.com/idc9/stor390/master/data/human_activity_test.csv')
test = read_csv('~/Downloads/human_activity_test.csv')

# again, select only 2 activities
test2 = subset(test, test$activity == 2 | test$activity==3)


train_x = select(train2, -activity)
train_y = train2$activity # turn into a vector

test_x = select(test2, -activity)
test_y = test2$activity # turn into a vector

# get predictions on test data
##set.seed(NULL)
k = 2 ## KEEP 2!!
test_predictions = knn(train=train_x, # training x
                       test=test_x, # test x
                       cl=train_y, # train y
                       k=k, prob=T) # set k
print(test_predictions)
print(test_y)

# ok, so we have now our KNN predictions for how things should and 
# shouldn't be classified as either activity #2 or activity #3
# based on our training inputs and on the grid of results from the test_x

# grab actual levels of predictions
# put into numbers for calculations
# this is just some vector magic
tp = as.numeric(levels(test_predictions))[test_predictions]


hist(tp,plot=TRUE, ylim=c(0,300), xlim=c(0,6), main='Activity 2 or 3', 
     xlab="Activity #")
par(new=T)
hist(test_y,plot=T,border='green', ylim=c(0,300), xlim=c(0,6), main='', xlab='')
legend('topright', c('Predicted', 'Actual'), col=c('black','green'), lwd=c(2,2))


# they look close, but not exact
#  how often do we miss classify things?
# compute test error
test_error = mean(test_y != test_predictions)
test_error

## NOTE: test_y just from breaking things up
#  you can group test and train and resample

# so, about 18% of the time we miss classify things

# can we do better!  Lets use CV and bootstrapping!

# gotta do this for formatting!!!
y = factor(train2$activity) # this is already a vector, put to a factor
# lets grab all inputs but activity
x = select(train2, -activity)

#### IN GROUPS: using this x,y as the train x&y: use the CV & bootstrap
#  tuning functions to pick the best k, plot!
# BONUS: what is the mis-classification rate now?

# ANS:
## THIS WONT WORK
#knn.kfold = tune.knn(x=train_x, y=train_y, k=1:20,
#                     tunecontrol=tune.control(sampling = "cross", cross=10))
knn.kfold = tune.knn(x=x, y=y, k=1:20, 
                       tunecontrol=tune.control(sampling = "cross", cross=10) )

knn.kfold

plot(knn.kfold$performances$k, knn.kfold$performances$error, type='l')



# what we can see here is that the calculated CV does not have the same shape
#  as our test patern.  Again, this is because its only
#  an approximation to test error!

# so, if we run the above 2 lines a bunch of times we see about 1 is a good k
#  what about for a bootstrap?
knn.boot = tune.knn(x = x, y = y, k = 1:10,tunecontrol=tune.control(sampling = "boot") )
knn.boot
# this above takes a WHILE.. maybe don't do??

# lets pick k = 1 and see how we do
# get predictions on test data
k_best = 1
#set.seed(NULL)
test_predictions = knn(train=train_x, # training x
                       test=test_x, # test x
                       cl=train_y, # train y
                       k=k_best) # set k

# compute test error
test_error = mean(test_y != test_predictions)
test_error
# now we are down less than 17% !  not a huge difference
# but still less, so that is good!


# We also have access to some test data itself, so we can 
#   calculate this directly
# also do by hand with actual test data
test_error_out = c()
for (k in 1:40){
  test_predictions = knn(train=train_x, # training x
                         test=test_x, # test x
                         cl=train_y, # train y
                         k=k) # set k
  
  tp = as.numeric(levels(test_predictions))[test_predictions]
  
  # they look close, but not exact
  #  how often do we miss classify things?
  # compute test error
  test_error_out = c(test_error_out, mean(test_y != test_predictions) )
}

plot(knn.kfold$performances$k, knn.kfold$performances$error, type='l', ylim=c(0,0.2))
#lines(knn.kfold_alone$performances$k, knn.kfold_alone$performances$error, col="green")
lines(1:40, test_error_out, col="green")

# from this we can see that the test error calculated with our "test" sample is minimum around k=10


## IN GROUPS: repeat this analysis for other sets of 2 activities
#  which do you think to be the best classifications?  Why?
# EXTRA: Do you think you can get rid of any of the 561 in put parameters?
#   why or why not?  Use CV to select a subset of parameters to justify your answer.
#  Compare computational time as well.

