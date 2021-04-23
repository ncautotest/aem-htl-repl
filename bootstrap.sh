#!/bin/bash
# Build and install on localhost, pass the port number as first argument to override the default of 4502

PROJECT_DIR_PARENT="${HOME}/projects/aem6"
mkdir -p ${PROJECT_DIR_PARENT}
PROJECT_NAME="aem-htl-repl"

# take port as 1st command line argument or use 4502 by default
PORT=${1:-4502}

echo PROJECT DIR="${PROJECT_DIR_PARENT}/${PROJECT_NAME}"
echo PORT=${PORT}

if [ ! -d "${PROJECT_DIR_PARENT}/${PROJECT_NAME}" ]; then
	cd "${PROJECT_DIR_PARENT}"
	git clone --depth 1 "https://github.com/ncautotest/${PROJECT_NAME}.git"
	cd "${PROJECT_NAME}"
else
	cd "${PROJECT_DIR_PARENT}/${PROJECT_NAME}"
	git pull
fi

mvn clean install content-package:install -Dcrx.port=${PORT}
open http://localhost:${PORT}/content/repl.html
