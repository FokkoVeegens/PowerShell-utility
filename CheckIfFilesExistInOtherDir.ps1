# This script verifies for files in $dir1 on a per-file basis if it exists in $dir2 and logs deviations
# Filters on certain file extensions, check calls to function at the bottom!

$dir1 = "C:\sourcedir"
$dir2 = "D:\targetdir"

function Get-FileMatches($sourcedir, $targetdir, $filter)
{
    $sourcefiles = Get-ChildItem -Path $dir1 -Filter $filter -Recurse
    [int]$totalfiles = $sourcefiles.Length
    [int]$currentfilenum = 0
    $act = "Scanning $filter files"
    Write-Progress -Activity $act -Status "0% Complete:" -PercentComplete 0
    foreach ($sourcefile in $sourcefiles)
    {
        $currentfilenum++
        [int]$perccomplete = Get-PercentComplete -filesDone $currentfilenum -totalFiles $totalfiles
        Write-Progress -Activity $act -Status "$perccomplete% Complete:" -PercentComplete $perccomplete
        $filename = Split-Path -Path $sourcefile -Leaf
        $sourcehash = Get-FileHash -Path $sourcefile.FullName -Algorithm SHA256
        $founditems = Get-ChildItem -Path $dir2 -Filter $filename -Recurse
        [bool]$found = $false
        [bool]$namematch = $false
        foreach ($founditem in $founditems)
        {
            $namematch = $true
            $targethash = Get-FileHash -Path $founditem.FullName -Algorithm SHA256
            if ($sourcehash.Hash -eq $targethash.Hash)
            {
                #Write-Host "Match: $($sourcefile.FullName) IS $($founditem.FullName)" -ForegroundColor Green
                $found = $true
                break
            }
        }
        if (!$namematch)
        {
            Write-Host "File not found at all: $($sourcefile.FullName)" -ForegroundColor Red
        }
        else
        {
            if (!$found)
            {
                Write-Host "Hash mismatch: $($sourcefile.FullName)" -ForegroundColor Yellow
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
Get-FileMatches -sourcedir $dir1 -targetdir $dir2 -filter "*.png"
Get-FileMatches -sourcedir $dir1 -targetdir $dir2 -filter "*.gif"
