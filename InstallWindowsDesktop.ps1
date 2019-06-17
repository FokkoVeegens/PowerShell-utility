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

# These packages might not correctly install from this script

Install-ChocoPackage -pkgName paint.net
Install-ChocoPackage -pkgName everything

# Upgrade prerequisites

choco upgrade all -y

# Trust windows certificates for Git

git config --global http.sslBackend schannel

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
Set-ItemProperty . Wallpaper "\\wgwa.local\dfs\home\veegensf\My Pictures\wallpaper\UxktUs8.jpg"
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

Stop-Process -ProcessName explorer

## Install AZ Azure DevOps CLI extension
az extension add --name azure-devops
