### these scripts were run on PBS HPC

#!/bin/bash
#PBS -q serial
#PBS -N ptdt
#PBS -V 
#PBS -S /bin/bash 
#PBS -l nodes=1:ppn=5
#PBS -o /home/ahangarim/ptdt/logfile.log
#PBS -e /home/ahangarim/ptdt/error.err

cd $PBS_O_WORKDIR

date
## ptdt for BIP
python /home/ahangarim/Util/ptdt/ptdt.py \
--prs /home/ahangarim/ptdt/bip/prs_file_bip \
--structure /home/ahangarim/ptdt/bip/structure_file \
--print \
--out /home/ahangarim/ptdt/bip/bip

date
## ptdt for leave-N-out SCZ
python /home/ahangarim/Util/ptdt/ptdt.py \
--prs /home/ahangarim/ptdt/scz/prs_file_scz \
--structure /home/ahangarim/ptdt/scz/structure_file \
--print \
--out /home/ahangarim/ptdt/scz/scz

date
## ptdt for MDD
python /home/ahangarim/Util/ptdt/ptdt.py \
--prs /home/ahangarim/ptdt/mdd/prs_file_mdd \
--structure /home/ahangarim/ptdt/mdd/structure_file \
--print \
--out /home/ahangarim/ptdt/mdd/mdd

date
## ptdt for LDL
python /home/ahangarim/Util/ptdt/ptdt.py \
--prs /home/ahangarim/ptdt/ldl/prs_file_ldl \
--structure /home/ahangarim/ldl/ldl/structure_file \
--print \
--out /home/ahangarim/ptdt/ldl/ldl

date
## ptdt for SCZ factor in BIP
python /home/ahangarim/Util/ptdt/ptdt.py \
--prs /home/ahangarim/ptdt/sczbip/prs_file_sczbip \
--structure /home/ahangarim/ptdt/sczbip/structure_file \
--print \
--out /home/ahangarim/ptdt/sczbip/sczbip

date
## ptdt for nonSCZ factor in BIP
python /home/ahangarim/Util/ptdt/ptdt.py \
--prs /home/ahangarim/ptdt/nonsczbip/prs_file_nonsczbip \
--structure /home/ahangarim/ptdt/nonsczbip/structure_file \
--print \
--out /home/ahangarim/ptdt/nonsczbip/nonsczbip

date
## ptdt for SCZ factor in MDD
python /home/ahangarim/Util/ptdt/ptdt.py \
--prs /home/ahangarim/ptdt/sczmdd/prs_file_sczmdd \
--structure /home/ahangarim/ptdt/sczmdd/structure_file \
--print \
--out /home/ahangarim/ptdt/sczmdd/sczmdd

date
## ptdt for nonSCZ factor in MDD
python /home/ahangarim/Util/ptdt/ptdt.py \
--prs /home/ahangarim/ptdt/nonsczmdd/prs_file_nonsczmdd \
--structure /home/ahangarim/ptdt/nonsczmdd/structure_file \
--print \
--out /home/ahangarim/ptdt/nonsczmdd/nonsczmdd




