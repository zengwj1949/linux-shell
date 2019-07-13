#!/bin/bash
# create users;

user_file=/data/tmp/user_file

[ -f ${user_file} ] || touch ${user_file}

for user in user{1..10}
do
	if ! id $user &> /dev/null
	then
		pass=$(echo $RANDOM | md5sum | cut -c 1-8) \
		&& useradd $user \
		&& echo "$pass" | passwd --stdin $user &> /dev/null \
	 	&& echo "$user: $pass" >> ${user_file} \
		&& echo "$user User create successful."
	else
		echo "$user User already exists!"
	fi
done	
