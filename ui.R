library(shiny)
library(shinyjs)
library(shiny.semantic)
library(shinyWidgets)
library(timevis)
library(V8)

jsCode <- "

shinyjs.init = function() {
  Shiny.onInputChange('TL_selection', '')
};

shinyjs.find_ev = function(){

  var sel_title = $('#timeline').find('.vis-selected').text()

  Shiny.onInputChange('TL_selection', sel_title)

}"

# Define UI for application that draws a histogram
shinyUI(
  semanticPage(
    
    useShinyjs(),
    extendShinyjs(text = jsCode),
    
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
