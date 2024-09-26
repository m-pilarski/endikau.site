# TODO: 
# - LOAD ALL DEPENDENCIES TOGETER TO AVOID REDUNDANCY (e.g., BOOTSTRAP)
# - MAKE PREP_GLOBAL_ASSET FUN SO THAT DEPENDENCIES ARE NOT NEEDED FOR EVERY SITE


nd_iframe_app <- function(.url, .width="100%", .height="400pt"){
  .url_hash <- digest::digest(.url)
  .nd_iframe_app <- list(
    tags$iframe(
      id=.url_hash, scrolling="no", loading="lazy",
      style=stringi::stri_c("width: ", .width, "; height: ", .height, ";")
    ),
    tags$script(
      stringi::stri_c(
        "$(document).ready(function(){",
        "  $('iframe#", .url_hash, "').attr('src', '", .url, "');",
        "});"
      )
    ),
    tags$script(
      stringi::stri_c(
        "var domains = ['https://shiny.dsjlu.wirtschaft.uni-giessen.de'];",
        "iframeResize(",
        "  {waitForLoad: false, license: 'GPLv3', checkOrigin: domains}, ",
        "  '#", .url_hash, "'",
        ");"
      )
    )
  )
  return(.nd_iframe_app)
}

#' nd_page
#'
#' @param .navbar NULL
#' @param .main NULL
#' @param .load_wordcloud2 NULL
#'
#' @return NULL
#' @export
#'
#' @examples NULL
nd_page <- function(
  .navbar=nd_navbar(), .main=el_main(), .load_wordcloud2=TRUE
){
  
  page <- tags$html(
    `scroll-behavior`="smooth",
    tags$head(
      tags$meta(charset="utf-8"), 
      tags$meta(
        name="viewport", content="width=device-width, initial-scale=1"
      ),
      tags$title("EnDiKaU: Sentimentanalyse"),
      # JS
      tags$script(src="assets/js/navbar_height.js"),
      tags$script(src="assets/js/toc_height.js"),
      tags$script(src="assets/vendor/jquery/js/jquery.min.js"),
      tags$script(src="assets/vendor/twemoji/js/twemoji.min.js"),
      tags$script(src="assets/vendor/bootstrap/js/bootstrap.bundle.js"),
      tags$script(src="assets/vendor/fontawesome/js/all.min.js"),
      tags$script(src="assets/vendor/iframe-resizer/js/iframe-resizer.parent.js"),
      if(.load_wordcloud2){
        tags$script(src="assets/vendor/wordcloud2/js/wordcloud2.js")
      },
      # CSS
      tags$link(href="assets/fonts/fonts.css", rel="stylesheet"),
      tags$link(href="assets/css/nd_site.css", rel="stylesheet"),
      htmltools::HTML('<script src="https://unpkg.com/lenis@1.1.13/dist/lenis.min.js"></script> <link rel="stylesheet" href="https://unpkg.com/lenis@1.1.13/dist/lenis.css">')
    ),
    tags$body(
      lang="de",
      .navbar,
      el_main(
        el_main_sec(
          .el_bg_color="#e9ebe5",
          tags$div(
            class="g-col-1 g-col-xl-3 text-end", style="font-size: 3rem;", 
            emoji::emoji("thermometer")
          ),
          tags$div(
            class="g-col-11 g-col-xl-6", 
            tags$h1("Sentimentanalyse"),
            "Automatisierte Erkennung von Stimmungen in Texten."
          )
        ),
        el_main_sec(
          tabindex="0",
          `data-bs-spy`="scroll",
          `data-bs-target`="#page-toc",
          `data-bs-smooth-scroll`="true",
          tags$div(
            class="g-col-12 g-col-xl-3 order-xl-3", 
            format_nd_toc(
              list(
                "einleitung"="Einleitung",
                "lexikon"="Lexikon&shy;basierte Sentiment&shy;analyse",
                list(
                  "lexikon-funktionsweise"="Funktions&shy;weise",
                  "lexikon-kritik"="Kritik"
                ),
                "transformer"="Machine-Learning-Basierte Sentiment&shy;analyse",
                list(
                  "transformer-funktionsweise"="Funktions&shy;weise"
                )
              )
            )
          ),
          tags$div(
            class="g-col-12 g-col-xl-6 order-xl-2 g-start-xl-4", 
            tags$div(
              class="content-sec", id="einleitung",
              tags$h3("Einleitung"),
              !!!purrr::map(stringi::stri_rand_lipsum(1), tags$p),
              tags$div(
                class="card",
                tags$div(
                  class="card-header",
                  "Wortwolke", emoji::emoji("cloud")
                ),
                tags$div(
                  class="card-body",
                  word_cloud_element()
                )
              ),
              tags$div(
                class="card",
                tags$div(
                  class="card-header",
                  "Ausprobieren", emoji::emoji("bulb")
                ),
                tags$div(
                  class="card-body",
                  nd_iframe_app("https://shiny.dsjlu.wirtschaft.uni-giessen.de/sentiment_dict/")
                )
              )
            ),
            tags$div(
              class="content-sec", id="transformer-funktionsweise",
              tags$h3("Hauptteil"), 
              !!!purrr::map(stringi::stri_rand_lipsum(2), tags$p),
            )
          )
        ),
        el_main_sec(
          .el_bg_color="#e9ebe5",
          tags$div(
            class="g-col-12", 
            tags$img(src="assets/img/JLU_Giessen-Logo-1.svg", width="200px"),
            tags$img(src="assets/img/Hessen-Logo.svg", width="100px"),
            !!!purrr::map(stringi::stri_rand_lipsum(10), tags$p)
          )
        )
      )
    ),
    tags$script("window.onload = function() { twemoji.parse( document, { base: 'assets/vendor/twemoji/', folder: 'svg', ext: '.svg' } ); }"),
    tags$style("img.emoji { cursor: pointer; height: 1em; width: 1em; margin: 0 .05em 0 .1em; vertical-align: -0.1em; }")
  )
  
  # temp_dir <- fs::file_temp(pattern="www")
  # fs::dir_create(temp_dir)
  temp_dir <- fs::path_real(here::here("../endikau.shares/site"))
  htmltools::save_html(page, fs::path(temp_dir, "index.html"))
  zip::unzip(
    zipfile=fs::path_package("endikau.site", "www", "assets.zip"),
    exdir=fs::path(temp_dir, "assets")
  )
  rstudioapi::viewer(fs::path(temp_dir, "index.html"))
  
}

if(interactive()){
  # devtools::install()
  endikau.site::nd_page(
    .navbar=nd_navbar()
    .main=
  )
}
