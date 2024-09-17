.here <- here::here()
stopifnot(stringi::stri_detect_regex(.here, "/endikau\\.site/?"))

.dir_git <- fs::file_temp(pattern="git")
.dir_lib <- fs::path(.here, "inst/www/assets/vendor/wordcloud2/")

gert::git_clone("git@github.com:timdream/wordcloud2.js.git", .dir_git)
# version 2023-07-19
gert::git_reset_hard(
  ref="61e1a11265fb4be60a9ccd64558b1231ce4a3a72", repo=I(.dir_git)
)

# processx::run("npm", c("build", .dir_git), wd=.dir_git)

if(fs::dir_exists(.dir_lib)){fs::dir_delete(.dir_lib)}
fs::dir_create(fs::path(.dir_lib, c("js")))

fs::file_copy(
  fs::path(.dir_git, "LICENSE"), fs::path(.dir_lib, "LICENSE")
)
fs::file_copy(
  fs::path(.dir_git, "src", "wordcloud2.js"),
  fs::path(.dir_lib, "js", "wordcloud2.js")
)