#!/bin/bash
filelocation=`bash -c "if [ $(ps -ef|grep -c com.termux ) -gt 0 ] ; then echo 0; else echo 1; fi"`

echo "file location: $filelocation"
if [ "$filelocation" == "0" ]
then
{
        echo "Linux"
}
else
        echo "Android"
fi
