#!/bin/bash
set -e
docker build -t kindlyops/reporter:fontastic .
docker push kindlyops/reporter:fontastic
