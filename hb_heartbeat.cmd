@echo off
setlocal
set XML=C:\ProgramData\Novosoft\Handy Backup 8\Users\@WIN-D~1\Logs\reporting.xml

set LATEST=1970-01-01 00:00:00
for /f "tokens=2 delims=<>" %%a in ('findstr /c:"EndTime" "%XML%" 2^>nul') do (
    set LATEST=%%a
)

if not "%LATEST%"=="1970-01-01 00:00:00" echo %LATEST%