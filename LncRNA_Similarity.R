# Find out Disease relatives of each lncRNAs
LncRNA_List <-  as.data.frame(unique(LD_Final["LncRNA"]))#,stringsAsFactors=TRUE)

for(i in 1:nrow(LncRNA_List))
{
  LD_Assoc[i,1] <- LncRNA_List[i,1]  #First Column = LncRNA
  LD_Assoc[i,2] <-(paste(LD_Final[which(LncRNA_List[i,1]==LD_Final$LncRNA),3], collapse=","))# Second column = Associated DOIDs 
}

RelL1 <- unlist(strsplit(LD_Assoc[4,2], split=","))
RelL2 <- unlist(strsplit(LD_Assoc[13,2], split=","))

sim <- doSim(RelL1,RelL2,measure= "Wang") 
sim_L1_L2 <- (sum(apply(sim,1,max))+sum(apply(sim,2,max)))/(length(RelL1)+length(RelL2))
