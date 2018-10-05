#!/usr/bin/env bash

# this script installs the linking workflow.

DATA_FOLDER='/home/jonas/linked/data'

if [ ! -d "$DATA_FOLDER" ]; then
    mkdir "$DATA_FOLDER"
fi

TEMP_FOLDER="$DATA_FOLDER/tmp"

if [ ! -d "$TEMP_FOLDER" ]; then
    mkdir "$TEMP_FOLDER"
fi

echo "Data directory: $DATA_FOLDER"

cd ..

LINKING_WORKING_DIRECTORY="$(pwd)/linking"

git clone https://github.com/linked-swissbib/linking_enrichment_environment.git "$LINKING_WORKING_DIRECTORY"

cd "$LINKING_WORKING_DIRECTORY"
echo "$DATA_FOLDER" > data_path.txt

LINKING_APPS_FOLDER="$LINKING_WORKING_DIRECTORY/apps"

wget -nc -P "$LINKING_APPS_FOLDER/LIMES" "https://github.com/dice-group/LIMES/releases/download/1.5.0/limes-core-1.5.0.jar"
wget -nc -P "$LINKING_APPS_FOLDER/reshaperdf" "https://github.com/linked-swissbib/reshaperdf/releases/download/v1.0.0/reshaperdf-1.0-SNAPSHOT-all.jar"
wget -nc -P "$LINKING_APPS_FOLDER/transform" "https://github.com/linked-swissbib/transformationtools/releases/download/v1.0.0/ntextract-1.0-SNAPSHOT-all.jar"
wget -nc -P "$LINKING_APPS_FOLDER/transform" "https://github.com/linked-swissbib/transformationtools/releases/download/v1.0.0/ntriples2jsonld-1.0-SNAPSHOT-all.jar"
wget -nc -P "$LINKING_APPS_FOLDER/transform" "https://github.com/linked-swissbib/transformationtools/releases/download/v1.0.0/rdfstats-1.0-SNAPSHOT-all.jar"
wget -nc -P "$LINKING_APPS_FOLDER/transform" "https://github.com/linked-swissbib/transformationtools/releases/download/v1.0.0/sparqlrequest-1.0-SNAPSHOT-all.jar"
wget -nc -P "$LINKING_APPS_FOLDER/transform" "https://github.com/linked-swissbib/transformationtools/releases/download/v1.0.0/splitfile-1.0-SNAPSHOT-all.jar"
wget -nc -P "$LINKING_APPS_FOLDER/transform" "https://github.com/linked-swissbib/transformationtools/releases/download/v1.0.0/unloadtriplestore-1.0-SNAPSHOT-all.jar"
wget -nc -P "$LINKING_APPS_FOLDER/genconfig" "https://github.com/linked-swissbib/genconfig/releases/download/v1.0.0/genconfig-1.0-SNAPSHOT-all.jar"









