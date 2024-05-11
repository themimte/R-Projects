# Check if need to install rvest` library
require(rvset)
library(rvest)
libraryr(lkkrwrfw4gtf24tg
gergregr
seg
)
rtkgshkrwrvbg
gsdgwfwegfwegwe

gsrgrwgw
egewgwg
url <- "https://en.wikipedia.org/wiki/List_of_bicycle-sharing_systems"
# Get the root HTML node by calling the `read_html()` method with URL
root_node <- read_html(url)
table_node <- html_node(root_node, "table")
table_node

# Convert the bike-shafvserglregmegme4ring system table into a dataframe
dataframe <- html_table(table_nodes[3],fill = TRUE)
dataframe

# Summarize the dataframe
summary(dataframe)

# Export the dataframe into a csv file
write.csv(dataframe,"D:/raw_bike_sharing_systems.csv")


# Check if you need to install the `tidyverse` library
library(tidyverse)

bike_sharing_df <- read.csv("raw_seoul_bike_sharing.csv")

# Or you may read it from here again
# url <- "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-RP0321EN-SkillsNetwork/labs/datasets/raw_seoul_bike_sharing.csv"
# Notice some column names in the raw datasets are not standalized if you haven't done them properly in the previous lab


summary(bike_sharing_df)
dim(bike_sharing_df)

# Drop rows with `RENTED_BIKE_COUNT` column == NA
library(tidyr)
bike_sharing_df <- bike_sharing_df %>% drop_na(RENTED_BIKE_COUNT)

# Print the dataset dimension again after those rows are dropped
dim(bike_sharing_df)


bike_sharing_df %>% filter(is.na(TEMPERATURE))


# Calculate the summer average temperature
summer_average_temp <- mean(bike_sharing_df$TEMPERATURE, na.rm = TRUE)

# Impute missing values for TEMPERATURE column with summer average temperature
bike_sharing_df$TEMPERATURE <- ifelse(is.na(bike_sharing_df$TEMPERATURE),
                          summer_average_temp,
                          bike_sharing_df$TEMPERATURE)

# Print the summary of the dataset again to make sure no missing values in all columns
summary(bike_sharing_df)

# Save the dataset as `seoul_bike_sharing.csv`
write.csv(bike_sharing_df, "C:/Users/mimte/Desktop/R-Manaf/R-Notebooks/seoul_bike_sharing.csv")


# Convert SEASONS, HOLIDAY, FUNCTIONING_DAY, and HOUR columns into indicator columns.

bike_sharing_df$HOLIDAY <- factor(bike_sharing_df$HOLIDAY,
                         levels = c('No Holiday', 'Holiday'),
                         labels = c(0,1))

bike_sharing_df$FUNCTIONING_DAY <- factor(bike_sharing_df$FUNCTIONING_DAY,
                           levels = c('No', 'Yes'),
                           labels = c(0, 1))

bike_sharing_df$SEASONS = factor(bike_sharing_df$SEASONS,
                         levels = c('Spring','Summer','Autumn','Winter'),
                         labels = c(1, 2, 3,4))


# Print the dataset summary again to make sure the indicator columns are created properly
summary(bike_sharing_df)


# Save the dataset as `seoul_bike_sharing_converted.csv`
write_csv(bike_sharing_df, "seoul_bike_sharing_converted.csv")

# Use the `mutate()` function to apply min-max normalization on columns 
# `RENTED_BIKE_COUNT`, `TEMPERATURE`, `HUMIDITY`, `WIND_SPEED`, `VISIBILITY`, `DEW_POINT_TEMPERATURE`, `SOLAR_RADIATION`, `RAINFALL`, `SNOWFALL`
bike_sharing_df <- mutate(bike_sharing_df, RENTED_BIKE_COUNT= (RENTED_BIKE_COUNT- min(RENTED_BIKE_COUNT))/(max(RENTED_BIKE_COUNT)-min(RENTED_BIKE_COUNT)))
bike_sharing_df[,4:11] <- scale(bike_sharing_df[,2:11])

# Print the summary of the dataset again to make sure the numeric columns range between 0 and 1

# Save the dataset as `seoul_bike_sharing_converted_normalized.csv`
write_csv(bike_sharing_df, "seoul_bike_sharing_converted_normalized.csv")

# Dataset list
dataset_list <- c('seoul_bike_sharing.csv', 'seoul_bike_sharing_converted.csv', 'seoul_bike_sharing_converted_normalized.csv')

for (dataset_name in dataset_list){
    # Read dataset
    dataset <- read_csv(dataset_name)
    # Standardized its columns:
    dataset <- bike_sharing_df <- mutate(dataset, RENTED_BIKE_COUNT= (RENTED_BIKE_COUNT- min(RENTED_BIKE_COUNT))/(max(RENTED_BIKE_COUNT)-min(RENTED_BIKE_COUNT)))
    dataset[,4:11] <- scale(dataset[,4:11])
    # Convert all columns names to uppercase
    names(dataset) <- toupper(names(dataset))
    # Replace any white space separators by underscore, using str_replace_all function
    names(dataset) <- str_replace_all(names(dataset), " ", "_")
    # Save the dataset back
    write.csv(dataset, dataset_name, row.names=FALSE)
}

