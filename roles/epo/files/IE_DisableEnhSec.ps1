function Disable-InternetExplorerESC {
   $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
   $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
   Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0 -Force
   Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0 -Force
   Rundll32 iesetup.dll, IEHardenLMSettings
   Rundll32 iesetup.dll, IEHardenUser
   Rundll32 iesetup.dll, IEHardenAdmin
}

Disable-InternetExplorerESC

#{
#   "type": "powershell",
#   "scripts":[
#   "{{ template_dir }}/scripts/Disable-InternetExplorerESC.ps1"
#   ],
#   "elevated_user": "{{user `win_local_admin`}}",
#   "elevated_password": "{{user `win_local_admin_pw`}}"
#}
