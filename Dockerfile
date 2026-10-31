# Сборка
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY ["wt-lab4-4mvc-leshkevich.csproj", "./"]
RUN dotnet restore "wt-lab4-4mvc-leshkevich.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet publish "wt_lab4_4mvc_leshkevich.csproj" -c Release -o /app/publish /p:UseAppHost=false

# запуск
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://0.0.0.0:10000
EXPOSE 10000

ENTRYPOINT ["dotnet", "wt-lab4-4mvc-leshkevich.dll"]