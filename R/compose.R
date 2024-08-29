#' Group Items into Scales
#'
#' @param df Data frame of items
#'
#' @return List of scales containing a list of items
#' @export
#'
#' @examples #build test data
#' testData <- data.frame("Case" = matrix(1:10, ncol = 1, nrow = 10))
#' x = 1
#' while(x <= round(runif(1, 3, 6))){ #Number of Variables
#'   y = 1
#'   while(y <= round(runif(1, 3, 10))){ #Number of Items
#'     temp <- round(runif(10, 1, 7)) #Number of Responses
#'     testData <- cbind(testData, as.data.frame(temp))
#'     colnames(testData)[colnames(testData) == "temp"] <-
#'       paste0("Var", x, "_", y)
#'     y = y + 1
#'     }
#'   x = x + 1
#' }
#'
#' #Group items into scales
#' test <- compose(testData)

compose <- function(df){

  #identify distinct variables from items
  varList <- unique(sub("_.*", "", names(df)))

  #create list of items for each variable
  dfs <- list()
  y = 1

  while(y <= length(varList)){
    dfs[[length(dfs)+1]] <- df[,c(grep(varList[y],
                                       colnames(df),
                                       value = T))]
    y = y + 1
  }

  names(dfs) <- c(varList)
  invisible(dfs)
}
