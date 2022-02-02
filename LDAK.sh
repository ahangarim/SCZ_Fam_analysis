##### these scripts are run on PBS HPC 


#!/bin/bash 
#PBS -q magma
#PBS -N LDAK
#PBS -V 
#PBS -S /bin/bash 
#PBS -l nodes=1:ppn=12
#PBS -o /home/ahangarim/kinship/LDAK/log_file.log
#PBS -e /home/ahangarim/kinship/LDAK/error_file.err

cd $PBS_O_WORKDIR 

date

/home/ahangarim/Util/LDAK/ldak5.1.linux \
--cut-weights /home/ahangarim/kinship/LDAK/weights/ \
--bfile /home/ahangarim/bgen/ALL_Irish/hardcall/All_Irish_binary_rel

date


/home/ahangarim/Util/LDAK/ldak5.1.linux \
--calc-weights-all /home/ahangarim/kinship/LDAK/weights/ \
--bfile /home/ahangarim/bgen/ALL_Irish/hardcall/All_Irish_binary_rel

date

/home/ahangarim/Util/LDAK/ldak5.1.linux \
--calc-kins-direct /home/ahangarim/kinship/LDAK/kinship_matrix/SCZ_All_kinship \
--bfile /home/ahangarim/bgen/ALL_Irish/hardcall/All_Irish_binary_rel \
--weights /home/ahangarim/kinship/LDAK/weights/weights.short --power -0.25 --kinship-raw YES

date

