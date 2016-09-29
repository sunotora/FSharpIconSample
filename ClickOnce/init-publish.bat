set MAGE="C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\mage.exe"

set APP_NAME=IconSample
set CERT_FILE="cert-files\symfo.pfx"
set OUTPUT_DIR=publish
set BIN_DIR=%OUTPUT_DIR%\ApplicationFiles\%APP_NAME%_0.0.0.0
set PROVIDER_URL="http://127.0.0.1/IconSample.application"

%MAGE% ^
-New Application ^
-ToFile %BIN_DIR%\%APP_NAME%.exe.manifest ^
-Name %APP_NAME% ^
-Version 0.0.0.0 ^
-FromDirectory %BIN_DIR% ^
-Processor "x86" ^
-IconFile myicon.ico

%MAGE% ^
-New Deployment ^
-ToFile %OUTPUT_DIR%\%APP_NAME%.application ^
-Install true ^
-AppManifest %BIN_DIR%\%APP_NAME%.exe.manifest ^
-Version 0.0.0.0 ^
-ProviderURL %PROVIDER_URL% ^
-IncludeProviderURL true ^
-Processor "x86" ^
-Publisher "sunotora" 
