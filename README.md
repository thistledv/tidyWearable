# tidyWearable

Script and documentation for tidying the UCI HAR Dataset 

by David Thistlethwaite



This repo is submission for  final project for Getting and Cleaning Data Project

##Repository Contents:

README.MD  -- this file

CodeBook.MD -- codebook for data and transformations

run_analysis.R -- R script for processing source dataset into tidy, summarizied dataset

tidy\_UCI_HAR\_dataset.txt -- contains the tidy data set

## Instructions:

To create the tidy dataset from the original source dataset:

1.  download and unzip source files from:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2.  Run the R script, providing source data directory as an argument

source("run_analysis.R" )    
run\_analysis("sourceDataDir")   

This assumes the source data was unzipped into a local directory called "sourceDataDir"

An output file is created in the local directory, called:  tidy\_UCI\_HAR\_dataset.txt 

It can be loaded into a data frame by typing:    tidyDataFrame <- read.table("tidy\_UCI\_HAR_dataset.txt", header=TRUE)

## Data Processing Steps:

The processing steps used in this R script to transform the source data are described in  CodeBook.MD.


