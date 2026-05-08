# ── Build stage ────────────────────────────────────────────────────────────────
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Restore dependencies first (layer-cached until .csproj changes)
COPY ["ConsultationBackend.csproj", "ConsultationBackend/"]
RUN dotnet restore "ConsultationBackend/ConsultationBackend.csproj"

# Copy the rest of the source and publish
COPY . ConsultationBackend/
WORKDIR /src/ConsultationBackend
RUN dotnet publish "ConsultationBackend.csproj" \
    --configuration Release \
    --output /app/publish

# ── Runtime stage ───────────────────────────────────────────────────────────────
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app

# Run as a non-root user
RUN groupadd --system appgroup && useradd --system --gid appgroup appuser
USER appuser

COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "ConsultationBackend.dll"]
