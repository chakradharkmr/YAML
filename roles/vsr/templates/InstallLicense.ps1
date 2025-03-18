#-----------------------------------------------------------------------------------------
# This script installs the license for VSR.
# The script is based on the InstallLicense.ps1 script as provided by Veritas.
#-----------------------------------------------------------------------------------------

$v2iAuto = $null
$oNet = $null

#-----------------------------------------------------------------------------------------
# Step 1: Create a VProRecovery automation object.
#-----------------------------------------------------------------------------------------

$v2iAuto = New-Object -ComObject "Veritas.ProtectorAuto"

#-----------------------------------------------------------------------------------------
# Step 2: Connect to the local agent.
#-----------------------------------------------------------------------------------------

Write-Host "Connecting..."

try
{
    $oNet = New-Object -ComObject "Wscript.Network"
    $v2iAuto.Connect($oNet.ComputerName)
}
catch
{
    Write-Host "Failed to Connect with an Exception..."
    Write-Host $_.Exception.GetType().FullName -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host "Exiting..."
    exit $1
}

#-----------------------------------------------------------------------------------------
# Step 3: Install the license
#-----------------------------------------------------------------------------------------
Write-Host "Installing License..."

try
{
 {% if ansible_facts['os_name'].find('Microsoft Windows 10') != -1 %}
    $v2iAuto.InstallLicenseEx('Veritas System Recovery {{ vsr_ver.split(".") [0] }}','','{{ vsr_workstation_license_key }}')
 {% endif %}
 {% if ansible_facts['os_name'].find('Microsoft Windows Server') != -1 %}
    $v2iAuto.InstallLicenseEx('Veritas System Recovery {{ vsr_ver.split(".") [0] }}','','{{ vsr_server_license_key }}')
 {% endif %}
}
catch
{
    Write-Host "Failed to Install license with an Exception..."
    Write-Host $_.Exception.GetType().FullName -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host "Exiting..."
    exit $1
}
Write-Host "License installed successfully..."
