# clone digital land python
cd $home
git clone https://github.com/digital-land/digital-land-python.git
echo '-------- Clone step completed'

# install pipenv
pip3 install pipenv

# create virtual environment
cd ~/digital-land-gcloud-shell-pipeline-runner
python3 -m pipenv install
export PATH="~/.local/bin:$PATH"
echo '-------- Pipenv step completed'

# install all dependencies in the virtual env
pipenv run bash 02-prepare-dependencies.sh

pipenv shell
