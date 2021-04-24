#!/bin/bash

for f in "$@"
do
    echo "Got $f"
    R -e "rmarkdown::render('${f}')" || true
done

