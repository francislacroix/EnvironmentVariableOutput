FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["EnvironmentVariableOutput/EnvironmentVariableOutput.csproj", "EnvironmentVariableOutput/"]
RUN dotnet restore "./EnvironmentVariableOutput/EnvironmentVariableOutput.csproj"
COPY ./EnvironmentVariableOutput ./EnvironmentVariableOutput
WORKDIR "/src/EnvironmentVariableOutput"
RUN dotnet build "./EnvironmentVariableOutput.csproj" -c $BUILD_CONFIGURATION -o /app/build
RUN dotnet publish "./EnvironmentVariableOutput.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
USER app
WORKDIR /app
COPY --from=build /app/publish .

EXPOSE 8080
EXPOSE 8081

ENTRYPOINT ["dotnet", "EnvironmentVariableOutput.dll"]