# Connectivity matrices  for functional MRI and diffusion MRI data
In this repo I have provided several notebooks for building connectivity matrices  for functional MRI and diffusion MRI data.


1) extract_connectivity_matrices_v1.ipynb - notebook for extracting connectivity matrices based on desikan killiany atlas using structural regions extracted from FreeSurfer and fmri data preproccessed with fmriprep
2) extract_connectivity_matrices_v2.ipynb - notebook for extracting connectivity matrices based on schaefer atlas and fmri data preproccessed with fmriprep
3) dti_tractography_cobre.ipynb - building structural connectivity matrices based on desikan killiany atlas using structural regions extracted from FreeSurfer and dti data. DTI data was preproceed using my script run_preproc_dti.sh or you can use this repo (BrainGB: https://braingb.us/preprocessing/)
4) run_preproc_dti.sh - preproccesing DTI
   steps: bet ->  remove non-brain tissue parts of the image
    if you want to add eddy-correction uncomment this line in the script

