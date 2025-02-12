library(MASS)
data("Boston")

#1
cat("Class of the dataset: ", class(Boston), "\n")
cat("Dimensions (Rows x Columns): ", dim(Boston), "\n")

#2
small_data <- Boston[, c("medv", "crim", "nox", "black", "lstat")]

pairs(small_data, main="Scatter plots of predictors vs median home value")

# 3. Find the suburb with the lowest median value of owner-occupied homes
min_medv <- Boston[which.min(Boston$medv),]
cat("Suburb with lowest median home value (medv):\n")
print(min_medv)

# Compare the values with overall ranges
cat("\nSummary statistics for the entire dataset:\n")
summary(Boston)

# 4. Identify suburbs with notably high crime rates, tax rates, or pupil-teacher ratios
cat("\nSummary statistics for crime rate, tax rate, and pupil-teacher ratio:\n")
summary(Boston[c("crim", "tax", "ptratio")])

# 5. Count how many suburbs bound the Charles River
charles_river_suburbs <- sum(Boston$chas == 1)
cat("\nNumber of suburbs that bound the Charles River: ", charles_river_suburbs, "\n")

# 6. Count how many suburbs average more than seven rooms per dwelling
more_than_7_rooms <- sum(Boston$rm > 7)
cat("\nNumber of suburbs with more than seven rooms per dwelling: ", more_than_7_rooms, "\n")

# 7. Additional question: Correlation between 'black' and 'lstat'
cor_black_lstat <- cor(Boston$black, Boston$lstat)
cat("\nCorrelation between proportion of blacks and percentage of lower status population: ", cor_black_lstat, "\n")
