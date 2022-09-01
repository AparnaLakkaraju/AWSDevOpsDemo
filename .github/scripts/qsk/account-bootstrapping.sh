#!/bin/bash

npx aws-cdk bootstrap \
    aws://$aws_account/$aws_region \
    --toolkit-stack-name CDKToolkit-QSK-$APP_NAME \
    --qualifier $QUALIFIER \
    --cloudformation-execution-policies 'arn:aws:iam::aws:policy/AdministratorAccess' \
    --tags Project=dpp-qsk \
    --tags ApplicationID=dpp-qsk