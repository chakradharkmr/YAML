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
start /B "Y-dPloy IT-Security configuration start" "{{ it_security.path }}" {{ it_security.options }}
start /B "Y-dPloy IT-Security configuration AutoIt" "{{ win_local_sw_depot }}\AutoIt\files\default\AutoIt3_x64.exe" "{{ local_ctmvp_depot }}\it_security_configuration.au3"
exit /B 0
