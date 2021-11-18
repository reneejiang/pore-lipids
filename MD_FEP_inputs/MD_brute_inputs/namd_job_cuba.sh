#!/bin/bash
#SBATCH -D /home/wenjuan/work/protein/Piezo/porehelix_cg_aa/revesedMap/namd/fep_pore
#SBATCH -J revsAA
#SBATCH --partition=gpus
#SBATCH --get-user-env
#SBATCH --nodes=1
#SBATCH --mail-type=ALL
#SBATCH --tasks-per-node=4
#SBATCH --gres=gpu:4
#SBATCH --time=300:00:00

source /etc/profile.d/modules.sh
srun hostname -s | sort -u >slurm.hosts

CUDA_HOME=/cm/shared/apps/cuda70/toolkit/current
export NAMD_HOME=/home/namkim/NAMD-GPU/bin
export PATH=$CUDA_HOME/bin:$NAMD_HOME:$PATH
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$NAMD_HOME:$LD_LIBRARY_PATH

cd /home/wenjuan/work/protein/Piezo/porehelix_cg_aa/revesedMap/namd/fep_pore


/shared2/work/lyna/NAMD_Git-2019-04-22_Linux-x86_64-multicore-CUDA/charmrun +p16 /shared2/work/lyna/NAMD_Git-2019-04-22_Linux-x86_64-multicore-CUDA/namd2 +idlepoll brute.inp >& brute.log

rm -f slurm.hosts


