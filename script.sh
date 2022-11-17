#!bin/bash

export $(cat .env | xargs)
pip install -r requirements.txt
python hello.py

