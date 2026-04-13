@echo off
setlocal
cd /d "%~dp0"
set "ROOT=%~dp0"
if "%ROOT:~-1%"=="\" set "ROOT=%ROOT:~0,-1%"

if exist "%ROOT%\dist\RunningHubImageGenerator.exe" (
    start "" "%ROOT%\dist\RunningHubImageGenerator.exe"
    exit /b 0
)

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

python -m pip install --upgrade pip
if errorlevel 1 goto :fail

python -m pip install -r "%ROOT%\requirements.txt"
if errorlevel 1 goto :fail

python "%ROOT%\runninghub_image_generator_gui.py"
exit /b %errorlevel%

:no_python
echo Python not found. Please install Python 3.10+ first.
pause
exit /b 1

:fail
echo Failed to start. Please send me the full console output.
pause
exit /b 1
