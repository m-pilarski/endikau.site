path_assets_dir <- local({
  .path_here <- here::here()
  stopifnot(stringi::stri_detect_regex(.path_here, "/endikau\\.site/?"))
  .path_assets_dir <- fs::path(.path_here, "inst", "www", "assets")
  stopifnot(fs::dir_exists(.path_assets_dir))
  return(.path_assets_dir)
})

path_assets_zip <- fs::path_ext_set(path_assets_dir, "zip")

path_css <- local({
  .path_css <- fs::path(path_assets_dir, "css")
  if(fs::dir_exists(.path_css)){fs::dir_delete(.path_css)}
  fs::dir_create(.path_css)
  return(.path_css)
})

sass::sass(
  input=sass::sass_file(
    fs::path("inst", "www", "assets", "scss", "nd_site.scss")
  ),
  output=fs::path(path_css, "nd_site.css"),
  cache=NULL
)

if(fs::file_exists(path_assets_zip)){fs::file_delete(path_assets_zip)}
zip::zip(
  zipfile=path_assets_zip, 
  files=fs::dir_ls(path_assets_dir), 
  mode="cherry-pick"
)

if(interactive()){devtools::install(); devtools::reload()}
