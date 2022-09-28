#!/bin/bash
##############################################################
# Usage ( * = optional ):                                    #
# ./script.sh <db-uri> *<username> *<password> #
##############################################################

if [ ! -z "$2" ]; then
    if [ ! -z "$3" ]; then
        echo "Using password authentication!"
        auth="--authenticationDatabase admin -u $2 -p $3"
    fi
fi

for coll in *; do
    if [ -d "${coll}" ] ; then
        echo "$coll"
        for file in $coll/*; do
            mongoimport --drop --uri "$1" --db "$coll" --collection "$(basename $file .json)" --file $file $auth
            #echo "$(basename $file .json)"
            #echo "$file"
        done
    fi
done
