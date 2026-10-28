@echo off
title PasswordAdmin Web UI
set "VAULT=%~dp0PasswordAdmin WebUI\PasswordVault.vault.json"
set "DEMO=%~dp0PasswordAdmin WebUI\demo\PasswordVault.vault.json"
if not exist "%VAULT%" if exist "%DEMO%" copy /Y "%DEMO%" "%VAULT%" >nul
start "PasswordAdmin Crypto Server" "%~dp0PasswordAdmin WebUI\crypto_bridge_server.exe" --server 8765 20
start "" "%~dp0PasswordAdmin WebUI\index.html"
exit
