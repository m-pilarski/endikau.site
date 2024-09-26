.here <- here::here()
stopifnot(stringi::stri_detect_regex(.here, "/endikau\\.site/?"))

.dir_git <- fs::file_temp(pattern="git")
.dir_lib <- fs::path(fs::file_temp(pattern="lib"), "jquery")
.path_vendor_zip <- fs::path(.here, "inst", "www", "assets", "vendor.zip")

gert::git_clone("git@github.com:jquery/jquery.git", .dir_git)
# version 3.7.1
gert::git_reset_hard(
  ref="f79d5f1a337528940ab7029d4f8bbba72326f269", repo=I(.dir_git)
)

processx::run("npm", "prune", wd=.dir_git)
processx::run("npm", c("run", "build"), wd=.dir_git)


if(fs::dir_exists(.dir_lib)){fs::dir_delete(.dir_lib)}
fs::dir_create(fs::path(.dir_lib, "js"))

fs::file_copy(fs::path(.dir_git, "LICENSE.txt"), fs::path(.dir_lib, "LICENSE"))
fs::file_copy(
  fs::path(.dir_git, "dist", "jquery.min.js"), 
  fs::path(.dir_lib, "js", "jquery.min.js")
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