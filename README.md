# CaseStudy3Public
### Case Study 3 Report
#### Application Links and Commands 
### Access Via Web 
### https://blakedatascienceapps.shinyapps.io/CaseStudy3/

### Access Via Github

### shiny::runGitHub("CaseStudy3Public", "BlakeMcl")

### Or here is the link

### https://github.com/BlakeMcl/CaseStudy3Public.git
#### Dataset: 
#### What data did you collect?

The data that I decided to use for this shiny app pertained to wine and the quality of it. There are many chemical factors that go into developing a good quality wine. This dataset has datapoints for the following factors: fixed acidity, volatile acidity, citric acid, residual sugar, chlorides, free sulfur dioxide, total sulfur dioxide, density, pH, sulphates, alcohol, quality. Each of these parameters has some sort of impact on the quality of the wine and contributes to the quality metric. The dataset can be found on kaggle here: https://www.kaggle.com/datasets/yasserh/wine-quality-dataset. 

#### Why is this topic interesting or important to you? (Motivation)

The reason this topic is interesting is because one of my hobbies is cooking and creating different types of extracts such as vanilla and peppermint. I tried to find a dataset that was for extracts but came across this wine one instead. It peaked my interest with all the obscure values and interesting conclusions 
### Algorithm:
####  How did you analyze the data?
#### Reasoning:
The algorithm that I chose to use for this dataset was a multivariate linear regression model. The reasoning behind choosing a model like this was based on the structure of the data. These wine values are continuous, meaning that you can have 3.6532, or 3. Since the data is not limited to discrete values it is easier to create a linear model that represents the trend of the data. It will be multivariate because there are multiple values in the dataset that have an impact on the quality of the wine. 

#### Mathematical Analysis:
The math behind performing a linear regression comes down to what combination of coefficients and values added together equal the given y. This creates the equation for a line that is able to predict the y value given some set of the X’s or independent variables. In the case of the wine data these independent variables are all the columns but quality. The first mathematical step is to get the Regression sums. These regression sums are used to calculate the coefficients(B) on the equations. See the below Equation:

Y =b0+ b1X1 + b2X2 + ….. + biXi

The regression sums are done by summing the square roots and subtracting the square of the sums and dividing by the number. This needs to be done for every variable and then by multiplying them together. Using these regression sums you can generate the B values and create the linear regression model. 

In our code the math is done by the built in modeling function lm() which automatically finds all the b values for us. 

#### What did you find in the data? (please include figures or tables in the report)

There were multiple conclusions I found within the dataset. To make my multivariate regression I used every parameter available in the CSV file. To analyze these values I created effect graphs which are included and can be viewed in the application. Each of the values has some sort of effect on the data. Some of the parameters had a positive effect and some of the had a negative effect. The parameters that had a positive effect meaning as they rose the quality rose are as follows: fixed acidity, residual sugar,free sulfur dioxide, total sulfur dioxide, sulphates, alcohol. The parameters that had a negative value are as follows: volatile acidity, citric acid, chlorides, total sulfur dioxide, density, pH. These assumptions were made using the graphs that are in the shiny application. Other conclusions I found were that if you made the values extreme or super high and low it has an unforeseen effect rather than the usually steady increase or decrease.  

