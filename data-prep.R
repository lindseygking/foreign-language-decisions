library(tidyverse)

# read dataset from csv file 
FLDM_tidy_long <- read.csv("FLDM_tidy.csv") %>%
  # remove extraneous columns
  select(-c(order, l2.mean.skills, l2.years, age, gender, language.group)) %>% 
  # remove outlier row
  slice(-c(74)) %>% 
  # make data longer by having dilemma type as its own column 
  pivot_longer(cols = c("trolley.choice", "footbridge.choice", "non.moral.choice"),
               names_to = "dilemma.type",
               values_to = "dilemma.choice")
  
  
# add zeros before id numbers with stringr to make each id number 3 digits long (consistency)
FLDM_tidy_long$ID <- str_pad(FLDM_tidy_long$ID, 3, pad = '0') 


# export dataframe to a csv file
write_csv(FLDM_tidy_long, "~/Desktop/UCHI Q2/d2m/foreign-language-decisions/FLDM_tidy_long.csv") 
