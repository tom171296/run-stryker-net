# Container image that runs your code
FROM mcr.microsoft.com/dotnet/sdk:6.0

ENV PATH="${PATH}:/root/.dotnet/tools"
COPY entrypoint.sh /entrypoint.sh

RUN dotnet tool install -g dotnet-stryker

ENTRYPOINT ["/entrypoint.sh"]