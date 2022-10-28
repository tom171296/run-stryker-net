#!/bin/sh
export PATH="$PATH:/root/.dotnet/tools"
cd /github/workspace

dotnet stryker --test-project Minor.Nijn.Test/Minor.Nijn.Test.csproj --project Minor.Nijn/Minor.Nijn.csproj