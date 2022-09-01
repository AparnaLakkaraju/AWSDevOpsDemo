#!/bin/bash

cd $CDK_APP_DIR

echo "Install Dependencies"
npm install

echo "Build CDK Application"
npm run build
