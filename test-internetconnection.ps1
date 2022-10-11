$result = (Get-CimInstance -ClassName Win32_PingStatus -Filter "Address='www.google.nl' AND Timeout=1000") | `
  ConvertTo-Json -depth 100 | `
  ConvertFrom-Json
if (!$result.IPV4Address -and !$result.IPV6Address)
{
  Write-Host "No internet connection available"
}
else
{
  Write-Host "Internet connection OK"
}
