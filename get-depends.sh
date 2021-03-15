#!/bin/bash

declare -A map

function isExist()
{
	for key in ${!map[*]};do
		if [ $key == $1 ]; then
			echo 1
			return 
		fi
	done
	echo 0
}

logfile=./log
function getDepends()
{
	ret=`apt-cache depends $1 | grep 依赖 | cut -d : -f2 | tr -d "<>"`
	for line in $ret
	do
		if [ "0" == `isExist $line` ]; then
			echo $line >> $logfile
			map[$line]=$line
			getDepends $line
		fi
	done
}


getDepends $1


