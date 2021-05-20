install.packages('IRkernel')
IRkernel::installspec()

# R script
w +1

weight = 5
weight * 2

# Analyze data with R:

# Load the data and set directory:

setwd("C:/Users/cms27/Desktop/Github/IP2019/R/r-novice-inflammation-data/data")
d = read.csv(file = "inflammation-01.csv", header = FALSE)

install.packages('IRkernel')

# Display the 3 first lines with "head":
head(d, n = 3L)

# Display the data (follow up):

d

d[1,1]                      # first row, first column
d[c(1, 3, 5), c(10, 20)]    # rows (1, 3 and 5), columns (10 and 20)
d[1:5, 1:3]                 # row from 1 to 5 and column 1 to 3
d[1, 1:5]                  # columns from 1 to 5 and row 1 
d[, 1]                      # all rows from col 1
d[1, ]                      # all column from row 1

# Indexing:
d[, 1]

min(d[, 1])               # the min inflammation on day 1
d[5, ]
max(d[5, ])               # the max inflammation for patient 5 











max(d[, c(4, 8, 12)])     # the max inflammation on days 4, 8 and 12 
min(d[c(3, 6), c(1,2,3,4,5)])      #  the min inflammation for patients 3 and 6 from day 1 to 5
mean(d[2, 4])

rowMeans(d[c(2, 4, 10),]) # the mean inflammation for patients 2, 4 and 10

summary(d[, 1:5])

# Exercice: compute in two different ways the mean for the first 10 patients of our data 
d[1:10,]

apply(d[1:10,], 1, mean)

rowMeans(d[1:10,])

# Plot:

plot(apply(d, 2, max), xlab = "day", ylab = "maximum", main = "maximum inflammation by day")
boxplot(d, main = "Summary")

# Exercise 2:
min_inf = apply(d,2,min)
plot(min_inf, xlab = "day", ylab = "min", main = "min inflammation by day")


# Exercise 3:
fk <- function(temp_F) {
  temp_K <- ((temp_F - 32) * (5 / 9)) + 273.15
  return(temp_K)
}

fk(32)

kc <- function(temp_K) {
  temp_C <- temp_K - 273.15
  return(temp_C)
}

fc <- function(temp_F) {
  temp_K <- fk(temp_F)
  temp_C <- kc(temp_K)
  val = c(temp_K, temp_C)
  return(val)
}



fc(32)

sum <- function(a,b,c =0,d = 0) {
  result = a + b
  result2 = c + d
  return(c(result, result2))
}

sum(5,10, 3, 4)


# Ex 5:

vp = c("***")
vc = c("Hello", "World")

fence = function(A,B){
  C = c(A,B,A)
  return(C)
}

newvec2 = fence(vc,vp)

newvec2

newvec2[4]
newvec2[length(newvec2)]

outside <- function(A){
  
  first = A[1]
  last = A[length(A)]
  
  C = c(first,last)
  
  return(C)
}

outside(newvec)


fence <- function(original, wrapper) {
  o <- c(wrapper, original, wrapper)
  return(o)
}

output = fence(original = vc, wrapper = vp)
output
output[3]
length(output)




# Ex 5bis
outside <- function(v) {
  first <- v[1]
   last <- v[length(v)]
   answer <- c(first, last)
   return(c(answer, length(v)))
}


# Test:
answer = fence(vc, vp)
outside(fence(vc, vp))


#####################################################################
#####################################################################
# Final exercise:

analyze <- function(filename) {
  # Plots the average, min, and max inflammation over time.
  # Input is character string of a csv file.
  d <- read.csv(file = filename, header = FALSE)
  avg_i <- apply(d, 2, mean)
  plot(avg_i)
  max_i <- apply(d, 2, max)
  plot(max_i)
  min_i <- apply(d, 2, min)
  plot(min_i)
}

path = "C:/Users/cms27/Desktop/Github/IP2019/R/r-novice-inflammation-data/data/inflammation-01.csv"
analyze(path)

pdf("C:/Users/cms27/Desktop/inflammation-01.pdf")
analyze("C:/Users/cms27/Desktop/Github/IP2019/R/r-novice-inflammation-data/data/inflammation-01.csv")
dev.off()


analyze_all <- function(pattern) {
  # Runs the function analyze for each file in the current working directory
  # that contains the given pattern.
  filenames <- list.files(path = "C:/Users/cms27/Desktop/Github/IP2019/R/r-novice-inflammation-data/data/", pattern = glob2rx(pattern), full.names = TRUE)
  for (f in filenames) {
    analyze(f)
  }
}

list.files(path = "C:/Users/cms27/Desktop/Github/IP2019/R/r-novice-inflammation-data/data", pattern =  "inflammation")

list.files(path = "C:/Users/cms27/Desktop/Github/IP2019/R/r-novice-inflammation-data/data", pattern =  "inflammation-[0-9]{2}.csv")
list.files(path = "C:/Users/cms27/Desktop/Github/IP2019/R/r-novice-inflammation-data/data", pattern = glob2rx("*inf*.csv"), full.names = TRUE)
list.files(path = "C:/Users/cms27/Desktop/Github/IP2019/R/r-novice-inflammation-data/data", pattern = glob2rx("*inf*.csv") , full.names = TRUE)


pdf("inflammation-all.pdf")
analyze_all("*inf*.csv")
dev.off()





View(cars)

## Ex3:

sign<-function(arg1){
if (arg1 < 0){return("Negative")}
else if (arg1 == 0){print("Null")}
else {print("Positive")}
}

sign(1)
sign(2)




sign2<-function(arg1=0, arg2){
  if (arg1 < 0 & arg2 < 0){return("Both negative")}
  else if (arg1 > 0 & arg2 > 0){print("Both positive")}
  else if (arg1 == 0 & arg2 == 0){print("Both zero")}
  else {print("Different sign")}
}

sign2(,0)

# Exercice 4 (Hard!): Introduction to Programming 
filenames <- list.files(path = "C:/Users/cms27/Desktop/Github/IP2019/R/r-novice-inflammation-data/data", pattern = "inflammation-[0-9]{2}.csv", full.names = TRUE)
filenames

filename_max <- "" # filename where the maximum average inflammation patient is found
patient_max <- 0 # index (row number) for this patient in this file
average_inf_max <- 0 # value of the average inflammation score for this patient

for (f in filenames) {
  d <- read.csv(file = f, header = FALSE)
  d.means <- apply(d, 1, mean)
  for (patient_index in 1:length(d.means)){
    patient_average_inf <- d.means[patient_index]
    if (patient_average_inf > average_inf_max) {
  		average_inf_max = patient_average_inf
  		filename_max = f
  		patient_max = patient_index
		}
  }
}

print(filename_max)
print(patient_max)
print(average_inf_max)

d.means

# Exercice 4 (Hard!): Introduction to Programming 
filenames <- list.files(path = "C:/Users/Cl?ent/Desktop/Github/IP2019/R/r-novice-inflammation-data/data", pattern = "inflammation-[0-9]{2}.csv", full.names = TRUE)

filename_max <- "" # filename where the maximum average inflammation patient is found
patient_max <- 0 # index (row number) for this patient in this file
average_inf_max <- 0 # value of the average inflammation score for this patient

for (f in filenames) {
  d <- read.csv(file = f, header = FALSE)
  d.means <- apply(d, 1, mean)
  for (patient_index in 1:length(d.means)){
    patient_average_inf <- d.means[patient_index]
    if (patient_average_inf > average_inf_max) {
      average_inf_max <- patient_average_inf
      filename_max <- f
      patient_max <- patient_index
    }
  }
}
print(filename_max)
print(patient_max)
print(average_inf_max)

## Ex 5: Rewrite analize()
analyze <- function(filename, output = NULL) {
  # Plots the average, min, and max inflammation over time.
  # Input:
  #    filename: character string of a csv file
  #    output: character string of pdf file for saving
  if (!is.null(output)) {
    pdf(output)
  }
  dat <- read.csv(file = filename, header = FALSE)
  avg_day_inflammation <- apply(d, 2, mean)
  plot(avg_day_inflammation)
  max_day_inflammation <- apply(d, 2, max)
  plot(max_day_inflammation)
  min_day_inflammation <- apply(d, 2, min)
  plot(min_day_inflammation)
  
  if (!is.null(output)) {
    dev.off()
  }
}


######################################################
# Session 10: structure in R

i = 2L
i

class(i)
typeof(i)
length(i)
attributes(i)

i = i * 1.2
class(i)
typeof(i)
length(i)
attributes(i)

x = "dataset"
class(x)
typeof(x)
length(x)
attributes(x)

y = 1:10
class(y)
typeof(y)
length(y)
attributes(y)

z = as.numeric(y)
class(z)
typeof(z)
length(z)
attributes(z)

# How to generate a list:
vector("character", length = 5)
character(5)
logical(5)
x = c(1,2,3)
typeof(x)

z  = c("S", "T", "J")
z = c(z,"A")

series  = 1:10
series2 = seq(10)
series == series2

# Ex2:
 
seq(1,10,0.1)

# Ex3:
x = c("a", NA, "c", "d", NA)
y = c("a", "b", "c", "d", "e")

is.na(y)
anyNA(y)

# Ex3 bis: 
xx = c(1.7, "a")
xx
typeof(xx)
class(xx)

xx = c(TRUE, FALSE, 2)
xx
xx = c("a", TRUE)
xx
xxx = as.logical(xx)
xxx

# Matrix
m = matrix(nrow =2, ncol=2)
dim(m)

m2 = matrix(10,50)
dim(m2)
m2 = matrix(0, 10,50)
dim(m2)


m2[i,j]

m = matrix(0,2,2)
m = 1:4 
dim(m) = c(2,2)

# Ex4:
m = matrix(0,10,10)
m
for (i in 1:10){
  for (j in 1:10){
  m[i,j] = i*j
  }
}
m

# Ex4 bis:
m = matrix(NA,10,10)
for (i in 1:10){
  for (j in 1:10){
    if (i == j){m[i,j] = 1}
    else {m[i,j] = 0}
  }
}


# Lists:

x = list(1,"a", TRUE, 1+4i)
class(x)
class(x[[4]])

mylist = list(a = "Name", b = 1:10, data = head(iris))
mylist$b
names(mylist)

class(mylist)
class(mylist$data)

# Dataframe:
dt <- data.frame(id =letters[1:10], x = NA, y = NA)
dt
lt <- list(id =letters[1:10], x = 1:10, y = 11:20)
dt$y
lt
str(dt)

# Ex5:

# Best version:
dt = data.frame(id = letters[1:10], x =NA, y = NA)
dt

for (i in 1:10){
  if (dt$id[i] == "e"){dt$x[i] = 1}
  else{dt$x[i] = 0}
  dt$y[i] = i
  dt$z = dt$x + dt$y
}

dt
# Alternative:
dt = data.frame(id = letters[1:10], x =0, y = 0)
for (i in 1:10){
  if(i == 5){dt$x[i] = 1}
  else{dt$x[i] = 0}
  dt$y[i] = i
dt$z = dt$x + dt$y
}

dt2 <- data.frame(id = letters[1:10],
                 x = "", y = "")


class(dt2$x)
dt2$x[1]
levels(dt2$x)

sapply(dt2, mode)
sapply(dt2, typeof)

transform(dt2, x = as.numeric(x))

dt2$x[2] = 1
dt
dt$id
typeof(dt$x)

######################################################
## 28.04.2019 -- Econometrics
######################################################

install.packages("stringi")
install.packages("tidyverse")
install.packages("ggplot2")

require("magrittr")
require("tidyverse")
require("dplyr")
require("AER")
require("nycflights13")
require("gapminder")
require("Lahman")
require("ggthemes")
require("gridExtra")

library(abc)
library(tidyverse)
library("dplyr")
library("AER")
library("nycflights13")
library("gapminder")
library("Lahman")
library("ggthemes")
library("gridExtra")
library("magrittr")


x = seq(0,10,0.3)
y =  2 + 3 * x + rnorm(length(x))
plot(x~y)

data("Journals", package = "AER")
journals = as_tibble(Journals, package = "AER")

####
# Exercise 2:

#Q1:
journals <-  mutate(journals, citeprice = price / citations)
journals$new = journals$price / journals$citations

#Q2:
plot(subs~(price/citations), data= Journals)
plot(subs~(citeprice), data= journals)
plot(log(subs) ~ log(price/citations), data = Journals)

####


ggplot(journals) + geom_point(aes(x = subs, y=citeprice))

ggplot(journals) + geom_point(aes(x = log(subs), y=log(citeprice)))

g = ggplot(journals)
p1 = g + geom_histogram(aes(x=citeprice), fill= "tomato3")
p2 = g + geom_histogram(aes(x=subs), fill= "tomato3")
p3 = g + geom_histogram(aes(x=log(citeprice)), fill= "tomato3")
p4 = g + geom_histogram(aes(x=log(subs)), fill= "tomato3")
grid.arrange(p1,p2,p3,p4)

ggplot(journals) + geom_point(aes(x = subs, y=citeprice))

###

journal_lm <- lm(log(subs) ~ log(citeprice), data = journals)
summary(j_lm)
abline(j_lm)

ggplot(journals, aes(x = log(citeprice), y = log(subs))) + geom_point() + stat_smooth(method = "lm", col = "tomato3")


plot(subs~citations, data= Journals)

journal_lm <- journals %>% lm(log(subs) ~ log(citeprice), data = .)
summary(journal_lm)

ggplot(journals, aes(x = log(citeprice), y = log(subs))) + geom_point() + stat_smooth(method = "lm", col = "tomato3")

plot(journal_lm, which = 1)
# Check for non linearities

plot(journal_lm, which = 2)
# Normality of residuals

plot(journal_lm, which = 3)

#That the red line is approximately horizontal. 
#Then the average magnitude of the standardized residuals isn't changing much as a function of the fitted values.
#That the spread around the red line doesn't vary with the fitted values.
# Then the variability of magnitudes doesn't vary much as a function of the fitted values.

linearHypothesis(journal_lm, "log(citeprice) = 1")

ggplot(journals) + geom_point(aes(x = subs, y=citeprice))
g = ggplot(journals)
p1 = g + geom_histogram(aes(x=citeprice), fill= "tomato3")
p2 = g + geom_histogram(aes(x=subs), fill= "tomato3")
p3 = g + geom_histogram(aes(x=log(citeprice)), fill= "tomato3")
p4 = g + geom_histogram(aes(x=log(subs)), fill= "tomato3")
grid.arrange(p1,p2,p3,p4)

ggplot(journals) + geom_point(aes(x = log(subs), y=log(citeprice)))

## Ex 2:

data("CPS1988", package = "AER")

cps = as_tibble(CPS1988)

cps

cps_lm = lm(log(wage) ~ experience + I(experience^2) + education + I(education^2) + ethnicity + smsa + region + parttime, data =cps)
summary(cps_lm)

cps_lm = cps %>% lm(log(wage) ~ experience + I(experience^2) + education + ethnicity, data =.)
summary(cps_lm)

cps_lm = cps %>% lm(log(wage) ~ experience + I(experience^2) + education + relevel(ethnicity, ref="afam"), data =.)
summary(cps_lm)

cps_lm = cps %>% lm(log(wage) ~ experience + I(experience^2) + education + ethnicity -1, data =.)
summary(cps_lm)

cps_lm = cps %>% lm(log(wage) ~ experience + I(experience^2) + education * ethnicity, data =.)
summary(cps_lm)

cps_lm = cps %>% lm(log(wage) ~ ethnicity / (experience + I(experience^2) + education), data =.)
summary(cps_lm)

jour_wls1 <- journals %>% lm(log(subs) ~ log(citeprice), data = ., weights = 1 / citeprice^2)
plot(jour_wls1, which = 3)

## STEP 1
jour_lm <- lm(log(subs) ~ log(citeprice), data = journals)

##STEP 2
aux_reg <- lm(log(residuals(jour_lm)^2) ~ log(citeprice), data = journals)

## STEP 3
jour_fgls <- lm(log(subs) ~ log(citeprice), data = journals, weights = 1 / exp(fitted(aux_reg)))

plot(jour_lm, which = 3)
plot(jour_fgls, which = 3)

install.packages("abc")
require("abc")

# -- Hackathon:

dgp <- function(n){
  
  x = seq(0,n,1)
  x1 = rnorm(length(x), 2, 0.1)
  x2 = rnorm(length(x) , 0, 0.1)
  y = 1 + 2 * x1 + x2
  
  datatest = tibble( 
    x1 = x1,
    x2 = x2,
    y  = y
  )
  
  return(datatest)
}

data = dgp(10000)



lm(y~x1, data=data)
lm1 = data %>% lm(y~x1, data=.)
summary(lm1)
hist(data$x1, prob=T, breaks="FD")
curve(dnorm(x), add=T)


x2 = rbeta(10000, 0.5,0.5)
plot(x2)      
hist(x2)
