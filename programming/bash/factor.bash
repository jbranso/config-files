#!/bin/bash

counter=1
while [ $counter -lt 100 ]
do
    echo $(factor $counter)
    let counter+=1
done
