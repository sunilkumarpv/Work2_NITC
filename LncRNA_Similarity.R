# Find out Disease relatives of each lncRNAs
# Input file is "LD_Final" obtained from "Input_processing.R"

LncRNA_List <-  as.data.frame(unique(LD_Final["LncRNA"]))

# LncRNA- DOID Association Matrix formation

index <- matrix(1:nrow(LncRNA_List),nrow = nrow(LncRNA_List),ncol = 1,byrow = TRUE)

LncRNA_Names <- apply(index, 1, function(x) LncRNA_List[x[1],])
DOIDs <- apply(index, 1, function(x) LD_Final[which(LncRNA_List[x[1],1]==LD_Final$LncRNA),3])
LncRNA_DOID <- cbind(LncRNA_Names,DOIDs) 

# Disease similarity computation

ind <- matrix(1:598,nrow=598,ncol=1,byrow=TRUE) # Function to run from 1 to 598 lncRNAs
ind1 <- t(combn(nrow(LD_Assoc),2)) #  C(592,2) combinations created and stored in inedex matrix, ind1
sim <- apply(ind1, 1, function(x) doSim(DOIDs[[x[1]]],DOIDs[[x[2]]],measure= "Wang")) # dosim function is applied for each pair

# lncRNA similarity computation (Formula from Reference Paper implemented)

ind2 <- matrix(1:nrow(ind1), nrow = nrow(ind1), ncol = 1,byrow = TRUE)

sim_L1_L2 <- apply(ind2,1,function(x){
  sim[[x[1]]][is.na(sim[[x[1]]])] <- 0
  if(is.matrix(sim[[x[1]]])==FALSE) sim[[x[1]]]
  else
     (sum(apply(sim[[x[1]]],1,max))+sum(apply(sim[[x[1]]],2,max)))/(nrow(sim[[x[1]]])+ncol(sim[[x[1]]]))
})
output <- cbind(ind1, sim_L1_L2)

# output1 carries similarity score between each pair of LncRNAs.. 





