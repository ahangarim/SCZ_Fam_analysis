t1 <- Sys.time()

### run gwas by subtraction for MDD
setwd("/home/ahangarim/genomicSEM/genomicSEM_PGC/GWAS_by_subtraction/")
library(GenomicSEM)
load("LDSCoutputSCZNonMDD.RData") #LDSCoutput for SCZ and MDD GWAS generated usign ldsc() function 
load("Sumstats_scz_mdd.RData") #sumstats output for SCZ and MDD GWAS using sumstats() function
### do SEM model without SNPs 
model<-'S=~NA*MDD + start(0.4)*SCZ
        NS=~NA*MDD
         NS~~1*NS
         S~~1*S
         S~~0*NS
         SCZ ~~ 0*MDD
         SCZ~~0*SCZ
         MDD~~0*MDD'
output<-usermodel(LDSCoutput_SCZ_MDD,estimation="DWLS",model=model)

# model with SNP
# S will be the SCZ contribution to MDD
# NS will be the non-SCZ contribution to MDD
model<-'S=~NA*MDD +start(0.2)*MDD + start(0.5)*SCZ
         NS=~NA*MDD +start(0.2)*MDD
         S~SNP
         NS~SNP
         NS~~1*NS
         S~~1*S
         S~~0*NS
         SCZ ~~ 0*MDD
         SCZ~~0*SCZ
         MDD~~0*MDD
         SNP~~SNP'

#Run the Genomic SEM GWAS
outputGWAS<-userGWAS(covstruc=LDSCoutput_SCZ_MDD,SNPs=p_sumstats_scz_mdd,estimation="DWLS",model=model,sub =c("S~SNP","NS~SNP"),parallel = TRUE)
scz <- outputGWAS[[1]]
nonscz <- outputGWAS[[2]]
write.table(scz,"/home/ahangarim/genomicSEM/genomicSEM_PGC/GWAS_by_subtraction/results/SCZfactor_MDD.csv",row.names = F,col.names = T, quote = F, sep = "\t")
write.table(nonscz,"/home/ahangarim/genomicSEM/genomicSEM_PGC/GWAS_by_subtraction/results/nonSCZfactor_MDD.csv",row.names = F,col.names = T,quote = F,sep = "\t")

t2 <- Sys.time()

t1
t2

