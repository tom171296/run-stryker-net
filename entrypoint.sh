#!/bin/sh
export PATH="$PATH:/root/.dotnet/tools"

ls

# dotnet stryker --test-project "/github/workspace/Minor.Nijn.Test/Minor.Nijn.Test.csproj"