
## Assignment and accessing vaiable

a <- 3 ## [1] 3

b <- sqrt(a*a+3) ## [1] 3.464102

bubba <- c(3,5,7,9)

bubba[2] ## [1] 5

bubba[1]  ## [1] 3

bubba[0] ## numeric(0) It gives information how data
		 ## are stored

bubba[3] ## [1] 7

bubba[4] ## [1] 9

bubba[5] ## [1] NA

 ## get the list of varibale on a particular session
ls()  ## [1] "a"     "b"     "bubba"

bubba + 5 ## [1]  8 10 12 14

bubba ## [1] 3 5 7 9

bubba <- bubba + 5 ## [1]  8 10 12 14

bubba ## [1] 8 10 12 14

## Basic statistical and helper function

mean(bubba)

var(bubba)

typeof(bubba)

## Working with String

str <- c("D","E")

str[2] ## [1] "E"

str[1]  ## [1] "D"

str[0] ## character(0) It gives information how data
		 ## are stored

str[3] ## [1] NA

typeof(str) ## [1] "character"
