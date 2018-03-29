# Only 88 diseases have gene associations available.. 
# Those diseases do not have gene associations are to be removed while forming adjacency matrices

# LncRNA Similarity matrix- No change-- LncSim
# LncRNA Adjacency matrix formation- put 1 for positions where similarity value > 0.5(Cumulative frequency distribution)

LncAdj <- LncSim
LncAdj[LncAdj < 0.5] <- 0
LncAdj[LncAdj >= 0.5] <- 1

# Disease Adjacency matrix.. Filter out Only diseases having gene association

grepPattern <- paste0("^", disease_labels, "$", collapse = "|")
selNames <- grep(grepPattern, rownames(DisSim), ignore.case = TRUE, value = TRUE)
DisSimNew <- subset(DisSim, select = selNames) # Only Diseases with gene associations
DisSimNew <- subset(DisSimNew, rownames(DisSimNew) %in% selNames)

#DisSimNew is not required, as of now..... 

# Disease Adjacency matrix formation- put 1 for positions where similarity value > 0.3(Cumulative frequency distribution)

DisAdj <- DisSim
DisAdj[DisAdj < 0.3] <- 0
DisAdj[DisAdj >= 0.3] <- 1

#LncRNA-Disease Adjacency Matrix formation....

 


# library(gtools)
# AllPaths <- as.data.frame(permutations(n=2,r=3,v=c("L","P"),repeats.allowed=T))
# LLPaths <- subset(AllPaths, AllPaths$V1 == "L" & AllPaths$V3 == "L")

