
## Reading feedback csv file
feedback <- read.csv(file="data/feedback.csv",head=TRUE,sep=",")

## Display the header and number of rows
attributes(feedback)

## Creating factor and then reordering

rate1_ = factor(feedback$Rate1,levels(factor(feedback$Rate1))[c(2,5,3,1,4)])
rate2_ = factor(feedback$Rate2,levels(factor(feedback$Rate2))[c(2,5,3,1,4)])
rate3_ = factor(feedback$Rate3,levels(factor(feedback$Rate3))[c(2,5,3,1,4)])

quest1_ = factor(feedback$Quest1,levels(factor(feedback$Quest1))[c(2,1)])
quest2_ = factor(feedback$Quest2,levels(factor(feedback$Quest2))[c(2,1)])
quest3_ = factor(feedback$Quest3,levels(factor(feedback$Quest3))[c(2,1)])
quest4_ = factor(feedback$Quest4,levels(factor(feedback$Quest4))[c(2,1)])
quest5_ = factor(feedback$Quest5,levels(factor(feedback$Quest5))[c(2,1)])
quest6_ = factor(feedback$Quest6,levels(factor(feedback$Quest6))[c(2,1)])

## Summary Statistics of factor

rate1 = summary(rate1_)
rate2 = summary(rate2_)
rate3 = summary(rate3_)

quest1 = summary(quest1_)
quest2 = summary(quest2_)
quest3 = summary(quest3_)
quest4 = summary(quest4_)
quest5 = summary(quest5_)
quest6 = summary(quest6_)


## Creating pie chart

feedbck_cols <- c("303","552","251","589","153")

## To what degree was the actual lab environment simulated.
png('report/To what degree was the actual lab environment simulated.png')

feedbck_percentlabels <- round(100*(rate1/sum(rate1)), 1)
feedbck_pielabels <- paste(feedbck_percentlabels, "%", sep="")

pie(rate1, col=feedbck_cols, labels=feedbck_pielabels, cex=0.7)

legend("topright", c("Excellent","VeryGood","Good","Average","Poor"), cex=0.7, fill=feedbck_cols)

dev.off()
## The manuals (Theory and Procedure) were found to be helpful.
png('report/The manuals (Theory and Procedure) were found to be helpful.png')

feedbck_percentlabels <- round(100*(rate2/sum(rate2)), 1)
feedbck_pielabels <- paste(feedbck_percentlabels, "%", sep="")

pie(rate1, col=feedbck_cols, labels=feedbck_pielabels, cex=0.7)

legend("topright", c("Excellent","VeryGood","Good","Average","Poor"), cex=0.7, fill=feedbck_cols)

dev.off()
## The results of experiment were easily interpretable.

png('report/The results of experiment were easily interpretable.png')

feedbck_percentlabels <- round(100*(rate3/sum(rate3)), 1)
feedbck_pielabels <- paste(feedbck_percentlabels, "%", sep="")

pie(rate1, col=feedbck_cols, labels=feedbck_pielabels, cex=0.7)

legend("topright", c("Excellent","VeryGood","Good","Average","Poor"), cex=0.7, fill=feedbck_cols)

dev.off()


#################################
png('report/Percentage of users.png')
la1 <- c(quest1[1],quest2[1],quest3[1],quest4[1],quest5[1],quest6[1])
la2 <- c(quest1[2],quest2[2],quest3[2],quest4[2],quest5[2],quest6[2])
xyz <- table(la1,la2)
xyz
labels <- c("Did you get the feel of actual lab while performing the experiments?",
  "Did you go through the manual/step by step method before performing the experiments live ?",
  "Could you measure and analyze the data successfully?",
  "Could you compare your results with the given typical results?",
  "Do you think performing experiments through virtual labs are more challenging than the real lab experiments?",
  "Do you think doing experiments through virtual lab gives scope for more innovative and creative research work?")


dev.off()


###############################++++REPORT++++#############################

question = data.frame(quest1,quest2,quest3,quest4,quest5,quest6,
                      round(100*(quest1/sum(quest1)), 1),
                      round(100*(quest2/sum(quest2)), 1),
                      round(100*(quest3/sum(quest3)), 1),
                      round(100*(quest4/sum(quest4)), 1),
                      round(100*(quest5/sum(quest5)), 1),
                      round(100*(quest6/sum(quest6)), 1))
question

feedback = data.frame(rate1,rate2,rate3,round(100*(rate1/sum(rate1)), 1),
                      round(100*(rate2/sum(rate2)), 1),round(100*(rate3/sum(rate3)), 1))
feedback

# Write to a file, suppress row names
write.csv(question, "report/report.csv")
write.csv(feedback, "report/feedback.csv")


