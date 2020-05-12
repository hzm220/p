We developed it based on the Lindel documentation (https://lindel.gs.washington.edu/Lindel/docs/). This Rshiny application should have the same results as Lindel. The input sequence also need to follow the introduction on the Lindel documentation: " It takes 65 bp sequence ( cleavage site at 30) as an input and predicts the frequencies for all possible deletions <30 bp, all 1-2 bp insertions, and insertions larger than 2 bp as a group."

1. command line install
 * pwd: /Users/Hui/CRISPRLindel

 Compatible with both Python2.7 and Python3.5 or higher.
 * create conda env: conda create -y --name r-cl python=3.6

 * conda info
 active environment : r-cl
 active env location : /Users/hui/opt/anaconda3/envs/r-cl
 shell level : 3
 user config file : /Users/Hui/.condarc
 populated config files : /Users/Hui/.condarc
 conda version : 4.8.3
 conda-build version : 3.18.11
 python version : 3.7.6.final.0

 * which conda:
 conda = "/Users/hui/opt/anaconda3/condabin/conda"

 * conda install : Requires biopython,numpy and scipy

 * Lidel install
 git clone https://github.com/shendurelab/Lindel.git
 cd Lindel
python setup.py install
python Lindel_prediction.py TAACGTTATCAACGCCTATATTAAAGCGACCGTCGGTTGAACTGCGTGGATCAATGCGTC test_seq

2. working in Rstudio
* prepare enviroment
library(reticulate)
Python
conda

* R_Lindel_prediction
Define rlindel function based on Lindel_prediction.py, with only one argument: inputseq, return the indels.

source_python("RLindelprediction.py")
RLindelprediction.py was modificated based on Lindel_prediction.py with the following changes:
add write_file
define rlp (r_lindel_prediction) function.
Replace sys.argv[1] with fucntion parameter inputseq.
Drop filename = sys.argv[2]
Replace print with return

3. Rshiny
an example sequence ( the same one as Lindel documentation "TAACGTTATCAACGCCTATATTAAAGCGACCGTCGGTTGAACTGCGTGGATCAATGCGTC")
can also be downloaded as a CSV file by clicking the download button.
 
4. install CRISPRseek
BiocManager::install("CRISPRseek")
browseVignettes("CRISPRseek")
