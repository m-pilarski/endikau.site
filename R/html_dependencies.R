#' Title
#'
#' @return list
#'
#' @examples
html_load_twemoji <- function(){
  list(
    htmltools::htmlDependency(
      name="twemoji",
      version="15.1.0",
      src=fs::path_package("endikau.site", "www", "assets", "vendor", "twemoji"),
      script="twemoji.min.js",
      all_files=TRUE
    ),
    htmltools::tags$script("window.onload = function() { twemoji.parse( document, { base: 'lib/twemoji-15.1.0/', folder: 'svg', ext: '.svg' } ); }"),
    htmltools::tags$style("img.emoji { cursor: pointer; height: 1em; width: 1em; margin: 0 .05em 0 .1em; vertical-align: -0.1em; }")
  )
}

#' Title
#'
#' @return list
#'
#' @examples
html_load_fonts <- function(){
  list(
    # sass::font_google("Open Sans", local=TRUE)$html_deps(),
    # sass::font_google("Source Serif 4", local=TRUE)$html_deps(),
    # sass::font_google("Monoton", local=TRUE)$html_deps()
    htmltools::htmlDependency(
      name="font-opensans",
      version="40",
      src=fs::path_package(
        "endikau.site", "www", "assets", "fonts", "open-sans"
      ),
      stylesheet=fs::path("font.css"),
      all_files=TRUE
    ),
    htmltools::htmlDependency(
      name="font-source-serif-4",
      version="8",
      src=fs::path_package(
        "endikau.site", "www", "assets", "fonts", "source-serif-4"
      ),
      stylesheet=fs::path("font.css"),
      all_files=TRUE
    ),
    htmltools::htmlDependency(
      name="font-monoton",
      version="19",
      src=fs::path_package(
        "endikau.site", "www", "assets", "fonts", "monoton"
      ),
      stylesheet=fs::path("font.css"),
      all_files=TRUE
    )
  )
}

#' Title
#'
#' @return list
#'
#' @examples
html_load_bootstrap <- function(.var_override = list()){
  
  .dir_tmp <- fs::dir_copy(
    fs::path_package("endikau.site", "www", "assets", "vendor", "bootstrap"),
    fs::dir_create(fs::file_temp("bootstrap"))
  )
  
  fs::dir_create(fs::path(.dir_tmp, "css"))
  
  sass::sass(
    input=sass::as_sass(
      input=c(
        .var_override,
        sass::sass_file(fs::path(.dir_tmp, "scss", "bootstrap.scss"))
      )
    ),
    output=fs::path(.dir_tmp, "css", "bootstrap.css")
  )
  
  list(
    htmltools::tags$meta(
      name="viewport", content="width=device-width, initial-scale=1"
    ),
    htmltools::htmlDependency(
      name="bootstrap",
      version="5.3.3",
      src=.dir_tmp,
      stylesheet=fs::path("css", "bootstrap.css"),
      all_files=TRUE
    ),
    htmltools::tags$script(
      src=fs::path("lib", "bootstrap-5.3.3", "js", "bootstrap.bundle.js")
    )
  )
}

html_load_fontawesome <- function(){
  list(
    htmltools::htmlDependency(
      name="fontawesome",
      version="6.6.0",
      src=fs::path_package(
        "endikau.site", "www", "assets", "vendor", "fontawesome"
      ),
      script=c(fs::path("js", "all.min.js")),
      all_files=TRUE
    )
  )
}

prep_fontawesome <- function(){
  .dir_git <- fs::file_temp(pattern="git")
  .dir_lib <- here::here("inst/www/assets/vendor/fontawesome/")
  gert::git_clone("git@github.com:FortAwesome/Font-Awesome.git", .dir_git)
  # 6.6.0 release
  gert::git_reset_hard(
    ref="37eff7fa00de26db41183a3ad8ed0e9119fbc44b", repo=I(.dir_git)
  )
  if(fs::dir_exists(.dir_lib)){fs::dir_delete(.dir_lib)}
  fs::dir_create(fs::path(.dir_lib, c("js", "svgs")))
  fs::file_copy(
    fs::path(.dir_git, "LICENSE.txt"), fs::path(.dir_lib, "LICENSE")
  )
  fs::file_copy(
    fs::path(.dir_git, "js", "all.min.js"), 
    fs::path(.dir_lib, "js", "all.min.js")
  )
  fs::dir_copy(
    fs::path(.dir_git, "svgs/"), .dir_lib
  )
}

html_load_custom_sass <- function(.sass=list()){
  
  if(length(.sass) == 0){return()}
  
  .dir_tmp <- fs::dir_create(fs::file_temp(pattern="sass"))
  
  sass::sass(input=.sass, output=fs::path(.dir_tmp, "custom.css"))
  
  htmltools::htmlDependency(
    name="custom_sass", version="0", src=.dir_tmp, stylesheet="custom.css"
  )
  
}

html_load_wordcloud2 <- function(){
  list(
    htmltools::htmlDependency(
      name="wordcloud2",
      version="6.6.0",
      src=fs::path_package(
        "endikau.site", "www", "assets", "vendor", "wordcloud2"
      ),
      script=c(fs::path("js", "wordcloud2.js")),
      all_files=TRUE
    )
  )
}
