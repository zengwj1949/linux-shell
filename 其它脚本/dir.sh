#!/bin/bash
if [ -e $HOME ]
then
	echo "Ok,on the directory.now to check the file"
	# checking if a file exists
	if [ -e $HOME/testing ]
	then
		# the file exists.append data to it
		echo "Apping data to existing file"
 		date >> $HOME/testing
	else
		# the file does not exist.create a new filw.
		echo "Creating the file."
		date > $HOME/testing
	fi
else
	echo "Sorry,you do not have a HOME diretory."
fi
