path_vendor <- local({
  .path_here <- here::here()
  stopifnot(stringi::stri_detect_regex(.path_here, "/endikau\\.site/?"))
  .path_vendor <- fs::path(.path_here, "inst", "www", "assets", "vendor")
  if(fs::dir_exists(.path_vendor)){fs::dir_delete(.path_vendor)}
  fs::dir_create(.path_vendor)
  return(.path_vendor)
})

local({
  .path_git_tmp <- fs::file_temp(pattern="git")
  .path_lib_tmp <- fs::path(path_vendor, "fontawesome")
  gert::git_clone("git@github.com:FortAwesome/Font-Awesome.git", .path_git_tmp)
  # 6.6.0 release
  gert::git_reset_hard(
    ref="37eff7fa00de26db41183a3ad8ed0e9119fbc44b", repo=I(.path_git_tmp)
  )
  fs::dir_create(fs::path(.path_lib_tmp, c("js")))
  fs::file_copy(
    fs::path(.path_git_tmp, "LICENSE.txt"), 
    fs::path(.path_lib_tmp, "LICENSE")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "js", "all.min.js"), 
    fs::path(.path_lib_tmp, "js", "all.min.js")
  )
  fs::dir_copy(
    fs::path(.path_git_tmp, "svgs"), 
    .path_lib_tmp
  )
})

local({
  .path_git_tmp <- fs::file_temp(pattern="git")
  .path_lib_tmp <- fs::path(path_vendor, "wordcloud2")
  gert::git_clone("git@github.com:timdream/wordcloud2.js.git", .path_git_tmp)
  # version 2023-07-19
  gert::git_reset_hard(
    ref="61e1a11265fb4be60a9ccd64558b1231ce4a3a72", repo=I(.path_git_tmp)
  )
  fs::dir_create(fs::path(.path_lib_tmp, c("js")))
  fs::file_copy(
    fs::path(.path_git_tmp, "LICENSE"), 
    fs::path(.path_lib_tmp, "LICENSE")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "src", "wordcloud2.js"),
    fs::path(.path_lib_tmp, "js", "wordcloud2.js")
  )
})

local({
  .path_git_tmp <- fs::file_temp(pattern="git")
  .path_lib_tmp <- fs::path(path_vendor, "twemoji")
  gert::git_clone("git@github.com:jdecked/twemoji.git", .path_git_tmp)
  # version 15.1.0
  gert::git_reset_hard(
    ref="7407fa31c51be5ab45626b8ab5554d50cc8073f6", repo=I(.path_git_tmp)
  )
  processx::run("npm", c("prune"), wd=.path_git_tmp)
  processx::run("npm", c("run", "build"), wd=.path_git_tmp)
  fs::dir_create(fs::path(.path_lib_tmp, c("js")))
  fs::file_copy(
    fs::path(.path_git_tmp, "LICENSE"), 
    fs::path(.path_lib_tmp, "LICENSE")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "dist", "twemoji.min.js"),
    fs::path(.path_lib_tmp, "js", "twemoji.min.js")
  )
  fs::dir_copy(
    fs::path(.path_git_tmp, "dist", "svg"), 
    .path_lib_tmp
  )
})

local({
  .path_git_tmp <- fs::file_temp(pattern="git")
  .path_lib_tmp <- fs::path(path_vendor, "jquery")
  gert::git_clone("git@github.com:jquery/jquery.git", .path_git_tmp)
  # version 3.7.1
  gert::git_reset_hard(
    ref="f79d5f1a337528940ab7029d4f8bbba72326f269", repo=I(.path_git_tmp)
  )
  processx::run("npm", "prune", wd=.path_git_tmp)
  processx::run("npm", c("run", "build"), wd=.path_git_tmp)
  fs::dir_create(fs::path(.path_lib_tmp, "js"))
  fs::file_copy(
    fs::path(.path_git_tmp, "LICENSE.txt"), 
    fs::path(.path_lib_tmp, "LICENSE")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "dist", "jquery.min.js"), 
    fs::path(.path_lib_tmp, "js", "jquery.min.js")
  )
})

local({
  .path_git_tmp <- fs::file_temp(pattern="git")
  .path_lib_tmp <- fs::path(path_vendor, "iframe-resizer")
  gert::git_clone(
    "git@github.com:davidjbradshaw/iframe-resizer.git", .path_git_tmp
  )
  # version 5.3.1
  gert::git_reset_hard(
    ref="251d7421476d439f7542e117e937a93374b56c39", repo=I(.path_git_tmp)
  )
  processx::run("npm", "prune", wd=.path_git_tmp)
  processx::run("npm", c("run", "build:latest"), wd=.path_git_tmp)
  fs::dir_create(fs::path(.path_lib_tmp))
  fs::file_copy(
    fs::path(.path_git_tmp, "LICENSE"), 
    fs::path(.path_lib_tmp, "LICENSE")
  )
  fs::dir_copy(
    fs::path(.path_git_tmp, "js"), 
    .path_lib_tmp
  )
})

local({
  .path_git_tmp <- fs::file_temp(pattern="git")
  .path_lib_tmp <- fs::path(path_vendor, "bootstrap")
  gert::git_clone("git@github.com:twbs/bootstrap.git", .path_git_tmp)
  # 5.3.3 release
  gert::git_reset_hard(
    ref="6e1f75f420f68e1d52733b8e407fc7c3766c9dba", repo=I(.path_git_tmp)
  )
  fs::dir_create(fs::path(.path_lib_tmp, c("js", "scss")))
  fs::file_copy(
    fs::path(.path_git_tmp, "LICENSE"), 
    fs::path(.path_lib_tmp, "LICENSE")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "dist", "js", "bootstrap.bundle.js"),
    fs::path(.path_lib_tmp, "js", "bootstrap.bundle.js")
  )
  fs::dir_copy(
    fs::path(.path_git_tmp, "scss/"), 
    .path_lib_tmp
  )
})