#!/bin/bash

scheme --quiet < "3.26.experiment.list.scm" | tee 3.26.results.list.txt 
scheme --quiet < "3.26.experiment.bst.scm" | tee 3.26.results.bst.txt
python 3.26.plot.py
