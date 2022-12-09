#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Loading library of required app packages
library(shiny)
library(tidyverse)
library(ggplot2)
library(dplyr)

# Loading the palmerpenguins dataset
penguins <- palmerpenguins::penguins

# Defining the UI for the "Playing with Penguins" shiny application
ui <- fluidPage(
    # Application title
    titlePanel("Playing with Penguins"),
  sidebarLayout(
    # Feature 1 - Adding selection filters for island and year
    sidebarPanel( 
      selectInput("yearInput", "Select a year:", choices = c("2007", "2008", "2009")),
      radioButtons("islandInput", "Choose an island:", choices = c("Torgersen", "Dream", "Biscoe")),
      # Feature 2 - Added fun image to shiny app
      img(src = "dancing-penguins.gif")), 
    # Feature 3 - Plot bill length, depth, flipper length and body mass bar graphs comparing all species
    mainPanel(
      tabsetPanel(
        tabPanel("Bill Length", plotOutput("bill_length")),
        tabPanel("Flipper Length", plotOutput("flipper_length")),
        tabPanel("Body Mass", plotOutput("body_mass")),
        tabPanel("Bill Depth", plotOutput("bill_depth"))),
      br(), br(),
      # Feature 3 - Produces corresponding table of plotted results
      tableOutput("results")
    )
  )
)

server <- function(input, output) {
# Creating reactive filter function specific to the set filter inputs above (island, year) so output plots and tables change according to these set conditions
 filtered <- reactive({
    penguins %>% 
     filter(
       island == input$islandInput,
       year == input$yearInput
     )
  })
 # Producing plot for bill length 
  output$bill_length <- renderPlot({
    filtered() %>% 
      ggplot(penguins, mapping = aes(species, bill_length_mm, fill = species)) + 
      geom_violin() + 
      geom_point() +
      labs(title = "Average Bill Length", x = "Species", y = "Bill Length (mm)", legend = "Species") + 
      theme(plot.title = element_text(hjust = 0.5)) +
      scale_fill_manual(values = c("Adelie" = "#F65D84",
                                    "Chinstrap" ="darkturquoise",
                                "Gentoo" = "#5DF695")) 
  })
  # Producing plot for flipper length
  output$flipper_length <- renderPlot({
    filtered() %>%
      ggplot(penguins, mapping = aes(species, flipper_length_mm, fill = species)) + 
      geom_violin() + 
      geom_point() +
      labs(title = "Average Flipper Length", x = "Species", y = "Flipper Length (mm)", legend = "Species") + 
      theme(plot.title = element_text(hjust = 0.5)) +
      scale_fill_manual(values = c("Adelie" = "#F65D84",
                                   "Chinstrap" ="darkturquoise",
                                   "Gentoo" = "#5DF695")) 
  })
  # Producing plot for body mass
  output$body_mass <- renderPlot({
    filtered() %>% 
      ggplot(penguins, mapping = aes(species, body_mass_g, fill = species)) + 
      geom_violin() + 
      geom_point() +
      labs(title = "Average Body Mass", x = "Species", y = "Body Mass (g)", legend = "Species") + 
      theme(plot.title = element_text(hjust = 0.5)) +
      scale_fill_manual(values = c("Adelie" = "#F65D84",
                                   "Chinstrap" ="darkturquoise",
                                   "Gentoo" = "#5DF695")) 
  })
  # Producing plot for bill depth
  output$bill_depth <- renderPlot({
    filtered() %>% 
      ggplot(penguins, mapping = aes(species, bill_depth_mm, fill = species)) + 
      geom_violin() +
      geom_point() +
      labs(title = "Average Bill Depth", x = "Species", y = "Bill Depth (mm)", legend = "Species") + 
      theme(plot.title = element_text(hjust = 0.5)) +
      scale_fill_manual(values = c("Adelie" = "#F65D84",
                                   "Chinstrap" ="darkturquoise",
                                   "Gentoo" = "#5DF695")) 
  })
  # Rendering corresponding table for plotted data
  output$results <- renderTable({
    filtered()
  })
}
  
# Running the application 
shinyApp(ui = ui, server = server)
