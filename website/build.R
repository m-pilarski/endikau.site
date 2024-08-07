fs::dir_delete("./site/")

shinylive::export("./app_3/", "./site/")

httpuv::runStaticServer("./site/")
