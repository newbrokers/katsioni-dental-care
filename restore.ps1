$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $dir
$historyDir = Join-Path $dir "history"

if (-not (Test-Path $historyDir)) {
    Write-Host "No saved versions found yet."
    Read-Host "Press Enter to close"
    exit
}

$files = Get-ChildItem -Path $historyDir -Filter "*.html" | Sort-Object LastWriteTime -Descending

if ($files.Count -eq 0) {
    Write-Host "No saved versions found yet."
    Read-Host "Press Enter to close"
    exit
}

Write-Host "Available versions (most recent first):"
Write-Host ""
for ($i = 0; $i -lt $files.Count; $i++) {
    Write-Host "$($i+1). $($files[$i].Name)  [$($files[$i].LastWriteTime)]"
}
Write-Host ""
$choice = Read-Host "Type the number of the version to restore"

if ($choice -notmatch '^[0-9]+$' -or [int]$choice -lt 1 -or [int]$choice -gt $files.Count) {
    Write-Host "Invalid choice."
    Read-Host "Press Enter to close"
    exit
}

$target = $files[[int]$choice - 1]
$ts = Get-Date -Format "yyyyMMdd_HHmmss"
$backupName = "index__" + $ts + "__before-restore.html"
Copy-Item "index.html" (Join-Path $historyDir $backupName)
Copy-Item $target.FullName "index.html" -Force

Write-Host ""
Write-Host "Restored: $($target.Name)"
Write-Host "Your previous version was also saved, so you can run this again to go back to it if needed."
Write-Host "This only changed the file on your computer -- run push.bat if you want to publish it live."
Read-Host "Press Enter to close"
