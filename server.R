#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(googlesheets)
library(dplyr)

hhtl_link <- "https://docs.google.com/spreadsheets/d/1ixqO2ZubVrb2-zV1gUSDWA0SmajvhZUitfv9LBPD4jc/edit?usp=sharing"

hhtl_obj <- hhtl_link %>%
  gs_url() 

hhtl_data <- hhtl_obj %>%
  gs_read("Sheet1")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$timeline <- renderTimevis({
    
      hhtl_data %>% timevis(height = 600) %>% return()
  })

  
  

  
})
