REM Not really PowerShell, but it is the fastest way to delete huge loads of files/dirs on Windows

del /f/q/s *.* > nul
cd..
rmdir /q/s FOLDER-NAME
