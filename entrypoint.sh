#!/bin/sh
export PATH="$PATH:/root/.dotnet/tools"

dotnet stryker --test-project /github/workspace/Minor.Nijn.Test/Minor.Nijn.Test.csproj --project /github/workspace/Minor.Nijn/Minor.Nijn.csproj