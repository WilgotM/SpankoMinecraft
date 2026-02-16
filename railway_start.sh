#!/bin/bash
set -e

# Railway assignar en port via miljövariabeln PORT.
# Vi måste uppdatera Eaglercrafts inställningar för att lyssna på denna port.
if [ -n "$PORT" ]; then
    echo "Configuring Eaglercraft to listen on port $PORT..."
    # Använd sed för att byta ut porten i konfigurationsfilen
    # Vi söker efter "address: 0.0.0.0:xxxx" och byter ut xxxx mot $PORT
    sed -i "s/address: 0.0.0.0:[0-9]*/address: 0.0.0.0:$PORT/g" bungee/plugins/EaglercraftXBungee/listeners.yml
else
    echo "No PORT environment variable detected. Using default settings."
fi

# Gå in i bungee-mappen och starta servern
echo "Starting BungeeCord..."
cd bungee
java -Xmx1024M -Xms512M -jar bungee.jar
