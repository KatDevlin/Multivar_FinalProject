# Multivar_FinalProject
Yale's Stats Department / School of Forestry & Environmental Studies Multivariate Statistics course (Spring '17)
Final Project Script - Data Cleaning and Merge Files 

## Description
This is Part 1 of my semester-long final project for the graduate-leve Multivariate Statistics course at Yale. The project uses attitudinal data from the Pew Research Center's Global Attitudes Project and economic indicators from the World Bank, obtained through their very handy WDI library. In this script, my partner and I retrieve the data, clean it up, turn individual-level data into country-level data, make some small changes/additions to make our lives easier in the analysis section (separate script) and merge everything together. The original script was created in May 2017 but I have revamped everything in December 2017 using R version 3.4.3 -- "Kite-Eating Tree"-- and R Studio Version 1.0.136. 

## Data
The data for the project comes from two sources: the Pew Research Center and the World Bank. The Pew Research data is free but requires the user to create an account before downloading (they like to see who downloads their data). You can access this here: http://www.pewglobal.org/dataset/spring-2015-survey-data/. We used the 2015 Global Attitudes survey. The download zip contains the data and other relevant files such as the codebook. The main data file comes in SPSS's .sav format but my script converts this to .csv. Because the file is larger than the limit for files on Github, it is not included in the repo. 

The World Bank has created an R library so that users can directly import data into R. These world development indicators are accessible through the WDI library. We used three indicators from 2015 in this analysis. 

## Directions
The directions for this project were purposely vague - we had to find (or create) a dataset and perform three different multivariate analyses with it. The analysis part of this project will be accessible in a separate script; this repo only deals with finding, cleaning and generally managing the data my partner and I used for the project.

## Running the Script
Libraries needed to run this script: `foreign`, `plyr`, `countrycode`, `WDI`.  You can run the following lines to ensure you have everything installed before running the script:

```
.packages = c("foreign", "plyr", "countrycode", "WDI")  
.inst <- .packages %in% installed.packages()  
if(length(.packages[!.inst]) > 0) install.packages(.packages[!.inst],repos='http://cran.us.r-project.org')
```

Because of the size of the original Pew Research SPSS file (and .csv converted version) I have commented out several lines in the .Rmd final script that deal with this file. If you want to download the file and run it locally, either uncomment those lines or use the `Final_CleanMerge.R` file in this repo. This will take you through each step from converting the .sav file through writing the final, cleaned country-level merged file. Because this project was completed over the course of the semester and involved working with a partner, we would write a new .csv each time we hit a milestone to avoid continuously downloading, writing and re-writing large or unnecessary data files.


