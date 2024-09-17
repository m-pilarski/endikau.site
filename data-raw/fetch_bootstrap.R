.here <- here::here()
stopifnot(stringi::stri_detect_regex(.here, "/endikau\\.site/?"))
.dir_git <- fs::file_temp(pattern="git")
.dir_lib <- fs::path(.here, "inst/www/assets/vendor/bootstrap/")
gert::git_clone("git@github.com:twbs/bootstrap.git", .dir_git)
# 5.3.3 release
gert::git_reset_hard(
  ref="6e1f75f420f68e1d52733b8e407fc7c3766c9dba", repo=I(.dir_git)
)
if(fs::dir_exists(.dir_lib)){fs::dir_delete(.dir_lib)}
fs::dir_create(fs::path(.dir_lib, c("js", "scss")))
fs::file_copy(
  fs::path(.dir_git, "LICENSE"), fs::path(.dir_lib, "LICENSE")
)
fs::file_copy(
  fs::path(.dir_git, "dist", "js", "bootstrap.bundle.js"),
  fs::path(.dir_lib, "js", "bootstrap.bundle.js")
)
fs::dir_copy(
  fs::path(.dir_git, "scss/"), .dir_lib
)