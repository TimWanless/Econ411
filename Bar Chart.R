#uses ggplot2 and tidyverse packages
library(ggplot2)
library(tidyverse)

#views mpg data
view(mpg)

#makes bar plot
ggplot(mpg, aes(x=fl)) +
  geom_bar()

ggplot(mpg) +
  geom_bar(aes(fl))

#makes a bar plot dividing by class of car
ggplot(mpg, aes(class)) +
  geom_bar()

ggplot(mpg) +
  geom_bar(aes(class))

#changes orientation to horizontal
ggplot(mpg, aes(fl)) +
  geom_bar() +
  coord_flip()
ggplot(mpg) +
  geom_bar(aes(fl))+
  coord_flip()

ggplot(mpg, aes(class)) +
  geom_bar()+
  coord_flip()
ggplot(mpg)+
  geom_bar(aes(class))+
  coord_flip()

#bar chart maps aes
ggplot(mpg, aes(x=fl, y=cty)) +
  geom_bar(stat= "identity")

ggplot(mpg, aes(x=class, y=hwy)) +
  geom_bar(stat="identity") +
  coord_flip()
