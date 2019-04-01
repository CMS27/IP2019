# R script

weight = 5
weight * 2

# Analyze data with R:

# Load the data and set directory:
setwd("C:/Users/Cl?ent/Desktop/Github/IP2019/R/r-novice-inflammation-data/data")
d = read.csv(file = "inflammation-01.csv", header = FALSE)

# Display the 3 first lines with "head":
head(d, n = 3L)

# Display the data (follow up):

d[1,1]                      # first row, first column
d[c(1, 3, 5), c(10, 20)]    # rows (1, 3 and 5), columns (10 and 20)
d[1, 1:5]                   # columns from (1 to 5) and row 1
d[, 1]                      # all columns from row 1

# Indexing:

min(d[, 1])               # the min inflammation on day 1
max(d[5, ])               # the max inflammation for patient 5 
max(d[, c(4, 8, 12)])     # the max inflammation on days 4, 8 and 12 
min(d[c(3, 6), 1:5])      #  the min inflammation for patients 3 and 6 from day 1 to 5
rowMeans(d[c(2, 4, 10),]) # the mean inflammation for patients 2, 4 and 10

summary(d[, 1:5])

# Exercice: compute in two different ways the mean for the first 10 patients of our data 

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

pdf("inflammation-01.pdf")
analyze("C:/Users/Cl?ent/Desktop/Github/IP2019/R/r-novice-inflammation-data/data/inflammation-01.csv", 1)
dev.off()




analyze_all <- function(pattern) {
  # Runs the function analyze for each file in the current working directory
  # that contains the given pattern.
  j = 0
  filenames <- list.files(path = "C:/Users/Cl?ent/Desktop/Github/IP2019/R/r-novice-inflammation-data/data", pattern = glob2rx(pattern), full.names = TRUE)
  for (f in filenames) {
    j = j+1
    analyze(f,j)
  }
}

list.files(path = "C:/Users/Clément/Desktop/Github/IP2019/R/r-novice-inflammation-data/data", pattern =  glob2rx("*inf*.csv") , full.names = TRUE)
list.files(path = "C:/Users/Clément/Desktop/Github/IP2019/R/r-novice-inflammation-data/data", pattern =  "inflammation-[0-9]{2}.csv")
list.files(path = "C:/Users/Clément/Desktop/Github/IP2019/R/r-novice-inflammation-data/data", pattern =  "inflammation*.csv")


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
filenames <- list.files(path = "C:/Users/ClÃ©ment/Desktop/Github/IP2019/R/r-novice-inflammation-data/data", pattern = "inflammation-[0-9]{2}.csv", full.names = TRUE)

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