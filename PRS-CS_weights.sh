##### These scripts are run on PBS HPC

#!/bin/bash 
#PBS -q magma
#PBS -N CommFact_PRScs
#PBS -V 
#PBS -S /bin/bash 
#PBS -l nodes=1:ppn=5
#PBS -o /home/projects/IrishGWAS/working/Analyses/PRS/PRScs/weights/logs/weights_fam.log
#PBS -e /home/projects/IrishGWAS/working/Analyses/PRS/PRScs/weights/logs/weights_fam.err

cd $PBS_O_WORKDIR

date


### PGC3-BIP
for i in {1..22}
do

/home/ahangarim/Util/anaconda3/anaconda3/bin/python3.7 /home/ahangarim/Util/PRScs/PRScs/PRScs.py \
--ref_dir=/home/projects/rileyNGS/Refs/1KG_PRScs_ref/ldblk_1kg_eur \
--bim_prefix=/home/projects/rileyNGS/Refs/1KG_PRScs_ref/Irish_SCZ_All \
--sst_file=/home/projects/rileyNGS/Refs/summary_stats/PRScs_prep/PGC3_BIP.assoc \
--n_gwas=413466 \
--phi=1e-2 \
--chrom $i \
--out_dir=/home/projects/IrishGWAS/working/Analyses/PRS/PRScs/weights/PGC3_BIP/PGC3_BIP_chr$i
done


date
### MDD 2019
for i in {1..22}
do

/home/ahangarim/Util/anaconda3/anaconda3/bin/python3.7 /home/ahangarim/Util/PRScs/PRScs/PRScs.py \
--ref_dir=/home/projects/rileyNGS/Refs/1KG_PRScs_ref/ldblk_1kg_eur \
--bim_prefix=/home/projects/rileyNGS/Refs/1KG_PRScs_ref/Irish_SCZ_All \
--sst_file=/home/projects/rileyNGS/Refs/summary_stats/PRScs_prep/MDD_2019.assoc \
--n_gwas=500199 \
--phi=1e-2 \
--chrom $i \
--out_dir=/home/projects/IrishGWAS/working/Analyses/PRS/PRScs/weights/MDD_2019/MDD_2019_chr$i
done

date
## nonSCZ factor in BIP
for i in {1..22}
do

/home/ahangarim/Util/anaconda3/anaconda3/bin/python3.7 /home/ahangarim/Util/PRScs/PRScs/PRScs.py \
--ref_dir=/home/projects/rileyNGS/Refs/1KG_PRScs_ref/ldblk_1kg_eur \
--bim_prefix=/home/projects/rileyNGS/Refs/1KG_PRScs_ref/Irish_SCZ_All \
--sst_file=/home/ahangarim/genomicSEM/genomicSEM_PGC/LeaveNoutGWAS_by_subtraction/results/All_nonSCZ_BIP.assoc  \
--n_gwas=312118 \
--phi=1e-2 \
--chrom $i \
--out_dir=/home/projects/IrishGWAS/working/Analyses/PRS/PRScs/weights/GWAS_by_subtraction/nonSCZ_BIP_chr$i
done

date
## SCZ factor in BIP
for i in {1..22}
do

/home/ahangarim/Util/anaconda3/anaconda3/bin/python3.7 /home/ahangarim/Util/PRScs/PRScs/PRScs.py \
--ref_dir=/home/projects/rileyNGS/Refs/1KG_PRScs_ref/ldblk_1kg_eur \
--bim_prefix=/home/projects/rileyNGS/Refs/1KG_PRScs_ref/Irish_SCZ_All \
--sst_file=/home/ahangarim/genomicSEM/genomicSEM_PGC/LeaveNoutGWAS_by_subtraction/results/All_SCZ_BIP.assoc  \
--n_gwas=149464 \
--phi=1e-2 \
--chrom $i \
--out_dir=/home/projects/IrishGWAS/working/Analyses/PRS/PRScs/weights/GWAS_by_subtraction/SCZ_BIP_chr$i
done


date
### nonSCZ factor in MDD
for i in {1..22}
do

/home/ahangarim/Util/anaconda3/anaconda3/bin/python3.7 /home/ahangarim/Util/PRScs/PRScs/PRScs.py \
--ref_dir=/home/projects/rileyNGS/Refs/1KG_PRScs_ref/ldblk_1kg_eur \
--bim_prefix=/home/projects/rileyNGS/Refs/1KG_PRScs_ref/Irish_SCZ_All \
--sst_file=/home/ahangarim/genomicSEM/genomicSEM_PGC/LeaveNoutGWAS_by_subtraction/results/All_nonSCZ_MDD.assoc  \
--n_gwas=461356 \
--phi=1e-2 \
--chrom $i \
--out_dir=/home/projects/IrishGWAS/working/Analyses/PRS/PRScs/weights/GWAS_by_subtraction/nonSCZ_MDD_chr$i
done



date
## SCZ factor in MDD
for i in {1..22}
do

/home/ahangarim/Util/anaconda3/anaconda3/bin/python3.7 /home/ahangarim/Util/PRScs/PRScs/PRScs.py \
--ref_dir=/home/projects/rileyNGS/Refs/1KG_PRScs_ref/ldblk_1kg_eur \
--bim_prefix=/home/projects/rileyNGS/Refs/1KG_PRScs_ref/Irish_SCZ_All \
--sst_file=/home/ahangarim/genomicSEM/genomicSEM_PGC/LeaveNoutGWAS_by_subtraction/results/All_SCZ_MDD.assoc  \
--n_gwas=149644 \
--phi=1e-2 \
--chrom $i \
--out_dir=/home/projects/IrishGWAS/working/Analyses/PRS/PRScs/weights/GWAS_by_subtraction/SCZ_MDD_chr$i
done

date


### LDL 

for i in {1..22}
do

/home/ahangarim/Util/anaconda3/anaconda3/bin/python3.7 /home/ahangarim/Util/PRScs/PRScs/PRScs.py \
--ref_dir=/home/projects/rileyNGS/Refs/1KG_PRScs_ref/ldblk_1kg_eur \
--bim_prefix=/home/projects/rileyNGS/Refs/1KG_PRScs_ref/Irish_SCZ_All \
--sst_file=/home/projects/rileyNGS/Refs/summary_stats/PRScs_prep/LDL_ENGAGE.assoc \
--n_gwas=62166 \
--chrom $i \
--out_dir=/home/projects/IrishGWAS/working/Analyses/PRS/PRScs/weights/LDL_ENGAGE/LDL_ENGAGE_chr$i
done

date

