#!/usr/bin/env bash

make html
rsync --delete -az _build/html/ ~/src/sjl.bitbucket.org/flask-csrf
hg -R ~/src/sjl.bitbucket.org commit -Am 'flask-csrf: Update documentation.'
hg -R ~/src/sjl.bitbucket.org push
