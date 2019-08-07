FROM mcr.microsoft.com/dotnet/core/runtime:2.2 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
WORKDIR /src
COPY ["DockerConsole.csproj", "./"]
RUN dotnet restore "./DockerConsole.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "DockerConsole.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "DockerConsole.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "DockerConsole.dll"]
