$coll = "https://servername:8080/tfs/defaultcollection"
$apiurl = "$coll/_apis"
$witadminpath = "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\Common7\IDE\CommonExtensions\Microsoft\TeamFoundation\Team Explorer\witadmin.exe"
$exportpath = "C:\TFS\WitExport"

if (!(Test-Path -Path $witadminpath -PathType Leaf))
{
    Write-Host "WitAdmin.exe not found" -ForegroundColor Red
    exit 1
}

Set-Alias -Name witadmin -Value $witadminpath

function List-Wits($teamproject)
{
    $list = witadmin listwitd /collection:$coll /p:$teamproject
    return $list
}

function Export-Wit($teamproject, $witname, $basepath)
{
    $targetdir = Join-Path -Path $basepath -ChildPath $teamproject
    if (!(Test-Path -Path $targetdir -PathType Container))
    {
        New-Item -Path $targetdir -ItemType Directory
    }
    $targetfile = Join-Path -Path $targetdir -ChildPath "$witname.xml"
    Write-Host "Exporting $witname from $teamproject to $targetfile"
    witadmin exportwitd /collection:$coll /p:$teamproject /n:$witname /f:$targetfile
}

$uri = "$apiurl/projects"
$projects = (invoke-webrequest -Uri $uri -Method GET -ContentType "application/json").value | ConvertFrom-Json

foreach ($project in $projects)
{
    $witdlist = List-Wits -teamproject $project.name
    foreach ($witd in $witdlist)
    {
        Export-Wit -teamproject $project.name -witname $witd -basepath $exportpath
    }
}
