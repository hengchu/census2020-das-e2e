#!/bin/bash

set -e

DATA_DIR=
IMAGE=census

function usage() {
    echo 'docker.sh -d <data_directory> [-i <image-name>]'
}

while getopts ":d:i:" opt; do
    case ${opt} in
        d ) DATA_DIR=$OPTARG
            ;;
        i ) IMAGE=$OPTARG
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

docker run --pid=host --mac-address="02:42:AC:11:00:02" -it --rm -v $DATA_DIR_ABS:/home/root/das_files/ ${IMAGE}
