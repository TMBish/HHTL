create_card = function(ind, df) {

  TLinfo <- df %>% filter(id == ind)
  
  dates <- ifelse(
                is.na(TLinfo$end), 
                TLinfo$start %>% format("%d %b %Y"),
                TLinfo$start %>% format("%d %b %Y") %>% paste(TLinfo$end %>% format("%d %b %Y"), sep = " - "))
  
  img_link <- TLinfo$img
  
  time_added <- TLinfo$entry_added %>% ymd_hms()
  
  since_now <- format_time_diff(Sys.time() %>% ymd_hms(), time_added)
  
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
  
}