# Container image that runs your code
FROM mcr.microsoft.com/dotnet/sdk:6.0

ENV PATH="${PATH}:/root/.dotnet/tools"
COPY entrypoint.ps1 /entrypoint.ps1
RUN dotnet tool install -g dotnet-stryker
