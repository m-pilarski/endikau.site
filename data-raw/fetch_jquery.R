.here <- here::here()
stopifnot(stringi::stri_detect_regex(.here, "/endikau\\.site/?"))

.dir_git <- fs::file_temp(pattern="git")
.dir_lib <- fs::path(.here, "inst/www/assets/vendor/jquery/")

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

fs::dir_delete(.dir_git)
