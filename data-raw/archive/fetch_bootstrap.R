.here <- here::here()
stopifnot(stringi::stri_detect_regex(.here, "/endikau\\.site/?"))

.dir_git <- fs::file_temp(pattern="git")
.dir_lib <- fs::path(fs::file_temp(pattern="lib"), "bootstrap")
.path_vendor_zip <- fs::path(.here, "inst", "www", "assets", "vendor.zip")

gert::git_clone("git@github.com:twbs/bootstrap.git", .dir_git)
# 5.3.3 release
gert::git_reset_hard(
  ref="6e1f75f420f68e1d52733b8e407fc7c3766c9dba", repo=I(.dir_git)
)

fs::dir_create(fs::path(.dir_lib, c("js", "scss")))

fs::file_copy(fs::path(.dir_git, "LICENSE"), fs::path(.dir_lib, "LICENSE"))
fs::file_copy(
  fs::path(.dir_git, "dist", "js", "bootstrap.bundle.js"),
  fs::path(.dir_lib, "js", "bootstrap.bundle.js")
)
fs::dir_copy(fs::path(.dir_git, "scss/"), .dir_lib)

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