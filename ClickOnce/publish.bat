@echo off
rem ####################################################
rem # Make ClickOnce deployment manifest
rem ####################################################
if defined NEW_VERSION goto equipment
set NEW_VERSION=0.0.0.1

:equipment
rem ####################################################
rem # Equipment
rem ####################################################
if defined MAGE goto findMage
set MAGE="C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\mage.exe"

:findMage
echo %PROVIDER_URL%
if defined PROVIDER_URL goto findClientProviderUrl
set PROVIDER_URL="http://127.0.0.1/IconSample.application"

:findClientProviderUrl
set APP_NAME=IconSample
set CERT_FILE="cert-files\symfo.pfx"
set OUTPUT_DIR=publish
set BIN_DIR=%OUTPUT_DIR%\ApplicationFiles\%APP_NAME%_%NEW_VERSION%

rem ####################################################
rem # Main Proc
rem ####################################################

%MAGE% ^
-New Application ^
-ToFile %BIN_DIR%\%APP_NAME%.exe.manifest ^
-Name %APP_NAME% ^
-Version %NEW_VERSION% ^
-FromDirectory %BIN_DIR% ^
-Processor "x86" ^
-IconFile myicon.ico

%MAGE% ^
-Sign %BIN_DIR%\%APP_NAME%.exe.manifest ^
-CertFile %CERT_FILE% ^
-Password "password"

%MAGE% ^
-Update %OUTPUT_DIR%\%APP_NAME%.application ^
-AppManifest %BIN_DIR%\%APP_NAME%.exe.manifest ^
-Version %NEW_VERSION% ^
-ProviderURL %PROVIDER_URL% ^
-IncludeProviderURL true ^
-Publisher "sunotora"

rem powershell ./convert.ps1 %OUTPUT_DIR%\%APP_NAME%.application

%MAGE% ^
-Sign %OUTPUT_DIR%\%APP_NAME%.application ^
-CertFile %CERT_FILE% ^
-Password "password"

echo F | xcopy %OUTPUT_DIR%\%APP_NAME%.application %OUTPUT_DIR%\%APP_NAME%_%NEW_VERSION%.application /Y

goto endProc

:fail
exit /b 1

:endProc
