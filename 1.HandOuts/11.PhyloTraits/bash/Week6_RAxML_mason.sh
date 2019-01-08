#!/bin/bash
#PBS -k o
#PBS -l nodes=2:ppn=8,vmem=100gb,walltime=120:00:00
#PBS -M wrshoema@indiana.edu
#PBS -m abe
#PBS -j oe

module load raxml/8.0.26

# cd into the directory with your alignment

raxmlHPC-PTHREADS -T 4 -f a -m GTRGAMMA -p 12345 -x 12345 -o Methanosarcina -# autoMRE -s ./p.isolates.afa -n T1