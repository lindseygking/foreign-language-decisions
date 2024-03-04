### WEEK 5 CLASS 1 ggplot 2

# find ggplot_iris_demo.Rmd in d2m repo (uploaded after class)

library(ggplot2)
library(tidyverse)
theme_set(theme_classic()) # pretty plots, there are other themes you can pick and choose
                           # you can set a global theme

# not completed, this code came from the slides 
iris %>% 
  filter(!is.na(Petal.Length)) %>% 
  group_by(Species) %>% 
  summarise(mean_PetalLength = mean(Petal.Length),
            sd_PetalLength = sd(Petal.Length),
            N = sum(!is.na(Petal.Length)),
            se_PetalLength = sd_PetalLength / sqrt(N)) %>% 
  ggplot(aes(x = Species, y = mean_PetalLength, fill = Species)) +
  geom_bar(alpha = .5, stat = "identity") +
  scale_fill_manual(values = c("#ffd4c4", "#ffb5e2", "#ce70e8")) +
  geom_errorbar(aes(ymin = mean_PetalLength - se_PetalLength, ymax = mean_PetalLength + se_PetalLength), width = 0.2) +
  geom_text(aes(label = (round(mean_PetalLength, 2))),
            position = position_dodge(width = .9),
            vjust = -.2, size = 4) +
  coord_cartesian(ylim = c(0,7)) +
  scale_y_continuous(breaks = seq(0, 7, by = 1)) +
  labs(x = "Species", y = "Petal Length (cm)", 
       title = "Bar Graph of Petal Length by Iris Species", caption = "Data: iris")


# 1-variable plots
ggplot(iris, aes(x = Species)) +
  geom_bar()

## Dotplot
ggplot(iris, aes(x = Species, y = Petal.Length, fill = Species)) +
  geom_dotplot(binaxis = "y", binwidth = .1, stackdir = "center") +
  scale_fill_manual(values = c("#ffd4c4", "#ffb5e2", "#ce70e8"))

## WEEK 5 CLASS 2








