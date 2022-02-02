t1 <- Sys.time()
### run gwas by subtraction
setwd("/home/ahangarim/genomicSEM/genomicSEM_PGC/GWAS_by_subtraction/")
library(GenomicSEM)
load("LDSCoutputSCZNonBIP.RData") #LDSCoutput for SCZ and BIP GWAS generated usign ldsc() function 
load("Sumstats_bip_scz.RData") #sumstats output for SCZ and MDD GWAS using sumstats() function
### do SEM model without SNPs 
model<-'S=~NA*BIP + start(0.4)*SCZ
        NS=~NA*BIP
         NS~~1*NS
         S~~1*S
         S~~0*NS
         SCZ ~~ 0*BIP
         SCZ~~0*SCZ
         BIP~~0*BIP'
output<-usermodel(LDSCoutput_SCZ_BIP,estimation="DWLS",model=model)
# model with SNP
# S will be the SCZ contribution to BIP
# NS will be the non-SCZ contribution to BIP
model<-'S=~NA*BIP +start(0.2)*BIP + start(0.5)*SCZ
         NS=~NA*BIP +start(0.2)*BIP
         S~SNP
         NS~SNP
         NS~~1*NS
         S~~1*S
         S~~0*NS
         SCZ ~~ 0*BIP
         SCZ~~0*SCZ
         BIP~~0*BIP
         SNP~~SNP'
#Run the Genomic SEM GWAS
outputGWAS<-userGWAS(covstruc=LDSCoutput_SCZ_BIP,SNPs=p_sumstats_bip_scz,estimation="DWLS",model=model,sub =c("S~SNP","NS~SNP"),parallel = TRUE)
bip <- outputGWAS[[1]]
nonbip <- outputGWAS[[2]]
write.table(bip,"/home/ahangarim/genomicSEM/genomicSEM_PGC/GWAS_by_subtraction/results/SCZ_BIP.csv",row.names = F,col.names = T, quote = F, sep = "\t")
write.table(nonbip,"/home/ahangarim/genomicSEM/genomicSEM_PGC/GWAS_by_subtraction/results/nonSCZ_BIP.csv",row.names = F,col.names = T,quote = F,sep = "\t")

t2 <- Sys.time()

t1
t2
