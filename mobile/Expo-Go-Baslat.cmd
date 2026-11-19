@echo off
setlocal
cd /d "%~dp0" || exit /b 1
set "EXPO_NO_TELEMETRY=1"
where node.exe >nul 2>&1
if errorlevel 1 goto :findNode
goto :check

:findNode
for /f "usebackq delims=" %%D in (`powershell -NoProfile -Command "(Get-AppxPackage -Name 'OpenAI.CodexPrimaryRuntime*' | Select-Object -First 1).InstallLocation"`) do if exist "%%D\dependencies\node\bin\node.exe" set "PATH=%%D\dependencies\node\bin;%PATH%"
where node.exe >nul 2>&1
if not errorlevel 1 goto :check
echo Node.js bulunamadi. / Node.js was not found.
goto :failed

:check
node -e "const {createRequire}=require('node:module');const expo=createRequire(require.resolve('expo/package.json'));expo.resolve('@expo/cli');require.resolve('react-native/package.json')" >nul 2>&1
if not errorlevel 1 goto :start
echo Mobil paket kurulumu eksik. Ayrintilar mobile/README.md dosyasinda.
echo Mobile dependencies are missing. See mobile/README.md.
goto :failed

:start
echo Telefon ve bilgisayar ayni Wi-Fi aginda olmali.
echo Connect your phone and computer to the same Wi-Fi.
node node_modules\expo\bin\cli start --go --lan --clear
if not errorlevel 1 exit /b 0

:failed
pause
exit /b 1
