@echo off
cd /d "%~dp0"
set /p msg="Commit message: "
git add -A
git commit -m "%msg%"
git push origin main
echo.
echo Done. Press any key to close.
pause >nul
