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
  
  observeEvent(input$upload_event, {
    
    title <- input$title
    
    img_link <- input$image_link
    
    ev_dates <- input$event_dates
    start_date <- ev_dates[1]
    end_date <- ifelse(ev_dates[1]==ev_dates[2], NA, ev_dates[2])
    
    desc <- input$description
    
    
    new_row <- data.frame(
      id = 1,
      content = title,
      start = start_date,
      end = end_date,
      img = img_link,
      description = desc
    )
    
    new_row %>% head()
    
  })

  
  

  
})
