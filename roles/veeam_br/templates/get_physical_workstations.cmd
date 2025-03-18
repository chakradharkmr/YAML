@echo off
for /F "usebackq" %%a in (`wmic /namespace:\\root\directory\ldap path ds_computer get ds_dnshostname ^| find /v "DS_dNSHostName" ^| findstr /r /v "^$"`) do (
  for /F "usebackq tokens=1 skip=1 delims= " %%m in (`wmic /node:%%a computersystem get model ^| findstr /r /v "^$"`) do (
    if not %%m==Virtual (
      for /F "usebackq tokens=3 skip=1 delims= " %%o in (`wmic /node:%%a os get caption ^| findstr /r /v "^$"`) do (
        if [%%o]==[10] ( 
          echo %%a
        )
      )
    )
  )
)
