#!/usr/bin/env bash

cd `dirname "${BASH_SOURCE[0]}"`

source ../env3/bin/activate

pip freeze > ../requirements/requirements-production.txt