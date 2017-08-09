#!/bin/bash

# userContent.css for general modifications
cat ./userContent/_variables.css > userContent.css  # Variables

# Merge all userContent files, using their name as domain name
for style in $(ls -N ./userContent/[^_]*); do           # Get files except for Vars
    FILE=$(echo $style | cut -c 15-)                    # Remove "./userContent/"
    URL=$(echo $FILE | rev | cut -c 5- | rev)           # Remove ".css"
    echo "@-moz-document $URL {" >> userContent.css     # Add @-moz-document header
    cat ./userContent/"$URL".css >> userContent.css     # Add file content
    echo "}" >> userContent.css                         # Close @-moh-document header
done

# userChrome.css for modifying FF UI
cat ./userChrome/_variables.css > userChrome.css        # Vars and open @-moz-document
cat ./userChrome/[^_]* >> userChrome.css                # Merge all files
echo "}" >> userChrome.css                              # Close @-moz-document
