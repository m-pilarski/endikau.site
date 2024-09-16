library(bslib)
library(htmltools)

site_theme <-
  bslib::bs_theme(
    version="5",
    # base_font=font_google("Source Serif 4"),
    # base_font=font_google("Libre Franklin"),
    base_font=sass::font_google("Source Sans 3"),
    # base_font=font_google("Open Sans"),
    # base_font=font_google("IBM Plex Sans"),
    # heading_font=font_google("Bebas Neue"),
    # heading_font=font_google("Archivo Black"),
    # heading_font=font_google("Patua One"),
    heading_font=sass::font_google("Source Sans 3"),
    # heading_font=font_google("Source Serif 4", wght=600),
    code_font=sass::font_google("IBM Plex Mono"),
    font_scale=1.5
    # preset=c(builtin_themes(), bootswatch_themes())[4]
  ) |>
  bslib::bs_add_variables(
    "enable-grid-classes"="false", 
    "enable-cssgrid"="true"
  ) |>
  bslib::bs_add_rules(
    sass::sass_file(
      fs::path_package(
        "www", "assets", "scss", "_variables.scss", package="endikau.site"
      )
    )
  ) |>
  bslib::bs_add_rules(
    sass::sass_file(
      fs::path_package(
        "www", "assets", "scss", "_layout.scss", package="endikau.site"
      )
    )
  ) |>
  bslib::bs_add_rules(
    sass::sass_file(
      fs::path_package(
        "www", "assets", "scss", "_toc.scss", package="endikau.site"
      )
    )
  ) |>
  bslib::bs_add_rules(
    sass::sass_file(
      fs::path_package(
        "www", "assets", "scss", "_text-style.scss", package="endikau.site"
      )
    )
  )


page_home <- nav_panel(
  title=tags$span(
    "EnDiKaU Startseite", bsicons::bs_icon("house-fill", size="1.5rem")
  ),
  tags$h2(paste0(
    "Einsatz neuer Daten in Kommunikationszusammenhängen auf ",
    "Unternehmensebene"
  )),
  includeMarkdown("project_description.md"),
  tags$h3("Methoden"),
  layout_column_wrap(
    fill=FALSE,
    card(
      card_header("Sentimentanalyse"),
      card_body(paste0(
        "Sentimentanalyse bezeichnet die automatische Auswertung von ",
        "Texten mit dem Ziel, eine geäußerte Haltung als positiv oder ",
        "negativ zu erkennen."
      )),
    ),
    card(
      card_header("Themenmodellierung"),
      card_body(paste0(
        "Themenmodellierung ist eine Methode des maschinellen Lernens, ",
        "die verwendet wird, um Themen in einem Textkorpus zu ",
        "identifizieren und zu klassifizieren."
      ))
    )
  ),
  tags$h3("Fallstudien"),
  layout_column_wrap(
    fill=FALSE,
    card(
      card_header("Produktrezensionen"),
      card_body(paste0(
        "Sentimentanalyse bezeichnet die automatische Auswertung von ",
        "Texten mit dem Ziel, eine geäußerte Haltung als positiv oder ",
        "negativ zu erkennen."
      )),
    )
  )
)

page_sentiment <- nav_panel(
  title="Sentiment", id="method-sentiment",
  tags$iframe(
    height="100vh", width="100%", frameborder="no", id="myIframe",
    src="https://shiny.dsjlu.wirtschaft.uni-giessen.de/sentiment_trans/"
  )
)

page_topic <- nav_panel(
  title="Topic",
  tags$h3("Sentimentanalyse – Test"),
  !!!purrr::map(stringi::stri_rand_lipsum(n_paragraphs=3), tags$p),
)

page_prod_reviews <- nav_panel(
  title="Produktrezensionen",
  tags$h3("Produktrezensionen"),
  !!!purrr::map(stringi::stri_rand_lipsum(n_paragraphs=3), tags$p),
)

page_about <- nav_panel(
  title="Über das Projekt",
  tags$h3("Über das Projekt"),
  !!!purrr::map(stringi::stri_rand_lipsum(n_paragraphs=3), tags$p),
)

page <- page_fillable(
  title=NULL,
  window_title="EnDiKaU",
  lang="de",
  # sidebar=menu_sidebar,
  theme=site_theme,
  navset_bar(
    position="fixed-top",
    padding="3.5rem",
    page_home,
    nav_menu(
      title=tags$span(
        "Methoden", bsicons::bs_icon("calculator-fill", size="1.5rem")
      ),
      align="right",
      page_sentiment,
      page_topic
    ),
    nav_menu(
      title=tags$span(
        "Fallstudien", bsicons::bs_icon("radar", size="1.5rem")
      ),
      page_prod_reviews
    ),
    nav_spacer(),
    nav_menu(
      title=tags$span(
        "Weitere Links", bsicons::bs_icon("three-dots", size="1.5rem")
      ),
      page_about,
    )
  ),
)

page <- bslib::page_fillable(
  div(
    style="width=100%; height:100vh",
    tags$iframe(
      height="100%", width="100%", frameborder="no", id="myIframe", scrolling="yes", 
      src="https://shiny.dsjlu.wirtschaft.uni-giessen.de/sentiment_dict/"),
  ),
  tags$script(src="https://cdn.jsdelivr.net/npm/@iframe-resizer/parent"),
  height="100%", width="100%", 
  # tags$script("iframeResize({ license: 'GPLv3', waitForLoad: true, warningTimeout: 10000, scrolling: true, }, '#myIframe');"),
  theme=site_theme
)

htmltools::htmlDependencies(page)

save_html(page, "inst/www/index.html")