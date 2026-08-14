@echo off
cd /d "%~dp0"
echo Recent versions (most recent at top):
echo.
git log --oneline -15
echo.
set /p n="How many versions back do you want to undo? (e.g. 1): "
echo.
echo This will roll the website back %n% version(s) and update the live site.
set /p confirm="Type Y to continue: "
if /i not "%confirm%"=="Y" goto :end
git reset --hard HEAD~%n%
git push -f origin main
echo.
echo Done. Rolled back %n% version(s).
echo If you want the newer version back, run redo.bat
:end
echo.
pause >nul
