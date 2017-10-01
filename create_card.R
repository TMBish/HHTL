create_card = function(ind, df, edit_mode=FALSE) {
  
  TLinfo <- df %>% filter(id == ind)
  
  dates <- ifelse(
    is.na(TLinfo$end), 
    TLinfo$start %>% format("%d %b %Y"),
    TLinfo$start %>% format("%d %b %Y") %>% paste(TLinfo$end %>% format("%d %b %Y"), sep = " - "))
  
  img_link <- TLinfo$img
  
  time_added <- TLinfo$entry_added %>% ymd_hms()
  
  since_now <- format_time_diff(Sys.time() %>% ymd_hms(), time_added)
  
  if (!edit_mode) {
    div(class = "ui card",
        div(class = "content",
            div(class = "right floated meta", since_now),
            img(class = "ui avatar image", src = "hannah.jpg"),
            "Hannah"
        ),
        div(class = "image",
            img(src = img_link)
        ),
        div(class = "content",
            span(class = "right floated", uiicon("calendar"), dates),
            uiicon("comment"), 
            TLinfo$content
        ),
        div(class = "extra content",
            
            HTML(TLinfo$description %>% markdown::markdownToHTML(text = . , fragment.only = TRUE))
            
        )
    )
  } else {
    
    div(class = "ui card",
        div(class = "content",
            div(class = "right floated meta", since_now),
            img(class = "ui avatar image", src = "hannah.jpg"),
            "Hannah"
        ),
        div(class = "image",
            img(src = img_link),
            
            textInput("new_img_url", label=NULL, value = TLinfo$img, width="100%")
        ),
        
        div(class = "content",
            span(class = "right floated", uiicon("calendar"), dateRangeInput("new_ev_dates", label=NULL, start = TLinfo$start, end = TLinfo$end)),
            span(uiicon("comment"), textInput("new_title",label=NULL, value = TLinfo$content))
        ),
        div(class = "extra content",
            
            textAreaInput("new_description", label=NULL, value = TLinfo$description, width="100%", height=250)
          
        )
    )
  }
  
}