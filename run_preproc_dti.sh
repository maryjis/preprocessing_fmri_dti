#!/bin/bash

input_directory="/workspace/home/datasets/mri/schizo_datasets/COBRE/COBRE"
printf "Run FSL: $input_directory"

all_ids=()
for dirname in /workspace/home/datasets/mri/schizo_datasets/COBRE/COBRE/sub-*/ses-*/dwi/*1_dwi.nii.gz; do
    id=${dirname}
    id=${id%/}

    if [ ! -e "/output/fmriprep/subj_done/sub-$id.html" ]; then
        # no output file corresponding to this ID found,
        # add it to he list
        all_ids+=( "$id" )
    fi
done
#
#
printf 'Found ID: %s\n' "${all_ids[@]}"
#parallel --jobs 10 --delay 180  --timeout 300% --progress --joblog /output/preprocessing.txt eddy_correct {1} 3101_EC 0   ::: ${all_ids[@]} & wait $!
#parallel --jobs 10  --delay 30 --progress --joblog preprocessing.txt eddy_correct  {1} /workspace/home/datasets/mri/schizo_datasets/COBRE/COBRE_preproc_dti/{/.}_EC  0 ::: ${all_ids[@]}$!
parallel --jobs 10  --delay 30 --progress --joblog preprocessing.txt bet  {1} /workspace/home/datasets/mri/schizo_datasets/COBRE/COBRE_preproc_dti/{/.}_brain  -m -n -f 0.2 ::: ${all_ids[@]} $!
#echo "DTI preprocessing - done"
#
#
#find /tmp -mindepth 1 -delete
#echo "Temp files cleared"