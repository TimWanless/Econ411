#' ---
#'title: "COMPILED REPORT FOR DATA ASSIGNMENT 9"
#' author: "Timothy Wanless"
#' date: "March 27th, 2020"
#' ---
#' 
#' This sets the working .
#' 
setwd("~/MSAE/MSAE-Spring2020/EFR 535")
#'
#' This installs packages
#' 
library(ggplot2)
library(tidyverse)
library(waffle)
#'
#'Loads data
#'Creates a dataframe
LMS <- data.frame(
  category=c("Videos","Readings","Discussion Boards","Assignments","Quizzes"),
  value=c(82.3, 16.4, 33.1, 71.9, 42.7)
)
view(LMS)
#'

#'
attach(LMS)
#'
#'This creates a stacked bar plot.
#'
ggplot(LMS, aes(x="",y=value, fill= category))+
  geom_bar(stat = "identity")+
  labs(x=NULL, y=NULL, title="Stacked Bar Plot of Online Student Activity")+
  scale_fill_brewer(palette = "Paired")+
  theme(plot.title = element_text(hjust = 0.5))
#'
#'This creates code for a percentage variable
#'
LMS$perc <- LMS$value/sum(LMS$value)
#'
#'This code reorganizes the sections from largest to smallest.
LMS$category <- factor(LMS$category, levels = c("Videos", "Assignments","Quizzes","Discussion Boards","Readings"))
#'
#'This creates a pie chart with data labels.
ggplot(LMS, aes(x="",y=value, fill= category))+
  geom_bar(stat = "identity")+
  coord_polar(theta = "y", start = 0)+
  labs(x=NULL, y=NULL, title="Piechart of Online Student Activity")+
  scale_fill_brewer(palette = "Blues")+
  theme(axis.line = element_blank(),
        axis.text = element_blank(),
        plot.title = element_text(hjust = 0.5))+
  geom_text(aes(label=scales::percent(round(perc,3))), position = position_stack(vjust = 0.5))
#'
#'This creates a waffle chart.
waffle(c("Videos"=82.3, "Readings"=16.4, "Discussion Boards"=33.1, "Assignments"=71.9, "Quizzes"=42.7), rows = 10, title="Waffle Chart of Student Online Activity")
#'
#'