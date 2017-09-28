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
library(shinyWidgets)
library(timevis)

find_ev <- "
shinyjs.find_ev = function(){

var ev = $('#timeline').find('.vis-selected').text();

return(ev)
}"


# Define UI for application that draws a histogram
shinyUI(
  semanticPage(
    
    useShinyjs(),
    extendShinyjs(text = find_ev),
    
    # Add custom css styles
    includeCSS(file.path('www', 'custom-style.css')),
    
    div(class="app-header",
    
    h1(class = "ui header", ": HANNAH'S HISTORY TIMELINE :")
    ),
    
    br(),
    
    
    # Sweet Alert
    receiveSweetAlert(messageId = "event_success"),
    
    
    div(class="ui grid", 
        
        div(class="one wide column",
            
            dropdownButton(
              tags$h3("Add a Historical Event"), hr(),
              
              textInput("title", label = "Event Name", value = ""),
              
              textInput("image_link", label = "Photo of Event (url)", value = ""),
              
              dateRangeInput("event_dates", label = "Period"),
              
              textAreaInput("description", 
                            label = "Add a Decription:", 
                            value = "", 
                            height = 150),
              
              actionButton("upload_event", "Add Event", icon =  uiicon("upload")),
              
              circle = TRUE, 
              icon = icon("plus"),
              width = "300px",
              tooltip = tooltipOptions(title = "Click to see inputs !")
            )   
        ),
        
        div(class="fifteen wide column",
            
            div(class = "ui horizontal divider", uiicon("world"), "The History Of Everything")
            
            
            )

    ),
    
    br(),
    
    timevisOutput("timeline"),
    
    br()
    
    # submitButton("test", "Test"),
    # 

  
   
  )
)
