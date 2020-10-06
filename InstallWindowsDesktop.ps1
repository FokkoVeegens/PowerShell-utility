$ErrorActionPreference = "Stop"

# Install chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Just to be sure, create an alias to the path to choco.exe
Set-Alias -Name choco -Value C:\ProgramData\chocolatey\bin\choco.exe

# Install software to your requirements (check https://chocolatey.org for details)
choco install netfx-4.8-devpack -y
choco upgrade dotnetcore-sdk -y
choco install azure-cli -y
choco install az.powershell -y
choco install vscode -y
choco install rdcman -y
choco install firefox -y
choco install git.install -y
choco install googlechrome -y
choco install microsoft-edge -y
choco install 7zip -y
choco install microsoft-teams.install -y
choco install sql-server-management-studio -y
choco install powershell -y
choco install powershell-core -y
choco install keepass -y
choco install visualstudio2019enterprise -y
choco install visualstudio2019-workload-netweb -y
choco install visualstudio2019-workload-azure -y
choco install visualstudio2019-workload-node -y
choco install visualstudio2019-workload-manageddesktop -y
choco install visualstudio2019-workload-netcoretools -y
choco install vsts-sync-migrator -y
choco install paint.net -y
choco install irfanview -y
choco install everything -y
choco install adobereader -y
choco install logitech-options -y
choco install setpoint -y
choco install snagit --version=13.1.1 -y
choco install sonos-controller -y
choco install stack -y
choco install spotify -y
choco install teamviewer -y
choco install vmware-horizon-client -y
choco install whatsapp -y
choco install docker-desktop -y
choco install nodejs-lts -y
choco install rufus -y
choco install vlc -y
choco install firacode-ttf -y
choco install jabra-direct -y

choco pin add -n=snagit
choco pin add -n=microsoft-teams.install
choco pin add -n=microsoft-edge

Enable-WindowsOptionalFeature -Online -FeatureName containers -All -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart

# Other settings

## Set Visual Studio Code as default editor for PowerShell
Set-ItemProperty -path Registry::HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\Shell\Edit\Command -name "(Default)" -value "`"C:\Program Files\Microsoft VS Code\Code.exe`" `"%1`""

## Show file extensions
Push-Location
Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
Set-ItemProperty . HideFileExt "0"
Set-ItemProperty . Hidden "1"
Pop-Location

## Use PowerShell instead of cmd.exe on Win+X
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name DontUsePowerShellOnWinX -Value 0

## Show This PC, Network, My Files icons on desktop
New-ItemProperty -Path Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value 0 -ErrorAction SilentlyContinue
New-ItemProperty -Path Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -Value 0 -ErrorAction SilentlyContinue
New-ItemProperty -Path Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Value 0 -ErrorAction SilentlyContinue

## Set desktop icon size (small)
Set-ItemProperty -path HKCU:\Software\Microsoft\Windows\Shell\Bags\1\Desktop -name IconSize -value 36

## Set wallpaper - if applicable
# Push-Location
# Set-Location HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
# Set-ItemProperty . Wallpaper "C:\users\youruser\pictures\picture.jpg"
# Pop-Location

## Set desktop icon spacing - back to windows std
# Push-Location
# Set-Location "HKCU:\Control Panel\Desktop\WindowMetrics"
# Set-ItemProperty . IconSpacing "-1125"
# Set-ItemProperty . IconVerticalSpacing "-1125"
# Set-ItemProperty . IconTitleWrap "1"
# Set-ItemProperty . CaptionHeight "-330"
# Set-ItemProperty . CaptionWidth "-330"
# Set-ItemProperty . "Shell Icon Size" "32"
# Pop-Location

## Enable task bar icons and grouping - back to windows std
# Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarGlomLevel -Value 0

## Use big icons - back to windows std
# Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarSmallIcons -Value 0

## Show taskbar on all displays disabled - back to windows std
# Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarEnabled -Value 0

## Restore personal email signature
# Copy-Item -Path "C:\sourcedir_of_your_signature\*" -Destination "$($env:USERPROFILE)\AppData\Roaming\Microsoft\Signatures" -Force -Recurse

## Restart explorer.exe to process changes
Stop-Process -ProcessName explorer

## Install AZ Azure DevOps CLI extension
Set-Alias -Name az -Value "C:\Program Files (x86)\Microsoft SDKs\Azure\CLI2\wbin\az.cmd"
az extension add --name azure-devops

## Trust windows certificates for Git - Only for on-prem git server with local certificate
# git config --global http.sslBackend schannel

## Manual Steps:

## INSTALL: 
## Office language packs
## Visio professional
## Visual Studio Liveshare
## ultimate racer
## Videopad video editor
