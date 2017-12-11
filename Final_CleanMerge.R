# Kat Devlin & Barrett Alexander
# Multivariate Statistics Final Project
# Data Clean & Merge File

## Analysis scripts are in a separate file.

setwd("~/Desktop/Multivar_FinalProject")

# Original file is SPSS dataset from Pew Research Center's Global Attitudes project
# Anyone can access .sav download file from site: http://www.pewglobal.org/datasets/2015/
# You must create account (free) to download the data so cannot use `download.file`
# I downloaded "Spring 2015 Survey Data" files, saved in local WD -> convert .sav to .csv
library(foreign)
x <- read.spss("PewGlobal2015.sav", to.data.frame=TRUE)  # large file: 45K+ obs, 927 vars
write.csv(x, file = "PewGlobal2015.csv")

# So moving forward we can just use this to read the data:
x <- read.csv("PewGlobal2015.csv", as.is = TRUE)
table(x$COUNTRY)  # country names and n size

# Using the codebook, I found all the questions that were asked in every country:
# Q1 typical day 
# Q3 current economic situation 
# Q4 future economic situation 
# Q6 will kids today be better off than parents 
# Q12A U.S. favorability
# Q12B China favorability 
# Q12C Iran favorability 
# Q12D Russia favorability 
# Q13A concern about climate change 
# Q13B concern about ISIS 
# Q13E concern about Iran nuclear program 
# Q13F concern about cyberattacks 
# Q13G concern about economic system instability
# Q17 international superpower 
# Q18 China v U.S. superpower status 
# Q19B U.S. respects personal freedoms 
# Q25A confidence in Obama
# Q25D confidence in Putin
# Q26A Approve Obama handling econ probs 
# Q26B Approve Obama handling climate probs 
# Q26C Approve Obama handling ISIS
# Q26D Approve Obama handling Iran 
# Q26E Approve Obama handling China 
# Q26F Approve Obama handling NKorea 
# Q26G Approve Obama handling Russia
# Q32 How serious is climate change threat 
# Q33 How to deal with climate change 
# Q39 enhanced interrogation justified or not 
# Q40 support U.S. in Paris climate talks
# Q41 When will we feel climate change harm
# Q42 how concernde about climate effects in your lifetime 
# Q43 climate change most serious effects 
# Q44 who should take charge on climate action 
# Q70 access to internet
# Q71 do you own a cell phone 
# Q72 do you own a smartphone (recode needed since subset of sample)
# Q73 internet usage (recode needed since subset of sample)
# Q74 social media usage (recode needed since subset of sample) 
# Q152 is religion important in your life
# Q164 employment status
# plus I want to keep the survey weights, `x$WEIGHT`

# Get Q column number for subsetting data - 39 total
t <- match(c("COUNTRY", "Q1", "Q3", "Q4", "Q6", "Q12A", "Q12B", "Q12C", "Q12D", "Q13A", 
             "Q13B", "Q13E", "Q13F", "Q13G", "Q17", "Q18", "Q19B", 
             "Q25A", "Q25D", "Q26A", "Q26B", "Q26C", "Q26D", "Q26E", "Q26F", "Q26G",
             "Q32", "Q33", "Q39", "Q40", "Q41", "Q42", "Q43", "Q44", "Q70", "Q71",
             "Q152", "Q164", "WEIGHT"),names(x))
# took out Q72, Q73, Q74

# Subsetting and writing a new .csv to avoid loading the larger file each
# time we work on the project
q <- x[c(t)]
q <- q[complete.cases(q),] # no missing data
write.csv(q, file = "PewGlobal2015_cleaner.csv", row.names = F)

# From here forward we're just working with this .csv:
y <- read.csv("PewGlobal2015_cleaner.csv", header = T, stringsAsFactors = F)

# Let's recode some variables
# Use codebook for full question info

y$Q1[y$Q1=="A particularly good day"] <- 1
y$Q1[y$Q1=="A typical day"] <- 2
y$Q1[y$Q1=="A particularly bad day"] <- 3
y$Q1[y$Q1=="Don’t know"] <- 99
y$Q1[y$Q1=="Refused"] <- 99
table(y$Q1)
y$Q1 <- as.numeric(y$Q1)

table(y$Q3)
y$Q3[y$Q3=="Very good"] <- 1
y$Q3[y$Q3=="Somewhat good"] <- 2
y$Q3[y$Q3=="Somewhat bad"] <- 3
y$Q3[y$Q3=="Very bad"] <- 4
y$Q3[y$Q3=="Don’t know"] <- 99
y$Q3[y$Q3=="Refused"] <- 99
table(y$Q3)
y$Q3 <- as.numeric(y$Q3)

table(y$Q4)
y$Q4[y$Q4=="Improve a lot"] <- 1
y$Q4[y$Q4=="Improve a little"] <- 2
y$Q4[y$Q4=="Remain the same"] <- 3
y$Q4[y$Q4=="Worsen a little"] <- 4
y$Q4[y$Q4=="Worsen a lot"] <- 5
y$Q4[y$Q4=="Don’t know"] <- 99
y$Q4[y$Q4=="Refused"] <- 99
table(y$Q4)
y$Q4 <- as.numeric(y$Q4)

table(y$Q6)
y$Q6[y$Q6=="Better off"] <- 1
y$Q6[y$Q6=="Worse off"] <- 2
y$Q6[y$Q6=="Same (Volunteered)"] <- 3
y$Q6[y$Q6=="Don’t know"] <- 99
y$Q6[y$Q6=="Refused"] <- 99
table(y$Q6)
y$Q6 <- as.numeric(y$Q6)

y$Q12A[y$Q12A=="Very favorable"] <- 1
y$Q12A[y$Q12A=="Somewhat favorable"] <- 2
y$Q12A[y$Q12A=="Somewhat unfavorable "] <- 3
y$Q12A[y$Q12A=="Very unfavorable "] <- 4
y$Q12A[y$Q12A=="Don’t know"] <- 99
y$Q12A[y$Q12A=="Refused"] <- 99
y$Q12A <- as.numeric(y$Q12A)

y$Q12B[y$Q12B=="Very favorable"] <- 1
y$Q12B[y$Q12B=="Somewhat favorable"] <- 2
y$Q12B[y$Q12B=="Somewhat unfavorable "] <- 3
y$Q12B[y$Q12B=="Very unfavorable "] <- 4
y$Q12B[y$Q12B=="Don’t know"] <- 99
y$Q12B[y$Q12B=="Refused"] <- 99
y$Q12B <- as.numeric(y$Q12B)

y$Q12C[y$Q12C=="Very favorable"] <- 1
y$Q12C[y$Q12C=="Somewhat favorable"] <- 2
y$Q12C[y$Q12C=="Somewhat unfavorable "] <- 3
y$Q12C[y$Q12C=="Very unfavorable "] <- 4
y$Q12C[y$Q12C=="Don’t know"] <- 99
y$Q12C[y$Q12C=="Refused"] <- 99
y$Q12C <- as.numeric(y$Q12C)

y$Q12D[y$Q12D=="Very favorable"] <- 1
y$Q12D[y$Q12D=="Somewhat favorable"] <- 2
y$Q12D[y$Q12D=="Somewhat unfavorable "] <- 3
y$Q12D[y$Q12D=="Very unfavorable "] <- 4
y$Q12D[y$Q12D=="Don’t know"] <- 99
y$Q12D[y$Q12D=="Refused"] <- 99
y$Q12D <- as.numeric(y$Q12D)

y$Q13A[y$Q13A=="Very concerned"] <- 1
y$Q13A[y$Q13A=="Somewhat concerned"] <- 2
y$Q13A[y$Q13A=="Not too concerned"] <- 3
y$Q13A[y$Q13A=="Not at all concerned"] <- 4
y$Q13A[y$Q13A=="Don't know"] <- 99
y$Q13A[y$Q13A=="Refused"] <- 99
table(y$Q13A)
y$Q13A <- as.numeric(y$Q13A)

y$Q13B[y$Q13B=="Very concerned"] <- 1
y$Q13B[y$Q13B=="Somewhat concerned"] <- 2
y$Q13B[y$Q13B=="Not too concerned"] <- 3
y$Q13B[y$Q13B=="Not at all concerned"] <- 4
y$Q13B[y$Q13B=="Don't know"] <- 99
y$Q13B[y$Q13B=="Refused"] <- 99
table(y$Q13B)
y$Q13B <- as.numeric(y$Q13B)

y$Q13E[y$Q13E=="Very concerned"] <- 1
y$Q13E[y$Q13E=="Somewhat concerned"] <- 2
y$Q13E[y$Q13E=="Not too concerned"] <- 3
y$Q13E[y$Q13E=="Not at all concerned"] <- 4
y$Q13E[y$Q13E=="Don't know"] <- 99
y$Q13E[y$Q13E=="Refused"] <- 99
table(y$Q13E)
y$Q13E <- as.numeric(y$Q13E)

y$Q13F[y$Q13F=="Very concerned"] <- 1
y$Q13F[y$Q13F=="Somewhat concerned"] <- 2
y$Q13F[y$Q13F=="Not too concerned"] <- 3
y$Q13F[y$Q13F=="Not at all concerned"] <- 4
y$Q13F[y$Q13F=="Don't know"] <- 99
y$Q13F[y$Q13F=="Refused"] <- 99
table(y$Q13F)
y$Q13F <- as.numeric(y$Q13F)

y$Q13G[y$Q13G=="Very concerned"] <- 1
y$Q13G[y$Q13G=="Somewhat concerned"] <- 2
y$Q13G[y$Q13G=="Not too concerned"] <- 3
y$Q13G[y$Q13G=="Not at all concerned"] <- 4
y$Q13G[y$Q13G=="Don't know"] <- 99
y$Q13G[y$Q13G=="Refused"] <- 99
table(y$Q13G)
y$Q13G <- as.numeric(y$Q13G)

y$Q17[y$Q17=="The United States"] <- 1
y$Q17[y$Q17=="China"] <- 2
y$Q17[y$Q17=="Japan OR"] <- 3
y$Q17[y$Q17=="The countries of the European Union"] <- 4
y$Q17[y$Q17=="None / There is no leading economic power (Volunteered) "] <- 5
y$Q17[y$Q17=="Other (Volunteered) "] <- 6
y$Q17[y$Q17=="Don’t know"] <- 99
y$Q17[y$Q17=="Refused"] <- 99
table(y$Q17)
y$Q17 <- as.numeric(y$Q17)

y$Q18[y$Q18=="Will never replace U.S."] <- 1
y$Q18[y$Q18=="Will eventually replace U.S."] <- 2
y$Q18[y$Q18=="Has already replaced U.S."] <- 3
y$Q18[y$Q18=="Don’t know"] <- 99
y$Q18[y$Q18=="Refused"] <- 99
table(y$Q18)
y$Q18 <- as.numeric(y$Q18)

y$Q19B[y$Q19B=="Yes - respects personal freedoms"] <- 1
y$Q19B[y$Q19B=="No – does not respect personal freedoms"] <- 2
y$Q19B[y$Q19B=="Don't know"] <- 99
y$Q19B[y$Q19B=="Refused"] <- 99
table(y$Q19B)
y$Q19B <- as.numeric(y$Q19B)

for (i in 18:19){
  y[,i] <- gsub("A lot of confidence", 1, y[,i])
  y[,i] <- gsub("Some confidence", 2, y[,i])
  y[,i] <- gsub("Not too much confidence", 3, y[,i])
  y[,i] <- gsub("No confidence at all", 4, y[,i])
  y[,i] <- gsub("Don’t know", 99, y[,i])
  y[,i] <- gsub("Refused", 99, y[,i])
  y[,i] <- as.numeric(y[,i])
}

for (i in 20:26){
  y[,i] <- gsub("Approve", 1, y[,i])
  y[,i] <- gsub("Disapprove", 0, y[,i])
  y[,i] <- gsub("Don't know", 99, y[,i])
  y[,i] <- gsub("Refused", 99, y[,i])
  y[,i] <- as.numeric(y[,i])
}

y$Q32[y$Q32=="Very serious"] <- 1
y$Q32[y$Q32=="Somewhat serious"] <- 2
y$Q32[y$Q32=="Not too serious"] <- 3
y$Q32[y$Q32=="Not a problem"] <- 4
y$Q32[y$Q32=="Don't know"] <- 99
y$Q32[y$Q32=="Refused"] <- 99
table(y$Q32)
y$Q32 <- as.numeric(y$Q32)

y$Q33[y$Q33=="Technology can solve the problem without major changes"] <- 1
y$Q33[y$Q33=="Have to make major changes"] <- 2
y$Q33[y$Q33=="Neither (Volunteered)"] <- 3
y$Q33[y$Q33=="Climate change does not exist (Volunteered)"] <- 4
y$Q33[y$Q33=="Don't know"] <- 99
y$Q33[y$Q33=="Refused"] <- 99
table(y$Q33)
y$Q33 <- as.numeric(y$Q33)

y$Q39[y$Q39=="Justified"] <- 1
y$Q39[y$Q39=="Not Justified"] <- 2
y$Q39[y$Q39=="Depends (Volunteered)"] <- 3
y$Q39[y$Q39=="Don't know"] <- 99
y$Q39[y$Q39=="Refused"] <- 99
table(y$Q39)
y$Q39 <- as.numeric(y$Q39)

y$Q40[y$Q40=="Support"] <- 1
y$Q40[y$Q40=="Oppose"] <- 2
y$Q40[y$Q40=="Climate change does not exist (Volunteered)"] <- 3
y$Q40[y$Q40=="Don't know"] <- 99
y$Q40[y$Q40=="Refused"] <- 99
table(y$Q40)
y$Q40 <- as.numeric(y$Q40)

y$Q41[y$Q41=="Now"] <- 1
y$Q41[y$Q41=="In the next few years"] <- 2
y$Q41[y$Q41=="Not for many years"] <- 3
y$Q41[y$Q41=="Never"] <- 4
y$Q41[y$Q41=="Climate change does not exist (Volunteered)"] <- 5
y$Q41[y$Q41=="Don't know"] <- 99
y$Q41[y$Q41=="Refused"] <- 99
table(y$Q41)
y$Q41 <- as.numeric(y$Q41)

y$Q42[y$Q42=="Very concerned"] <- 1
y$Q42[y$Q42=="Somewhat concerned"] <- 2
y$Q42[y$Q42=="Not too concerned"] <- 3
y$Q42[y$Q42=="Not at all concerned"] <- 4
y$Q42[y$Q42=="Climate change does not exist (Volunteered)"] <- 5
y$Q42[y$Q42=="Don't know"] <- 99
y$Q42[y$Q42=="Refused"] <- 99
table(y$Q42)
y$Q42 <- as.numeric(y$Q42)

y$Q43[y$Q43=="Droughts or water shortages"] <- 1
y$Q43[y$Q43=="Long periods of unusually hot weather"] <- 2
y$Q43[y$Q43=="Rising sea levels"] <- 3
y$Q43[y$Q43=="Severe weather, like floods or intense storms"] <- 4
y$Q43[y$Q43=="Climate change does not exist (Volunteered)"] <- 5
y$Q43[y$Q43=="Don't know"] <- 99
y$Q43[y$Q43=="Refused"] <- 99
table(y$Q43)
y$Q43 <- as.numeric(y$Q43)

y$Q44[y$Q44=="Rich countries, such as the U.S., Japan and Germany, should do more than developing countries because they have produced"] <- 1
y$Q44[y$Q44=="Developing countries should do just as much as rich countries because they will produce most of the world's greenhouse g"] <- 2
y$Q44[y$Q44=="Rising sea levels"] <- 3
y$Q44[y$Q44=="Climate change does not exist (Volunteered)"] <- 5
y$Q44[y$Q44=="Don't know"] <- 99
y$Q44[y$Q44=="Refused"] <- 99
table(y$Q44)
y$Q44 <- as.numeric(y$Q44)


y$Q70[y$Q70=="Yes"] <- 1
y$Q70[y$Q70=="No"] <- 2
y$Q70[y$Q70=="Don’t know"] <- 99
y$Q70[y$Q70=="Refused"] <- 99
table(y$Q70)
y$Q70 <- as.numeric(y$Q70)

y$Q71[y$Q71=="Yes"] <- 1
y$Q71[y$Q71=="No"] <- 2
y$Q71[y$Q71=="Don’t know"] <- 99
y$Q71[y$Q71=="Refused"] <- 99
table(y$Q71)
y$Q71 <- as.numeric(y$Q71)

y$Q152[y$Q152=="Very important"] <- 1
y$Q152[y$Q152=="Somewhat important"] <- 2
y$Q152[y$Q152=="Not too important"] <- 3
y$Q152[y$Q152=="Not at all important"] <- 4
y$Q152[y$Q152=="Don't know"] <- 99
y$Q152[y$Q152=="Refused"] <- 99
table(y$Q152)
y$Q152 <- as.numeric(y$Q152)

y$Q164[y$Q164=="In paid work"] <- 1
y$Q164[y$Q164=="In education (not paid for by employer), in school, student even if on vacation"] <- 2
y$Q164[y$Q164=="Apprentice or trainee"] <- 3
y$Q164[y$Q164=="Doing housework, looking after the home, children or other persons (not paid)"] <- 4
y$Q164[y$Q164=="Permanently sick or disabled"] <- 5
y$Q164[y$Q164=="Retired"] <- 6
y$Q164[y$Q164=="Unemployed and looking for a job"] <- 7
y$Q164[y$Q164=="Don’t know"] <- 99
y$Q164[y$Q164=="Refused"] <- 99
table(y$Q164)
y$Q164 <- as.numeric(y$Q164)

# Now we can write the final clean version of the Pew Research data 
write.csv(y, file = "PewGlobal2015_cleanest.csv", row.names = F)

####################################################################

y <- read.csv("PewGlobal2015_cleanest.csv", header = T, stringsAsFactors = F)

# After much discussion with our stats professor, my partner and I settled on not
# using the survey weights and using country means to present the data at the
# country level. Not the original plan but what our professor persuaded us to do
# in order to move the project forward.

library(plyr)
p <- ddply(y[,-c(1,39)], .(y$COUNTRY), numcolwise(mean))

# We want to do some mapping later, so we'll add 3-letter country ISO codes now
# This will also help later with merging
library(countrycode)
p$ISOcountry <- countrycode(p$`y$COUNTRY`, "country.name.en", "iso3c")
table(p$ISOcountry)
colnames(p)[1] <- "country"

# And now we'll write the country-level means dataset
write.csv(p, file = "PewGlobal2015_final.csv", row.names = F)

p <- read.csv("PewGlobal2015_final.csv", as.is = T)
# Next we took data from the World Bank and will merge with country-level Pew data
# The data is available through the WDI library
# Variables we chose to include and their codes listed below
library(WDI)
library(countrycode)
country <- as.character(p$ISOcountry)
country <- countrycode((country), "iso3c", "iso2c")
table(country)
#"GDP per capita (constant 2000 US$)" 'NY.GDP.PCAP.KD'
#"Foreign direct investment, net inflows (% of GDP)" BX.KLT.DINV.WD.GD.ZS
#"Trade (% of GDP)" NE.TRD.GNFS.ZS

a <- WDI(indicator=c('NY.GDP.PCAP.KD', 'BX.KLT.DINV.WD.GD.ZS','NE.TRD.GNFS.ZS'), country=c(country),
         start=2015, end=2015)
dim(a)
head(a)
tail(a)
# This has missing data for Venezuela and didn't include the Palestinian territories. 
# Therefore, we exclude those from further analysis.
a <- a[-38,]

# Turn it into a data frame
df <- data.frame(a$country, a$year, a$iso2c, a$NY.GDP.PCAP.KD,
                 a$BX.KLT.DINV.WD.GD.ZS, a$NE.TRD.GNFS.ZS)
# Rename columns because they're horrible and write it into .csv
colnames(df) <- c("country","year", "iso2", "gdp.per.capita", "fdi.gdp", "trade.gdp")
head(df)
write.csv(df, file = "WorldBank15.csv", row.names = F)
####################################################################

x <- read.csv("PewGlobal2015_final.csv", as.is = TRUE)
y <- read.csv("WorldBank15.csv", as.is=TRUE)

# need to remove Palestinian territories from Pew data
x <- x[-24,]
dim(x)

# Last step: merge the data frames, joining by country name
final <- merge.data.frame(x, y, by="country")
colnames(final)[39] <- "iso3"
final <- final[-40]  # get rid of year column since all same year
write.csv(final, "FinalProjectData.csv", row.names = F)
