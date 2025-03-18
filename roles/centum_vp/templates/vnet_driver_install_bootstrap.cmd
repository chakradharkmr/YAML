@echo off

:checkElevated
net file 1>nul 2>nul

if '%errorlevel%' == '0' (
  goto mainScript 
) else (
  goto getElevated
)
::-------------------------------------------------------------------------------------------------

:getElevated
  if '%1'=='ELEV' (shift & goto mainScript)
  echo.
  echo Elevating...
  setlocal DisableDelayedExpansion
  set "batchPath=%~0"
  setlocal EnableDelayedExpansion
  echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\runAsAdmin.vbs"
  echo UAC.ShellExecute "!batchPath!", "ELEV", "", "runas", 1 >> "%temp%\runAsAdmin.vbs"
  "%temp%\runAsAdmin.vbs"
  exit /B
::-------------------------------------------------------------------------------------------------

:mainScript

@echo Waiting for Y-dPloy to reconnect...
:waitForFile
ping 127.0.0.1 -n 2 > nul
if not exist "{{ local_ctmvp_depot }}\y-dploy_connected.test" (
  goto waitForFile
)
if exist "{{ local_ctmvp_depot }}\y-dploy_connected.test" (
  DEL /Q /F "{{ local_ctmvp_depot }}\y-dploy_connected.test"
)

start /B "Y-dPloy Vnet driver installation start" "{{ local_product_path }}\COMDRVS\Setup.exe"
start /B "Y-dPloy Vnet driver installation AutoIt" "{{ win_local_sw_depot }}\AutoIt\files\default\AutoIt3_x64.exe" "{{ local_product_path }}\vnet_driver_install.au3"
exit /B 0
