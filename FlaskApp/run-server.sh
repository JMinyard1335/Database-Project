#!/bin/bash


REQUIREMENTS=requirements.txt
VENV=.venv

# if there is not a virtual enviroment create one
if [ ! -d $VENV ]; then
    python3 -m venv $VENV
    source $VENV/bin/activate
    pip install -r $REQUIREMENTS
fi

# activate the virtual enviroment
source $VENV/bin/activate

# set the flask app
export FLASK_APP=app.py
# run the app
tmux new-session -d flask run
