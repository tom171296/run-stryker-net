#!/bin/sh
export PATH="$PATH:/root/.dotnet/tools"
dotnet stryker --test-project Minor.Nijn.Test/Minor.Nijn.Test.csproj