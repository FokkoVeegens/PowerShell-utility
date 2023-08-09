# Gets all software installed on a list of servers, using WinRM

$Servers = @("Server1","Server2","Server3")
$ExportFile = "C:\temp\software.csv"
 
$script = {
    $InstalledSoftware = Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
    $InstalledSoftware | Where-Object { $_.GetValue('DisplayName') } | Select-Object @{Name="Package";Expression={$_.GetValue('DisplayName')}}, @{Name="Version";Expression={$_.GetValue('DisplayVersion')}}
}
 
$AllSoftware = @()
foreach ($Server in $Servers) {
    $result = Invoke-Command -ComputerName $Server -ScriptBlock $script -ErrorVariable "errorText" -ErrorAction SilentlyContinue
    if ($errorText) {
        Write-Host "Running on server $Server failed: $($errorText.ErrorDetails.Message)"
    }
    else {
        Write-Host "Server $Server processed successfully"
        $AllSoftware += $result
    }
    $errorText = $null  
}
 
$AllSoftware | Select-Object -Property PSComputerName, Package, Version | Export-Csv -Path $ExportFile -Encoding utf8 -UseCulture
