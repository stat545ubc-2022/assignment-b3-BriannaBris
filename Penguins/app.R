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
library(shinythemes)

# Loading the palmerpenguins dataset
penguins <- palmerpenguins::penguins

# Defining the UI for the "Playing with Penguins" shiny application
ui <- fluidPage(
  # New Feature 1 - Updated the theme of my Shiny app from default to "cerulean" 
    theme = shinytheme("cerulean"),
  # New Feature 2 - Added palmerpenguins R package png for aesthetics
    img(src = "logo.png", height = 200, width = 200, align = "left"),
    img(src = "logo.png", height = 200, width = 200, align = "right"),
  # Application title updated to be larger and centered for most aesthetically pleasing user interface
    h1("Playing with Penguins", align = "center", style = "font-size:90px"),
    h2("This shiny app is designed to visualize bill length, flipper length, body mass and bill depth changes between penguin species in the palmerpenguins dataset across islands and year.", align = "center", style = "font-size:15px"),
    br(),
    br(),
    br(),
    br(),
  sidebarLayout(
    sidebarPanel( 
    # New Feature 3 - Added note explaining how to use Shiny app and what the output would be for new users
      helpText("Please select the desired year and island inputs from the drop down menu to output the corresponding violin plots and results table!", align = "center"),
    # New Feature 4 (UPDATED) - Switching selection filters for island and year to check boxes to visualize multiple island and year parameters at once
      checkboxGroupInput("yearInput", "Select year(s):", choices = c("2007", "2008", "2009")),
      checkboxGroupInput("islandInput", "Select island(s):", choices = c("Torgersen", "Dream", "Biscoe")),
    # Added fun image to shiny app
      img(src = "dancing-penguins.gif")), 
    # Plot bill length, depth, flipper length and body mass bar graphs comparing all species
    mainPanel(
      tags$style(type="text/css",
                 ".shiny-output-error { visibility: hidden; }",
                 ".shiny-output-error:before { visibility: hidden; }"),
      tabsetPanel(
        tabPanel("Bill Length", plotOutput("bill_length")),
        tabPanel("Flipper Length", plotOutput("flipper_length")),
        tabPanel("Body Mass", plotOutput("body_mass")),
        tabPanel("Bill Depth", plotOutput("bill_depth"))),
      br(), br(),
      # Produces corresponding table of plotted results
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
      scale_fill_manual(values = c("Adelie" = "#FF7CA0",
                                   "Chinstrap" ="#93F7F5",
                                   "Gentoo" = "#8EF5BE")) +
  # New Feature 5 - Added facet_wrap to group output graphs by island
      facet_wrap(~ island)
  })
  # Producing plot for flipper length
  output$flipper_length <- renderPlot({
    filtered() %>%
      ggplot(penguins, mapping = aes(species, flipper_length_mm, fill = species)) + 
      geom_violin() + 
      geom_point() +
      labs(title = "Average Flipper Length", x = "Species", y = "Flipper Length (mm)", legend = "Species") + 
      theme(plot.title = element_text(hjust = 0.5)) +
      # Updated customized species-specific colours for aesthetics
      scale_fill_manual(values = c("Adelie" = "#FF7CA0",
                                   "Chinstrap" ="#93F7F5",
                                   "Gentoo" = "#8EF5BE")) +
      # New Feature 5 - Added facet_wrap to group output graphs by island
      facet_wrap(~ island)
  })
  # Producing plot for body mass
  output$body_mass <- renderPlot({
    filtered() %>% 
      ggplot(penguins, mapping = aes(species, body_mass_g, fill = species)) + 
      geom_violin() + 
      geom_point() +
      labs(title = "Average Body Mass", x = "Species", y = "Body Mass (g)", legend = "Species") + 
      theme(plot.title = element_text(hjust = 0.5)) +
      scale_fill_manual(values = c("Adelie" = "#FF7CA0",
                                   "Chinstrap" ="#93F7F5",
                                   "Gentoo" = "#8EF5BE")) +
      # New Feature 5 - Added facet_wrap to group output graphs by island
      facet_wrap(~ island)
  })
  # Producing plot for bill depth
  output$bill_depth <- renderPlot({
    filtered() %>% 
      ggplot(penguins, mapping = aes(species, bill_depth_mm, fill = species)) + 
      geom_violin() +
      geom_point() +
      labs(title = "Average Bill Depth", x = "Species", y = "Bill Depth (mm)", legend = "Species") + 
      theme(plot.title = element_text(hjust = 0.5)) +
      scale_fill_manual(values = c("Adelie" = "#FF7CA0",
                                   "Chinstrap" ="#93F7F5",
                                   "Gentoo" = "#8EF5BE")) +
      # New Feature 5 - Added facet_wrap to group output graphs by island
      facet_wrap(~ island)
  })
  # Rendering corresponding table for plotted data
  output$results <- renderTable({
    filtered()
  })
}
  
# Running the application 
shinyApp(ui = ui, server = server)
