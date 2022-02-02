###### These scripts are run on PBS HPC

#!/bin/bash
#PBS -q workq
#PBS -N PRScs_score
#PBS -V 
#PBS -S /bin/bash 
#PBS -l nodes=1:ppn=8
#PBS -o /home/projects/IrishGWAS/working/Analyses/PRS/PRScs/scores/logs/PRS.log
#PBS -e /home/projects/IrishGWAS/working/Analyses/PRS/PRScs/scores/logs/PRS.err


cd $PBS_O_WORKDIR

date


#### PGC3-BIP
for i in {1..22}
do
/home/ahangarim/Util/plink2/plink2 --vcf /home/projects/IrishGWAS/SCZ_CC/Post_all_QC/HRC_version_r.1.1/vcfs/chr$i.dose_filtered.vcf.gz dosage=DS \
  --score /home/projects/IrishGWAS/working/Analyses/PRS/PRScs/weights/PGC3_BIP/All_PGC3_BIP.score list-variants \
  --out /home/projects/IrishGWAS/working/Analyses/PRS/PRScs/scores/CC/CC_PGC3_BIP_chr$i
done
date

for i in {1..22}
do
/home/ahangarim/Util/plink2/plink2 --vcf /home/projects/IrishGWAS/SCZ_Fam/Post_all_QC/HRC_version_r.1.1/vcfs/chr$i.dose_filtered.vcf.gz dosage=DS  \
  --score /home/projects/IrishGWAS/working/Analyses/PRS/PRScs/weights/PGC3_BIP/All_PGC3_BIP.score list-variants \
  --out /home/projects/IrishGWAS/working/Analyses/PRS/PRScs/scores/Fam/Fam_PGC3_BIP_chr$i
done
date

for i in {1..22}
do
/home/ahangarim/Util/plink2/plink2 --vcf /home/projects/IrishGWAS/psychChip/20160415/Genos/Imputed/HRC_version_r.1.1/vcfs/chr$i.dose_filtered.vcf.gz dosage=DS \
--score /home/projects/IrishGWAS/working/Analyses/PRS/PRScs/weights/PGC3_BIP/All_PGC3_BIP.score list-variants \
--out /home/projects/IrishGWAS/working/Analyses/PRS/PRScs/scores/psychChip/psychChip_PGC3_BIP_chr$i
done
date


### Same code was used for other PRS we just swapped --score files and the output files for others. 
