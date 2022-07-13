# https://bookdown.org/yihui/bookdown/rstudio-connect.html

# install.packages('rsconnect')

install.packages("htmltools")

library(rsconnect)
library(bookdown)

publish_book(name = NULL, account = NULL, server = NULL,
             render = c("none", "local", "server"))


detach_package <- function(pkg, character.only = FALSE)
{
  if(!character.only)
  {
    pkg <- deparse(substitute(pkg))
  }
  search_item <- paste("package", pkg, sep = ":")
  while(search_item %in% search())
  {
    detach(search_item, unload = TRUE, character.only = TRUE)
  }
}

detach_package(htmltools)


install.packages("htmltool", repos="http://cran.rstudio.com/", dependencies=TRUE)

update.packages("htmltools")

remove.packages("htmltools")

install.packages("htmltools")

sessionInfo()
