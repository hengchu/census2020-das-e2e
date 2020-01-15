#!/bin/bash

set -e

DATA_DIR=

function usage() {
    echo 'docker.sh -d <data_directory>'
}

while getopts ":d:" opt; do
    case ${opt} in
        d ) DATA_DIR=$OPTARG
            ;;
        \? ) usage
             exit 1
             ;;
    esac
done

if [ ! -d "$DATA_DIR" ]; then
    echo "Data Directory ${DATA_DIR} does not exist!"
    exit 1
fi

DATA_DIR_ABS=`realpath ${DATA_DIR}`

docker run --pid=host -it --rm -v $DATA_DIR_ABS:/home/root/das_files/ census
