# Only for onprem installations

$nugetpath = "C:\NuGet\nuget.exe"
Set-Alias -Name nuget -Value $nugetpath
$outputpath = "C:\FeedOutput"
$nugetsource = "MyNugetFeedName"
$feedbaseurl = "https://tfsserver:8080/tfs/DefaultCollection/_apis/packaging/feeds/ea1fd6bb-7240-4432-beb8-a314531a4c1e/nuget/packages/" #replace server url and feed GUID with your own

$packages = (nuget list -Source $nugetsource -AllVersions)
foreach ($package in $packages)
{
    $packagename = ($package -split " ")[0]
    $packageversion = ($package -split " ")[1]
    Invoke-WebRequest -Uri "$($feedbaseurl)$($packagename)/versions/$($packageversion)/content" -OutFile "$($outputpath)\$($packagename).$($packageversion).nupkg" -UseDefaultCredentials
}
