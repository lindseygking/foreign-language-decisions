library(tidyverse)
library(papaja)
require(base)

### Assignment #2

## ASSIGN VARIABLES
# assign numeric variable
age <- 23.37

# assign string variable
bday <- "August 21, 2000"

## CREATE DATAFRAME
# use above variables
age_df <- data.frame(age, bday)

print(age_df)

### Assignment #4 "Hello world"

hello_world <- function(selected_language) {
  # set supported languages
  languages <- list("Spanish", "English", "French", "German", "Italian") 
  # set correlating greetings
  greetings <- list("Hola mundo", "Hello world", "Bonjour le monde", "Hallo welt", "Ciao mondo") 
  
  if (selected_language %in% languages) { # if the language the user provides is in list "languages"
    index <- match(selected_language, languages) # match the provided language to the list "languages"
    greeting <- greetings[index] # index list "greetings" so the # greeting matches the # language 
    paste0(greeting, "!") # paste the appropriate greeting based on the provided language 
  } else {
    "Language not supported!" # lets user know to input a different language 
  }
}

# Call the function with the desired language
hello_world("English")

  
    

