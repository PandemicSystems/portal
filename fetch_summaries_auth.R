

# functions -----------------------------------------------------------------------------------

## modified from https://gist.github.com/ritchieking
## Download file from private GitHub repo (any size)

library(tidyverse)
library(httr) 
library(rlist)
library(jsonlite)

# on MacOS environmental variable must be hard coded. Find with Sys.getenv("GITHUB_PAT")
source("local/credentials.R")
Sys.setenv(GITHUB_PAT = GITHUB_PAT)


# functions ---------------------------------------------------------------

fetchGHdata <- function(account, repo, path) {
  
  # Store a personal access token in .Renviron
  # See https://blog.exploratory.io/extract-data-from-private-github-repository-with-rest-api-db804fa43d84
  auth <- authenticate(Sys.getenv("GITHUB_PAT"), "")
  
  # auth <- authenticate(auth)
  
  # Seperate the filename from the directory
  match <- regexpr("^(.*[\\/])", path)
  if (match[1] > 0) {
    dir <- path %>% substring(match[1], attr(match, "match.length"))
    file <- path %>% substring(attr(match, "match.length") + 1, nchar(path))
  } else {
    dir <- ""
    file <- path
  }
  
  # To handle files larger than 1MB, use this trick:
  # https://medium.com/@caludio/how-to-download-large-files-from-github-4863a2dbba3b
  req_meta <- 
    httr::content(
      httr::GET(
        paste("https://api.github.com/repos", account, repo, "contents", dir, sep="/"), 
        auth
      )
    )
  
  entry <- req_meta %>% rlist::list.filter(name == file)
  sha <- entry[1][[1]]$sha
  
  # Stop with message if file not found.
  if(is.null(sha)){
    f <- paste(account, repo, path, sep="/")
    stop(paste(f, "not found."))
  }

  # Grab contents, using sha as a reference
  req_blob <- httr::GET(
    url = paste("https://api.github.com/repos", account, repo, "git/blobs", sha, sep="/"), 
    auth
  )
  
  # Need to decode the contents, which are returned in base64
  d <- httr::content(req_blob)$content %>%
    jsonlite::base64_dec() %>%
    rawToChar()
  
  return(d)
}

insert_tag <- function(html,tag,before="</body>") {
  gsub(before,paste0(tag,"\n",before),html)
}

fetch_and_fix <- function(url,destfile) {
  # tmp <- readLines(url)
  tmp <- tempfile("tmp", fileext = ".html")
  utils::download.file(url, destfile = tmp, cacheOK = FALSE)
  
  # insert resizer script
  script <- '<script type="text/javascript" src="js/iframeResizer.contentWindow.min.js"></script>'
  h <- readLines(tmp)
  out <- gsub("</body>",paste0(script,"\n</body>"),h)
  
  # insert resizer script
  writeLines(out,destfile)
  cat(paste("Done writing", destfile,"\n"))
}

# resizer script ------------------------------------------------------------------------------

resizer <- '<script type="text/javascript" src="js/iframeResizer.contentWindow.min.js"></script>'

# Fetch Web Summaries --------------------------------------------------------------------

# Download a rendered HTML file from a different repository, insert a script to 
# prepare it for embedding, and save as a new file locally. 
fetchGHdata("PandemicSystems", "sarkar-social-tipping-points", "web-summary.html") %>% insert_tag(resizer) %>% 
  writeLines("DP4_summary.html")

# The html file can then be embedded in an Rmd document with the following code:
# 
# ```{r echo=FALSE, out.extra='id="DP4" scrolling="no" width="100%"'}
# knitr::include_url("DP4_summary.html")
# ```
# <script>iFrameResize({ log: false }, '#DP4')</script>
#
