@echo off

:: Set working dir
cd %~dp0 & cd ..

set PAUSE_ERRORS=1
call bat\SetupSDK.bat
call bat\SetupApp.bat

echo.
echo Starting AIR Debug Launcher...
echo.

mxmlc -load-config+=config.xml -debug=true +configname=air -swf-version=25 -o bin/air-adapter-example.swf

if errorlevel 1 goto error
goto end

:error
pause

:end
