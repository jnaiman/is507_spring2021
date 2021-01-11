# plotting KNN function
# Let's plot this using our "contour" function again
plot2dProbKNN <- function(knn_train_prediction, sample_data, grid_size, prob_cut_off, xmin,xmax, ymin,ymax, 
                          prob, xlabel='x1', ylabel='x2',
                          col1 = "magenta", col2="blue", ytoggle=1, title="", lwd=1){
  
  x1_new = seq(x1min,x1max,length=grid_size)
  x2_new = seq(x2min,x2max,length=grid_size)
  # This is a bit of a hack - it just flips the probability so that we
  #  pick out *only* the 0.5 line for prob = -1
  # This is just fancy stuff for plotting
  prob2 = ifelse(knn_train_prediction=="1", prob, 1-prob)
  # Basically, we are now calculating the probability of "success"
  #  instead of probability of belonging in a specific group.
  
  # Formatting for contour plots (like before)
  prob2 = matrix(prob2, grid_size, grid_size)
  
  contour(x1_new,x2_new, prob2, levels=prob_cut_off, labels="", main=title,lwd=lwd,xlab=xlabel,ylab=ylabel)
  mask = sample_data$y == ytoggle
  points(sample_data$x1[mask], sample_data$x2[mask], col=col1)
  points(sample_data$x1[!mask], sample_data$x2[!mask], col=col2)
  
  
}


# plot GLM
plot2dProbGLM <- function(sample_data, grid_size, prob_cut_off, xmin,xmax, ymin,ymax, 
                          myProbFunction = probFunction, xlabel='x1', ylabel='x2',
                          col1 = "magenta", col2="blue", ytoggle=1){
  # a few variables we need:
  #grid_size = 100 # size of our grid (assume equal in x & y)
  #prob_cut_off = 0.5 # cut at 1/2 - 50% probability of success i.e. equally likely to be blue/pink
  # how far will our grid span in x1 and x2 - lets cover all space visible:
  #myx1_seq = seq(-2,4,length=grid_size)
  #myx2_seq = seq(-2, 4, length=grid_size) # for looping and testing
  myx1_seq = seq(xmin,xmax,length=grid_size)
  myx2_seq = seq(ymin, ymax, length=grid_size) # for looping and testing
  
  # Let's first make a probability grid - will calculate the probability of 
  #  success, i.e. probability that a specific grid point should be tagged as 
  #  being in the "magenta" distribution:
  probGrid = matrix(0,grid_size,grid_size) # 100x100 grid
  for (i in 1:grid_size){
    for (j in 1:grid_size){
      myProb = myProbFunction(myx1_seq[i],myx2_seq[j])
      # now, lets save!
      probGrid[i,j] = myProb
    }
  }
  
  contour(myx1_seq,myx2_seq, probGrid, levels=prob_cut_off, labels="", 
          xlab=xlabel, ylab=ylabel)
  mask = sample_data$y == ytoggle
  points(sample_data$x1[mask], sample_data$x2[mask], col=col1)
  points(sample_data$x1[!mask], sample_data$x2[!mask], col=col2)
  
}