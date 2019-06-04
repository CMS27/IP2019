library("tidyverse")
library("tibble")
library("rcompanion")
library("ggplot2")
library("stats")
library("car")
library("MASS")

#Question 1
dgp<- function(n,s) {
e=rnorm(n,0,1)
set.seed(s)
x1=rnorm(n,2,0.1)
set.seed(s)
x2=rbeta(n,0.3,0.3)
set.seed(s)
x3=runif(n,0,1)
y=2+0.5*x1-x2+2*x3+e
data<-tibble(x1,x2,x3,e,y)
return(data)
}
dgp100<-dgp(100,1)
dgp1000<-dgp(1000,1)
dgp10000<-dgp(10000,1)

#Question 2
#Plot x1
plotNormalHistogram(dgp10000$x1)
#Plot x2
hist(dgp10000$x2,freq=FALSE)
b<-density(dgp10000$x2)
lines(b)

#Question 3
y_lm = dgp10000 %>% lm(y~x1+x2+x3,data=.)
y_lm
linearHypothesis(y_lm, "x1=0")
linearHypothesis(y_lm, "x2=0")
linearHypothesis(y_lm, "x3=0")
linearHypothesis(y_lm, c("x1=0","x2=0","x3=0"))


#Question 4
for (i in 1:1000){
  dgp_<-dgp(10000,i)
  y.lm<-dgp_ %>% lm(y~x1+x2+x3, data=.)
  if (i==1){
    beta2<-as.vector(y.lm$coefficients[3])
    bias2<-as.vector(mean(beta2)+1)
    mean2<-as.vector(mean(beta2))
  }
  else{
    beta2<-as.vector(c(beta2, y.lm$coefficients[3]))
    bias2<-as.vector(c(bias2,mean(beta2)+1))
    mean2<-as.vector(c(mean2,mean(beta2)))
  }
  rm(dgp_)
  rm(y.lm)
}

plot(bias2,xlab="Number of simulations",ylab=expression(paste("Bias of ",hat(beta),"2")))
abline(h=0)
plot(mean2,xlab="Number of simulations", ylab = expression(paste("Mean of ",hat(beta),"2")))
abline(h=-1)


#Question 5
for (i in seq(10,100000,length.out=10)){
  dgp_<-dgp(i,1)
  y.lm<-dgp_ %>% lm(y~x1+x2+x3, data=.)
  if (i==10){
    beta1<-as.vector(y.lm$coefficients[2])
  }
  else{
    beta1<-as.vector(c(beta1, y.lm$coefficients[2]))
  }
  rm(dgp_)
  rm(y.lm)
}
plot(seq(10,100000,length.out=10), beta1,  xlab="Number of observation", ylab=expression(paste(hat(beta),"1")))
abline(h=1/2)