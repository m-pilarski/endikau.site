path_fonts <- local({
  .path_here <- here::here()
  stopifnot(stringi::stri_detect_regex(.path_here, "/endikau\\.site/?"))
  .path_fonts <- fs::path(.path_here, "inst", "www", "assets", "fonts")
  if(fs::dir_exists(.path_fonts)){fs::dir_delete(.path_fonts)}
  fs::dir_create(.path_fonts)
  return(.path_fonts)
})

local({
  
  .font_spec_grid <- tibble::tribble(
    ~family, ~wght,
    "Open Sans", c((3:8) * 100), 
    "Source Serif 4", c((2:9) * 100), 
    "Monoton", c(400),
  )
  
  .path_font_file_vec <- fs::path()
  .path_font_style_vec <- fs::path()
  
  .font_spec_grid |> 
    purrr::transpose() |> 
    purrr::walk(\(..font_spec){
      
      ..font_all_path_vec <- 
        sass::font_google(
          family=..font_spec[["family"]], wght=..font_spec[["wght"]], 
          ital=c(0, 1), local=TRUE, cache=NULL
        ) |> 
        purrr::chuck("html_deps") |> 
        rlang::exec() |> 
        purrr::chuck("src", "file") |> 
        fs::dir_ls()
      
      .path_font_style_vec <<- .path_font_style_vec |> c(
        ..font_all_path_vec[fs::path_ext(..font_all_path_vec) == "css"]
      )
      .path_font_file_vec <<- .path_font_file_vec |> c(
        ..font_all_path_vec[fs::path_ext(..font_all_path_vec) != "css"]
      )
      
    })
  
  .path_font_style_vec |> 
    purrr::map(readr::read_lines) |> 
    purrr::list_c(ptype=character()) |> 
    readr::write_lines(fs::path(path_fonts, "fonts.css"))
  
  fs::file_copy(.path_font_file_vec, path_fonts)
  
})