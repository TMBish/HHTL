# Hannah History Timeline

Hannah's History Time Line (HHTL) is a minimalist shiny app I built to help my wife Hannah learn and retain history. The app contains a simple timevis timeline widget with functionality to add and edit events. Technically the app includes:

- A googlesheets backend using the googlesheets package
- UI elements from shinyWidgets and shiny.semantic
- Some extra interactivity with shinyjs

The google authentication is unfortunately a bit hacky at the moment with the oauth file manually copied over to the server to avoid erroring out with an auth request.