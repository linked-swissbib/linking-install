#!/usr/bin/env bash

# this script installs the linking workflow.

if [ `whoami` == jonas ]; then
    BASE_DATA_PATH='/home/jonas/linked/data'
elif [ `whoami` == swissbib ]; then
    BASE_DATA_PATH='/swissbib_index/data'
else
    echo "Unknown user! Specifiy base data path for this user!"
fi

LINKED_SOURCE_DATA_FOLDER="$BASE_DATA_PATH/enrichedLineInput"
LINKED_TARGET_DATA_FOLDER="$BASE_DATA_PATH/enrichedLineOutput"
LINKED_TMP_DATA_FOLDER="$LINKED_TARGET_DATA_FOLDER/tmp"
LINKED_DBPEDIA_DATA_FOLDER="$LINKED_TARGET_DATA_FOLDER/dbpedia"
LINKED_VIAF_DATA_FOLDER="$LINKED_TARGET_DATA_FOLDER/viaf"
LINKED_LOGGING="$LINKED_TARGET_DATA_FOLDER/logs"

if [ ! -d "$LINKED_SOURCE_DATA_FOLDER" ]; then
    echo "Could not find source folder at $LINKED_SOURCE_DATA_FOLDER! Please specify a source folder."
    exit 1
fi

if [ ! -d "$LINKED_TARGET_DATA_FOLDER" ]; then
    mkdir "$LINKED_TARGET_DATA_FOLDER"
fi

if [ ! -d "$LINKED_TMP_DATA_FOLDER" ]; then
    mkdir "$LINKED_TMP_DATA_FOLDER"
fi

if [ ! -d "$LINKED_DBPEDIA_DATA_FOLDER" ]; then
    mkdir "$LINKED_DBPEDIA_DATA_FOLDER"
fi

if [ ! -d "$LINKED_VIAF_DATA_FOLDER" ]; then
    mkdir "$LINKED_VIAF_DATA_FOLDER"
fi

if [ ! -d "$LINKED_LOGGING" ]; then
    mkdir "$LINKED_LOGGING"
fi

RESHAPERDF_SCRIPT="$(pwd)/reshaperdf"

cd ..

LINKING_WORKING_DIRECTORY="$(pwd)/linking"

git clone https://github.com/linked-swissbib/linking_enrichment_environment.git "$LINKING_WORKING_DIRECTORY"

cd "$LINKING_WORKING_DIRECTORY"

export LINKING_APPS_FOLDER="$LINKING_WORKING_DIRECTORY/apps"

wget -nc -P "$LINKING_APPS_FOLDER/LIMES" "https://github.com/dice-group/LIMES/releases/download/1.5.0/limes-core-1.5.0.jar"
wget -nc -P "$LINKING_APPS_FOLDER/reshaperdf" "https://github.com/linked-swissbib/reshaperdf/releases/download/v1.0.0/reshaperdf-1.0-SNAPSHOT-all.jar"
wget -nc -P "$LINKING_APPS_FOLDER/transform" "https://github.com/linked-swissbib/transformationtools/releases/download/v1.0.0/ntextract-1.0-SNAPSHOT-all.jar"
wget -nc -P "$LINKING_APPS_FOLDER/transform" "https://github.com/linked-swissbib/transformationtools/releases/download/v1.0.0/ntriples2jsonld-1.0-SNAPSHOT-all.jar"
wget -nc -P "$LINKING_APPS_FOLDER/transform" "https://github.com/linked-swissbib/transformationtools/releases/download/v1.0.0/rdfstats-1.0-SNAPSHOT-all.jar"
wget -nc -P "$LINKING_APPS_FOLDER/transform" "https://github.com/linked-swissbib/transformationtools/releases/download/v1.0.0/sparqlrequest-1.0-SNAPSHOT-all.jar"
wget -nc -P "$LINKING_APPS_FOLDER/transform" "https://github.com/linked-swissbib/transformationtools/releases/download/v1.0.0/splitfile-1.0-SNAPSHOT-all.jar"
wget -nc -P "$LINKING_APPS_FOLDER/transform" "https://github.com/linked-swissbib/transformationtools/releases/download/v1.0.0/unloadtriplestore-1.0-SNAPSHOT-all.jar"
wget -nc -P "$LINKING_APPS_FOLDER/genconfig" "https://github.com/linked-swissbib/genconfig/releases/download/v1.0.0/genconfig-1.0-SNAPSHOT-all.jar"


echo '#!/usr/bin/env bash' > "$RESHAPERDF_SCRIPT"
echo '# script to run reShapeRDF directly from bash.' >> "$RESHAPERDF_SCRIPT"
echo '' >> "$RESHAPERDF_SCRIPT"
echo "java -Xmx8g -jar $LINKING_APPS_FOLDER/reshaperdf/reshaperdf-1.0-SNAPSHOT-all.jar \$@" >> "$RESHAPERDF_SCRIPT"

# script to be able to run reshaperdf as globally.
sudo cp "$RESHAPERDF_SCRIPT" /usr/bin/
sudo chown root:root /usr/bin/reshaperdf
sudo chmod +x /usr/bin/reshaperdf

echo Done
exit 0
