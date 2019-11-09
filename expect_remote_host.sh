#!/usr/bin/expect
set hostip "172.16.1.254"
set username "test"
set passwd "abc-123"

spawn ssh $username@$hostip
expect {
	"yes/no" { send "yes\r"; exp_continue }
	"password:" { send "$passwd\r" };
}

interact

