library(tidyverse)
library(reshape2)
# read dataset from csv file 
FLDM_tidy_long <- read.csv("FLDM_tidy.csv") %>%
  # remove extraneous columns
  select(-c(order, l2.mean.skills, l2.years, age, gender)) %>% 
  # remove outlier row
  slice(-c(74)) %>% 
  # make data longer by having dilemma type as its own column 
  pivot_longer(cols = c("trolley.choice", "footbridge.choice", "non.moral.choice"),
               names_to = "dilemma.type",
               values_to = "dilemma.choice")

FLDM_tidy_long$language.group <- as.factor(FLDM_tidy_long$language.group)
FLDM_tidy_long$dilemma.choice<-replace(FLDM_tidy_long$dilemma.choice, FLDM_tidy_long$dilemma.choice==2, 1) 
FLDM_tidy_long$dilemma.choice<-replace(FLDM_tidy_long$dilemma.choice, FLDM_tidy_long$dilemma.choice==1, 0) 
View(FLDM_tidy_long)
  
# add zeros before id numbers with stringr to make each id number 3 digits long (consistency)
FLDM_tidy_long$ID <- str_pad(FLDM_tidy_long$ID, 3, pad = '0') 


# export dataframe to a csv file
write_csv(FLDM_tidy_long, "~/Desktop/UCHI Q2/d2m/foreign-language-decisions/FLDM_tidy_long.csv") 

FLDM_German <- FLDM_tidy_long %>% 
  filter(language.group != 5)
View(FLDM_German)

FLDM_English <- FLDM_tidy_long %>% 
  filter(language.group != 3)
View(FLDM_English)

only_eng <- FLDM_tidy %>% 
  filter(language.group == 5) 
only_it <- FLDM_tidy %>% 
  filter(language.group == 1) 
only_ger <- FLDM_tidy %>% 
  filter(language.group == 3) 

mean(only_it$trolley.choice, na.rm = TRUE)
mean(only_ger$trolley.choice, na.rm = TRUE)
mean(only_eng$trolley.choice, na.rm = TRUE)

mean(only_it$footbridge.choice, na.rm = TRUE)
mean(only_ger$footbridge.choice, na.rm = TRUE)
mean(only_eng$footbridge.choice, na.rm = TRUE)

mean(only_it$non.moral.choice, na.rm = TRUE)
mean(only_ger$non.moral.choice, na.rm = TRUE)
mean(only_eng$non.moral.choice, na.rm = TRUE)

# df for demographics table 
Condition <- c('Italian', 'German', 'English')
N <- c(39, 28, 36)
trolley.means <- c('54%','73%','61%')
footbridge.means <- c('13%', '43%', '36%')
non.moral.means <- c('87%', '92%', '93%')
FLDM_demographics <- data.frame(Condition, N, trolley.means, footbridge.means, non.moral.means)
print(FLDM_demographics)
