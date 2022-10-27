#!/bin/bash

# Every experiment runs for 30s
# The max prime increases logarithmically
# Number of threads can increase from 1 to #physical CPU cores

for j in seqrd rndwr rndrd
do
  echo -e "\tIO Operation: $j"
  sysbench --num-threads=16 --test=fileio --file-num=20 --file-io-mode=async --file-total-size=128G --file-test-mode=$j --time=30 prepare
  for i in {1..32..1}
  do
    echo "Number of threads: $i"
	  sysbench --num-threads="$i" --test=fileio --file-num=20 --file-io-mode=async --file-total-size=128G --file-test-mode=$j --time=30 run >> "bareMetalOutputs_async/results_${i}_${j}.txt"
  done
	sysbench --num-threads=16 --test=fileio --file-num=20 --file-io-mode=async --file-total-size=128G --file-test-mode=$j --time=30 cleanup 
done
