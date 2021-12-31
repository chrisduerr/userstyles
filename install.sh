#!/bin/bash

cat variables.css | tee ~/.mozilla/firefox/*/chrome/userContent.css > /dev/null
cat variables.css | tee ~/.mozilla/firefox/*/chrome/userChrome.css > /dev/null

cat userContent/* | tee -a ~/.mozilla/firefox/*/chrome/userContent.css > /dev/null
cat userChrome/* | tee -a ~/.mozilla/firefox/*/chrome/userChrome.css > /dev/null
