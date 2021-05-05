library(tidyverse)
load("rda/murders.rda")

murders%>% mutate(abb=reorder(abb,rate))%>%
  ggplot(aes(abb,rate))+
  geom_bar(width=0.5,stat="identity",color="Red")+
  xlab("State")+
  ylab("Murder Rate")+
  coord_flip()

ggsave("figs/barplot.png")
