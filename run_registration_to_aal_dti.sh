#!/bin/bash

for dirname in /workspace/mnt/data/pp-mm-mri/dwi/sub-*; do
    id=${dirname#/workspace/mnt/data/pp-mm-mri/dwi/sub-}
    id=${id%/}
    printf ${id}
    printf " "
    FA=/workspace/mnt/data/pp-mm-mri/dwi/sub-${id}/nodif_brain_mask.nii.gz
    output=/workspace/mnt/data/pp-mm-mri/dwi/sub-${id}/labels.nii
    mat=/workspace/mnt/data/pp-mm-mri/dwi/sub-${id}/TM.mat

    flirt -in AAL.nii -ref ${FA} -out ${output} -omat ${mat} -cost corratio -dof 12  -interp nearestneighbour
done     