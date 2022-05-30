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

#import AzCloud functions
iex (irm functions.osdcloud.com)

#Connect AzOSDCloud
Connect-AzOSDCloud


#Connect To AzureAD
Connect-AzAccount -UseDeviceAuthentication -AuthScope Storage -ErrorAction Stop

# Start-OSDCloud -Product NODRIVER -OSLanguage en-us -OSBuild 22H2 -OSEdition Enterprise -ZTI
Start-OSDCloud -Product NODRIVER -ZTI -ImageFileUrl "https://osdcloudbechtlev.blob.core.windows.net/server/de-de-server2022.wim?sp=r&st=2022-05-30T14:32:08Z&se=2022-05-30T22:32:08Z&spr=https&sv=2020-08-04&sr=b&sig=AqcBGheH%2FscLPKxzDPO40BxEHJzYw%2FMq9liD%2F4DDXtU%3D" -ImageIndex 2

# Set Drive Lable Name
Set-Volume -DriveLetter C -NewFileSystemLabel "Windows"

# Restart from WinPE
Write-Host -ForegroundColor Cyan "Restarting in 10 seconds!"
Start-Sleep -Seconds 10

wpeutil reboot
