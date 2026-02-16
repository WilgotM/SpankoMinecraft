#!/bin/bash
set -e

# --- TIDSKONTROLL ---
# Vi använder UTC-tid eftersom Railway körs i molnet. 
# Sverige är UTC+1 (vinter) eller UTC+2 (sommar).
# 07:30 - 15:30 svensk tid är ca 06:30 - 14:30 UTC.

HOUR=$(date +%H)
DAY=$(date +%u) # 1=Måndag, 7=Söndag

# 1. Kolla om det är helg (6=Lördag, 7=Söndag)
if [ $DAY -ge 6 ]; then
    echo "Det är helg! Servern öppnar igen på måndag kl 07:30."
    sleep 3600 # Vänta en timme innan vi stänger av så Railway inte startar om frenetiskt
    exit 0
fi

# 2. Kolla klockan (06:30 till 14:30 UTC motsvarar ca 07:30-15:30 svensk tid)
if [ $HOUR -lt 6 ] || [ $HOUR -ge 15 ]; then
    echo "Klockan är $HOUR:00 UTC. Servern är stängd. Öppet 07:30-15:30 svensk tid."
    sleep 3600
    exit 0
fi

# --- VANLIG START ---
if [ -n "$PORT" ]; then
    echo "Konfigurerar port $PORT..."
    sed -i "s/address: 0.0.0.0:[0-9]*/address: 0.0.0.0:$PORT/g" bungee/plugins/EaglercraftXBungee/listeners.yml
fi

echo "Startar BungeeCord..."
cd bungee
# Vi sänker RAM till 256MB för att spara pengar och hålla oss under $1/månad
java -Xmx256M -Xms128M -jar bungee.jar
