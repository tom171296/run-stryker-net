#!/bin/sh -l
testProject=$1

echo "Changing direcotry to $testProject"
cd $testProject

echo "Starting Striker.NET run"
dotnet stryker