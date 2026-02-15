# replit.md

## Overview

This is an EaglercraftX 1.8 project — a web-based Minecraft client that runs in the browser via WebAssembly/JavaScript. The repository appears to be a deployment/server setup for EaglercraftX, using a BungeeCord proxy server to handle connections. The project serves the Eaglercraft web client via an integrated HTTP server within the BungeeCord plugin and proxies player connections to backend Minecraft servers.

## User Preferences

Preferred communication style: Simple, everyday language.

## System Architecture

### Project Structure

The repository is structured as a BungeeCord-based Minecraft proxy server deployment:

- **`bungee/`** — Contains the BungeeCord proxy server setup, including plugins
- **`bungee/plugins/EaglercraftXBungee/`** — The EaglercraftX BungeeCord plugin that handles WebSocket connections from browser-based Minecraft clients and serves the web client files via HTTP
- **`eula.txt`** — References the source repository (WilliamKnight7/EaglercraftX-18)

### How It Works

1. **BungeeCord Proxy**: Acts as the main server, sitting between web clients and backend Minecraft servers. It handles player authentication, server switching, and connection management.

2. **EaglercraftX BungeeCord Plugin**: This plugin does two things:
   - Serves the Eaglercraft web client (HTML, JS, CSS, game assets) over HTTP to browsers
   - Handles WebSocket connections from the browser-based client, translating them into standard Minecraft protocol for backend servers

3. **HTTP MIME Types Configuration** (`http_mime_types.json`): Configures how the built-in HTTP server serves static files, including content types, file extension mappings, cache expiration times, and character encoding. Key file types served include:
   - HTML/JS/CSS for the web client interface
   - `.epk` files (Eaglercraft resource packs, served as binary)
   - Image assets (PNG, JPEG, GIF, WebP, SVG)

### Design Decisions

- **BungeeCord as the server platform**: Chosen because it provides a mature proxy framework for Minecraft, handling multiple backend servers and player management. The Eaglercraft plugin extends it with WebSocket and HTTP support.
- **Integrated HTTP server**: Rather than requiring a separate web server (like Nginx), the plugin serves web files directly, simplifying deployment.
- **Cache control via MIME config**: Static assets have configurable expiration times (1 hour for HTML/JS, 4 hours for images and game packs) to balance freshness with performance.

## External Dependencies

- **Java Runtime**: Required to run BungeeCord (typically Java 8+)
- **BungeeCord**: The Minecraft proxy server framework
- **EaglercraftXBungee Plugin**: Handles Eaglercraft-specific WebSocket protocol and HTTP file serving
- **Backend Minecraft Servers**: One or more Minecraft 1.8 servers that BungeeCord proxies connections to (e.g., Spigot, Paper)
- **Web Browser**: End users connect via modern web browsers that support WebSockets and WebAssembly/JavaScript