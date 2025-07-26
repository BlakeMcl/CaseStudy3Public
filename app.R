library(dplyr)
library(car)
library(shiny)
library(bslib)
library(effects)
# Model Definitions

wine_df <- read.csv("winequality-red.csv")
regression_score_model <- lm(quality ~ 
                               fixed.acidity + 
                               volatile.acidity + 
                               citric.acid + 
                               residual.sugar + 
                               chlorides + 
                               free.sulfur.dioxide +
                               total.sulfur.dioxide +
                               density +
                               pH +
                               sulphates +
                               alcohol,
                             data = wine_df)
sum <- summary(regression_score_model)
predict_values <- data.frame(fixed.acidity = 7.3, 
                             volatile.acidity = .7,
                             citric.acid = 0,
                             residual.sugar = 1.9, 
                             chlorides = 0.007,
                             free.sulfur.dioxide = 11,
                             total.sulfur.dioxide = 34,
                             density =.99,
                             pH = 3.51,
                             sulphates = 0.56,
                             alcohol = 9.4)
predict(regression_score_model, predict_values)
#avPlots(regression_score_model)

#Shiny Instantiate

ui <- page_sidebar(
  # App title ----
  title = "Wine Rating Prediction:",
  # Sidebar panel for inputs ----
  sidebar = sidebar(
    # Input: Slider for the number of bins ----
      textOutput("prediction"),
      sliderInput(
      inputId = "f_acid",
      label = "Fixed Acidity Value",
      min = 0,
      max = 10,
      value = 5
    ),
    sliderInput(
      inputId = "v_acid",
      label = "Volatile Acidity Value",
      min = 0,
      max = 1,
      value = .5
    ),
    sliderInput(
      inputId = "citric_acid",
      label = "Citric Acid Value",
      min = 0,
      max = 1,
      value = .5
    ),
    sliderInput(
      inputId = "sugar",
      label = "Sugar Value",
      min = 0,
      max = 10,
      value = 5
    ),
    sliderInput(
      inputId = "cl",
      label = "Cloride Value",
      min = 0,
      max = .5,
      value = .25
    ),
    sliderInput(
      inputId = "f_su",
      label = "Free Sulfur Dioxide Value",
      min = 1,
      max = 20,
      value = 10
    ),
    sliderInput(
      inputId = "t_su",
      label = "Total Sulfur Value",
      min = 1,
      max = 150,
      value = 30
    ),
    sliderInput(
      inputId = "density",
      label = "Density Value",
      min = .9,
      max = 1,
      value = .95
    ), 
    sliderInput(
      inputId = "ph",
      label = "pH Value",
      min = 1,
      max = 12,
      value = 3
    ), 
    sliderInput(
      inputId = "sulphates",
      label = "Sulphates Value",
      min = 0,
      max = 1,
      value = .5
    ),
    sliderInput(
      inputId = "alcohol",
      label = "Alcohol Value",
      min = 0,
      max = 20,
      value = 10
    ), 
  ),
  h3("Dataset Explaination"),
  p("The data that I decided to use for this shiny app pertained to wine and
  the quality of it. There are many chemical factors that go into developing 
  a good quality wine. This dataset has datapoints for the following factors: 
  fixed acidity, volatile acidity, citric acid, residual sugar, chlorides, 
  free sulfur dioxide, total sulfur dioxide, density, pH, sulphates, alcohol, 
  quality. Each of these parameters has some sort of impact on the quality of 
  the wine and contributes to the quality metric. The dataset can be found on
  kaggle here: https://www.kaggle.com/datasets/yasserh/wine-quality-dataset."),
  h3("Model Explaination"),
  p("The algorithm that I chose to use for this dataset was a multivariate 
    linear regression model. The reasoning behind choosing a model like this 
    was based on the structure of the data. These wine values are continuous, 
    meaning that you can have 3.6532, or 3. Since the data is not limited to 
    discrete values it is easier to create a linear model that represents the 
    trend of the data. It will be multivariate because there are multiple 
    values in the dataset that have an impact on the quality of the wine. "),
  h3("Plots"),
  p(" The graphs represent the effect that the parameter will have on the \n 
    quality of the wine. The dashed lines show datapoints that were plotted"),
  fluidRow(id='row1',
  plotOutput("chartfixedacid"),
  plotOutput("chartvolatileacid"),
  plotOutput("chartcitricacid"),
  plotOutput("chartresidualsugar"),
  plotOutput("chartchlorides"),
  plotOutput("chartfreesulfurdioxide"),
  plotOutput("charttotalsulfurdioxide"),
  plotOutput("chartdensity"),
  plotOutput("chartpH"),
  plotOutput("chartsulphates"),
  plotOutput("chartalcohol"),
  ),
)

server <- function(input, output) {
  
  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$chartfixedacid <- renderPlot({
    proportions <- effect("fixed.acidity", regression_score_model)
    plot(proportions)
  })
  output$chartvolatileacid <- renderPlot({
    proportions <- effect("volatile.acidity", regression_score_model)
    plot(proportions)
  })
  output$chartcitricacid <- renderPlot({
    proportions <- effect("citric.acid", regression_score_model)
    plot(proportions)
  })
  output$chartresidualsugar <- renderPlot({
    proportions <- effect("residual.sugar", regression_score_model)
    plot(proportions)
  })
  output$chartchlorides <- renderPlot({
    proportions <- effect("chlorides", regression_score_model)
    plot(proportions)
  })
  output$chartfreesulfurdioxide <- renderPlot({
    proportions <- effect("free.sulfur.dioxide", regression_score_model)
    plot(proportions)
  })
  output$charttotalsulfurdioxide <- renderPlot({
    proportions <- effect("total.sulfur.dioxide", regression_score_model)
    plot(proportions)
  })
  output$chartdensity <- renderPlot({
    proportions <- effect("density", regression_score_model)
    plot(proportions)
  })
  output$chartpH <- renderPlot({
    proportions <- effect("pH", regression_score_model)
    plot(proportions)
  })
  output$chartsulphates <- renderPlot({
    proportions <- effect("sulphates", regression_score_model)
    plot(proportions)
  })
  output$chartalcohol <- renderPlot({
    proportions <- effect("alcohol", regression_score_model)
    plot(proportions)
  })
  output$distPlot <- renderPlot({})
  
  output$prediction <- renderText({
    predict_values <- data.frame(fixed.acidity = input$f_acid, 
                                 volatile.acidity = input$v_acid,
                                 citric.acid = input$citric_acid,
                                 residual.sugar = input$sugar, 
                                 chlorides = input$cl,
                                 free.sulfur.dioxide = input$f_su,
                                 total.sulfur.dioxide = input$t_su,
                                 density =input$density,
                                 pH = input$ph,
                                 sulphates = input$sulphates,
                                 alcohol = input$alcohol)
    print(paste("Your Wines Predicted Score:\n", predict(regression_score_model, predict_values)))
    
  })
  
}

shinyApp(ui = ui, server = server)


