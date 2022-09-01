#!/bin/bash

cd $CDK_APP_DIR

echo "Install Dependencies"
npm install

echo "Build CDK Application"
npm run build

echo "Synth"
npx aws-cdk synth --quiet

echo "Deploy"
npx aws-cdk deploy --require-approval never
