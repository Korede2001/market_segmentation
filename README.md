# Market Segmentation Using Principal Component Analysis and Cluster Analysis

This paper outlines my solution to the 'TiVo Segmentation Analytics' case study by Kellogg School of Management. The case study can be purchased here: https://store.hbr.org/product/tivo-segmentation-analytics/KEL932

## Exploratory Data Analysis of TiVo Survey Data

A summary of the dataset is shown below:

![tivo_summary](https://user-images.githubusercontent.com/55578569/81492459-b998d100-928f-11ea-900a-02c9ede1d014.png)

We see there were 1000 survey responses with survey data condensed into 17 variables.

![tivo_hist](https://user-images.githubusercontent.com/55578569/81492737-27de9300-9292-11ea-8a1a-ac16940f7880.png)

We see a right skew in the annual and monthly electronics spend, telling us that some individuals spend a much larger amount of money on electronics than others, forcing the mean spend on electronics up such that it is now higher than the median spend.

Based on this, we might expect the annual income to also have a similar trend as a higher income might correlate to a higher spend on electronics. Observing the Annual income histogram, we notice outliers with > $600,000 annual income. To observe the skew excluding those outliers, we zoom into the histogram, looking at values between $20,000 and $70,000. The histogram is shown below:

![income_hist](https://user-images.githubusercontent.com/55578569/81493089-44c89580-9295-11ea-99eb-29cb62397de2.png)

From above, we see a right skew in the annual income even within this zoomed in range, suggesting that an increasing income might explain the higher spend on electronics. To further confirm this argument, the correlation between the annual income and the monthly electronics spend and annual electronics spend was found. These both correspond to 0.361 (as the annual electronics spend was calculated by multiplying the monthly spend by 12). Hence, there is a weak positive correlation between electronics spend and annual income, telling us that although both variables tend to go up in response to one another, the relationship is not very strong.

Subsequently, bar charts were created to observe the distribution of categorical variables. These are displayed below:

![var_bar](https://user-images.githubusercontent.com/55578569/81493223-a2a9ad00-9296-11ea-9d66-d5e7bb93d7fc.png)

From the figure above, we see that there are more male respondents than female respondents, more married respondents than single respondents, and more early technology adopter than late adopter, to mention a few. These characteristics will be observed more closely in the industry overview section.


## Industry Overview (Question 3)

An overview of the general characteristics of the TV-watching customers is generated using Excel as instructed by the Question prompts. 

![excel_pivot](https://user-images.githubusercontent.com/55578569/81493349-98d47980-9297-11ea-8fb6-702f88aa568d.png)

![excel_pivot2](https://user-images.githubusercontent.com/55578569/81498652-1317f480-92be-11ea-8db1-ad7b551dde00.png)

![excel_pivot3](https://user-images.githubusercontent.com/55578569/81498708-6a1dc980-92be-11ea-8d2c-23b48d3fac0f.png)


## Generating Market Segments Using a Principal Component Analysis and a Cluster Analysis

After observing the general characteristics of customers on various attributes, Question 8, which required generating market segments based on various characteristics was attempted.

### Exclusion of Highly Correlated Variables
As a first step, highly correlated variables were excluded in preparation for a principal component analysis. This was done to avoid multicollinearity, which would lead to the unfair weighting of the same concept, skewing the results towards that concept (Sambandam, 2003). A principal component analysis is intended to reduce the data into its essence by indicating the combination of the most informative variables which explain a large variation of the data.

To exclude highly correlated variables, categorical variables were codified using numeric values, to enable computation of correlations. The categorical variables codified include: Marital Status, Work Status, Purchasing decision-maker, Purchasing location, Gender, Education, Favourite Feature, and Technology Adoption.

Following this codification, a correlation analysis was conducted (by plotting a correlogram) using all the quantitative variables (including the codified ones) to identify highly correlated variables for exclusion. The correlogram is displayed below:

![correlogram](https://user-images.githubusercontent.com/55578569/81499357-f500c300-92c2-11ea-9c7b-1182bc4de4bd.png)

±0.7 was set as the correlation threshold as this is the standard threshold at which multicollinearity is known to be present. Hence, ‘Favorite feature’, ‘Monthly Electronics Spend’, ‘Spending as % of income (%),’ and ‘Purchasing Location’ were excluded from the principal component analysis (PCA) as they have a correlation equal to or greater than 0.7 with other variables.

### Data Reduction Through Principal Component Analysis
Following the exclusion of highly correlated variables, a principal component analysis (PCA) was conducted to breakdown the dataset into informative dimensions and tell us which variables are the most important in explaining the variation in each dimension and, by extension, the dataset. The percentage variance explained by the various principal components (PCs) is displayed in the graph below:

![pca_summary](https://user-images.githubusercontent.com/55578569/81503987-b973f200-92de-11ea-88b2-c378ebbf0439.png)

Looking at the x-axis, PC1, PC2, and PC3 solitarily explain about 24%, 17%, and 14% of the variation in the dataset, respectively. The label on the PC3 bar indicates that PC1, PC2, and PC3 cumulatively explain 54.1% of the variance in the dataset.

Next, we zoom into the principal components to see which variables were significant/ important in the various PCs for explaining the variance accounted for by those PCs. The graph below shows this breakdown:

![pca_vars1](https://user-images.githubusercontent.com/55578569/81504179-b4637280-92df-11ea-965f-711b1290dfcc.png)

![pca_vars2](https://user-images.githubusercontent.com/55578569/81504200-d52bc800-92df-11ea-8a25-76e0b12496b9.png)

From the figures above, we see that ‘Annual spending on electronics’ and ‘Technology Adoption’ are the two most important variables in PC1. In PC2, ‘Work Status’ and ‘Marital Status’ are the most important variables.

### Plotting of PCA Results & Cluster Analysis
The PCA results were then plotted to observe trends, clusters, and relationships between variables in the dataset. Specifically, PC2 was plotted against PC1 as this combination explains the most variation in the dataset.

![pca_biplot](https://user-images.githubusercontent.com/55578569/81504321-6a2ec100-92e0-11ea-8195-de1dbc1fa5cd.png)

**Note:** The lines emanating from the origin indicate the direction and size of the influence of the variables on the principal components (longer lines along a PC indicate stronger influence). 

From the biplot above, we can almost see four clusters of data points (clusters circled in red). This suggests four distinct clusters of people in our dataset that the potential customers could be segmented into. The respondents within each cluster have similarities in certain variables measured in the study. They, however, differ from individuals in other clusters on certain measured variables. This suggests that the four clusters could each serve as unique market segments with differing characteristics and needs. 

To accurately define the four clusters with variables measured in the study, different combinations of variables were tried until combinations that closely captured each of the clusters/segments were determined. These variable combinations were inferred from the loadings and directions of different variables acting on the clusters in the biplot above. 

The final variables combinations and the datapoints that correspond to the segment described by these combinations are shown below. Here the segment names were derived by closer observation of the captured segments. This will be discussed in the next section:

**Note:** As the clusters were inferred, we expect overlap between the clusters. However, the overlap shouldn't be terribly much.

#### Segment 1 (WEALTHY TECH ENTHUSIASTS):

![segment1](https://user-images.githubusercontent.com/55578569/81504472-56d02580-92e1-11ea-876e-732904aec5f6.png)

The circle representing ‘TRUE’ indicates the group of respondents that satisfied the grouping criteria (variable combinations) specified. The grouping criteria here that almost captured the first cluster in the biplot was rich (average annual income of the group was greater than the average annual income of all the respondents), early-adopter professionals that purchase electronics frequently (average purchasing Frequency of the group is less than the average purchasing frequency of all the respondents).

**Note:** The purchasing frequency was defined in the case study as the average number of months between electronics purchases. Hence, a lower purchasing frequency should correspond to a more frequent purchaser.

#### Segment 2 (LOW-INCOME TECH SAVVY SINGLES):

![segment_2](https://user-images.githubusercontent.com/55578569/81505188-70736c00-92e5-11ea-8b06-1752a95a2b62.png)

The circle representing ‘TRUE’ indicates the group of respondents that satisfied the grouping criteria. The grouping criteria here that almost captured the second cluster in the biplot was lower income (average annual income of the group was less than the average annual income of all the respondents), early-adopter professionals that are not married but purchase quite frequently (average purchasing Frequency of the group is less than the average purchasing frequency of all the respondents).

#### Segment 3 (FAMILY-ORIENTED TECH LOYALISTS):

![segment_3](https://user-images.githubusercontent.com/55578569/81505321-322a7c80-92e6-11ea-85cb-c6e0ac49f4ad.png)

The circle representing ‘TRUE’ indicates the group of respondents that satisfied the grouping criteria. The grouping criteria here that almost captured the third cluster was late adopters (reported ‘Late’ for Technology Adoption).

#### Segment 4 (INFREQUENT LOW-SPENDING EARLY ADOPTERS):

![image](https://user-images.githubusercontent.com/55578569/81505481-63f01300-92e7-11ea-97e4-cb6ad22704bc.png)

The circle representing ‘TRUE’ indicates the group of respondents that satisfied the grouping criteria. The grouping criteria here that almost captured the fourth cluster was early adopters that purchase electronics infrequently (average purchasing frequency of the group is greater than the average purchasing frequency of all the respondents in the dataset) and spend a small amount on electronics annually (average annual spending on electronics of the group is less than the average annual spending on electronics of all the respondents in the dataset).

### Segment Description

 After reasonably capturing each inferred segment, each segment was then analyzed and described (through marketing personas) with variables in the dataset. The description and general characteristics of each segment is displayed below:
 
 ![segment_description](https://user-images.githubusercontent.com/55578569/81505932-cbf42880-92ea-11ea-92f0-1ce37e7586c2.png)

### Additional Insights (Suggestion For TiVo's on Target Segment)

An especially exciting segment to target would be the ‘Wealthy Tech Enthusiasts.’ This segment is wealthy, and on average, spends $700 on electronics annually (see figure above). Hence, they could comfortably purchase TiVo’s product. Furthermore, in the segment description, we see that this particular segment has needs that TiVo’s product can address. Firstly, the individuals are extremely busy, and so the time-shifting and schedule control features of TiVo’s product could be very appealing to them. Also, individuals in this segment (mostly men) seem to make purchases desired by the family (possibly to keep the family satisfied while they are busy working). Hence, TiVo could create a marketing initiative targeted at this segment, which emphasizes the time-shifting and schedule control features of their new product, framing the product as a way for such people to include their favorite shows into their busy schedules by recording them for later viewing. TiVo could also employ a psychological marketing approach where it markets the product as a sure way to keep the family happy. By addressing these needs of TV watching flexibility and family satisfaction, through their product's advertisements, TiVo can capture the interest of this segment and increase their product sales. Another benefit of capturing this segment is that they purchase electronics frequently, and so could be a steady revenue source if TiVo develops more need-satisfying products. Also, by satisfying the needs of these affluent early adopters, TiVo can expand to more segments as this group could publicize the product and cause members of other segments to try the product.

### Noted Flaws In the Study and Potential Solutions
It is, however, important to note that the needs of each segment (in Scheme A and B) were induced from the data and not explicitly reported by the respondents. This indicates a limitation of ThinkAlike’s study: it failed to explore the reasons customers purchase electronics. The ‘why’ is crucial as it allows ThinkAlike to identify customers’ pain points and needs accurately, and these could be leveraged in TiVo’s product advertising and positioning. Furthermore, ThinkAlike asked questions regarding consumers’ attitudes and behavior to technology in general, and this might not translate to TiVo’s product, which is intended to disrupt the industry. The only question ThinkAlike asked that was directly related to TiVo's product, was the respondents’ favorite feature. Lastly, ThinkAlike’s sample size for the study was small and will likely affect the generalizability of its results.

To address the limitations of ThinkAlike’s research, I would start by adding a question that finds out the reasons consumers buy electronics. This question can be phrased in a qualitative form and analyzed for keywords with a technique such as word cloud analysis. This should indicate consumers’ needs, and help TiVo decide which segment’s needs it can most effectively address. I will also ask more questions directly related to TiVo’s product, such as how interested consumers are in the product or how likely they are to purchase the product. I would specifically ask if they will be willing to spend $499 on such a product, to get an idea of the potential demand for the product. I would also increase the sample size to increase the reliability and generalizability of the results. Lastly, I would  reduce the interview time to twenty minutes to reduce the study dropout rate.
