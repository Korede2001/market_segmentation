#Import TiVo dataset into R excluding the ID column and the last two rws not involved 
#in the dataset
library(readr)
library(readr)
tivo <- read_csv("~/Downloads/TiVo-Segmentation-Analytics-Data2 - Survey Data.csv",
               col_types = cols(ID = col_skip()))
tivo= tivo[-c(1001:1002),]
View(tivo)


######Observe dataset ##############
summary(tivo)

install.packages('DataExplorer')

library(DataExplorer)


DataExplorer::create_report(tivo)

#Zoom into the Annual income histogram (observing values between $20,000 and $70,000)
hist(tivo$`Annual Income (x1000 $)`, main="Histogram for Annual Income (x1000$)", 
     xlab="Annual Income (x1000$)", xlim = c(20, 70), breaks= 200)


#############################
#Question 4a

#Get the men in the dataset who are married and consider themselves early adopters
married_early_adopter_men= tivo[which(tivo$Gender=='Male' & tivo$`Marital Status`=='Married' &
             tivo$`Technology Adoption`=='Early'),]

#Married early adopter men who can afford the $499 TiVo and still spend on electronics in the next two years
sum(married_early_adopter_men$`Annual spending on electronics`>499/2)


#############################
#Question 4b

#Get women in tivo dataset
women=tivo[which(tivo$Gender=='Female'),]

#Get women with MA or PhD
women_ma_phd= women[which(women$Education=='MA'| women$Education=='PhD'),]

#Women with MA or PhD making purchasing decision on electronics with discussion with spouse
nrow(women_ma_phd[which(women_ma_phd$`Purchasing Decision-maker`=='Single'),])

#############################
#Question 4c

#Early adopters that purchase electronics at least once every year, and do so in stores
#that specialize in electronics?

early_adopter_specialty= tivo[which(tivo$`Technology Adoption`=='Early' & 
                                      tivo$`Purchasing Frequency (every x months)`<=12 &
                                tivo$`Purchasing Location`=='specialty stores'),]

nrow(early_adopter_specialty)

#############################
#Question 4d

#Get seniors (Age>65) in dataset that spend more than six hours a day watching TV
seniors_tv_hours= tivo[which(tivo$Age>65 & tivo$`TV Viewing (hours/day)`>6),]
nrow(seniors_tv_hours)

#Get the mathematical income range (highest income - lowest income)
mathematical_income_range= max(seniors_tv_hours$`Annual Income (x1000 $)`)-
  min(seniors_tv_hours$`Annual Income (x1000 $)`)

mathematical_income_range

#Get the range of incomes as an interval with the bounds as the lowest income and the
#highest income
range_of_income= data.frame(min(seniors_tv_hours$`Annual Income (x1000 $)`),
           max(seniors_tv_hours$`Annual Income (x1000 $)`))
colnames(range_of_income)= c('Lower Bound (x $1000)','Upper bound (x $1000)')

rownames(range_of_income)= c('Income Range')

View(range_of_income)

#Calculate the average annual income for the seniors that spend more 
#than six hours a day watching TV
mean(seniors_tv_hours$`Annual Income (x1000 $)`)
mean(seniors_tv_hours$`Annual Income (x1000 $)`)*1000

###########################################################
#Question 5

#Correlate Annual Income with Age
correlation= cor(tivo$`Annual Income (x1000 $)`,tivo$Age)
correlation

#Find the coefficient of determination (r-squared)
correlation^2

###########################################################
#Question 6

#Create a regression model for gender and annual income, and extract the r-squared
#Since it is a simple regression, the r-squared will be the same regardless of which variable
#is modelled as the dependent or independent variable

#Create a dataset in which Gender will be dummified/codified 
tivo_numeric= tivo
tivo_numeric$Gender= ifelse(tivo_numeric$Gender == "Male", 1, 0)

#Create regression model
lm_gender_income= lm(tivo_numeric$`Annual Income (x1000 $)`~tivo_numeric$Gender)

#Extract the r-squared from the model
summary(lm_gender_income)$r.squared

###########################################################
#Question 7

#a. Correlate Age with Purchasing Frequency and find r-squared
cor(tivo$Age,tivo$`Purchasing Frequency (every x months)`)^2

#b. Correlate Annual Income with TV viewing and find r-squared
cor(tivo$`Annual Income (x1000 $)`,tivo$`TV Viewing (hours/day)`)^2

#c. Correlate Education with Favourite feature and find r-squared

#Find the unique levels of education in order to know how many numbers
#are needed for codification
unique(tivo$Education)


#Codify Education in the tivo_numeric dataset
for (i in 1:length(tivo_numeric$Education)){
  if (tivo_numeric$Education[i]=='None'){tivo_numeric$Education[i]= 0} 
  else if (tivo_numeric$Education[i]=='BA'){tivo_numeric$Education[i]=1} 
  else if (tivo_numeric$Education[i]=='MA') {tivo_numeric$Education[i]=2} 
  else {tivo_numeric$Education[i]=3}
}

tivo_numeric$Education= as.numeric(tivo_numeric$Education)



#Find the unique levels of Favourite feature in order to know how many numbers
#are needed for codification
unique(tivo$`Favorite feature`)

#Codify Favourite feature
for (i in 1:length(tivo_numeric$`Favorite feature`)){
  if (tivo_numeric$`Favorite feature`[i]=='saving favorite shows to watch as a family'){tivo_numeric$`Favorite feature`[i]= 0} 
  else if (tivo_numeric$`Favorite feature`[i]=='time shifting'){tivo_numeric$`Favorite feature`[i]=1} 
  else if (tivo_numeric$`Favorite feature`[i]=='cool gadget') {tivo_numeric$`Favorite feature`[i]=2} 
  else if (tivo_numeric$`Favorite feature`[i]=='schedule control') {tivo_numeric$`Favorite feature`[i]=3}
  else {tivo_numeric$`Favorite feature`[i]=4}
}
tivo_numeric$`Favorite feature`= as.numeric(tivo_numeric$`Favorite feature`)

#Find correlation and r-squared between Education and Favourite feature
cor(tivo_numeric$Education,tivo_numeric$`Favorite feature`)^2


#d. Correlate Monthly Electronics Spend with Monthly Household Spend, and find r-squared
cor(tivo$`Monthly Electronics Spend`,tivo$`Monthly Household Spend`)^2

###########################################################
#Question 8#########

#Arbitrary Segmentation (Without Statistical Analyses)#############

#Create a column in the dataset to categorize based on age
tivo$Age_category= tivo$Age

#Both tivo numeric and tivo have the same Age column so there is no difference in iterating over both
#I iterate over tivo_numeric because this was done above, and I wanted to save time
for (i in 1:length(tivo_numeric$Age)){
  if (tivo_numeric$Age[i]<= 26)
  {tivo$Age_category[i]= 0} 
  else if (tivo_numeric$Age[i]<= 35)
  {tivo$Age_category[i]=1} 
  else if (tivo_numeric$Age[i]<=44) 
  {tivo$Age_category[i]=2} 
  else if (tivo_numeric$Age[i]<= 53) 
  {tivo$Age_category[i]=3}
  else if (tivo_numeric$Age[i]<= 62)
  {tivo$Age_category[i]= 4}
  else if (tivo_numeric$Age[i]<= 71)
  {tivo$Age_category[i]= 5}
  else {tivo$Age_category[i]=6}
}

getmode <- function(v) {
  unique_value <- unique(v)
  unique_value[which.max(tabulate(match(v, unique_value)))]
}

#####AGE 18-26 ##########
#Reported favorite features and purchasing locations
unique(tivo[tivo$Age_category==0,]$`Favorite feature`)
unique(tivo[tivo$Age_category==0,]$`Purchasing Location`)


#Most reported feature and purchasing location
getmode(tivo[tivo$Age_category==0,]$`Favorite feature`)
getmode(tivo[tivo$Age_category==0,]$`Purchasing Location`)


#####AGE 27-35 ##########
#Reported favorite features and purchasing locations
unique(tivo[tivo$Age_category==1,]$`Favorite feature`)
unique(tivo[tivo$Age_category==1,]$`Purchasing Location`)


#Most reported feature and purchasing location
getmode(tivo[tivo$Age_category==1,]$`Favorite feature`)
getmode(tivo[tivo$Age_category==1,]$`Purchasing Location`)


#####AGE 36-44 ##########
#Reported favorite features and purchasing locations
unique(tivo[tivo$Age_category==2,]$`Favorite feature`)
unique(tivo[tivo$Age_category==2,]$`Purchasing Location`)


#Most reported feature and purchasing location
getmode(tivo[tivo$Age_category==2,]$`Favorite feature`)
getmode(tivo[tivo$Age_category==2,]$`Purchasing Location`)

#####AGE 45-53 ##########
#Reported favorite features and purchasing locations
unique(tivo[tivo$Age_category==3,]$`Favorite feature`)
unique(tivo[tivo$Age_category==3,]$`Purchasing Location`)


#Most reported feature and purchasing location
getmode(tivo[tivo$Age_category==3,]$`Favorite feature`)
getmode(tivo[tivo$Age_category==3,]$`Purchasing Location`)


#Codify the other categorical variables in tivo_numeric in order to conduct a correlation
#analysis for segmentation

tivo_numeric$`Marital Status`= ifelse(tivo_numeric$`Marital Status`== 'Married', 1, 0)

tivo_numeric$`Work Status`= ifelse(tivo_numeric$`Work Status`== 'Professional', 1, 0)

tivo_numeric$`Purchasing Decision-maker`= ifelse(tivo_numeric$`Purchasing Decision-maker`
                                                 == 'Family', 1, 0)

#Codify Purchasing Location
for (i in 1:length(tivo_numeric$`Purchasing Location`)){
  if (tivo_numeric$`Purchasing Location`[i]=='retail')
    {tivo_numeric$`Purchasing Location`[i]= 0} 
  else if (tivo_numeric$`Purchasing Location`[i]=='discount')
    {tivo_numeric$`Purchasing Location`[i]=1} 
  else if (tivo_numeric$`Purchasing Location`[i]=='mass-consumer electronics') 
    {tivo_numeric$`Purchasing Location`[i]=2} 
  else if (tivo_numeric$`Purchasing Location`[i]=='specialty stores') 
    {tivo_numeric$`Purchasing Location`[i]=3}
  else {tivo_numeric$`Purchasing Location`[i]=4}
}

tivo_numeric$`Purchasing Location`= as.numeric(tivo_numeric$`Purchasing Location`)


tivo_numeric$`Technology Adoption`= 
  ifelse(tivo_numeric$`Technology Adoption`== 'Early', 1, 0)


#Install and load Data Explorer package to conduct Correlation analysis and PCA
library(DataExplorer)
library(ggplot2)
install.packages('flexclust')
library(flexclust)

plot_correlation(tivo_numeric, 
                 theme_config= list(axis.text.x= element_text(angle = 90), plot.title= element_text(hjust = 0.5)))

#Based on correlation analysis, exclude highly correlated variables from PCA analysis
#The correlation threshold here is 0.7 (Square root of the threshold given in the case which was for R-squared).
#Variables that were >= 0.7 correlated with other variables were excluded
tivo_pca= tivo_numeric[,-which(names(tivo_numeric) %in% c("Favorite feature","Monthly Electronics Spend",
                                                          "Spending as % of income (%)","Purchasing Location"))]


#Use only numeric fields for the PCA
pca= prcomp(tivo_pca[,unlist(lapply(tivo_pca, FUN=class))=="numeric"],center = TRUE, scale.=TRUE)

#Show results from the PCA
summary(pca)

pca

#Return the factor loadings for the PCA
print(pca, digits=1)


#Plot the variance explained by the different PCs as well as the important variables in each 
plot_prcomp(tivo_pca[,unlist(lapply(tivo_pca, FUN=class))=="numeric"], title = 'Principal Component Analysis', 
            theme_config= list(plot.title= element_text(hjust = 0.5)),variance_cap = 1)

#Load packages needed to 
install.packages('devtools')
library(devtools)
install_github("vqv/ggbiplot")
library(ggbiplot)

#Plot PC2 against PC1 of PCA
ggbiplot(pca, alpha= 0.5, obs.scale = 1, var.scale = 0.5 )

###################### EARLY INFREQUENT ###########################
#Define infrequent early adopters purchasing segment
early_infrequent= tivo$`Technology Adoption`=='Early' & (tivo$`Purchasing Frequency (every x months)`> mean(tivo$`Purchasing Frequency (every x months)`)
                                                         & tivo$`Annual spending on electronics`< mean(tivo$`Annual spending on electronics`))

#PCA capturing early infrequent group
ggbiplot(pca, alpha= 0.5, obs.scale = 1, var.scale = 0.5, ellipse= TRUE, groups= early_infrequent )

#groups for above: early_infrequent
ggbiplot(pca, alpha= 0.5, ellipse = TRUE, groups= tivo$`Annual spending on electronics`< mean(tivo$`Annual spending on electronics`))

###################### EARLY FREQUENT SINGLE PROFESSIONALS ###########################
#Define frequent early adopting single professionals purchasing segment
early_frequent= tivo$`Technology Adoption`=='Early' & 
  (tivo$`Work Status`=='Professional') & 
  (tivo$`Annual Income (x1000 $)`< mean(tivo$`Annual Income (x1000 $)`)) & (tivo$`Marital Status`=='Single')

#PCA capturing early frequent group
ggbiplot(pca, alpha= 0.5, obs.scale = 1, var.scale = 0.5, ellipse= TRUE, groups= early_frequent )

###################### LATE ADOPTERS ###########################
#Get late adopters
late_spenders= which(tivo[,'Technology Adoption']=='Late')

#PCA based on late tech adoption
ggbiplot(pca, alpha= 0.5, obs.scale = 1, var.scale = 0.5, ellipse=TRUE, groups= tivo$`Technology Adoption` =='Late')


###################### RICH EARLY-ADOPTING FREQUENT PROFESSIONALS ###########################
#PCA for rich early-adopting frequent-purchasing professionals 
rich_early_frequent= (tivo$`Technology Adoption`=='Early') & (tivo$`Purchasing Frequency (every x months)`< mean(tivo$`Purchasing Frequency (every x months)`)) & 
  (tivo$`Work Status`=='Professional') & (tivo$`Annual Income (x1000 $)`> mean(tivo$`Annual Income (x1000 $)`))

ggbiplot(pca, alpha= 0.5, obs.scale = 1, var.scale = 0.5, ellipse= TRUE, groups= rich_early_frequent)


#Create report
DataExplorer::create_report(tivo_pca[,unlist(lapply(tivo_pca, FUN=class))=="numeric"])


#CALCULATIONS FOR QUESTION 8##########

######SEGMENT 1 (Early adopters that purchase infrequently)###########
length(which(tivo$`Technology Adoption`=='Early' & (tivo$`Purchasing Frequency (every x months)`> 
                                                      mean(tivo$`Purchasing Frequency (every x months)`))))


early_infrequent_segment= tivo[which(tivo$`Technology Adoption`=='Early' & (tivo$`Purchasing Frequency (every x months)`> 
                                                                              mean(tivo$`Purchasing Frequency (every x months)`))),]


#Average annual income of early infrequent segment
mean(early_infrequent_segment$`Annual Income (x1000 $)`)*1000

sum(early_infrequent_segment$`Favorite feature`=='schedule control')


#Reported favorite features and purchasing locations
unique(early_infrequent_segment$`Favorite feature`)
unique(early_infrequent_segment$`Purchasing Location`)


#Most reported feature and purchasing location
getmode(early_infrequent_segment$`Favorite feature`)
getmode(early_infrequent_segment$`Purchasing Location`)

#Number of respondents who reported a purchasing location of 'discount'
length(which(early_infrequent_segment$`Purchasing Location`=='discount'))

#Number of respondents who reported a purchasing location of 'retail'
length(which(early_infrequent_segment$`Purchasing Location`=='retail'))

#Average electronics spend for early infrequent segment
mean(early_infrequent_segment$`Annual spending on electronics`)


###########SEGMENT 2 (LATE ADOPTERS) ########################
late_adopters= tivo[which(tivo[,'Technology Adoption']=='Late'),]

#Number of late adopters
nrow(late_adopters)

#Average annual income of late adopters
mean(late_adopters$`Annual Income (x1000 $)`)*1000

#Reported favourite features and purchasing locations
unique(late_adopters$`Favorite feature`)
unique(late_adopters$`Purchasing Location`)

#Average electronics spend for late adopters
mean(late_adopters$`Annual spending on electronics`)


###########SEGMENT 3 (AFFLUENT, EARLY ADOPTERS, PURCHASE FREQUENTLY, PROFESSIONALS) ########################
early_frequent_professionals= tivo[(tivo$`Technology Adoption`=='Early') & 
                                     (tivo$`Purchasing Frequency (every x months)`< mean(tivo$`Purchasing Frequency (every x months)`)) 
                                   & (tivo$`Work Status`=='Professional') & (tivo$`Annual Income (x1000 $)`> mean(tivo$`Annual Income (x1000 $)`)),]

#Number of early adopting professionals
nrow(early_frequent_professionals)

#Average annual income of early adopter professionals
mean(early_frequent_professionals$`Annual Income (x1000 $)`)*1000

#Reported favourite features and purchasing locations
unique(early_frequent_professionals$`Favorite feature`)
unique(early_frequent_professionals$`Purchasing Location`)

#Most reported favorite feature and purchasing location
getmode(early_frequent_professionals$`Favorite feature`)

#Average electronics spend for early adopter professionals
mean(early_frequent_professionals$`Annual spending on electronics`)

#Percentage that were males
sum(early_frequent_professionals$Gender=='Male')/nrow(early_frequent_professionals)*100

#Segment 3 Average TV Viewing Time
mean(early_frequent_professionals$`TV Viewing (hours/day)`)

hist(early_frequent_professionals$`TV Viewing (hours/day)`)

#Compare to Average TV Viewing Time of the Entire Dataset
mean(tivo$`TV Viewing (hours/day)`)
hist(tivo$`TV Viewing (hours/day)`)

###########SEGMENT 4 (LESS AFFLUENT, EARLY ADOPTERS, SINGLES,PURCHASE QUITE FREQUENTLY, PROFESSIONALS) ########################
lower_income_professionals= tivo[(tivo$`Technology Adoption`=='Early') & (tivo$`Work Status`=='Professional') & (tivo$`Annual Income (x1000 $)`< mean(tivo$`Annual Income (x1000 $)`)) 
                                 & (tivo$`Marital Status`=='Single'),]


#Number of early adopting lower income professionals
nrow(lower_income_professionals)


#Average annual income of early adopter professionals
mean(lower_income_professionals$`Annual Income (x1000 $)`)*1000

#Reported favourite features and purchasing locations
unique(lower_income_professionals$`Favorite feature`)
unique(lower_income_professionals$`Purchasing Location`)

#Most reported favorite feature and purchasing location
getmode(lower_income_professionals$`Favorite feature`)

#Average electronics spend for early adopter professionals
mean(lower_income_professionals$`Annual spending on electronics`)



