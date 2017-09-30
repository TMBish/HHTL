
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
    
    time_added <- Sys.time()
    
    if(end_date==start_date){end_date<-NA}
    
    
    # New data in a dataframe
    new_row <- data.frame(
      id = revals$data %>% pull(id) %>% max() + 1,
      content = title,
      start = start_date,
      end = end_date,
      img = img_link,
      description = desc,
      entry_added = time_added
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
  
  # Respond to a timeline click event
  observe({
    
    selected_index = input$timeline_selected 
    
    # Only do something if the event is a new TL index has been clicked on
    if (selected_index %>% length() > 0) {
      
      showModal(
        modalDialog(
          create_card(selected_index, revals$data)
        , title = NULL, size ="l", footer=NULL, easyClose = TRUE, fade = TRUE
        )
      )
      
    }
  })
  
  
})
