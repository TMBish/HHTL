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

# Define UI for application that draws a histogram
shinyUI(
  semanticPage(
    
    # Add custom css styles
    includeCSS(file.path('www', 'custom-style.css')),
    
    div(class="app-header",
    
    h1(class = "ui header", ": Hannah's History Timeline :")
    ),
    
    br(),
    
    div(class="ui grid", 
        
        div(class="one wide column",
            
            dropdownButton(
              tags$h3(style="color:#FBBD08;","Add a Historical Event"), hr(),
              
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
    # div(class = "ui stackable two column grid", 
    #     
    #     
    #     div(class = "column", 
    #         
    #         div(class = "ui horizontal divider", uiicon("options"), "Add History")
    #         
    # 
    #         
    #         
    #         
    #         
    #         ),
    #     
    #     
    #     
    #     div(class = "column", id = "details",  
    #         
    #         
    #         div(class = "ui horizontal divider", uiicon("options"), "Details"),
    #         
    #           div(class = "ui card",
    #               
    #               div(class = "content", 
    #                   
    #                   div(class = "right floated meta", "14h"), 
    #                   img(class = "ui avatar image", src = "hannah.jpg"), 
    #                   "Hannah"
    # 
    #               ),
    #               
    #               div(class = "image", 
    #                   
    #                   img(src = "wedding.jpg")
    #                   
    #               ), 
    #               
    #               div(class = "content", 
    #                   
    #                   span(class = "right floated", uiicon("calendar"), "201-04-08"),
    #                   uiicon("comment"), "Tom + Hannah Wedding"
    #                   
    #               ),
    #               
    #               div(class = "extra content", 
    #                   
    #                       tags$p("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
    #                       
    #                       
    #                   
    #               )
    #           )
    #         
    #         
    #         )
    #     
    #     
    # )
  
   
  )
)
