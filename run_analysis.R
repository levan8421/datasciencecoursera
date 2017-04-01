library(dplyr)
library(readr)

### Reading activities and measurement
activity <- read.table("./activity_labels.txt", header = FALSE)
measurement <- read.table("./features.txt", header = FALSE)


### Reading training data
train_data <- read.table("./train/X_train.txt", header = FALSE)

train_activity <- read.table("./train/y_train.txt", header = FALSE)
colnames(train_activity) <- "Activity"

train_subject <- read.table("./train/subject_train.txt", header = FALSE)
colnames(train_subject) <- "Subject"

train_body_acc_x <- read.table("./train/Inertial Signals/body_acc_x_train.txt", header = FALSE)
train_body_acc_y <- read.table("./train/Inertial Signals/body_acc_y_train.txt", header = FALSE)
train_body_acc_z <- read.table("./train/Inertial Signals/body_acc_z_train.txt", header = FALSE)

train_body_gyro_x <- read.table("./train/Inertial Signals/body_gyro_x_train.txt", header = FALSE)
train_body_gyro_y <- read.table("./train/Inertial Signals/body_gyro_y_train.txt", header = FALSE)
train_body_gyro_z <- read.table("./train/Inertial Signals/body_gyro_z_train.txt", header = FALSE)

train_total_acc_x <- read.table("./train/Inertial Signals/total_acc_x_train.txt", header = FALSE)
train_total_acc_y <- read.table("./train/Inertial Signals/total_acc_y_train.txt", header = FALSE)
train_total_acc_z <- read.table("./train/Inertial Signals/total_acc_z_train.txt", header = FALSE)


### Reading testing data
test_data <- read.table("./test/X_test.txt", header = FALSE)

test_activity <- read.table("./test/y_test.txt", header = FALSE)
colnames(test_activity) <- "Activity"

test_subject <- read.table("./test/subject_test.txt", header = FALSE)
colnames(test_subject) <- "Subject"

test_body_acc_x <- read.table("./test/Inertial Signals/body_acc_x_test.txt", header = FALSE)
test_body_acc_y <- read.table("./test/Inertial Signals/body_acc_y_test.txt", header = FALSE)
test_body_acc_z <- read.table("./test/Inertial Signals/body_acc_z_test.txt", header = FALSE)

test_body_gyro_x <- read.table("./test/Inertial Signals/body_gyro_x_test.txt", header = FALSE)
test_body_gyro_y <- read.table("./test/Inertial Signals/body_gyro_y_test.txt", header = FALSE)
test_body_gyro_z <- read.table("./test/Inertial Signals/body_gyro_z_test.txt", header = FALSE)

test_total_acc_x <- read.table("./test/Inertial Signals/total_acc_x_test.txt", header = FALSE)
test_total_acc_y <- read.table("./test/Inertial Signals/total_acc_y_test.txt", header = FALSE)
test_total_acc_z <- read.table("./test/Inertial Signals/total_acc_z_test.txt", header = FALSE)


### Request #1: Merging train data and test data
merged_data <- rbind(train_data, test_data)
merge_activity <- rbind(train_activity, test_activity)
merge_subject <- rbind(train_subject, test_subject)

merged_body_acc_x <- rbind(train_body_acc_x, test_body_acc_x)
merged_body_acc_y <- rbind(train_body_acc_y, test_body_acc_y)
merged_body_acc_z <- rbind(train_body_acc_z, test_body_acc_z)

merged_body_gyro_x <- rbind(train_body_gyro_x, test_body_gyro_x)
merged_body_gyro_y <- rbind(train_body_gyro_x, test_body_gyro_y)
merged_body_gyro_z <- rbind(train_body_gyro_x, test_body_gyro_z)

merged_total_acc_x <- rbind(train_total_acc_x, test_total_acc_x)
merged_total_acc_y <- rbind(train_total_acc_x, test_total_acc_y)
merged_total_acc_z <- rbind(train_total_acc_x, test_total_acc_z)


### Merging with subject and activity
merged_data <- cbind(merge_subject, merge_activity, merged_data)

merged_body_acc_x <- cbind(merge_subject, merge_activity, merged_body_acc_x)
merged_body_acc_y <- cbind(merge_subject, merge_activity, merged_body_acc_y)
merged_body_acc_z <- cbind(merge_subject, merge_activity, merged_body_acc_z)

merged_body_gyro_x <- cbind(merge_subject, merge_activity, merged_body_gyro_x)
merged_body_gyro_y <- cbind(merge_subject, merge_activity, merged_body_gyro_y)
merged_body_gyro_z <- cbind(merge_subject, merge_activity, merged_body_gyro_z)

merged_total_acc_x <- cbind(merge_subject, merge_activity, merged_total_acc_x)
merged_total_acc_y <- cbind(merge_subject, merge_activity, merged_total_acc_y)
merged_total_acc_z <- cbind(merge_subject, merge_activity, merged_total_acc_z)


### Ordering subject and activity
merged_data <- merged_data %>% arrange(Subject, Activity)

merged_body_acc_x <- merged_body_acc_x %>% arrange(Subject, Activity)
merged_body_acc_y <- merged_body_acc_y %>% arrange(Subject, Activity)
merged_body_acc_z <- merged_body_acc_z %>% arrange(Subject, Activity)

merged_body_gyro_x <- merged_body_gyro_x %>% arrange(Subject, Activity)
merged_body_gyro_y <- merged_body_gyro_y %>% arrange(Subject, Activity)
merged_body_gyro_z <- merged_body_gyro_z %>% arrange(Subject, Activity)

merged_total_acc_x <- merged_total_acc_x %>% arrange(Subject, Activity)
merged_total_acc_y <- merged_total_acc_y %>% arrange(Subject, Activity)
merged_total_acc_z <- merged_total_acc_z %>% arrange(Subject, Activity)


### Request #2: Extracting mean and std values of data set
extracted_ind <- grep(".mean.|.std.", measurement$V2)
extracted_data <- merged_data %>% select(Subject, Activity, extracted_ind+2)


### Request #3: Using descriptive activity names to name the activities in the data set
colnames(activity) <- c("Activity", "Activity_Str")
converted_data <- merge(extracted_data, activity, by = "Activity")
converted_data <- converted_data %>% 
                  mutate(Activity=Activity_Str) %>% 
                  select(Subject, Activity, V1:V552, -Activity_Str) %>%
                  arrange(Subject)
                  

### Request #4: Renaming data set with descriptive variable names
col_of_interest <- names(converted_data)[3:length(converted_data)]
var_names <- measurement[parse_number(col_of_interest), "V2"]
names(converted_data)[3:length(converted_data)] <- as.character(var_names)


### Request #5: Creating a second, independent tidy data set with the average of each variable 
### for each activity and each subject.
mean_grouped_data <-  converted_data %>% group_by(Subject, Activity) %>% summarize_each(funs(mean))
write.table(mean_grouped_data, "./tidy_data_set.txt", row.name=FALSE)
