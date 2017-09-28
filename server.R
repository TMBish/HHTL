library(shiny)
library(googlesheets)
library(dplyr)
library(glue)

hhtl_link <- "https://docs.google.com/spreadsheets/d/1ixqO2ZubVrb2-zV1gUSDWA0SmajvhZUitfv9LBPD4jc/edit?usp=sharing"

hhtl_obj <- hhtl_link %>%
  gs_url()

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  revals <- reactiveValues(
    data = hhtl_obj %>% gs_read()
  )
  
  # The timevis timeline object
  output$timeline <- renderTimevis({
    
    revals$data %>%
      timevis(height = 600) %>%
      return()
    
  })
  
  # Observe when an event update request is received
  observeEvent(input$upload_event, {
    
    title <- input$title
    img_link <- input$image_link
    ev_dates <- input$event_dates
    start_date <- ev_dates[1]
    end_date <- ev_dates[2]
    desc <- input$description
    
    if(end_date==start_date){end_date<-NA}
    
    
    # New data in a dataframe
    new_row <- data.frame(
      id = revals$data %>% pull(id) %>% max() + 1,
      content = title,
      start = start_date,
      end = end_date,
      img = img_link,
      description = desc
    )
    
    # Add row to googlesheet object
    hhtl_obj <- hhtl_obj %>%
      gs_add_row(new_row, ws = 1)
    
    # Update reactive object
    revals$data <- hhtl_obj %>% gs_read()
    
    # Create update message
    sendSweetAlert(
      messageId = "event_success", title = "Success!!", text = glue("You added {title} to the timeline!"), type = "success"
    )
    
  })
  
  # On click show modal
  shinyjs::onclick("timeline", {
    
    test = js$find_ev()
    
    shinyjs::alert(test)

    
    # # Modal
    # showModal(
    #   
    #   modalDialog(
    #     
    #     div(class = "ui card",
    #         
    #         div(class = "content",
    #             
    #             div(class = "right floated meta", "14h"),
    #             img(class = "ui avatar image", src = "hannah.jpg"),
    #             "Hannah"
    #             
    #         ),
    #         
    #         div(class = "image",
    #             
    #             img(src = "wedding.jpg")
    #             
    #         ),
    #         
    #         div(class = "content",
    #             
    #             span(class = "right floated", uiicon("calendar"), "201-04-08"),
    #             uiicon("comment"), "Tom + Hannah Wedding"
    #             
    #         ),
    #         
    #         div(class = "extra content",
    #             
    #             tags$p("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
    #             
    #         )
    #         
    #         
    #         
    #     ),
    #     title = NULL,
    #     size ="l",
    #     easyClose = TRUE,
    #     fade = TRUE)
    # )
  })
  
})
