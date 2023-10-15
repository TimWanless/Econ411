#'COMPILED REPORT FOR DATA ASSIGNMENT 7
#'
#'This code installs data packages
#'
#'
#'This code sets working directory
#'
setwd("~/MSAE/MSAE-Spring2020/EFR 535")
#'
library(ggplot2)
library(tidyverse)
library(dplyr)
#'This code loads and views Tophat data.
#'
library(readxl)
Tophat <- read_excel("Tophat data - Jan 18 2018.xls")
View(Tophat)
attach(Tophat)

#'
#'Creates vertical bar chart using Year
ggplot(Tophat, aes(x=Year)) +
  geom_bar()
#'Creates horizontal bar chart using Program of Study
#'
ggplot(Tophat, aes(x=Program_of_Study)) +
  geom_bar() +
  coord_flip()

#'Creates vertical bar chart using Year with color
ggplot(Tophat, aes(x=Year)) +
  geom_bar(fill = "springgreen4", color = "springgreen4")

#'Creates horizontal bar chart using Program of Study with color
ggplot(Tophat, aes(x=Program_of_Study)) +
  geom_bar(fill = "navy", color = "navy") +
  coord_flip()
#'
#'Creates vertical bar chart using Year with different default color outlines and white fill
ggplot(Tophat, aes(Year, color = Year)) +
  geom_bar(fill="white")

#'Creates horizontal bar chart using Program of study and different default color outlines and white fill
ggplot(Tophat, aes(Program_of_Study, color = Program_of_Study)) +
  geom_bar(fill="white") +
  coord_flip()

#'The legend is not necessary in the two previous graphs as the information is conveyed in the bar labels.
#'
#'Creates vertical bar chart using Year with different color fill.
ggplot(Tophat, aes(x = as.factor(Year), fill = as.factor(Year))) +
  geom_bar() +
  scale_fill_brewer(palette = "Spectral")

#'Creates horizontal bar chart using Program of study and different color fill.
ggplot(Tophat, aes(x = as.factor(Program_of_Study), fill = as.factor(Program_of_Study))) +
  geom_bar() +
  scale_fill_brewer(palette = "Greens") +
  coord_flip()

#'Adjusts the width and theme of the bar graphs
ggplot(Tophat, aes(Year)) +
  geom_bar(stat = "count", width = 0.9) +
  theme_classic()

ggplot(Tophat, aes(Program_of_Study)) +
  geom_bar(stat = "count", width = 0.4)+
  theme_light() +
  coord_flip()
#'
#'Creates bar graph with Program of Study on the x axis and the Tophat Total Qs Correct on the y axis. They are reordered by height.
#'Creates presummarized variables
sums_PoSTQC <- aggregate(Tophat_Qs_Correct~Program_of_Study , data = Tophat, FUN = sum)
view(sums_PoSTQC)
sums_YTTQa <- aggregate(Tophat_total_Qs_answered~Year, data = Tophat, FUN = sum)
view(sums_YTTQa)
#'
ggplot(sums_PoSTQC, aes(x = reorder(Program_of_Study, Tophat_Qs_Correct, sum), y = Tophat_Qs_Correct, fill = Program_of_Study)) +
  geom_bar(stat="identity") +
  scale_fill_brewer(palette = "Blues") +
  coord_flip()

ggplot(sums_YTTQa, aes(x = reorder(Year,Tophat_total_Qs_answered, sum), y = Tophat_total_Qs_answered, fill = Year)) +
  geom_bar(stat="identity") +
  scale_fill_brewer(palette = "Reds")

#'
#'This code makes a lolliplot of the previous bar chart
ggplot(sums_YTTQa, aes(x = Year, y = Tophat_total_Qs_answered)) +
  geom_point(color = "red", size = 5) +
  geom_segment(aes(x=Year, xend=Year, y=0, yend=Tophat_total_Qs_answered), color = "grey")

