# tidydata
Code for Course Project of getting and cleaning data

The first slab of code downloads the data from the link and unzips the files present in the downloaded file.

The next slab of the code deals with reading files from the downloaded files. Firstly the features.txt file is read which contains the variable names of all the data and activity and subject names are also added to the vector of variables.

To read the data from test x_test.txt with values,  y_test.txt with activity data and subject_test.txt with subject values are read separately and column binded to a single data frame. The column names are then set to vector of variables extracted before. A similar procedure is undertaken for train data and another data frame is created. The combined data frame is created by row binding both the above data frames.

The next slab of code deals with subsetting the columns only with mean and standard deviations. A vector is created which contains only the variables which have mean or std in their names. To this activity and subject are added again. These variables are sorted on the basis of numbers before them and these are only subsetted into final data. They are then arranged in order of subject and activity.

The next slab of code deals with giving descriptive activity names. The activity_labels.txt file is read and converted to factor. It then replaces the activity numbers in data with labels.

In final computation of means for data first the number of unique subject and activities are taken. Then in a double nested loop the column means for all data is calculated and row binded to the answer data frame. The column names are given followed by descriptive activities. The columns are finally rearranged and the output is written.



