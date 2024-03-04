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
  mutate(brown_hair = ifelse(hair == "brown", "True", "False")) %>% 
  mutate(species_first_letter = str_extract(species, "\\b[A-Z]{1}"))

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


### ASSIGNMENT 12 MORE PLOTS

## PLOT 1 

hair_order <- c('none', 'brown', 'black', 'bald', 'white', 'blond', 'auburn, white', 'blonde', 'brown, grey', 'grey')

sw.wrangled %>% 
  ggplot(aes(x = factor(hair, level = hair_order), y = mass, fill = hair)) +
  geom_boxplot(alpha = .5) +
  coord_cartesian(ylim = c(0, 160)) +
  scale_y_continuous(breaks = seq(0, 160, by = 40)) +
  geom_jitter(data = sw.wrangled, aes(x = factor(hair, level = hair_order), y = mass, col = hair)) +
  labs(x = "Hair Color(s)", y = "Mass (kg)", fill = "Colorful hair")

## PLOT 2

sw.wrangled %>% 
  ggplot(aes(x = mass, y = height_in)) +
  geom_point() +
  facet_wrap(vars(brown_hair), 
             labeller = labeller(brown_hair = c("True" = "Has brown hair", "False" = "No brown hair"))) +
  geom_smooth(method = "lm") +
  coord_cartesian(xlim = c(-200, 200), ylim = c(-4, 100)) +
  scale_x_continuous(breaks = seq(-200, 200, by = 100)) +
  scale_y_continuous(breaks = seq(-4, 100, by = 20)) +
  labs(title = "Mass vs. height by brown-hair-havingness", subtitle = "A critically important analysis")

## PLOT 3
# x = species_first_letter, y = count, fill = gender, flip axes 
sw.wrangled %>% 
  mutate(species_first_letter = str_extract(species, "\\b[A-Z]{1}")) %>%
  filter(!is.na(species_first_letter)) %>% 
  ggplot(aes(x = factor(species_first_letter, levels = rev(levels(factor(species_first_letter)))), fill = gender)) +
  geom_bar() +
  coord_flip() +
  labs(x = "species_first_letter")


### ASSIGNMENT 13 LAST PLOT YAY
## I surrender

# install.packages("ggsci")
library(ggsci)

sw.wrangled %>% 
  ggplot(aes(x = height_cm, y = mass, color = gender)) +
  scale_color_uchicago() +
  geom_point(alpha = .5) +
  geom_smooth(fill = "#ccccff", method = "lm") +
  facet_wrap(vars(gender),
             scales = "free_y",
             labeller = labeller(gender = c("f" = "Female", "m" = "Male", 'NA' = "Other"))) +
  scale_x_continuous(n.breaks = 8) +
  theme_bw() +
  theme(panel.grid.major.y = element_line(linetype = 'dotdash', color = "gray"),
        panel.grid.major.x = element_line(linetype = 'dashed'),
        panel.grid.minor = element_line(linetype = 'blank'),
        panel.background = element_rect(fill = "seashell"),
        strip.background = element_rect(fill = "#006400"),
        strip.text = element_text(color = "white", family = "Courier", hjust = 0),
        axis.title = element_text(family = "Comic Sans MS"),
        title = element_text(family = "Comic Sans MS"),
        legend.position = "bottom",
        axis.text.x = element_text(angle = 45, vjust = .5, hjust = .5),
        axis.text.y = element_text(face = "bold.italic", hjust = 0), 
        legend.title = element_text(family = "Brush Script MT", size = 20),
        legend.background = element_rect(fill = "#ccccff"),
        plot.caption = element_text(color = "red", angle = 180, hjust = 0)) +
  labs(title = "Height and weight across gender presentation", 
       subtitle = 'A cautionary tale in misleading "free" axis scales & bad design choice',
       x = "Height (cm)",
       y = "Mass (kg)", 
       color = "Gender Presentation",
       caption = "Color hint: use the ggsci package!")
  
