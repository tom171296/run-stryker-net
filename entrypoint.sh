#!/bin/sh
export PATH="$PATH:/root/.dotnet/tools"

echo ls

# dotnet stryker --test-project "/github/workspace/Minor.Nijn.Test/Minor.Nijn.Test.csproj"