# Remove Duplicates form raw LD data

LD_NoDup <- Raw_LD_human [!duplicated(Raw_LD_human [c(1,2)]),]

# Subset DOID to match with LD

DOID_LD_Common <- subset(DOID, DOID$`Preferred Label` %in% LD_NoDup$Disease)

# Retain interactions of diseases having DOID in LD

LD_Final <- subset(LD_NoDup, LD_NoDup$Disease %in% DOID_LD_Common$`Preferred Label`)

# Making LncRNA, Disease and DOID in to a single file.. Organism coloumn will be replaced by DOID column

LDFinal_vector <- LD_Final[['Disease']]

for(i in 1:nrow(LD_Final))
  LD_Final[i,3] <- DOID[which(LDFinal_vector[i] == DOID$`Preferred Label`),1]
colnames(LD_Final)[3] <- "DOID" # DOID Column is named to DOID

LD_Final$DOID <- gsub('_',':', LD_Final$DOID)
