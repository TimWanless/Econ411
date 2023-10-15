#'COMPILED REPORT FOR DATA ASSIGNMENT 5
#'
#'This code installs data packages
#'
#'
#'This code sets working directory
#'
setwd("~/MSAE/MSAE-Spring2020/EFR 535")
#'
library(ggplot2)
#'This code loads and views Tophat data.
#'
library(readxl)
Tophat_data <- read_excel("Lesson 6/Tophat data - Jan 18 2018.xls")
View(Tophat_data)
attach(Tophat_data)
#'
#'This code examines the data with tibble.
#'
tibble(Tophat_data)
#'
#'This code creates frequency tables variable.
#'
mytable <- table(Program_of_Study2, Year)
mytable
#'
#'This code creates mean and range for Final Grade % and participation %.
#'
mean(Tophat_participation_percent)
mean(Final_Grade_percent)

range(Tophat_participation_percent)
range(Final_Grade_percent)

#'This code creates a scatterplot using participation percentage and final grade.
#'
ggplot(data = Tophat_data) + geom_point(mapping = aes(x = Tophat_participation_percent, y = Final_Grade_percent))
#'
#'This code adds jittering to the scatterplot.
#'
ggplot(data = Tophat_data) + geom_jitter(mapping = aes(x = Tophat_participation_percent, y = Final_Grade_percent))
#'
#'The two graphs look fairly similar. Therefore we can conclude there are not a lot of similar value overlapping each other like in the example in the videos.
#'
#'
#'
#'This code creates a facet-grid of Program of Study2
#'
ggplot(data = Tophat_data) +
  geom_jitter(mapping = aes(x = Tophat_participation_percent, y = Final_Grade_percent))+
  facet_wrap(~ Program_of_Study2, nrow = 3)
#'
#'The majority of students are in the Pre-Nursing program and there seems to be a correlation between participation percentage and final grade.
#'
#'
#'This code creates a scatterplot using participation percentage and separated by color
#'
ggplot(data = Tophat_data) + geom_jitter(mapping = aes(x = Tophat_participation_percent, y = Final_Grade_percent, color = Program_of_Study2))
#'
#'This code creates scatterplot separated by shape
ggplot(data = Tophat_data) + geom_jitter(mapping = aes(x = Tophat_participation_percent, y = Final_Grade_percent, shape = Program_of_Study2))

#'This code creates scatterplot separated by size
ggplot(data = Tophat_data) + geom_jitter(mapping = aes(x = Tophat_participation_percent, y = Final_Grade_percent, size = Program_of_Study2))

#'This code creates scatterplot separated by transparency
ggplot(data = Tophat_data) + geom_jitter(mapping = aes(x = Tophat_participation_percent, y = Final_Grade_percent, alpha = Program_of_Study2))

#'This is my personal preference for aesthetics
ggplot(data = Tophat_data) + geom_jitter(mapping = aes(x = Tophat_participation_percent, y = Final_Grade_percent, color = Program_of_Study2, shape = Program_of_Study2))

#'This code creates a scatter plot with a smooth line
ggplot(data = Tophat_data, mapping = aes(x = Tophat_participation_percent, y = Final_Grade_percent)) +
    geom_point(mapping = aes(color = Program_of_Study2, shape = Program_of_Study2)) +
    geom_smooth()

#'This code adds a theme to scatter plot with a smooth line
ggplot(data = Tophat_data, mapping = aes(x = Tophat_participation_percent, y = Final_Grade_percent)) +
  geom_point(mapping = aes(color = Program_of_Study2, shape = Program_of_Study2)) +
  geom_smooth()
  theme_classic()
  
  