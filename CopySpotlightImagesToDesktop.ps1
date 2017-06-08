# Copies Windows Spotlight images to your desktop and changes the extension so that the images are usable
$imgSrcLocation = Join-Path -Path $env:USERPROFILE -ChildPath "appdata\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
$imgTargetLocation = Join-Path -Path $env:USERPROFILE -ChildPath "Desktop\Spotlight Images"

if (!(Test-Path -Path $imgSrcLocation -PathType Container))
{
	Write-Host "Spotlight images for current user not found" -ForegroundColor Red
	return
}

if (!(Test-Path -Path $imgTargetLocation -PathType Container))
{
	New-Item -Path $imgTargetLocation -ItemType Container | Out-Null
}

Get-ChildItem -Path $imgSrcLocation | ForEach-Object { Copy-Item -Path $_.FullName -Destination "$imgTargetLocation\$($_.Name).jpg" }