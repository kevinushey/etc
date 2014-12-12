format <- function(path) {

  content <- readLines(path)
  contentNoComments <- gsub("//.*", "", content, perl = TRUE)

  # Tabs to 2 spaces
  content <- gsub("\t", "  ", content)

  # Find lines ending with commas -- these are continuations that can be vertically aligned
  x <- grep(",\\s*$", contentNoComments, perl = TRUE)
  start <- x[1]
  end <- start + 1
  groups <- list()
  for (i in 1:(length(x) - 1)) {
    if (x[i + 1] != x[i] + 1) {
      groups <- c(groups, list(c(start, end)))
      start <- x[i + 1]
      end <- start + 1
    } else {
      end <- end + 1
    }
  }
  groups <- c(groups, list(c(start, end)))

  invisible(lapply(groups, function(group) {
    start <- group[[1]]
    end   <- group[[2]]

    # Should end with either a paren or a new function
    isClosedWithParen <- grepl("\\)\\s*$", contentNoComments[end], perl = TRUE)
    isDefiningFunction <- grepl("\\)\\s*\\{\\s*$", contentNoComments[end], perl = TRUE)
    if (!(isClosedWithParen || isDefiningFunction))
      return(NULL)

    # Find the opening paren on the first line
    matches <- gregexpr("\\(", contentNoComments[start], perl = TRUE)[[1]]
    if (!length(matches))
      return(NULL)
    indentSize <- matches[length(matches)]
    indent <- paste(rep(" ", times = indentSize), collapse = "")
    content[(start + 1):end] <<-
      paste(indent,
            gsub("^[[:blank:]]*", "", content[(start + 1):end]),
            sep = "")
  }))
  cat(content, file = path, sep = "\n")
}
