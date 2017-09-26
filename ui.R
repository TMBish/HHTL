#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shiny.semantic)
library(timevis)

# Define UI for application that draws a histogram
shinyUI(
  semanticPage(
    
    # Add custom css styles
    includeCSS(file.path('www', 'custom-style.css')),
    
    
    h1(class = "ui header", "Hannah's History Timeline"),
    
    div(class = "ui horizontal divider", uiicon("tag"), "Timeline"),
    
    br(),
    
    timevisOutput("timeline"),
    
    br(),
    
    div(class = "ui horizontal divider", uiicon("tag"), "Details")
    
  

  )
)
