#!/bin/bash
#set -x

export NTRIALS=${NTRIALS:-"60"}
export PERCENTILE=${PERCENTILE:-"90"}
export LATENCY=${LATENCY:-"5000"}
export MQPS=${MQPS:-"1500"}

for qps in ${MQPS}; do
    for percentile in ${PERCENTILE}; do
	for latency in ${LATENCY}; do
	    newdir="bayesopt_trials${NTRIALS}_qps${qps}_percentile${percentile}_latency${latency}"
	    echo $newdir
	    mkdir ${newdir}
	    python -u bayesopt.py --trials ${NTRIALS} --qps ${qps} --percentile ${percentile} --latency ${latency} > ${newdir}/"${newdir}.log"
	    mv *.bin ${newdir}
	    mv *.log ${newdir}
	    mv *.txt ${newdir}
	    
	    rsync --mkpath -avz ${newdir}/* don:/home/handong/cloudlab/xl170/img-dnn/linux_static/${newdir}/
	done
    done
done


# bayesopt_trials60_qps1500_percentile90_latency5000
# bayesopt_trials60_qps2000_percentile99_latency5000

#bayesopt_trials60_qps2500_percentile99_latency5000

# bayesopt_trials60_qps3000_percentile99_latency5000
