#!/bin/bash

CONFIG_FILE_PATH=./$CDK_APP_DIR/$CONFIG_FILE_NAME
existShare=$(jq 'has("share")' $CONFIG_FILE_PATH);
existQualifier=$(jq 'has("qualifier")' $CONFIG_FILE_PATH);
existName=$(jq '.app | has("name")' $CONFIG_FILE_PATH);
existVersion=$(jq '.app | has("version")' $CONFIG_FILE_PATH);

if ( $existShare && $existQualifier && $existName && $existVersion ); then
echo "SHARING=$(jq '.share' $CONFIG_FILE_PATH)" >> $GITHUB_ENV;
share=$(jq '.share' $CONFIG_FILE_PATH);
echo "QUALIFIER=$(jq '.qualifier' $CONFIG_FILE_PATH | awk '{print substr($0, 2, length($0) - 2)}')" >> $GITHUB_ENV;
echo "APP_NAME=$(jq '.app.name' $CONFIG_FILE_PATH | awk '{print substr($0, 2, length($0) - 2)}')" >> $GITHUB_ENV;
echo "APP_VERSION=$(jq '.app.version' $CONFIG_FILE_PATH | awk '{print substr($0, 2, length($0) - 2)}')" >> $GITHUB_ENV;
if ( $share ); then
    echo "## New version will be released soon!! :rocket:" >> $GITHUB_STEP_SUMMARY;
    echo "- Name: $(jq '.app.name' $CONFIG_FILE_PATH)" >> $GITHUB_STEP_SUMMARY;
    echo "- Version: $(jq '.app.version' $CONFIG_FILE_PATH)" >> $GITHUB_STEP_SUMMARY;
else
    echo "## Product is in developing mode!! :muscle:" >> $GITHUB_STEP_SUMMARY;
    echo "#### Please set share flag to true in your configuration file, if your app is ready to share." >> $GITHUB_STEP_SUMMARY;
fi
else
echo "## Validation Error of config file" >> $GITHUB_STEP_SUMMARY;
echo "### Config file must contain following fields at least" >> $GITHUB_STEP_SUMMARY;
echo '{"app": {"name": "YOUR_PRODUCT_NAME", "version": "YOUR_PRODUCT_VERSION"}, "qualifier": "YOUR_BOOTSTRAP_QUALIFIER", "share": "BOOLEAN"}' | jq . >> $GITHUB_STEP_SUMMARY;
exit 1
fi  