<#
 # Description : Script to Run Cloud Image
 # Created : 30.05.2022
 #>

# Starting the Imaging
Write-Host "=========================================================================" -ForegroundColor Cyan
Write-Host "===================== Cloud Image Deployment Script =====================" -ForegroundColor Cyan
Write-Host "=========================================================================" -ForegroundColor Cyan
Write-Host "========================== Starting Imaging ZTI =========================" -ForegroundColor Cyan
Write-Host "================== Edition - 22H2 == Build - 19044.1706 =================" -ForegroundColor Cyan
Write-Host "=========================================================================" -ForegroundColor Cyan
Start-Sleep -Seconds 5

# Updating Module
Install-Module OSD -Force
Import-Module OSD -Force

#Install AzAD
Install-Module AzureAD -Force
Import-Module AzureAD -Force

#Install Az.Accounts
Install-Module Az.Accounts -Force
Import-Module Az.Accounts -Force

#Install Az.KeyVault
Install-Module Az.KeyVault -Force
Import-Module Az.KeyVault -Force

#Install Az.Resources
Install-Module Az.Az.Resources -Force
Import-Module Az.Az.Resources -Force

#Install Az.Storage
Install-Module Az.Storage -Force
Import-Module Az.Storage -Force

#Install Microsoft.Graph.DeviceManagement
Install-Module Microsoft.Graph.DeviceManagement -Force
Import-Module Microsoft.Graph.DeviceManagement -Force




#Connect To AzureAD
Connect-AzAccount -UseDeviceAuthentication -AuthScope Storage -ErrorAction Stop

# Start-OSDCloud -Product NODRIVER -OSLanguage en-us -OSBuild 22H2 -OSEdition Enterprise -ZTI
Start-OSDCloud -Product NODRIVER -ZTI -ImageFileUrl "https://osdcloudbechtlev.blob.core.windows.net/server/de-de-server2022.wim" -ImageIndex 2

# Set Drive Lable Name
Set-Volume -DriveLetter C -NewFileSystemLabel "Windows"

# Restart from WinPE
Write-Host -ForegroundColor Cyan "Restarting in 10 seconds!"
Start-Sleep -Seconds 10

wpeutil reboot
