#!/bin/bash

export PATH="$PATH:/bin/dtk/"
export DSI_PATH="/bin/dtk/matrices/" 

for dirname in /workspace/home/datasets/mri/schizo_datasets/COBRE/COBRE/sub-*; do
    id=${dirname#/workspace/home/datasets/mri/schizo_datasets/COBRE/COBRE/sub-}
    id=${id%/}
    printf ${id}
    printf " "

    data=/workspace/home/zubrikhina/datasets/COBRE_preproc_dti/sub-${id}/sub-${id}_dwi.nii_EC.nii.gz
    bvec=/workspace/home/zubrikhina/datasets/COBRE_preproc_dti/sub-${id}/sub-${id}_adjs.bvec
    bval=/workspace/home/zubrikhina/datasets/COBRE_preproc_dti/sub-${id}/sub-${id}_dwi.bval
    FA=/workspace/home/zubrikhina/datasets/COBRE_preproc_dti/sub-${id}/sub-${id}_mask.nii
    temp=/workspace/home/zubrikhina/datasets/COBRE_preproc_dti/sub-${id}/temp/
    output=/workspace/home/zubrikhina/datasets/COBRE_preproc_dti/sub-${id}/dtk/
    rm -R ${temp}
    mkdir -p ${temp}
    mkdir -p ${output}
    cp ${data} ${temp}

    ############ diffusion toolkit ###############################################################################################

    python -c "import sys; print('\n'.join(' '.join(c) for c in zip(*(l.split() for l in sys.stdin.readlines() if l.strip()))))" < ${bvec} > ${temp}/bvecs_4dt.bvec

    dti_recon ${data} ${output}/dti -gm ${temp}/bvecs_4dt.bvec -b 800 -b0 auto -no_eigen -no_exp -ot nii

    dti_tracker ${output}/dti ${output}/tract_tmp.trk -fact -at 60 -iy -m ${FA} 0.15 1 -it nii
    spline_filter ${output}/tract_tmp.trk 1 ${output}/dti_fact_tracts.trk
    rm ${output}/tract_tmp.trk

    # rm ${output}/*.dat
done    
