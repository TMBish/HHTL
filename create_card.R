create_card = function(ind, df, edit_mode=FALSE) {

  TLinfo <- df %>% filter(id == trimws(ind))
  
  dates <- ifelse(
    is.na(TLinfo$end_date), 
    TLinfo$start_date %>% format("%d %b %Y"),
    TLinfo$start_date %>% format("%d %b %Y") %>% paste(TLinfo$end_date %>% format("%d %b %Y"), sep = " - ")
  )
  
  img_link <- TLinfo$img
  
  time_added <- TLinfo$entry_added %>% ymd_hms()
  
  # Since now info
  since_now <- format_time_diff(Sys.time() %>% ymd_hms(), time_added)
  
  # Description if na is blank
  description = ifelse(is.na(TLinfo$description),"", TLinfo$description)

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
            span(class = "right floated", icon("calendar"), dates),
            icon("comment"), 
            TLinfo$title
        ),
        div(class = "extra content",
            
            description %>% markdown::markdownToHTML(text = . , fragment.only = TRUE) %>% HTML()
            
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

            uiOutput("img_preview"),
            
            textInput("new_img_url", label=NULL, value = TLinfo$img, width="100%")
        ),
        
        div(class = "content",
            span(
                class = "right floated", 
                icon("calendar"), 
                dateRangeInput(
                    "new_ev_dates", 
                    label=NULL, 
                    start = TLinfo$start_date, 
                    end = TLinfo$end_date)
                ),
            span(icon("comment"), textInput("new_title",label=NULL, value = TLinfo$title))
        ),
        div(class = "extra content",
            
            textAreaInput("new_description", label=NULL, value = description, width="100%", height=250)
          
        ), 

        div(class = "extra content",

            textInput("edit_code", "Enter code word:")

        )
    )
  }
  
}