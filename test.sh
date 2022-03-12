#!/bin/bash
filelocation=`bash -c "if [ -e 'getprop ro.product.vendor.model' ]; then echo 0; else echo 1; fi"`

echo "file location: $filelocation"
if [ "$filelocation" == "0" ]
then
{
        echo "Linux"
}
else
        echo "Android"
fi
