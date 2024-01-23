# read dataset from csv file 
FLDM_tidy_data <- read.csv("FLDM_tidy.csv")

# add zeros before id numbers with stringr to make each id number 3 digits long (consistency)
stringr::
  
# remove extraneous columns
# the only columns you need are: participant ID, language condition, choices, and language proficiency 
FLDM_tidy_data <- select(-c(#insert unwanted columns here
  ))
  
# make data long for the sake of the tidyverse
# turn dilemma type from individual rows to one column 
# each participant will have 3 rows (one for each dilemma type)
pivot_longer()

# export dataframe to a csv file
write_csv(FLDM_tidy_data, "~/Desktop/UCHI Q2/d2m/foreign-language-decisions/FLDM_tidy_data.csv") 