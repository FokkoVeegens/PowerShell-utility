# Installs prerequisites

Set-Alias -Name choco -Value C:\ProgramData\chocolatey\bin\choco.exe

function Install-ChocoPackage ([string]$pkgName)
{
    $output = choco list $pkgName --localonly
    if ($output -like "*0 packages installed*")
    {
        choco install $pkgName -y
        if ($LASTEXITCODE -ne 0)
        {
            Write-Error "Chocolatey failed, exitcode: $$LASTEXITCODE"
            exit 1
        }
    }
    else
    {
        Write-Host "Package $pkgName is already installed"
    }
}

Install-ChocoPackage -pkgName dotnet4.7
Install-ChocoPackage -pkgName netfx-4.7.1-devpack
Install-ChocoPackage -pkgName netfx-4.7.2-devpack
Install-ChocoPackage -pkgName nodejs-lts
Install-ChocoPackage -pkgName nodejs.install
Install-ChocoPackage -pkgName azure-cli
Install-ChocoPackage -pkgName javaruntime
Install-ChocoPackage -pkgName azurepowershell
Install-ChocoPackage -pkgName vscode
Install-ChocoPackage -pkgName rdcman
Install-ChocoPackage -pkgName firefox
Install-ChocoPackage -pkgName git.install
Install-ChocoPackage -pkgName googlechrome
Install-ChocoPackage -pkgName 7zip
Install-ChocoPackage -pkgName microsoft-teams.install
Install-ChocoPackage -pkgName sql-server-management-studio
Install-ChocoPackage -pkgName powershell
Install-ChocoPackage -pkgName keepass
Install-ChocoPackage -pkgName imageglass
Install-ChocoPackage -pkgName visualstudio2019enterprise
Install-ChocoPackage -pkgName python
Install-ChocoPackage -pkgName openssl.light
Install-ChocoPackage -pkgName vsts-sync-migrator

# These packages might not correctly install from this script

Install-ChocoPackage -pkgName paint.net
Install-ChocoPackage -pkgName everything

# Upgrade prerequisites

choco upgrade all -y

# Other settings

## Show file extensions
Push-Location
Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
Set-ItemProperty . HideFileExt "0"
Set-ItemProperty . Hidden "1"
Pop-Location

## Set wallpaper
Push-Location
Set-Location HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
Set-ItemProperty . Wallpaper "\\wgwa.local\dfs\home\veegensf\My Pictures\wallpaper\sailing.jpg"
Pop-Location

## Set desktop icon spacing
Push-Location
Set-Location "HKCU:\Control Panel\Desktop\WindowMetrics"
Set-ItemProperty . IconSpacing "-1125"
Set-ItemProperty . IconVerticalSpacing "-1125"
Set-ItemProperty . IconTitleWrap "1"
Set-ItemProperty . CaptionHeight "-330"
Set-ItemProperty . CaptionWidth "-330"
Set-ItemProperty . "Shell Icon Size" "32"
Pop-Location

## Enable task bar icons and grouping (default Windows setting)
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarGlomLevel -Value 0

## Use big icons (default Windows setting)
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarSmallIcons -Value 0

## Use PowerShell instead of cmd.exe on Win+X
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name DontUsePowerShellOnWinX -Value 0

## Show taskbar on all displays disabled (default Windows setting)
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarEnabled -Value 0

## Show This PC, Network, My Files icons on desktop
New-ItemProperty -Path Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value 0 -ErrorAction SilentlyContinue
New-ItemProperty -Path Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -Value 0 -ErrorAction SilentlyContinue
New-ItemProperty -Path Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Value 0 -ErrorAction SilentlyContinue

## Set desktop icon size (small)
Set-ItemProperty -path HKCU:\Software\Microsoft\Windows\Shell\Bags\1\Desktop -name IconSize -value 36

## Restore personal email signature
Copy-Item -Path "D:\PersonalSources\Handtekeningen\*" -Destination "$($env:USERPROFILE)\AppData\Roaming\Microsoft\Handtekeningen" -Force -Recurse

## Restart explorer.exe to process changes
Stop-Process -ProcessName explorer

## Install AZ Azure DevOps CLI extension
az extension add --name azure-devops

## Install most important VS Code extensions
code --install-extension ms-vsts.team
code --install-extension ms-vscode.powershell

## Trust windows certificates for Git
git config --global http.sslBackend schannel

## Manual Steps:
## Download FiraCode font: https://github.com/tonsky/FiraCode/releases/download/1.207/FiraCode_1.207.zip
## Settings in VS Code
## "editor.fontSize": 12,
## "editor.fontLigatures": true,
## "editor.fontFamily": "Fira Code"
