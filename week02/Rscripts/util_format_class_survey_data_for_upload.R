# DO NOT UPLOAD TO MOODLE
#  This is a utility file to be run on the downloaded class data after they take the survey.
#  This file will format the class's data

# read in file with names
classData = read.csv("/Users/jillnaiman/Dropbox/teaching/stats_fall_2020/week02/Intake_Survey.csv")

# take out columns -> Moodle formatting
#newData = classData[,-c(1,2,3,4,5,6,7,8,9,10,23,24,25,26)]
newData = classData[,c(11,13,14)]
# rename
names(newData) = c("familiarity.with.stats", "programming.language.tmp", "time.programming.tmp")
# do some cleaning
progLang = c()
for (i in 1:nrow(newData)){
  # look for Python
  if (length(grep('Python',newData$programming.language.tmp[i])) != 0){
    progLang = c(progLang,"Python")
  } else if (length(grep('python',newData$programming.language.tmp[i])) != 0){
    progLang = c(progLang, "python")
  } else if (newData$programming.language.tmp[i] == 'R'){
    progLang = c(progLang, 'R')
  } else if (newData$programming.language.tmp[i] == 'r'){
    progLang = c(progLang, 'R')
  } else if (newData$programming.language.tmp[i] == 'JS'){
    progLang = c(progLang, 'JavaScript')
  } else if (length(grep('sql',newData$programming.language.tmp[i])) != 0){
    progLang = c(progLang, 'R')
  } else if (length(grep('Shell',newData$programming.language.tmp[i])) != 0){
    progLang = c(progLang, 'Shell')
  } else if (length(grep('None',newData$programming.language.tmp[i])) != 0){
    progLang = c(progLang, 'Python') # default
  } else if (newData$programming.language.tmp[i] == 'c'){
    progLang = c(progLang, 'C/C++')
  }
}
# save
newData$programming.language = progLang
# drop temp
newData = newData[,!names(newData) %in% c("programming.language.tmp")]

# clean time
times = c()
for (i in 1:nrow(newData)){
  # look for Python
  pos = grep(':',newData$time.programming.tmp[i])
  times = c(times, substr(newData$time.programming.tmp[i],pos+4, 10000))
}
# save
newData$time.programming = times
# drop temp
newData = newData[,!names(newData) %in% c("time.programming.tmp")]

# write out
write.csv(newData, file = "/Users/jillnaiman/Dropbox/teaching/stats_fall_2020/week02/formatted_class_answers_orig.csv")


# # write out file
# write.csv(newData, file = "/Users/jillnaiman/Dropbox/teaching/stats_spring_2020/week02/formatted_class_answers_orig_orig.csv")
# 
# time_in = newData[,5]
# # lets reformat this data a bit!
# time_min = c() # storage
# time_max = c() # storage
# # lets look at the options again
# myLevels = levels(time_in)
# print(myLevels)
# # so ,we can see our options
# # lets do a for loop!
# for (i in 1:length(time_in)){
#   # note we can also do: time_in[i] == '< 6 months'
#   if (time_in[i] == myLevels[1]){ # < 6 months
#     time_min = c(time_min,0)
#     time_max = c(time_max, 0.5) # in years
#   } else if (time_in[i] == myLevels[2]) { # 1-2 years
#     time_min = c(time_min, 1.0)
#     time_max = c(time_max, 2.0)
#   } else if (time_in[i] == myLevels[3]) {
#     time_min = c(time_min, 2.0)
#     time_max = c(time_max, 4.0)
#   } else {
#     time_min = c(time_min,0.5)
#     time_max = c(time_max,1.0)
#   }
# }
# 
# 
# # to print like fall 2018 for examples of datatypes
# dataTypes = newData[c(1,4)]
# # rename
# names(dataTypes) = c("Fam.Stats","language")
# 
# # add time min & max
# dataTypes$time_yr.min = time_min
# dataTypes$time_yr.max = time_max
# 
# # for viewing
# View(dataTypes)
# 
