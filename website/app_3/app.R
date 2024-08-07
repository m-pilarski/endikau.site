shiny::enableBookmarking(store="url")

# if(FALSE){curl::curl("example.com")}

# pallette <- jsonlite::read_json("colors.json")
capabilities('libcurl')

pallette <- list(
  "bg" = "#ffffff",
  "fg" = "#000000",
  "primary" = "#165a97",
  "secondary" = "#f2f2f2",
  "success" = "#e5f0cf",
  "info" = "#eaf7ff",
  "warning" = "#ffce7b",
  "danger" = "#ffce7b"
)

library(htmltools)
library(bslib)

ui <- bslib::page_sidebar(
  title="Einsatz neuer Daten in Kommunikationszusammenhängen auf Unternehmensebene",
  sidebar = bslib::sidebar(
    bslib::nav_item(
      htmltools::tags$a(
        "Sentimentanalyse",
        # href="/sentimentanalyse",
        # class="link"
      )
    )
  ),
  bslib::layout_column_wrap(
    bslib::card(
      bslib::card_header("Sentimentanalyse"),
      bslib::card_body(
        p("This is the body."),
        p("This is still the body.")
      ),
      width=12
    )
  ),
  theme=bslib::bs_theme(
    bg=pallette$bg,
    fg=pallette$fg,
    primary=pallette$primary,
    secondary=pallette$secondary,
    success=pallette$success,
    info=pallette$info,
    warning=pallette$warning,
    danger=pallette$danger,
    base_font="Source Serif 4",
    code_font="IBM Plex Mono",
    heading_font="Source Serif 4"
  ),
  lang="de"
)

server <- function(input, output, session) {
  
  # observe({
  #   data <- parseQueryString(session$clientData$url_search)
  #   session$sendCustomMessage(type='updateSelections', data)
  #   updateSelectInput(session, 'scale', selected=data$scale)
  # })
  # observe({
  #   reactiveValuesToList(input)
  #   session$doBookmark()
  # })
  # onBookmarked(function(url) {
  #   updateQueryString(url)
  # })
  
}


shiny::shinyApp(ui=ui, server=server)
