# clone digital land python
cd $home
git clone https://github.com/digital-land/digital-land-python.git
# TEMPORARY: next step gets version of cli.py that surfaces '--custom-temp-dir' parameter to the digital-land pipeline command
#   in the future this change should be merged and next step not needed.
curl -qfsL 'https://raw.githubusercontent.com/digital-land/digital-land-python/bf8255ce99e04ff7c1f9c7c2fa6c1a4c712588aa/digital_land/cli.py' > digital-land-python/digital_land/cli.py


echo '-------- Clone step completed'

# install pipenv
pip3 install pipenv

# create virtual environment
cd ~/digital-land-gcloud-shell-pipeline-runner
python3 -m pipenv install
export PATH="/home/henrique_farina/.local/bin:$PATH"
echo '-------- Pipenv step completed'

# install all dependencies in the virtual env
pipenv run bash 02-prepare-dependencies.sh

pipenv shell
