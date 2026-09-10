@echo off
title PasswordAdmin Web UI
start "PasswordAdmin Crypto Server" "%~dp0crypto_bridge_server.exe" --server 8765 20
start "" "%~dp0index.html""
exit
