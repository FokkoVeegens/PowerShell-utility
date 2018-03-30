# This script verifies for files in $dir1 on a per-file basis if it exists in $dir2 and logs deviations
# Filters on certain file extensions, check calls to function at the bottom!
param
(
    $source,
    $destination,
    [switch]$verbose
)
$dir1 = $source
$dir2 = $destination

function Get-FileMatches($sourcedir, $targetdir, $filter)
{
    $sourcefiles = Get-ChildItem -Path $dir1 -Filter $filter -Recurse
    [int]$totalfiles = $sourcefiles.Length
    [int]$currentfilenum = 0
    $act = "Scanning $filter files ($totalfiles items)"
    Write-Progress -Activity $act -Status "0% Complete:" -PercentComplete 0
    foreach ($sourcefile in $sourcefiles)
    {
        if ($verbose)
        {
            Write-Host "Processing file: $sourcefile" -ForegroundColor DarkGray
        }
        $currentfilenum++
        [int]$perccomplete = Get-PercentComplete -filesDone $currentfilenum -totalFiles $totalfiles
        Write-Progress -Activity $act -Status "$perccomplete% Complete:" -PercentComplete $perccomplete
        $filename = Split-Path -Path $sourcefile -Leaf
        $sourceSize = (Get-Item -Path $sourceFile.FullName).Length
        $targetsize = 0
        $sourcehash = Get-FileHash -Path $sourcefile.FullName -Algorithm SHA256
        $founditems = Get-ChildItem -Path $dir2 -Filter $filename -Recurse
        [bool]$hashmatch = $false
        [bool]$namematch = $false
        [bool]$sizematch = $false
        [int]$foundcount = 0
        foreach ($founditem in $founditems)
        {
            $foundcount++
            $namematch = $true
            $targethash = Get-FileHash -Path $founditem.FullName -Algorithm SHA256
            $targetsize = (Get-Item -Path $founditem.FullName).Length
            if ($sourcehash.Hash -eq $targethash.Hash)
            {
                #Write-Host "Match: $($sourcefile.FullName) IS $($founditem.FullName)" -ForegroundColor Green
                $hashmatch = $true
                break
            }
            elseif ($sourceSize -eq $targetsize) {
                $sizematch = $true
                break
            }
        }
        if (!$namematch)
        {
            Write-Host "File not found at all: $($sourcefile.FullName)" -ForegroundColor Red
        }
        else
        {
            if (!$hashmatch)
            {
                $sourcerelpath = $sourcefile.FullName -replace [regex]::Escape($source), [string]::Empty
                $targetrelpath = $founditem.FullName -replace [regex]::Escape($destination), [string]::Empty
                if ($sizematch)
                {
                    Write-Host "Hash mismatch (but size is equal): $sourcerelpath <> $targetrelpath" -ForegroundColor Yellow
                }
                else 
                {
                    Write-Host "Hash mismatch ($foundcount files found, size: $sourceSize <> $targetsize): $sourcerelpath <> $targetrelpath" -ForegroundColor Yellow
                }
            }
        }
    }
}

function Get-PercentComplete([int]$filesDone, [int]$totalFiles)
{
    [double]$complete = $filesDone/$totalFiles*100
    return [Math]::Round($complete)
}

Get-FileMatches -sourcedir $dir1 -targetdir $dir2 -filter "*.jpg"
Get-FileMatches -sourcedir $dir1 -targetdir $dir2 -filter "*.jpeg"
Get-FileMatches -sourcedir $dir1 -targetdir $dir2 -filter "*.mts"
Get-FileMatches -sourcedir $dir1 -targetdir $dir2 -filter "*.mov"
