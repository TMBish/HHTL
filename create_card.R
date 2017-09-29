create_card = function(ind) {

  div(class = "ui card",
      div(class = "content",
          div(class = "right floated meta", "14h"),
          img(class = "ui avatar image", src = "hannah.jpg"),
          #"Hannah"
          ind
      ),
      div(class = "image",
          img(src = "wedding.jpg")
      ),
      div(class = "content",
          span(class = "right floated", uiicon("calendar"), "201-04-08"),
          uiicon("comment"), "Tom + Hannah Wedding"
      ),
      div(class = "extra content",
          tags$p("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
      )
  )
  
}