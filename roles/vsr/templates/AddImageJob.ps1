#-----------------------------------------------------------------------------------------
# This script adds a back-up job of the system drive and corresponding EFI system 
# partion to VSR. The script is based on the 'AddImageJob.ps1' script as provided by 
# Veritas as part of Veritas System Recovery.
#-----------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------
# Step 1: Initialzation
#-----------------------------------------------------------------------------------------

$v2iAuto = $null
$oNet = $null
$oVolume = [System.Collections.ArrayList]@($null)
$oTempVol = $null
$oTask = $null
$oLocation1 = New-Object -ComObject "Veritas.VProRecovery.FolderLocation"
$oLocation2 = New-Object -ComObject "Veritas.VProRecovery.FolderLocation"
$sFolder = "{{ vsr_where_to_backup}}\{{ inventory_hostname }}"
$oImageJob = $null
 
#-----------------------------------------------------------------------------------------
# Step 2: Create a VProRecovery automation object.
#-----------------------------------------------------------------------------------------

$v2iAuto = New-Object -ComObject "Veritas.ProtectorAuto"
	
#-----------------------------------------------------------------------------------------
# Step 3: Connect to the local agent.
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
# Step 4: Create a task to schedule the image job.
# Parameters used:
#  Description - specify a description for the image job
#  StartDateTime - set a start date 
#  RepeatInterval - set an interval to repeat, such as, weekly, monthly, etc
#  AddRepeatDay(0) , AddRepeatDay(3) - set the days to repeat, such as Sunday, Monday, etc
#-----------------------------------------------------------------------------------------
	
$oTask = New-Object -ComObject "Veritas.Scheduler.Task"
$oTask.Description = "Full Image Schedule"
$oTask.StartDateTime = "3/3/2021 18:00"	# GMT
$oTask.RepeatInterval = $oTask.Constants.Interval{{ vsr_backup_interval }}
$oTask.AddRepeatDay(0)	# Sunday
$oTask.Validate()	# Make sure we built the task correctly

#-----------------------------------------------------------------------------------------
# Step 5: Find the volumes to image and add them to $oVolume and $oLocation[n]. 
#-----------------------------------------------------------------------------------------
	
Foreach($oTempVol in $v2iAuto.Volumes($false))
{
  if($oTempVol.VolumeTagInclusive -like "*EFI_SYSTEM_PARTITION*")
  {
    $oVolume.Add($oTempVol)
    $oLocation1.FileSpec = $oTempVol.GeneratedFilename
    $oLocation1.Path = $sFolder
  }
  if($oTempVol.System -eq $true)
  {
    $oVolume.Add($oTempVol)
    $oLocation2.FileSpec = $oTempVol.GeneratedFilename
    $oLocation2.Path = $sFolder
  }
}

#-----------------------------------------------------------------------------------------
# Step 6: Create an image job.
# Parameters used: 
#   DisplayName - specify a display name for the image job
#   Description - specify a description for the image job
#   IncrementalSupport -  true/false 
#   RunOnce - true/false
#   Compression types
#     ImageCompressionLow	
#     ImageCompressionMedium	
#     ImageCompressionHigh	
#     ImageCompressionNewMedium
#-----------------------------------------------------------------------------------------

$oImageJob = $null
$oImageJob = New-Object -ComObject "Veritas.VProRecovery.ImageJob"
$oImageJob.DisplayName = "Recovery point of " + [Array]$oVolume.DisplayName
$oImageJob.Description = "Regular backup image of the system volume"
$oImageJob.IncrementalSupport = $true
$oImageJob.RunOnce = $false
$oImageJob.Compression = $oImageJob.Constants.ImageCompressionHigh
$oImageJob.Reason = $oImageJob.Constants.ImageReasonAutomatic
$oImageJob.Volumes = [Array]$oVolume.ID
$oImageJob.Task = $oTask
$oImageJob.Location($oVolume[1].ID) = $oLocation1
$oImageJob.Location($oVolume[2].ID) = $oLocation2
	
#-----------------------------------------------------------------------------------------
# Step 7: Add the image job to the list of jobs.
#-----------------------------------------------------------------------------------------

try 
{
  $v2iAuto.AddImageJob($oImageJob)
} 
catch 
{
  Write-Host "Add Image Job Failed with Exception..."
  Write-Host $_.Exception.GetType().FullName -ForegroundColor Red
  Write-Host $_.Exception.Message -ForegroundColor Red
  Write-Host "Exiting..."
  exit $1
}
Write-Host "Image Job added successfully..."
