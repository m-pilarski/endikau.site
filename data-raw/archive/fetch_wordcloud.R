.here <- here::here()
stopifnot(stringi::stri_detect_regex(.here, "/endikau\\.site/?"))

.dir_git <- fs::file_temp(pattern="git")
.dir_lib <- fs::path(fs::file_temp(pattern="lib"), "wordcloud2")
.path_vendor_zip <- fs::path(.here, "inst", "www", "assets", "vendor.zip")

gert::git_clone("git@github.com:timdream/wordcloud2.js.git", .dir_git)
# version 2023-07-19
gert::git_reset_hard(
  ref="61e1a11265fb4be60a9ccd64558b1231ce4a3a72", repo=I(.dir_git)
)

fs::dir_create(fs::path(.dir_lib, c("js")))

fs::file_copy(
  fs::path(.dir_git, "LICENSE"), fs::path(.dir_lib, "LICENSE")
)
fs::file_copy(
  fs::path(.dir_git, "src", "wordcloud2.js"),
  fs::path(.dir_lib, "js", "wordcloud2.js")
)

if(!fs::file_exists(.path_vendor_zip)){zip::zip(.path_vendor_zip, character())}
.lib_in_vendor_zip <- vctrs::vec_in(
  fs::path_file(.dir_lib), 
  fs::path(zip::zip_list(.path_vendor_zip)[["filename"]])
)
if(!.lib_in_vendor_zip){
  zip::zip_append(zipfile=.path_vendor_zip, files=.dir_lib, mode="cherry-pick")
}

fs::dir_delete(.dir_git)
fs::dir_delete(.dir_lib)