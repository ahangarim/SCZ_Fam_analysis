
## code used for h2 calculation. same code was used for other sumstats, we just switched the sumstats and output file. 

source /home/projects/rileyNGS/Util/anaconda/anaconda2/bin/activate ldsc

/home/projects/rileyNGS/Util/ldsc/ldsc/ldsc.py \
--h2 /home/ahangarim/munged/nonscz_bip.sumstats.gz \
--ref-ld-chr /home/projects/rileyNGS/Refs/ldsc/eur_w_ld_chr/ \
--w-ld-chr /home/projects/rileyNGS/Refs/ldsc/eur_w_ld_chr/ \
--out /home/ahangarim/genomicSEM/genomicSEM_PGC/h2/nonscz_bip

