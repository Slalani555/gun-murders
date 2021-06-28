library(tidyverse)
library(rvest)

# read in raw murders data from Wikipedia
url <- "https://en.wikipedia.org/w/index.php?title=Gun_violence_in_the_United_States_by_state&direction=prev&oldid=810166167"
murders_raw<- read_html(url)%>%
  html_nodes("table")%>%
html_table()%>%
  .[[1]]%>%
  setNames(c("state","population","total","murder_rate"))

#inspect data and column classes
head(murders_raw)
class(murders_raw$population)
class(murders_raw$total)

# direct conversion to numeric fails because of commas
murders_raw$population[1:3]
as.numeric(murders_raw$population[1:3])

# detect whether there are commas
commas<-function(x)any(str_detect(x,","))
murders_raw%>% summarize_all(funs(commas))

murders_new<- murders_raw%>%
  mutate_at(2:3,parse_number)

murders_new%>%head
