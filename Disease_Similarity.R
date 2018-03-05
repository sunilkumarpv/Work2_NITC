unq_dis <- subset(LD_Final, !duplicated(Disease))
unq_dis <- unq_dis[, 2:3]
dis_index <- t(combn(nrow(unq_dis),2))
DisScore <- as.matrix(apply(dis_index, 1, function(x) doSim(unq_dis$DOID[x[1]],unq_dis$DOID[x[2]],measure= "Wang")))
DisScore[is.na(DisScore)] <- 0
DisScoreMat <- cbind(dis_index,DisScore)
labels <- unique(c(DisScoreMat[, 1], DisScoreMat[, 2]))
DisSim <- matrix(0, length(labels), length(labels))
rownames(DisSim) <- labels
colnames(DisSim) <-labels
DisSim[DisScoreMat[, 1:2]] <- as.numeric(DisScoreMat[, 3]) 
library(Matrix)
DisSim <- as.matrix(forceSymmetric(DisSim))
diag(DisSim) <- 1
rownames(DisSim) <- unq_dis$Disease
colnames(DisSim) <- unq_dis$Disease
