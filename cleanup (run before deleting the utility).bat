@echo off
setlocal
set "MENU_NAME=FileHandleInspector"

reg delete "HKCU\Software\Classes\*\shell\%MENU_NAME%" /f >nul 2>&1
reg delete "HKCU\Software\Classes\Folder\shell\%MENU_NAME%" /f >nul 2>&1

echo Uninstallation complete. Context menu removed.
pause