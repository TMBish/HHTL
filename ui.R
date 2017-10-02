shinyUI(
  semanticPage(
    title = "My page",
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
    
    # Main page after load
    # hidden(
    div(id = "app-body", class="ui grid", 
        
        hidden(
          div(class="one wide column", id = "dropdown-div",
              
              
              dropdownButton(
                tags$h3("Add a Historical Event"), hr(),
                
                textInput("title", label = "Event Name", value = ""),
                
                textInput("image_link", label = "Photo of Event (url)", value = ""),
                
                dateRangeInput("event_dates", label = "Period"),
                
                textAreaInput("description", 
                              label = "Add a Decription:", 
                              value = "", 
                              height = 150),
                
                actionButton("upload_event", "Add Event", icon =  icon("upload")),
                
                circle = TRUE, 
                icon = icon("plus"),
                width = "300px",
                tooltip = tooltipOptions(title = "Click to see inputs !")
              ) 
          )
        ),
        
        div(class="fifteen wide column",
            
            div(class = "ui horizontal divider", icon("globe"), "The History Of Everything")
            
        )
        
    ),
    
    br(),
    
    timevisOutput("timeline"),
    
    br()
    # )
  )
)
