#!/bin/bash

cat variables.css > ~/.mozilla/firefox/*/chrome/userContent.css
cat variables.css > ~/.mozilla/firefox/*/chrome/userChrome.css

cat userContent/* >> ~/.mozilla/firefox/*/chrome/userContent.css
cat userChrome/* >> ~/.mozilla/firefox/*/chrome/userChrome.css
