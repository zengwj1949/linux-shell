#!/bin/bash
if [ -e $HOME ]
then
	echo "The object is exists.is it a file?"
	if [ -f $HOME ]
	then
		echo "Yes,It is a file."
	else
		echo "No,It not is a file."
		if [ -f $HOME/.bash_history ]
		then
			echo "But this is a file!"
		fi
	fi
else
	echo "Sorry,the object does not exist."
fi 	
