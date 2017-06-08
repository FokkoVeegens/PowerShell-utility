# Switches off the Internet Explorer menu bar through the registry (useful when controlled by your admin through group policies
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Internet Explorer\Main" -Name AlwaysShowMenus -ErrorAction SilentlyContinue
