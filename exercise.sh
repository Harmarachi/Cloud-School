#!/bin/bash

#This project copies files from my downloads to document folder(for backup purposes) 
#If the file already exists in documents, It prompmts user to overwrite


# This is to define my downloads and documents folders
downloads="$HOME/Downloads"
documents="$HOME/Documents"

cd $downloads

for download in *
do
	BASENAME=$(basename $download)
	if [ -f "$downloads/$download" ]
	then
		CMD="upload "
		curl -X POST https://api.dropboxapi.com/2/files/create_folder_batch \
		--header "Authorization: Bearer " \
    		--header "Content-Type: application/json" \
    		--data "{\"paths\": [\"/Homework/math\"],\"autorename\": false,\"force_async\": false}"
		read -p "$download already exists here. Overwrite it? y/n: " answer
		case $answer in
			[yY])
				cp -r $download $documents
				;;
			[nN])
				echo "Skipping this file"
				continue
				;;
		esac
	else
		cp -r $download $documents
	fi

done
