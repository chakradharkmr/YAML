@echo off
for /F "usebackq" %%a in (`wmic /namespace:\\root\directory\ldap path ds_computer get ds_dnshostname ^| find /v "DS_dNSHostName" ^| findstr /r /v "^$"`) do (
  for /F "usebackq tokens=1 skip=1 delims= " %%m in (`wmic /node:%%a computersystem get model ^| findstr /r /v "^$"`) do (
    if %%m==Virtual (
      echo %%a
    )
  )
)
