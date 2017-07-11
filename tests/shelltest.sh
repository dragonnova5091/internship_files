#!usr/bin/sh
#some tests
echo start

while read line; do 
	echo "$line"
	sleep 0.1
	
done <testfile.txt

echo "done"



if test $1 -gt 0 
then 
	echo "here"
	exit 1
fi


read

#cat testfile.txt 
