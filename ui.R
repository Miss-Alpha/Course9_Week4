library(shiny)
library(plotly)
shinyUI(fluidPage(
    titlePanel("World Statistics"),
    sidebarLayout(
        sidebarPanel(
            radioButtons("rb", "Choose a Variable to See the Statistics:",
                         choiceNames = list(
                             "GDP",
                             "Life Expectancy",
                             "Population"
                         ),
                         choiceValues = list(
                             "gdpPercap", "lifeExp", "pop"
                         )),
        ),
        mainPanel(
            h4("Line Graph From 1952-2007"),
            textOutput("text"),
            tabsetPanel(type = "tabs",
                        tabPanel("Plot", plotlyOutput("plot")),
                        tabPanel("Table", tableOutput("table"))
            )
            
        )
    )
))