# Unique diseases under this experiment is stored in DOID_LD_Common$`Preferred Label`
# desease_gene association datatset is subset to contain only these diseases... 

DiseaseNames <- as.vector(DOID_LD_Common[["Preferred Label"]]) 
DiseaseNames1 <- paste("^",DiseaseNames, "$", sep="")
DisGen_relevant <- subset(curated_gene_disease_associations , grepl(paste(DiseaseNames1, collapse = "|"), diseaseName,ignore.case = TRUE),value=TRUE)

#Adjacency Matrix Formartion

DisGen_relevant1 <- as.matrix(DisGen_relevant[, c(2,4,5)],header = FALSE)

gene_labels <- unique(DisGen_relevant1[, 1])
disease_labels <- unique(DisGen_relevant1[, 2])

DisGenMat <- matrix(0, length(t(gene_labels)), length(t(disease_labels)))
rownames(DisGenMat) <- t(gene_labels)
colnames(DisGenMat) <- t(disease_labels)
DisGenMat[DisGen_relevant1[, 1:2]] <- as.numeric(DisGen_relevant1[, 3])
