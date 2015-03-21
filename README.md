# Getting_and_Cleaning_Data
Class Project for **Getting &amp; Cleaning Data** class - *Coursera getdata-012*
Use the **run_analysis()** script to transform the Smartphone data into a tidy format. 
- The data should be located in the **UCI HAR Dataset** folder in the working directory. 
- The script produces two text files, "data.txt" and "averages.txt.". The "data.txt" file contains the whole data set (with columns containing "mean()" or "std()" in their name only.
  - The script first loads the data using the load_data() function. to load the data, filter the columns, and combine the test and train data into one data frame. It utilizes the load_type_data() function, which reads the subjects_xxx.txt file, the activity data in the y_xxx.txt file, and the recorded data in the X_xxx. file.
  - Next the script labels the activities with descriptive names in the name_activities() function. The activities are read from the activity_labels.txt file.
  - Then the script creates a summary of the data by calculating the averages of the recorded data for each features by avtivity and subject. This is done in the create_summary() function. This function uses the simplify_summary() and the simplify_subject_list_element() functions to tidy up the transformed data. The function also sorts the average data by activity and subject
  - Lastly the run_analysis() script write the two data frames to their respective files.
