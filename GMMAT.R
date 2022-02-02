start_time <- Sys.time()
Sys.time()
#load the required libraries
library(GMMAT)
library(data.table)
setwd("/home/ahangarim/GMMAT/PRS_Fam/")
# Load the GRM and makes sure that the columns are in order.
GRM <- as.matrix(read.table("/home/ahangarim/kinship/LDAK/kinship_matrix/SCZ_All_kinship.grm.raw",check.names=F))
FAM <- read.table("/home/ahangarim/kinship/LDAK/kinship_matrix/SCZ_All_kinship.grm.id")
colnames(FAM) <- c("IID","FID")
colnames(GRM) <- FAM$IID
rownames(GRM) <- FAM$IID
FAM$seq <- 1:nrow(FAM)
GRM[which(GRM<0)]=0
pheno <- fread("All_phenotype_PRS.summary") # load the file for PRS and phenotypes 
pheno <- merge(pheno,FAM[,c("IID","seq")],by="IID") # make sure that genotype and phenotype data have the same sequence of individuals
pheno$seq <- as.numeric(as.character(pheno$seq))
pheno <- pheno[with(pheno,order(seq)),]
# Prepare PRS column for GMMAT
prs <- pheno[,grep("zscore",colnames(pheno))] # all PRS column names contain the phrase "zscore"
prs <- as.data.frame(t(prs))
prs$SNP <- rownames(prs)
prs$A1 <- "N"
prs$A2 <- "F"
prs <- prs[,c((ncol(prs)-2):ncol(prs),1:(ncol(prs)-3))]
write.table(prs,"/home/ahangarim/GMMAT_results/PRS/data_PRS_scaled.txt",c=F,r=F,qu=F,sep="\t")

# run the mixed model analysis using glmm.wald() in GMMAT
endpoints <- c("Group")
ep <- endpoints[1]
for (ep in endpoints)
{
  form <- as.formula(paste(ep,"~+sex+platform+site+PC1+PC2+PC3+PC4+PC5+PC6+PC7+PC8+PC9+PC10"))
  temp <- glmm.wald(fixed=form, data=pheno, kins=GRM, id="IID", missing.method="omit", family=binomial(link="logit"), infile="data_PRS_scaled.txt", infile.ncol.skip=3, infile.ncol.print=1, infile.header.print=c("PRS"), snps=rownames(prs), method="ML", method.optim="Nelder-Mead")
  temp$ANALYSIS <- ep
  if(ep==endpoints[1]) resultsAll <- temp else resultsAll <- rbind(resultsAll,temp)   
}
write.csv(resultsAll,"GMMAT_ALL_PRS_results.csv",row.names=F)


## get OR and CI, and correct for multiple testing
k <- fread("/home/ahangarim/GMMAT_results/PRS/GMMAT_ALL_PRS_results.csv")
k$OR <- exp(k$BETA)
k$CI_lower <- exp(k$BETA-(k$SE*1.959964))
k$CI_upper <- exp(k$BETA+(k$SE*1.959964))
k$CI <- paste0(format(k$CI_lower,dig=3),"-",format(k$CI_upper,dig=3))
k$CI <- gsub(" ","",k$CI)
k$P_holm <- p.adjust(k$P,method = "holm")
k

write.table(k,"Final_GMMAT_OR.csv",row.names=F,col.names=t,quote=F,sep="\t")
