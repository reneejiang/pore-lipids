#pore-lipids add MATLAB codes for classifications of atoms and beads inside pore region

In this github, it contains 3 main folder.

Folder fep-3lipid-pore/  includes the final data of FEP/REMD simulations, which the acceptance ratio, uncorrelated samples and FEP time series data.

Folder matlab_code/ includes the in-house MATLAB codes to calculate the number of atoms in each region of the pore (upper, chockpoint, and lower regions). 
The aa_fep_pore.csv file is the pore alpha carbon atom location for classifying the 3 regions of the pore and used as the boundary to classify as inside or outside pore.
Inside this folder, la0/ is taken as the example folder for testing the matlab codes. la0 folder has subdirectory of po4_dir, wat_dir, tail_dir, which are generated from gromacs function "gmx select" to find each type of atoms within 10A of the pore helix. Given the input files from la0 folder, one should be able to run these matlab codes. 
The matlab code "inpolyhedron" is cited from "Sven. 2021. Inpolyhedron- are points inside a triangulated volume?"

Folder MD_FEP_inputs/ includes the two subdirectories which are FEP_inputs and MD_brute_inputs. For the FEP harmonical restraints, we run the brute simulation first to get the estimated upper boundaries of our FEP_inputs, which sets the force constant=0 in brute simulations. The detailed settting of our restrains are located in the subfolders called "inputfiles/", the example_distance_restraint.namd.col, and example_rmsd_restraint.namd.col are also shown as reference for readers to use in the future.

the python2 script plot_3lipids_system.ipynb is used the show the FEP related data posted in the paper.

