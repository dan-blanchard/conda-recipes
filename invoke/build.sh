#!/bin/bash

if [ $PY3K -eq 0 ]; then
    rm -rf invoke/vendor/yaml3
fi
$PYTHON setup.py install

# Add more build steps here, if they are necessary.

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.
