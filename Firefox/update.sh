#!/bin/bash

# Use some black magic to get profile name from profiles.ini
# If you do not want to use the default profile, replace this with your profile name
PROFILE_NAME=$(cat $HOME/.mozilla/firefox/profiles.ini | tr -d "\n" | sed 's/.*Path=\(.*\)Default=1.*/\1/g')

# Create "chrome" dir if it does not exist
if [ ! -d "$HOME/.mozilla/firefox/$PROFILE_NAME/chrome" ];then
    mkdir "$HOME/.mozilla/firefox/$PROFILE_NAME/chrome"
fi

# Locations of the userChrome.css and userContent.css files
USERCHROME_PATH="$HOME/.mozilla/firefox/$PROFILE_NAME/chrome/userChrome.css"
USERCONTENT_PATH="$HOME/.mozilla/firefox/$PROFILE_NAME/chrome/userContent.css"


### USERCONTENT for general modifications
cat ./userContent/_variables.css > $USERCONTENT_PATH    # Variables

# Merge all userContent files, using their name as domain name
for style in $(ls -N ./userContent/[^_]*); do           # Get files except for Vars
    FILE=$(echo $style | cut -c 15-)                    # Remove "./userContent/"
    URL=$(echo $FILE | rev | cut -c 5- | rev)           # Remove ".css"
    echo "@-moz-document $URL {" >> $USERCONTENT_PATH   # Add @-moz-document header
    cat ./userContent/"$URL".css >> $USERCONTENT_PATH   # Add file content
    echo "}" >> $USERCONTENT_PATH                       # Close @-moh-document header
done


### USERCHROME for modifying FF UI
cat ./userChrome/_variables.css > $USERCHROME_PATH      # Vars and open @-moz-document
cat ./userChrome/[^_]* >> $USERCHROME_PATH              # Merge all files
echo "}" >> $USERCHROME_PATH                            # Close @-moz-document
