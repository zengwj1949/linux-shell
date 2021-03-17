#!/bin/bash
# Format: UserParameter=key,shell/command;

set -e

Uptime () {
	mysqladmin extended-status | grep -w "Uptime" | awk '{print $4}'	
}

Questions () {
	mysqladmin extended-status | grep -w "Questions" | awk '{print $4}'
}

Threads_connected () {
	mysqladmin extended-status | grep -w "Threads_connected" | awk '{print $4}'
}

Com_select () {
	mysqladmin extended-status | grep -w "Com_select" | awk '{print $4}'
}

Com_commit () {
	mysqladmin extended-status | grep -w "Com_commit" | awk '{print $4}'
}

Com_rollback () {
	mysqladmin extended-status | grep -w "Com_rollback" | awk '{print $4}'
}

Slow_queries () {
	mysqladmin extended-status | grep -w "Slow_queries" | awk '{print $4}'
}

$1
