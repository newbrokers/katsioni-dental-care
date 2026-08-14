@echo off
cd /d "%~dp0"
echo This will bring back the version you had before your last undo.
set /p confirm="Type Y to continue: "
if /i not "%confirm%"=="Y" goto :end
git reset --hard ORIG_HEAD
git push -f origin main
echo.
echo Done. Restored the newer version.
:end
echo.
pause >nul
