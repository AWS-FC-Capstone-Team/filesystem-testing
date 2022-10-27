#!/bin/bash

# echo "Begin async or sync Docker sysbench IO tests?[async/sync]"
# response="async"

# echo ""

# if [ "$response" == "async" ] 
# then
#     echo "------Beginning async Docker sysbench IO tests--------"
#     cd testFiles_async
#     bash runAllIOTestsDocker_async.sh
# elif [ "$response" == "sync" ]
# then
#     echo "------Beginning sync Docker sysbench IO tests--------"
#     cd testFiles_ssync
#     bash runAllIOTestsDocker_sync.sh
# else 
#     echo "invalid response"
# fi

echo "Sync tests"
for j in seqwr seqrd rndwr rndrd
do
  echo -e "\tIO Operation: $j"
  sysbench --num-threads=16 --test=fileio --file-num=20 --file-io-mode=sync --file-total-size=16G --file-test-mode=$j --time=30 prepare
  for i in {1..16..1}
  do
    echo "Number of threads: $i"
	  sysbench --num-threads="$i" --test=fileio --file-num=20 --file-io-mode=async --file-total-size=16G --file-test-mode=$j --time=30 run >> "/testFiles_sync/results_${i}_${j}_sync.txt"
  done
	sysbench --num-threads=16 --test=fileio --file-num=20 --file-io-mode=sync --file-total-size=16G --file-test-mode=$j --time=30 cleanup 
done


echo "Async tests"
for j in seqwr seqrd rndwr rndrd
do
  echo -e "\tIO Operation: $j"
  sysbench --num-threads=16 --test=fileio --file-num=20 --file-io-mode=async --file-total-size=16G --file-test-mode=$j --time=30 prepare
  for i in {1..16..1}
  do
    echo "Number of threads: $i"
	  sysbench --num-threads="$i" --test=fileio --file-num=20 --file-io-mode=async --file-total-size=16G --file-test-mode=$j --time=30 run >> "/testFiles_async/results_${i}_${j}_async.txt"
  done
	sysbench --num-threads=16 --test=fileio --file-num=20 --file-io-mode=async --file-total-size=16G --file-test-mode=$j --time=30 cleanup 
done