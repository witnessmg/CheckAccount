#!/bin/bash
#rm -Rf node_modules components
npm install
node node_modules/component/bin/component install
node node_modules/component/bin/component build -o public -n assets
