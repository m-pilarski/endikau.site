.here <- here::here()
stopifnot(stringi::stri_detect_regex(.here, "/endikau\\.site/?"))

.dir_git <- fs::file_temp(pattern="git")
.dir_lib <- fs::path(.here, "inst/www/assets/vendor/fontawesome/")
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

fs::dir_delete(.dir_git)

