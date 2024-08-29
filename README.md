
<!-- README.md is generated from README.Rmd. Please edit that file -->

# composr

<!-- badges: start -->
<!-- badges: end -->

The goal of composr is to facilitate the analysis of survey data by
automating the creation of composite variables. Using item naming
conventions, composr groups items by construct and calculates basic
descriptive statistics.

Label column names with the scale name and item number separated by an
underscore (e.g., “Att_3”). Also, before using composr, ensure the data
is cleaned and all recoding is completed.

## Installation

You can install the development version of composr from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("morrphd/composr")
```

## Example

To illustrate the functionality of composr, here is an example. First,
create a test dataset with 3-6 variables, with 3-10 items each.

``` r
testData <- data.frame("Case" = matrix(1:10, ncol = 1, nrow = 10))
x = 1

while(x <= round(runif(1, 3, 6))){ #Number of Variables
  y = 1
  while(y <= round(runif(1, 3, 10))){ #Number of Items
    temp <- round(runif(10, 1, 7)) #Number of Responses
    testData <- cbind(testData, as.data.frame(temp))
    colnames(testData)[colnames(testData) == "temp"] <-
      paste0("Var", x, "_", y)
    y = y + 1
    }
  x = x + 1
}

str(testData)
#> 'data.frame':    10 obs. of  20 variables:
#>  $ Case  : int  1 2 3 4 5 6 7 8 9 10
#>  $ Var1_1: num  3 1 4 4 4 3 2 4 7 2
#>  $ Var1_2: num  5 5 7 2 2 5 2 2 4 4
#>  $ Var1_3: num  6 1 4 6 6 2 6 2 5 5
#>  $ Var1_4: num  4 4 2 6 2 3 5 2 1 3
#>  $ Var1_5: num  3 3 3 3 6 5 6 5 1 5
#>  $ Var1_6: num  3 4 2 1 2 6 2 6 2 4
#>  $ Var1_7: num  1 6 6 2 7 5 7 4 1 6
#>  $ Var1_8: num  3 1 5 7 3 2 4 6 5 7
#>  $ Var2_1: num  5 6 3 6 6 6 4 3 1 4
#>  $ Var2_2: num  2 6 2 4 4 6 2 3 4 2
#>  $ Var2_3: num  4 4 4 5 2 5 5 2 4 5
#>  $ Var2_4: num  4 3 5 3 7 6 3 2 5 4
#>  $ Var3_1: num  3 6 7 1 5 6 3 4 4 6
#>  $ Var3_2: num  3 4 1 5 3 3 3 5 3 3
#>  $ Var3_3: num  1 5 3 6 6 2 6 2 6 6
#>  $ Var3_4: num  2 5 5 6 4 2 2 6 6 4
#>  $ Var3_5: num  3 3 3 5 3 1 6 7 6 3
#>  $ Var3_6: num  4 7 3 3 6 5 5 3 7 1
#>  $ Var3_7: num  7 4 6 7 2 4 5 2 1 1
```

Next, load composr and run the *compose()* function to sort the items
into groups.

``` r
library(composr)
test <- compose(testData)
str(test)
#> List of 4
#>  $ Case: int [1:10] 1 2 3 4 5 6 7 8 9 10
#>  $ Var1:'data.frame':    10 obs. of  8 variables:
#>   ..$ Var1_1: num [1:10] 3 1 4 4 4 3 2 4 7 2
#>   ..$ Var1_2: num [1:10] 5 5 7 2 2 5 2 2 4 4
#>   ..$ Var1_3: num [1:10] 6 1 4 6 6 2 6 2 5 5
#>   ..$ Var1_4: num [1:10] 4 4 2 6 2 3 5 2 1 3
#>   ..$ Var1_5: num [1:10] 3 3 3 3 6 5 6 5 1 5
#>   ..$ Var1_6: num [1:10] 3 4 2 1 2 6 2 6 2 4
#>   ..$ Var1_7: num [1:10] 1 6 6 2 7 5 7 4 1 6
#>   ..$ Var1_8: num [1:10] 3 1 5 7 3 2 4 6 5 7
#>  $ Var2:'data.frame':    10 obs. of  4 variables:
#>   ..$ Var2_1: num [1:10] 5 6 3 6 6 6 4 3 1 4
#>   ..$ Var2_2: num [1:10] 2 6 2 4 4 6 2 3 4 2
#>   ..$ Var2_3: num [1:10] 4 4 4 5 2 5 5 2 4 5
#>   ..$ Var2_4: num [1:10] 4 3 5 3 7 6 3 2 5 4
#>  $ Var3:'data.frame':    10 obs. of  7 variables:
#>   ..$ Var3_1: num [1:10] 3 6 7 1 5 6 3 4 4 6
#>   ..$ Var3_2: num [1:10] 3 4 1 5 3 3 3 5 3 3
#>   ..$ Var3_3: num [1:10] 1 5 3 6 6 2 6 2 6 6
#>   ..$ Var3_4: num [1:10] 2 5 5 6 4 2 2 6 6 4
#>   ..$ Var3_5: num [1:10] 3 3 3 5 3 1 6 7 6 3
#>   ..$ Var3_6: num [1:10] 4 7 3 3 6 5 5 3 7 1
#>   ..$ Var3_7: num [1:10] 7 4 6 7 2 4 5 2 1 1
```

The items are now sorted into their scales. To create the composite
variable in the main dataset, run the *compute()* function for each
variable.

``` r
testData <- compute(test$Var1, testData)
#>   Variable Items  n   Mean        SD     Alpha
#> 1     Var1     8 10 3.8375 0.4332131 -1.477997
tail(names(testData))
#> [1] "Var3_3" "Var3_4" "Var3_5" "Var3_6" "Var3_7" "Var1"
```

Notice that, in addition to adding a column for the composite variable,
running this command also produced basic statistical information.

For questions, contact Ethan Morrow at <emorrow3@illinois.edu>.
