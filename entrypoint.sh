#!/bin/sh -l
testProject=$1

export PATH="$PATH:/root/.dotnet/tools"

echo "Changing direcotry to $testProject"
cd $testProject

echo "Starting Striker.NET run"
dotnet stryker

htmlReport=$(cat ./StrykerOutput/**/**/*.html | base64)

echo $htmlReport
echo "htmlReport=$htmlReport" >> $GITHUB_OUTPUT
