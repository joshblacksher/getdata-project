#Project
This project is the final class project for the getdata class.  I will assume you know what that is if you are viewing this file.

#Files included
- README.md - this file
- CodeBook.md - describes the variables, the data, and the transformations performed to clean up the data
- run_analysis.R - contains the script to perform the analysis

#Reproduction environment
- R version 3.1.1
- RStudio verion 0.98.1091
- Windows version 8.1
- Internet access
- Sufficient computing memory, disk, and user privileges

#Steps to reproduce
1. copy the run_analysis.R file into the working directory
2. run the script as follows: *source("run_analysis.R"); run_analysis()*
3. in addition to the downloaded and unzipped data input files; the script produces 2 output files
    - total_sig.txt - final complete and tidy signal data set
    - summary_sig.txt - tidy summary of the means of each signal type by Action and Subject
