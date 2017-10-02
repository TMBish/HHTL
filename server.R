
shinyServer(function(input, output) {
  
  revals <- reactiveValues(
    data = hhtl_obj %>% gs_read()
  )
  
  # The timevis timeline object
  output$timeline <- renderTimevis({
    
    tl = revals$data %>%
      timevis(height = 600)
    
    shinyjs::show("dropdown-div")
    
    return(tl)
    
  })
  
  # Observe when an event update request is received
  observeEvent(input$upload_event, {
    
    shinyjs::alert("startdy")
    
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
    
    shinyjs::alert("Just before adding to spreaddy")
    
    # Add row to googlesheet object
    hhtl_obj <- hhtl_obj %>%
      gs_add_row(new_row, ws = 1)
    
    shinyjs::alert("Just afrer adding to spreaddy")
    
    
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
        , title = NULL, size ="l", 
        footer=actionBttn(inputId = "edit_ev", label = "Edit",style = "unite", color = "warning"),
        easyClose = TRUE, fade = TRUE
        )
      )
      
    }
  })
  
  # Respond to a edit event button click
  observeEvent( input$edit_ev, {
    
    selected_index = input$timeline_selected 
      
    showModal(
        modalDialog(
          create_card(selected_index, revals$data, edit_mode=TRUE),
          title = NULL, size ="l",
          footer=div(
            actionBttn(inputId="cancel_edits", label = "Cancel",style = "unite", color = "danger"),
            actionBttn(inputId = "save_edits", label = "Save",style = "unite", color = "success")
            ),
          easyClose = TRUE, fade = TRUE
          
        )
      )
      
  })
  
  # The image preview in the edit event modal
  output$img_preview <- renderUI({
    img(src = input$new_img_url)
  })
  
  
  # Cancel an edit
  observeEvent(input$cancel_edits ,{
    
    removeModal()
    
    selected_index = input$timeline_selected 
    
    showModal(
      modalDialog(
        create_card(selected_index, revals$data)
        , title = NULL, size ="l", 
        footer=actionBttn(inputId = "edit_ev", label = "Edit",style = "unite", color = "warning"),
        easyClose = TRUE, fade = TRUE
      )
    )
  })
  
  # Save changes from an edit
  observeEvent(input$save_edits ,{
    
    selected_index = input$timeline_selected 
    
    new_row <- data.frame(
      id = selected_index %>% as.integer(),
      content = input$new_title,
      start = input$new_ev_dates[1],
      end = input$new_ev_dates[2],
      img = input$new_img_url,
      description = input$new_description,
      entry_added = Sys.time()
    )
    
    # Add row to googlesheet object
    hhtl_obj <- hhtl_obj %>%
      gs_edit_cells(
        input = new_row,
        anchor = glue("R{selected_index%>%as.integer() + 1}C1"),
        col_names = FALSE
    )

    # Update reactive object
    revals$data <- hhtl_obj %>% gs_read()

    # Create update message
    sendSweetAlert(
      messageId = "event_success", title = "Success!!", text = glue("Details successfully Updated"), type = "success"
    )

  })
  
  
  
})
