
## Reading feedback csv file
feedback <- read.csv(file="feedback.csv",head=TRUE,sep=",")

## Display the header and number of rows
attributes(feedback)

## Creating factor and then reordering

rate1 = factor(feedback$Rate1,levels(factor(feedback$Rate1))[c(2,5,3,1,4)])
rate2 = factor(feedback$Rate2,levels(factor(feedback$Rate2))[c(2,5,3,1,4)])
rate3 = factor(feedback$Rate3,levels(factor(feedback$Rate3))[c(2,5,3,1,4)])

quest1 = factor(feedback$Quest1,levels(factor(feedback$Quest1))[c(2,1)])
quest2 = factor(feedback$Quest2,levels(factor(feedback$Quest2))[c(2,1)])
quest3 = factor(feedback$Quest3,levels(factor(feedback$Quest3))[c(2,1)])
quest4 = factor(feedback$Quest4,levels(factor(feedback$Quest4))[c(2,1)])
quest5 = factor(feedback$Quest5,levels(factor(feedback$Quest5))[c(2,1)])
quest6 = factor(feedback$Quest6,levels(factor(feedback$Quest6))[c(2,1)])

## Summary Statistics of factor

summary(rate1)
summary(rate2)
summary(rate3)

summary(quest1)
summary(quest2)
summary(quest3)
summary(quest4)
summary(quest5)
summary(quest6)


## Creating pie chart

feedbck_cols <- c("grey90","grey50","black","grey30","white")
feedbck_percentlabels <- round(100*rate1/sum(rate1), 1)
pielabels <- paste(feedbck_percentlabels, "%", sep="")

pie(rate1, main="My Best Piechart", col=cols, labels=pielabels, cex=0.8)

legend("topright", c("Mon","Tue","Wed","Thu","Fri"), cex=0.8, fill=cols)




