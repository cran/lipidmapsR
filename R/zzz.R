.onAttach <- function(libname, pkgname) {
  packageStartupMessage(paste0(
    "\nThis is lipidmapsR version ",
    utils::packageVersion("lipidmapsR"),
    ".\nCurated by Mingzhuo Tian."
  ))
}
