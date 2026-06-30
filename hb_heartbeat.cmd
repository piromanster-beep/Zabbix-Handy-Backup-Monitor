@echo off
set XML=C:\ProgramData\Novosoft\Handy Backup 8\Users\@WIN-D~1\Logs\reporting.xml

if not exist "%XML%" exit /b

for /f %%a in ('powershell -Command "[math]::Floor(((Get-Date) - (Get-Item '%XML%').LastWriteTime).TotalHours)"') do echo %%a
