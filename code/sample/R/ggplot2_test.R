df <- data.frame(time = factor(c("Lunch","Dinner"), levels=c("Lunch","Dinner")),
                 total_bill = c(14.89, 17.23))
#   time total_bill
#  Lunch      14.89
# Dinner      17.23

# Load the ggplot2 library
library(ggplot2)

# Basic line graph. These both have the same result.
ggplot(data=df, aes(x=time, y=total_bill, group=1)) + geom_line()
ggplot(data=df, aes(x=time, y=total_bill)) + geom_line(aes(group=1))

# Add points
ggplot(data=df, aes(x=time, y=total_bill, group=1)) + geom_line() + geom_point()


# Change color of both line and points
# Change line type and point type, and use thicker line and larger points
# Change points to circles with white fill
ggplot(data=df, aes(x=time, y=total_bill, group=1)) + 
  geom_line(colour="red", linetype="dotted", size=1.5) + 
  geom_point(colour="red", size=4, shape=21, fill="white")