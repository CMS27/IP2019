# R script

weight = 5
weight * 2

# Analyze data with R:

# Load the data and set directory:
setwd("C:/Users/Clément/Desktop/Github/IP2019/R/r-novice-inflammation-data/data")
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