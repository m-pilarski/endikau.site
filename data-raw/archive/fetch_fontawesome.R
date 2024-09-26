.here <- here::here()
stopifnot(stringi::stri_detect_regex(.here, "/endikau\\.site/?"))

.dir_git <- fs::file_temp(pattern="git")
.dir_lib <- fs::path(fs::file_temp(pattern="lib"), "fontawesome")
.path_vendor_zip <- fs::path(.here, "inst", "www", "assets", "vendor.zip")
gert::git_clone("git@github.com:FortAwesome/Font-Awesome.git", .dir_git)
# 6.6.0 release
gert::git_reset_hard(
  ref="37eff7fa00de26db41183a3ad8ed0e9119fbc44b", repo=I(.dir_git)
)
if(fs::dir_exists(.dir_lib)){fs::dir_delete(.dir_lib)}
fs::dir_create(fs::path(.dir_lib, c("js")))
fs::file_copy(
  fs::path(.dir_git, "LICENSE.txt"), fs::path(.dir_lib, "LICENSE")
)
fs::file_copy(
  fs::path(.dir_git, "js", "all.min.js"), 
  fs::path(.dir_lib, "js", "all.min.js")
)
fs::dir_copy(
  fs::path(.dir_git, "svgs"), .dir_lib
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