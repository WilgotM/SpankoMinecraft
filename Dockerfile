# Använd en lättvikts-Java 8 image (vanligast för Eaglercraft/Bungee)
FROM eclipse-temurin:8-jre

# Installera nödvändiga verktyg (ffmpeg fanns i din replit.nix)
RUN apt-get update && apt-get install -y \
    bash \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Sätt arbetsmappen
WORKDIR /app

# Kopiera alla filer till containern
COPY . .

# Gör startskriptet körbart
RUN chmod +x railway_start.sh main.sh

# Starta servern med vårt speciella script
CMD ["./railway_start.sh"]
