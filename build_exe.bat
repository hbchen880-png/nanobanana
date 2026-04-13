@echo off
setlocal
cd /d "%~dp0"
set "ROOT=%~dp0"
if "%ROOT:~-1%"=="\" set "ROOT=%ROOT:~0,-1%"

set "PY_CMD="
where py >nul 2>nul && set "PY_CMD=py"
if not defined PY_CMD where python >nul 2>nul && set "PY_CMD=python"

if not defined PY_CMD goto :no_python

if not exist "%ROOT%\.venv\Scripts\python.exe" (
    "%PY_CMD%" -m venv "%ROOT%\.venv"
    if errorlevel 1 goto :fail
)

call "%ROOT%\.venv\Scripts\activate.bat"
if errorlevel 1 goto :fail

python -m pip install --upgrade pip setuptools wheel
if errorlevel 1 goto :fail

python -m pip install -r "%ROOT%\requirements.txt"
if errorlevel 1 goto :fail

python -m pip install --upgrade pyinstaller
if errorlevel 1 goto :fail

python -c "import tkinter, requests; from PIL import Image, ImageTk; import runninghub_image_generator_gui as m; from pathlib import Path; m.write_embedded_icon_ico(Path('app_icon.ico')); print('precheck ok / icon generated')"
if errorlevel 1 goto :fail

if exist "%ROOT%\build" rmdir /s /q "%ROOT%\build"
if exist "%ROOT%\dist" rmdir /s /q "%ROOT%\dist"

python -m PyInstaller --noconfirm --clean "%ROOT%\RunningHubImageGenerator.spec"
if errorlevel 1 goto :fail

echo.
echo Build finished.
echo EXE: "%ROOT%\dist\RunningHubImageGenerator.exe"
pause
exit /b 0

:no_python
echo Python not found. Please install Python 3.10+ first.
pause
exit /b 1

:fail
echo.
echo Build failed. Please send me the full console output.
pause
exit /b 1
