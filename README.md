PeerGetData
===========

The code on run_analisys.R works by executing, in order, the following steps:

1) Read all the usefull data from the files provided (training and test data) to data frames

2) Change the names of columns in both data frames

3) Add to the main training and test files columns for subjects and y (activity)

4) Bind Testing and Training sets

5) Separates, the means and standard deviation columns of of summed data frame into a new one

6) Add to this new data frame columns for subject and y (activity)

7) Transform the "int" values of subjects into "strings", and applies the gsub function, so "1" becomes WALKING for all the 6.

8) With the aggregate function, generate the final data frame, with means for each subject and each acitivity.
