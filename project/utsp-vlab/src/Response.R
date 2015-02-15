
## Reading eval_result csv file
eval_result <- read.csv(file="data/eval_result.csv",head=TRUE,sep=",")

## Reading answer sheet

answesheet <- read.csv(file="data/answer.csv",head=TRUE,sep=",")

answer_sheet = data.frame(Srno = answesheet$Srno,Answer = answesheet$Answer)

number_of_question = nrow(answer_sheet)

user_result = data.frame(UsrNo = eval_result$UsrNo,QtsNo = eval_result$QtsNo,
                         Answer = eval_result$Answer)

## Number of rows in data frame
rows <- nrow(user_result)

## Number of unique user id
u_id_ = factor(user_result$UsrNo)

unique_user = (levels(u_id_))
              
unique_user_no = length(unique_user)

mat<-matrix(list(), nrow=unique_user_no, ncol=5)

for(i in 1:unique_user_no) {
  mat[[i,1]] = unique_user[i] # unique user id
  mat[[i,2]] = 0 # number of correct answer
  mat[[i,3]] = 0 # number of wrong answer
  mat[[i,4]] = 0 # number of incorrect answer
  mat[[i,5]] = 0 # totla number of answer
  #mat[[i,6]] = list() # index to scan
}

for(i in 1:rows) {
 
  for(j in 1:unique_user_no) {
    
    if ( mat[[j,1]] == user_result$UsrNo[i]  ) {
      index = j
    }
    
  }
  
  for(k in 1:number_of_question) {
    
    if ( answer_sheet$Srno[k] == user_result$QtsNo[i]  ) {
      answer = answer_sheet$Answer[k]
    }
    
  }
  
  xyz = "Did Not Answered"
  
  if (grepl(user_result$Answer[i], answer)) {
    mat[[index,2]] <- mat[[index,2]] + 1
  }else if (grepl(xyz, user_result$Answer[i])) {
    mat[[index,4]] <- mat[[index,4]] + 1
  }else
    mat[[index,3]] <- mat[[index,3]] + 1
  
  mat[[index,5]] <- mat[[index,5]] + 1
  #mat[[index,6]] <- append(mat[[index,6]],list(i))
}

##################Report ################
final<-matrix(list(), nrow=unique_user_no, ncol=3)

final[,1] = mat[,2] # Correct
final[,2] = mat[,3] # Wrong
final[,3] = mat[,4] # Unansowered

write.csv(final, "report/result_v2.csv")
# Write to a file, suppress row names
write.csv(mat, "report/result_v1.csv")
