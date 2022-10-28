# Container image that runs your code
FROM mcr.microsoft.com/dotnet/sdk:6.0
RUN dotnet tool install -g dotnet-stryker

RUN dotnet stryker --test-project Minor.Nijn.Test/Minor.Nijn.Test.csproj 