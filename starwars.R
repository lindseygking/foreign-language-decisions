library(tidyverse)

## Create your goal tibble to replicate

# Run this line to see what your end product should look like
sw.wrangled.goal <- read_csv("sw-wrangled.csv") %>% 
  mutate(across(c(hair, gender, species, homeworld), factor)) # this is a quick-and-dirty fix to account for odd importing behavior

# View in console
sw.wrangled.goal 

# Examine the structure of the df and take note of data types
# Look closely at factors (you may need another function to do so) to see their levels
str(sw.wrangled.goal) 



## Use the built-in starwars dataset to replicate the tibble above in a tbl called sw.wrangled
# If you get stuck, use comments to "hold space" for where you know code needs to go to achieve a goal you're not sure how to execute
sw.wrangled <- starwars %>%
  # separate first and last name
  separate(name, c("first_name", "last_name"), sep = " ") %>%
  # sort alphabetically by last name
  arrange(.$last_name) %>% 
  # add initials column 
  add_column(initials = sapply(str_extract_all(paste(.$first_name, .$last_name, sep = " "), "[A-Z]")
                               , paste, collapse = "")
             , .after = "last_name") %>%
  # remove skin_color, eye_color, birth_year, films, vehicles, starships, and sex
  select(-c(skin_color, eye_color, birth_year, films, vehicles, starships, sex)) %>% 
  # change NAs in hair_color to "none"
  mutate(hair_color = ifelse(is.na(hair_color), "none", hair_color)) %>% 
  mutate(gender = ifelse(as.character(gender) == "feminine", "f", as.character(gender)),
         gender = ifelse(as.character(gender) == "masculine", "m", as.character(gender))) %>% 
  # rename height, and hair_color
  rename(height_cm = height, 
         hair = hair_color) %>% 
  # show height in inches (height_in) and centimeters (height_cm)
  add_column(height_in = .$height_cm/2.54
             , .after = "initials" ) %>% 
  mutate(brown_hair = ifelse(hair == "brown", "True", "False"))

View(sw.wrangled)

## What doesn't match exactly:
# inch values are rounded/computed differently than the goal dataset
# not sure how to have the first names alphabetical within the last names being alphabetical
# seems like some of the subjects were removed from the goal set, not sure what parameters they were removed by, could individually remove those names 


## Check that your sw.wrangled df is identical to the goal df
# Use any returned information about mismatches to adjust your code as needed
#all.equal(sw.wrangled.goal, sw.wrangled)

### ASSIGNMENT 11 PART 1: recreate plots 

## PLOT 1

sw.wrangled %>% 
  filter(!is.na(height_cm)) %>% 
  ggplot(aes(x=height_cm)) + 
  geom_bar()
# how do you make the bars thicker instead of thin lines?

## PLOT 2
 
sw.wrangled %>% 
  ggplot(aes(x=hair)) +
  geom_bar()
# need to sort bars (sorted_hair)
 

## PLOT 3

sw.wrangled %>%
  ggplot(aes(x = height_in, y = mass)) +
  geom_point(shape = 17) +
  xlim(0, 100) +
  ylim(0, 160)