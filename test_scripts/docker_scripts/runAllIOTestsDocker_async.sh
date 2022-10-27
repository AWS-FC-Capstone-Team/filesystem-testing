#!/bin/bash
echo "Sync tests"
for j in seqwr seqrd rndwr rndrd
do
  echo -e "\tIO Operation: $j"
  sysbench --num-threads=16 --test=fileio --file-num=20 --file-io-mode=sync --file-total-size=16G --file-test-mode=$j --time=30 prepare
  for i in {1..16..1}
  do
    echo "Number of threads: $i"
	  sysbench --num-threads="$i" --test=fileio --file-num=20 --file-io-mode=async --file-total-size=16G --file-test-mode=$j --time=30 run >> "results_${i}_${j}_sync.txt"
  done
	sysbench --num-threads=16 --test=fileio --file-num=20 --file-io-mode=sync --file-total-size=16G --file-test-mode=$j --time=30 cleanup 
done