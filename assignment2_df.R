library(tidyverse)
library(papaja)
require(base)

## ASSIGN VARIABLES
# assign numeric variable
age <- 23.37

# assign string variable
bday <- "August 21, 2000"

## CREATE DATAFRAME
# use above variables
age_df <- data.frame(age, bday)

print(age_df)