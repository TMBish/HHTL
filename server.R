
shinyServer(function(input, output) {
  
  revals <- reactiveValues(
    data = data
  )
  
  # The timevis timeline object
  output$timeline <- renderTimevis({
    
    tl = revals$data %>%
      rename(
        "start" = start_date, 
        "end" = end_date,
        "content" = title
      ) %>%
      mutate(
        end = ifelse(start==end,NA,end) %>% as_date()
      ) %>%
      timevis(height = 600)
    
    shinyjs::show("dropdown-div")
    
    return(tl)
    
  })
  
  # Observe when an event update request is received
  observeEvent(input$upload_event, {
    
    data_ = revals$data
    
    title <- input$title
    img_link <- input$image_link
    ev_dates <- input$event_dates
    start_date <- ev_dates[1]
    end_date <- ev_dates[2]
    desc <- input$description
    
    time_added <- Sys.time()
    
    #if(end_date==start_date){end_date<-NA}
    
    # New data in a dataframe
    new_row <- tibble(
      id = ifelse(data_ %>% nrow() == 0 , 1, data_$id %>% max() + 1),
      title = title,
      start = start_date,
      end = end_date,
      img = img_link,
      description = desc,
      entry_added = time_added
    )
    
    # Write to database
    sql = glue_sql("
      INSERT INTO events VALUES
        ({new_row$id}, {new_row$title} , {new_row$start %>% as.character()} , {new_row$end %>% as.character()}, {new_row$img}, {new_row$description}, current_timestamp);", .con = db_pool)
    dbExecute(db_pool, sql)
    
    # Refresh Data
    revals$data <- dbGetQuery(db_pool, "SELECT * FROM events")
    
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
    
    data_ = revals$data
    
    selected_index = input$timeline_selected 

    new_row <- tibble(
      id = selected_index %>% as.integer(),
      title = input$new_title,
      start = input$new_ev_dates[1],
      end = input$new_ev_dates[2],
      img = input$new_img_url,
      description = input$new_description,
      entry_added = Sys.time()
    )
    
    # Update the database
    sql = glue_sql("
                   UPDATE events SET
                      id = {new_row$id},
                      title = {new_row$title},
                      start_date = {new_row$start %>% as.character()},
                      end_date = {new_row$end %>% as.character()},
                      img = {new_row$img},
                      description = {new_row$description},
                      entry_added = current_timestamp
                    WHERE
                      id = {selected_index}", .con = db_pool)
    
    dbExecute(db_pool, sql)
    
    # Refresh Data
    revals$data <- dbGetQuery(db_pool, "SELECT * FROM events")
    
    # Create update message
    sendSweetAlert(
      messageId = "event_success", title = "Success!!", text = glue("Details successfully Updated"), type = "success"
    )
    
  })
  
  
  
})
