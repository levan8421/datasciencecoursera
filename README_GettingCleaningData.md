## The script is run by following the steps as explained in the comments as:
### Step 1: Reading all the text file, including activity labels, measurement features, training data, and testing data
### Step 2: Merging training data and testing data of each categories together, such as measurement data set, body_acc_x, body_gyro_x, total_acc_x, etc.
        Merging subjects and activities with the merged data sets.
        Ordering the merged data sets according to subject and activity.
### Step 3: Extracting the mean and std measurement of measurement data set.
### Step 4: Using descriptive activity names to name the activities in the measurement data set by looking up activity code of measurement data set with activity labels
### Step 5: Renaming data set with descriptive variable names by using appropriate measurement features
### Step 6: Creating a second, independent tidy data set with the average of each variable for each activity and each subject.
