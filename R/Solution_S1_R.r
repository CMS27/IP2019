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

kc <- function(temp_K) {
  temp_C <- temp_K - 273.15
  return(temp_C)
}

fc <- function(temp_F) {
  temp_K <- fk(temp_F)
  temp_C <- kc(temp_K)
  return(temp_C)
}

# Ex 5:
fence <- function(original, wrapper) {
  answer <- c(wrapper, original, wrapper)
  return(answer)
}

# Ex 5bis
outside <- function(v) {
  first <- v[1]
   last <- v[length(v)]
   answer <- c(first, last)
   return(answer)
}

# Test:
fence(vc, vp)
outside(answer)


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

analyze(path)

pdf("inflammation-01.pdf")
analyze("C:/Users/Cl?ent/Desktop/Github/IP2019/R/r-novice-inflammation-data/data/inflammation-01.csv", 1)
dev.off()




analyze_all <- function(pattern) {
  # Runs the function analyze for each file in the current working directory
  # that contains the given pattern.
  filenames <- list.files(path = "C:/.../data", pattern = glob2rx(pattern), full.names = TRUE)
  for (f in filenames) {
    analyze(f)
  }
}

list.files(path = "C:/Users/Cl?ent/Desktop/Github/IP2019/R/r-novice-inflammation-data/data", pattern =  glob2rx("*inf*.csv") , full.names = TRUE)
list.files(path = "C:/Users/Cl?ent/Desktop/Github/IP2019/R/r-novice-inflammation-data/data", pattern =  "inflammation-[0-9]{2}.csv")
list.files(path = "C:/Users/Cl?ent/Desktop/Github/IP2019/R/r-novice-inflammation-data/data", pattern =  "inflammation*.csv")


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

sign(-6)

sign2<-function(arg1 = 1, arg2= 1){
  if (arg1 < 0 & arg2 < 0){return("Both negative")}
  else if (arg1 > 0 & arg2 > 0){print("Both positive")}
  else {print("Different sign")}
}

sign2(-6,-1)

# Exercice 4 (Hard!): Introduction to Programming 
filenames <- list.files(path = "C:/Users/Clément/Desktop/Github/IP2019/R/r-novice-inflammation-data/data", pattern = "inflammation-[0-9]{2}.csv", full.names = TRUE)

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
dt = data.frame(id = letters[1:10], x =0, y = 0)
for (i in 1:10){
  if(i == 5){dt$x[i] = 1}
  else{dt$x[i] = 0}
  dt$y[i] = i*i
dt$z = dt$x + dt$y
}

dt2 <- data.frame(id = letters[1:10],
                 x = "", y = "")
sapply(dt2, mode)
sapply(dt2, typeof)

transform(dt2, x = as.numeric(as.character(x)))

dt2$x[2] = 1
dt
dt$id
typeof(dt$x)

######################################################
## 28.04.2019 -- Econometrics
######################################################

install.packages("stringi")
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


journals <- journals %>% mutate(citeprice = price / citations)

j_lm <- lm(log(subs) ~ log(price/citations), data = Journals)
plot(log(subs) ~ log(price/citations), data = Journals)
abline(j_lm)
summary(j_lm)


plot(subs~citations, data= Journals)

journal_lm <- journals %>% lm(log(subs) ~ log(citeprice), data = .)
summary(journal_lm)

ggplot(journals, aes(x = log(citeprice), y = log(subs))) + geom_point() + stat_smooth(method = "lm", col = "tomato3")

plot(journal_lm, which = 1)
plot(journal_lm, which = 2)
plot(journal_lm, which = 3)

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
