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
  echo Set UAC = CreateObject^("Shell.Application"^) > "%~dp0runAsAdmin.vbs"
  echo UAC.ShellExecute "!batchPath!", "ELEV", "", "runas", 1 >> "%~dp0runAsAdmin.vbs"
  "%~dp0runAsAdmin.vbs"
  exit /B
::-------------------------------------------------------------------------------------------------

:mainScript
echo off
title ePO Updater Batch File

echo Silent installer is selected. 
set ELECTRON_RUN_AS_NODE=true
echo Electron variable = %ELECTRON_RUN_AS_NODE%
set DB_PASSWORD={{ epo_sql_sysadmin_pw }}
"%~dp0node_modules\electron\dist\electron.exe" "%~dp0main.js"
set ELECTRON_RUN_AS_NODE=
echo Electron variable = %ELECTRON_RUN_AS_NODE%
:END