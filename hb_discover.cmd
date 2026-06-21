@echo off
setlocal enabledelayedexpansion
set XML=C:\ProgramData\Novosoft\Handy Backup 8\Users\@WIN-D~1\Logs\reporting.xml

echo {"data":[
set FIRST=1
for /f "tokens=3 delims=<>" %%a in ('findstr /i "TaskName" "%XML%" 2^>nul') do (
    if not "%%a"=="TaskName" (
        if not !FIRST!==1 echo ,
        set FIRST=0
        echo {"{#TASK}":"%%a"}
    )
)
echo ]}
