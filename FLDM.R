
# read dataset from csv file 
FLDM_tidy_long <- read.csv("data/FLDM_tidy.csv") %>%
  # remove extraneous columns
  select(-c(order, l2.mean.skills, l2.years, age, gender)) %>% 
  # remove outlier row
  slice(-c(74)) %>% 
  # make data longer by having dilemma type as its own column 
  pivot_longer(cols = c("trolley.choice", "footbridge.choice", "non.moral.choice"),
               names_to = "dilemma.type",
               values_to = "dilemma.choice")


FLDM_tidy_long$language.group <- as.factor(FLDM_tidy_long$language.group)
FLDM_tidy_long$language.condition <- as.factor(FLDM_tidy_long$language.condition)

# add zeros before id numbers with stringr to make each id number 3 digits long (consistency)
FLDM_tidy_long$ID <- str_pad(FLDM_tidy_long$ID, 3, pad = '0') 


# export dataframe to a csv file
write_csv(FLDM_tidy_long, "data/FLDM_tidy_long.csv") 

FLDM_German <- FLDM_tidy_long %>% 
  filter(language.group != 5)


FLDM_English <- FLDM_tidy_long %>% 
  filter(language.group != 3)




# df for demographics table 
Condition <- c('Italian', 'English', 'German')
N <- c(39, 28, 36)
trolley.means <- c('54%','73%','61%')
footbridge.means <- c('13%', '43%', '36%')
non.moral.means <- c('87%', '92%', '93%')
FLDM_demographics <- data.frame(Condition, N, trolley.means, footbridge.means, non.moral.means)


## conduct descriptive analysis 
FLDM_data <- read.csv("data/S1_Dataset.csv")

FLDM_tidy <- FLDM_data %>% 
  # remove unwanted columns
  select(-c(l2.conversation, l2.reading, l2.understanding, l2.writing)) %>% 
  #arrange the ID numbers in ascending order
  arrange(ID)

# select only the necessary groups
FLDM_desc <- FLDM_tidy %>% 
  select(language.condition, language.group, trolley.choice, footbridge.choice, non.moral.choice) %>% 
  drop_na() 

# make longer for sake of dplyr
FLDM_desc_long <- FLDM_desc %>% 
  pivot_longer(c(trolley.choice, footbridge.choice, non.moral.choice), names_to = "dilemma.type")



  
    

