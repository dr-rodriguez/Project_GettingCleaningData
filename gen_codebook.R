# Quick script to generate the variable list for the CodeBook.md file

maintxt <- '## List of Variables\n\n'

# Loop through each variable in alldata3
# Process each variable name creating a short 
# description of it (based on features_info.txt)
# Paste the name and the description for all variables 
# together and output to a file

# ====================================================================
# Function to process the variable names
desc_name <- function(x) {
    fulltxt <- 'Average of the ' # since all variables are averages across subject/activity
    
    # Check if mean or std
    txt0 <- if(grepl('_Std',x,fixed=T)) 
        'standard deviation ' else 'mean '
    txt0 <- paste0(txt0, 'measurement of the ')
    
    # Check if FFT or not
    txt1 <- if(grepl('^f',x)) 
        'Fourier transform of the ' else ''
    
    # Check for relevant strings to construct parts of the final string
    txt2 <- if(grepl('Jerk',x)) {
        'jerk of the '
    } else if(grepl('Mag',x)) {
        'magnitude of the '
    } else ''
    
    stype <- if(grepl('BodyBody',x)) {
        'body-body'
    } else if(grepl('Gravity',x)) {
        'gravity'
    } else if(grepl('Body',x)) {
        'body'
    } else ''
    mtype <- if(grepl('Acc',x)) {
        'accelerometer'
    } else if(grepl('Gyro',x)) {
        'gyroscope'
    } else ''
    txt3 <- paste('signal from the',stype, mtype)
    
    # Closing string (check the end of the string)
    txt4 <- if(grepl('_X$',x)) {
        ' in the X direction.'
    } else if(grepl('_Y$',x)) {
        ' in the Y direction.'
    } else if(grepl('_Z$',x)) {
        ' in the Z direction.'
    } else '.'
    
    
    fulltxt <- paste0(fulltxt, txt0, txt1, txt2, txt3, txt4)
}

# ====================================================================
# Loop through all the variable names and process them
cnames <- names(alldata3)
for(i in seq_along(cnames)) {
    
    # A line for the variable name
    maintxt <- paste0(maintxt, '### ', cnames[i], '\n')
    
    # Another line for descriptive statements
    
    # If activity
    if(grepl('activity', cnames[i])) {
        txt1 <- 'Type of activity: LAYING, SITTING, STANDING, WALKING, '
        txt1 <- paste0(txt1, 'WALKING_DOWNSTAIRS, WALKING_UPSTAIRS')
    } else if(grepl('subject', cnames[i])) 
        txt1 <- 'Subject identifier'
      else {
          txt1 <- desc_name(cnames[i])
          units <- if(grepl('Gyro',cnames[i])) {
              'radians/sec'
          } else 'g'
          txt1 <- paste0(txt1, '\n\nUnits: ', units)
      }
        
    
    # Add the information to the main text
    maintxt <- paste0(maintxt, txt1, '\n\n')
    txt1 <- '' # Reset value of descriptive text
    
}

# ====================================================================
# Output to the md file
cat(maintxt, file='CodeBook.md')