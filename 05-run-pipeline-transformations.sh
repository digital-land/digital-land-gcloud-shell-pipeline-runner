# Make sure runnning from $home folder and inside virtual env 
# cd $home
# pipenv shell

# VARIABLES
DATASET='listed-building-outline'
ENDPOINT='0cbe4f9bc30b4b44da34618881d5986fdf49cfcf5d37ea998d26da79520e12a0' 
ORGANISATION='local-authority-eng:BUC' 
ENTRYDATE='2022-05-04' 
RESOURCE='6c961fcd2c76a1602a98f309dc7bffe4323b3192bb839c9c773b4365f9a2ec41'

echo '-------- Variables setting step completed'

#  Make dirs for tranasform step, all folders depend on '$DATASET'
mkdir -p 'my_temp_dir' 'transformed/'$DATASET 'issue/'$DATASET 'var/column-field/'$DATASET 'var/dataset-resource/'$DATASET
echo '-------- Directories to support transform step completed'

### MANUAL ADDITION ######### Only used if we want to test with resource 0126822588...
# this one-off collection was happening in github actions at the 'make transform' stage
# curl -qfsL 'https://digital-land-production-collection-dataset.s3.eu-west-2.amazonaws.com/listed-building-collection/collection/resource/0126822588c342cc3c70db214692f390780cd97f9def116fec58a3d816f6855e' > collection/resource/0126822588c342cc3c70db214692f390780cd97f9def116fec58a3d816f6855e

#  Run transform step needs to have the following args set:
digital-land --dataset $DATASET  pipeline --custom-temp-dir='my_temp_dir' --endpoints $ENDPOINT --organisations $ORGANISATION --entry-date $ENTRYDATE --issue-dir issue/$DATASET --column-field-dir var/column-field/$DATASET --dataset-resource-dir var/dataset-resource/$DATASET  collection/resource/$RESOURCE transformed/$DATASET/$RESOURCE.csv
echo '-------- Pipeline step completed'

# Create dataset and make checks
mkdir -p dataset
time digital-land --dataset $DATASET dataset-create --output-path dataset/$DATASET.sqlite3 transformed/$DATASET/$RESOURCE.csv
time datasette inspect dataset/$DATASET.sqlite3 --inspect-file=dataset/$DATASET.sqlite3.json
time digital-land --dataset $DATASET dataset-entries dataset/$DATASET.sqlite3 dataset/$DATASET.csv
echo '-------- Dataset step completed'

# Create hoisted dataset
mkdir -p hoisted
time digital-land --dataset $DATASET dataset-entries-hoisted dataset/$DATASET.csv hoisted/$DATASET-hoisted.csv
echo '-------- Hoisted dataset step completed'


# md5sum
md5sum dataset/$DATASET.csv dataset/$DATASET.sqlite3

# csv stack step
csvstack issue//$DATASET/$RESOURCE.csv > dataset/$DATASET-issue.csv
echo '-------- CSV stack step completed'