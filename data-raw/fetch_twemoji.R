.here <- here::here()
stopifnot(stringi::stri_detect_regex(.here, "/endikau\\.site/?"))

.dir_git <- fs::file_temp(pattern="git")
.dir_lib <- fs::path(.here, "inst/www/assets/vendor/twemoji/")

gert::git_clone("git@github.com:jdecked/twemoji.git", .dir_git)
# version 15.1.0
gert::git_reset_hard(
  ref="7407fa31c51be5ab45626b8ab5554d50cc8073f6", repo=I(.dir_git)
)
processx::run("npm", c("prune"), wd=.dir_git)
processx::run("npm", c("run", "build"), wd=.dir_git)


if(fs::dir_exists(.dir_lib)){fs::dir_delete(.dir_lib)}
fs::dir_create(fs::path(.dir_lib, c("js")))

fs::file_copy(
  fs::path(.dir_git, "LICENSE"), fs::path(.dir_lib, "LICENSE")
)
fs::file_copy(
  fs::path(.dir_git, "dist", "twemoji.min.js"),
  fs::path(.dir_lib, "js", "twemoji.min.js")
)
fs::dir_copy(
  fs::path(.dir_git, "dist", "svg"), .dir_lib
)

fs::dir_delete(.dir_git)

