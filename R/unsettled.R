#' Identify Inflated Response Option Values
#'
#' @description
#' For use in conjunction with settle(). This function identifies variables with outside of the specified range that may require manual recoding to address inflated response option values.
#'
#' @param df The data frame to examine
#' @param points Maximum number of response options
#'
#' @return A list of variables that may need manual deflation of response option values
#' @export
#'
#' @examples #For seven-point scales: df1 <- unsettled(df, 7)

unsettled <- function(df, points){

  recodeList <- list()

  for(c in names(df)){
    i <- df[,toString(c)]
    if(is.integer(i) == T){
      min <- range(i, na.rm = T)[1]
      max <- range(i, na.rm = T)[2]
      if(max-min != (points-1) & max > points){
        recodeList[[length(recodeList)+1]] <- c
      }
    }
  }
  return(recodeList)
}
