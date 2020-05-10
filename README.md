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


## Industry Overview (Questions 3 & 4)

An overview of the general characteristics of the TV-watching customers is generated using Excel as instructed by the Question prompts. 

![excel_pivot](https://user-images.githubusercontent.com/55578569/81493349-98d47980-9297-11ea-8fb6-702f88aa568d.png)

![excel_pivot2](https://user-images.githubusercontent.com/55578569/81498652-1317f480-92be-11ea-8db1-ad7b551dde00.png)

![excel_pivot3](https://user-images.githubusercontent.com/55578569/81498708-6a1dc980-92be-11ea-8d2c-23b48d3fac0f.png)




