rm(list=ls())
# Load required libraries
library(MASS)
library(ggplot2)
library(dplyr)

# Load the Boston dataset
data("Boston")

# ----------------- Question 1: Class, Rows, and Columns -----------------

# Check the class of the dataset
dataset_class = class(Boston)
print(paste("Class of dataset:", dataset_class))

# Get dimensions of dataset
dataset_dim = dim(Boston)
print(paste("Number of rows:", dataset_dim[1]))
print(paste("Number of columns:", dataset_dim[2]))

# Column names
print("Column names:")
print(colnames(Boston))

# ----------------- Question 2: Create Smaller Dataset and Scatter Plots -----------------

# Select relevant variables
boston_small = Boston[, c("medv", "crim", "nox", "black", "lstat")]

# Create scatter plots in a single graph using ggplot2
plot1 = ggplot(boston_small, aes(x=crim, y=medv)) + 
  geom_point() + 
  ggtitle("Median Home Value vs Crime Rate")

plot2 = ggplot(boston_small, aes(x=nox, y=medv)) + 
  geom_point() + 
  ggtitle("Median Home Value vs Nitrogen Oxides")

plot3 = ggplot(boston_small, aes(x=black, y=medv)) + 
  geom_point() + 
  ggtitle("Median Home Value vs Proportion of Blacks")

plot4 = ggplot(boston_small, aes(x=lstat, y=medv)) + 
  geom_point() + 
  ggtitle("Median Home Value vs Lower Status Percentage")

# Arrange plots in a single panel
library(gridExtra)
grid.arrange(plot1, plot2, plot3, plot4, ncol=2)

# ----------------- Question 3: Lowest Median Value Suburb -----------------

# Find suburb with the lowest median home value
lowest_medv_suburb = Boston[which.min(Boston$medv), ]
print("Suburb with lowest median home value:")
print(lowest_medv_suburb)

# Compare values of predictors
summary_boston = summary(Boston[, c("crim", "nox", "black", "lstat")])
print("Summary of the selected predictors:")
print(summary_boston)

# ----------------- Question 4: High Crime Rates, Tax Rates, and Pupil-Teacher Ratios -----------------

# Find suburbs with high crime, tax, or pupil-teacher ratios
high_crime = Boston[which.max(Boston$crim), ]
high_tax = Boston[which.max(Boston$tax), ]
high_ptratio = Boston[which.max(Boston$ptratio), ]

print("Suburb with highest crime rate:")
print(high_crime)

print("Suburb with highest tax rate:")
print(high_tax)

print("Suburb with highest pupil-teacher ratio:")
print(high_ptratio)

# ----------------- Question 5: Suburbs Bounded by Charles River -----------------

# Count suburbs that bound the Charles River
charles_river_count = sum(Boston$chas == 1)
print(paste("Number of suburbs bordering the Charles River:", charles_river_count))

# ----------------- Question 6: Suburbs with More Than 7 Rooms per Dwelling -----------------

# Count suburbs with average rooms > 7
high_rm_count = sum(Boston$rm > 7)
print(paste("Number of suburbs with more than 7 rooms per dwelling:", high_rm_count))

# ----------------- Question 7: Additional Analysis -----------------

# Question: How many suburbs have median home value above $40,000?
high_medv_count = sum(Boston$medv > 40)
print(paste("Number of suburbs with median home value above $40,000:", high_medv_count))




# Histograms to visualize distributions
par(mfrow = c(1, 3))  # Arrange plots in a 1x3 grid

# Histogram for crime rate
hist(Boston$crim, breaks = 50, main = "Crime Rate Distribution",
     xlab = "Per Capita Crime Rate", col = "lightblue")

# Histogram for tax rate
hist(Boston$tax, breaks = 50, main = "Tax Rate Distribution",
     xlab = "Property Tax Rate per $10,000", col = "lightgreen")

# Histogram for pupil-teacher ratio
hist(Boston$ptratio, breaks = 50, main = "Pupil-Teacher Ratio Distribution",
     xlab = "Pupil-Teacher Ratio", col = "lightcoral")


