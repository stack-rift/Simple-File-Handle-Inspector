@echo off
setlocal

set "FILE_MENU_TITLE=Find which process is using this file"
set "FOLDER_MENU_TITLE=Find which process is using this folder"
set "MENU_NAME=FileHandleInspector"
set "APP_DIR=%~dp0"
set "START_BAT=%APP_DIR%.scripts\handle_inspector.bat"
set "ICON_PATH=%APP_DIR%.scripts\icon.ico"

echo Creating context menu...

reg add "HKCU\Software\Classes\*\shell\%MENU_NAME%" /ve /d "%FILE_MENU_TITLE%" /f >nul 2>&1
reg add "HKCU\Software\Classes\*\shell\%MENU_NAME%\command" /ve /d "powershell.exe -Command \"Start-Process -FilePath '%START_BAT%' -ArgumentList '\"%%1\"' -Verb RunAs\"" /f >nul 2>&1
reg add "HKCU\Software\Classes\*\shell\%MENU_NAME%" /v "Icon" /d "%ICON_PATH%" /f >nul 2>&1

reg add "HKCU\Software\Classes\Folder\shell\%MENU_NAME%" /ve /d "%FOLDER_MENU_TITLE%" /f >nul 2>&1
reg add "HKCU\Software\Classes\Folder\shell\%MENU_NAME%\command" /ve /d "powershell.exe -Command \"Start-Process -FilePath '%START_BAT%' -ArgumentList '\"FOLDER%%1\"' -Verb RunAs\"" /f >nul 2>&1
reg add "HKCU\Software\Classes\Folder\shell\%MENU_NAME%" /v "Icon" /d "%ICON_PATH%" /f >nul 2>&1

echo Installation complete. Context menu has been added for files and folders.
pause