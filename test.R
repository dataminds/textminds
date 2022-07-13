bookdown::publish_book()
y

pkg_v <- c(
          "tidyverse", "tidytext", "textdata", "epubr", "showtext",
           "RcppMeCab", "KoNLP", "SnowballC", "hunspell", "spacyr",
           "tidygraph", "textclean", "quanteda", "seededlda",
           "tidylo", "readtext", "stm"
            )
lapply(pkg_v, require, ch = T)



names( installed.packages()[,"Package"] )
package_list <- c("tidyverse", "epubr", "showtext", "tidytext", "tidymodels",  #"quanteda.corpora",
                  "tidygraph", "textclean", "quanteda", "seededlda",  "newsmap",
                  "LSX", "topicmodels", "ldatuning", "RcppMeCab", "RSelinium",
                  "pander", "bookdown")
( package_list_installed <- package_list %in% installed.packages()[,"Package"] )

( new_pkg <- package_list[!package_list_installed] )
if(length(new_pkg)) install.packages(new_pkg)

lapply(package_list, require, ch = T)


( package_list_installed <- pkg_v %in% installed.packages()[,"Package"] )
( new_pkg <- pkg_v[!package_list_installed] )
if(length(new_pkg)) install.packages(new_pkg)




install.packages("rlang")
library(rlang)


iris %>% sample_n(10) %>% pander


list.files(".") #작업디렉토리에 있는 모든 파일 표시
list.files("./images") #작업디렉토리아래에 있는 images폴더에 있는 모든 파일 표시
list.files("images")

list.files("..") # 작업디렉토리 위 폴더에 있는 모든 파일 표시
list.files("../dir") #작업디렉토의 위 폴더 아래(즉, 현 작업디렉토리와 같은 위치에 있는 폴더)리아래에 있는 images폴더에 있는 모든 파일 표시

list.files("/") #루트디렉토리에 있는 모든 파일 표시
list.files("/data") #루트디렉토리 아래의 data폴더에 있는 모든 파일 표시


list.files("~")
list.files("C:/Users/J/Documents")
list.files("~/R")

list.files("C:/Users/J/Documents/R/win-library/4.0")
list.files("~/Documents/R/win-library/4.0")


list.files("C:\Users\J\Documents")

library(tidyverse)


bookdown::publish_book(name = NULL, account = NULL, server = NULL,
                       render = c("none", "local", "server"))
y

bookdown::publish_book()
y
y


guess_encoding("c:/data/ogamdo.txt")



fileConn<-file("output.txt")
writeLines(ogamdo_txt, fileConn)
close(fileConn)

?writeLines
readLines('ogamdo.txt')
?readLines

?scan

scan("c:/data/ogamdo.txt", what = "character", sep= "\n")


?file

sessionInfo()

?download.file

?html_elements


getwd()

?html_nodes()


?GET

# http://repowiki.kr/archives/84



install.packages("jsonlite", type = "source")
library(jsonlite)

?html_attrs


file_url

u <- 'https://news.naver.com/main/main.nhn?mode=LSD&mid=shm&sid1=101'

url <- 'https://news.naver.com/'
path <- 'main/main.nhn'
query <- 'mode=LSD&mid=shm&sid1=101'

url2 <- modify_url(url, path = path, query = query)

u == url2

library(tidyverse)
my_1 <- c("cheese", NA, NA)
my_2 <- c("", "", "and ")
paste(my_1, my_2, sep = "")
str_c(my_1, my_2, sep = "")





# Use str_c() instead of paste(): my_toppings_str
my_toppings_str <- ___

# Print my_toppings_str
___

# paste() my_toppings_and with collapse = ", "
___

# str_c() my_toppings_str with collapse = ", "
___
