# Load Required Libraries
library(tidyverse)
library(ggplot2)
library(caret)

# Load Dataset
data = read.csv("your_dataset.csv")  # Replace with your actual dataset filename

# Data Preprocessing
# Convert categorical variables to factors
data$Marital.Status = as.factor(data$Marital.Status)
data$Gender = as.factor(data$Gender)
data$Education = as.factor(data$Education)
data$Occupation = as.factor(data$Occupation)
data$Home.Owner = as.factor(data$Home.Owner)
data$Commute.Distance = as.factor(data$Commute.Distance)
data$Region = as.factor(data$Region)
data$Purchased.Bike = as.factor(data$Purchased.Bike)

# Exploratory Data Analysis (EDA)
# Check for missing values
print(colSums(is.na(data)))

# Summary of Dataset
summary(data)

# Bike Sales by Region
bike_region = data %>%
  group_by(Region, Purchased.Bike) %>%
  summarise(Count = n())

# Plot: Bike Sales by Region
# Load necessary library
library(ggplot2)

# Enhanced Bar Plot for Bike Sales by Region
ggplot(bike_region, aes(x = Region, y = Count, fill = Purchased.Bike)) +
  geom_bar(stat = "identity", position = "dodge", color = "black", width = 0.7) +
  scale_fill_manual(values = c("#264653", "#E76F51")) +  # Deep teal & rich coral-orange
  labs(title = "Bike Sales by Region",
       subtitle = "Comparative analysis of bike purchases across regions",
       x = "Region", y = "Count",
       fill = "Bike Purchased") +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 18, color = "#2A2A2A"),
    plot.subtitle = element_text(size = 13, color = "#5A5A5A"),
    axis.title.x = element_text(size = 14, face = "bold"),
    axis.title.y = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 12, color = "#4A4A4A"),
    legend.position = "top",
    legend.title = element_text(face = "bold"),
    legend.text = element_text(size = 12),
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major.y = element_line(color = "gray80", linetype = "dashed")
  )


# Relationship between Age and Bike Purchase
# Load necessary library

# Improved Age Distribution Plot
ggplot(data, aes(x = Age, fill = Purchased.Bike)) +
  geom_histogram(binwidth = 5, position = "dodge", color = "black", alpha = 0.9) +
  scale_fill_manual(values = c("#1B4965", "#E63946")) +  # Deep navy & vibrant red
  labs(title = "Age Distribution by Bike Purchase",
       subtitle = "Comparing bike purchase trends across age groups",
       x = "Age", y = "Count",
       fill = "Bike Purchased") +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 18, color = "#2A2A2A"),
    plot.subtitle = element_text(size = 13, color = "#5A5A5A"),
    axis.title.x = element_text(size = 14, face = "bold"),
    axis.title.y = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 12, color = "#4A4A4A"),
    legend.position = "top",
    legend.title = element_text(face = "bold"),
    legend.text = element_text(size = 12),
    panel.grid.major = element_line(color = "gray80", linetype = "dashed"),
    panel.grid.minor = element_blank()
  )


# Relationship between Income and Bike Purchase
ggplot(data, aes(x = Income, fill = Purchased.Bike)) +
  geom_histogram(binwidth = 10000, position = "dodge") +
  labs(title = "Income Distribution by Bike Purchase", x = "Income", y = "Count") +
  theme_minimal()

# Predictive Modeling
# Logistic Regression
model = glm(Purchased.Bike ~ Age + Gender + Income + Marital.Status + Region + Occupation + Commute.Distance, 
            data = data, family = binomial)

# Model Summary
summary(model)

# Predictions
data$Prediction = predict(model, data, type = "response")
data$Predicted.Bike = ifelse(data$Prediction > 0.5, 1, 0)

# Model Evaluation
conf_matrix = table(data$Purchased.Bike, data$Predicted.Bike)
print(conf_matrix)

# Accuracy of Model
accuracy = sum(diag(conf_matrix)) / sum(conf_matrix)
print(paste("Model Accuracy:", round(accuracy, 4)))

# Conclusion:
# - Identify customer segments more likely to purchase bikes.
# - Recommend ideal regions for setting up new showrooms.

