#' Create and Compute Composite Variable Statistics
#'
#' @param loc List of items grouped by scale, created using compose function
#' @param df The data frame to add the composite variable to
#'
#' @importFrom stats na.omit var
#'
#' @return A data frame with the composite variable added and basic statistics
#' @export
#'
#' @examples #Use data from the compose function
#' #testData <- compute(test$var1, testData)

compute <- function(loc, df){
  name <- as.character(substitute(loc)[3])
  df$temp <- rowMeans(loc, na.rm=T)

  #descriptive stats
  obs <- nrow(loc)
  mean <- mean(df$temp, na.rm = T)
  sd <- sd(df$temp, na.rm = T)

  #alpha
  loc_noNA <- na.omit(loc)
  num_col <- ncol(loc)
  cron <- (num_col/(num_col-1))*(1 - sum(apply(loc_noNA,2,var))/var(apply(loc_noNA,1,sum)))

  print(data.frame(Variable = name, Items = num_col, n = obs,
                   Mean = mean, SD = sd, Alpha = cron))

  #store computed variable in dataset
  if(any(colnames(df)==name)){
    stop("The variable already exists in the dataset")}

  colnames(df)[colnames(df) == "temp"] <- name
  invisible(df)
}
