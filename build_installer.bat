@echo off
setlocal
cd /d "%~dp0"

if not exist "%~dp0dist\NanoBananaImageGenerator.exe" (
    echo dist\NanoBananaImageGenerator.exe not found. Please run build_exe.bat first.
    pause
    exit /b 1
)

set "ISCC="
if exist "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" set "ISCC=C:\Program Files (x86)\Inno Setup 6\ISCC.exe"
if not defined ISCC if exist "C:\Program Files\Inno Setup 6\ISCC.exe" set "ISCC=C:\Program Files\Inno Setup 6\ISCC.exe"

if not defined ISCC (
    echo Inno Setup 6 not found. Please install it first.
    echo Download and install Inno Setup 6, then run this script again.
    pause
    exit /b 1
)

"%ISCC%" "%~dp0installer.iss"
if errorlevel 1 (
    echo.
    echo Installer build failed.
    pause
    exit /b 1
)

echo.
echo Installer build finished.
echo Setup EXE: "%~dp0installer_dist\NanoBananaImageGenerator_Setup.exe"
pause
exit /b 0
