#!/bin/bash
echo  "================================================================"
echo  " _____  _____ _____            _____             _              "
echo  "|  __ \|  __ \_   _|          |  __ \           | |             "
echo  "| |__) | |  | || |    ______  | |  | | ___   ___| | _____ _ __  "
echo  "|  ___/| |  | || |   |______| | |  | |/ _ \ / __| |/ / _ \ '__| "
echo  "| |    | |__| || |_           | |__| | (_) | (__|   <  __/ |    "
echo  "|_|    |_____/_____|          |_____/ \___/ \___|_|\_\___|_|    "
echo  "                                                                "
echo  "================================================================"

# Settings
#repo?

# Args
src=$1 # get url
obj=$2
para=$3
data=$3 # get mount point
ext="${obj:(-4)}" # get extension

# Vars
etl=/tmp/etl
space=" "

# Get etl
mkdir -p $etl
ssh-keyscan -H github.com >> ~/.ssh/known_hosts # this is bad practice
git clone $src $etl

echo $etl/$obj$space$para

if [ $ext == .ktr ]; then # transformation
        sh ./pan.sh -file=$etl/$obj$space$para -norepo
elif [ $ext == .kjb ]; then # job
        sh ./kitchen.sh -file=$etl/$obj$space$para -norepo
fi
