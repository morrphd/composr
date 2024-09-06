#' Lower Inflated Response Option Values
#'
#' @description
#' Survey software will sometimes assign arbitrary values to response options. When this happens, a 1-5 scale may become a 14-18 scale. This function lowers all values with the specified range so that the minimum value is 1.
#'
#' @param df The data frame to examine
#' @param points Maximum number of response options
#'
#' @return A data frame with deflated response option values
#' @export
#'
#' @examples #For seven-point scales: df1 <- settle(df, 7)

settle <- function(df, points){
  for(c in names(df)){
    i <- df[,toString(c)]
    if(is.integer(i) == T){
      min <- range(i, na.rm = T)[1]
      max <- range(i, na.rm = T)[2]
      if(max-min == (points-1) & max > points){
        i <- i - (min-1)
        df[,toString(c)] <- i
      }
    }
  }
  return(df)
}
