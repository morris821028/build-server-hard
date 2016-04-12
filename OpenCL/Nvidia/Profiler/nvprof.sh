#!/bin/bash

COMPUTE_PROFILE=1 COMPUTE_PROFILE_CONFIG=nvvp.cfg $@

find . -name 'opencl_profile*.log' | while read LOGFILE;
do
	TARGET=${LOGFILE//opencl/cuda};
	LOGLINE=$(wc -l < "$LOGFILE");
	if [ "$LOGLINE" -gt "7" ]
	then
		sed -e 's/OPENCL_/CUDA_/g' \
			-e 's/ndrange/grid/g' \
			-e 's/workitem/thread/g' \
			-e 's/workgroupsize/threadblocksize/g' \
			-e 's/stapmemperworkgroup/stasmemperblock/g' \
			$LOGFILE > $TARGET;
	fi;
done;

cat cuda_profile_*.log > nvvp.log
rm cuda_profile_*.log opencl_profile*.log
