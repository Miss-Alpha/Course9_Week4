library(shiny)
library(dplyr)
library(plotly)
library(gapminder)

shinyServer(function(input, output) {
    gaps_df <- gapminder %>%
        group_by(continent, year) %>%
        summarize(gdp_mean = mean(gdpPercap), lifeExp_mean = mean(lifeExp), population_mean = mean(pop))
    gaps <- reactive({
        varInput <- input$rb
        if(varInput == "gdpPercap")
        {
            gapp <- plot_ly(gaps_df, x= ~year, y= ~gdp_mean, color = ~continent, 
                    type = "scatter", mode = "lines+markers", colors = "Set1",
                    marker = list(size = 10, width = 2),
                    text = ~paste("Year: ", year, '<br>GDP:', round(gdp_mean)))
        }
        if(varInput == "pop")
        {
            gapp <- plot_ly(gaps_df, x= ~year, y= ~population_mean, color = ~continent, 
                    type = "scatter", mode = "lines+markers", colors = "Set1",
                    marker = list(size = 10, width = 2),
                    text = ~paste("Year: ", year, '<br>Population:', round(population_mean)))
        }
        if(varInput == "lifeExp")
        {
            gapp <- plot_ly(gaps_df, x= ~year, y= ~lifeExp_mean, color = ~continent, 
                    type = "scatter", mode = "lines+markers", colors = "Set1",
                    marker = list(size = 10, width = 2),
                    text = ~paste("Year: ", year, '<br>Life Expectancy:', round(lifeExp_mean)))
        }
        gapp
    })
    output$plot <- renderPlotly(gaps())
    output$table <- renderTable(gaps_df)
})
