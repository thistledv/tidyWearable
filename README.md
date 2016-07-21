# tidyWearable

Script and documentation for tidying the UCI HAR Dataset 

by David Thistlethwaite


This repo is submission for  final project for Getting and Cleaning Data Project

##Repository Contents:

README.MD  -- this file

CodeBook.MD -- codebook for data and transformations

run_analysis.R -- R script for processing source dataset into tidy, summarizied dataset

tidy\_UCI_HAR\_dataset.txt -- contains the tidy data set that can be read into an R dataframe by this command:

 tidyDataFrame <- read.table("tidy\_UCI\_HAR_dataset.txt", header=TRUE)