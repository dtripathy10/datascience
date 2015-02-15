###  Factor Data Type

data = c(1,2,2,3,1,2,3,3,1,2,3,3,1)
fdata = factor(data)
fdata  ##	[1] 1 2 2 3 1 2 3 3 1 2 3 3 1
	   ##	Levels: 1 2 3
rdata = factor(data,labels=c("I","II","III"))

levels(fdata) <- c ('A','B','C')

fdata ##  [1] A B B C A B C C A B C C A
	  ## Levels: A B C
