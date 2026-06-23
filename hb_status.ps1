param($taskName)
$LogRoot = "C:\ProgramData\Novosoft\Handy Backup 8\Users\@WIN-D~1\Logs"

$found = $false
Get-ChildItem $LogRoot -Directory | ForEach-Object {
    $folderNumber = $_.Name
    $latestErr = Get-ChildItem $_.FullName -Filter "*.log.err" | Sort-Object Name -Descending | Select-Object -First 1
    if (-not $latestErr) { return }

    $content = Get-Content $latestErr.FullName -Encoding Unicode -ErrorAction SilentlyContinue | Out-String
    if ($content -match "TaskName\s*=\s*`"$taskName`"") {
        $found = $true
        $status = "UNKNOWN"
        if ($content -match 'Успешно завершено') { $status = "SUCCESS" }
        elseif ($content -match 'Не выполнено!') { $status = "FAIL" }

        $lastRun = ""
        if ($content -match '(\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2})\s+SESSION ENDED') {
            $lastRun = $Matches[1]
        }

        $errors = 0
        if ($content -match 'ошибок:\s*(\d+)') {
            $errors = [int]$Matches[1]
        }

        Write-Output "STATUS:$status FOLDER:$folderNumber LAST_RUN:$lastRun ERRORS:$errors"
        return
    }
}

if (-not $found) { Write-Output "STATUS:NOT_FOUND FOLDER:? LAST_RUN: ERRORS:0" }
