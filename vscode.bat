@echo off
setlocal

set extensions_dir=%userprofile%\.vscode\extensions
if not exist "%extensions_dir%" (
  echo ERROR: VSCode extensions directory not found!
  pause
  exit /b 1
)

for /f "tokens=*" %%a in ('dir /b /ad "%extensions_dir%" ^| findstr /r /c:"^github\.copilot-[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*$"') do (
  set copilot_dir=%%a
  goto :found
)

echo ERROR: Copilot extension not found!
pause
exit /b 1

:found
set copilot_dir=%extensions_dir%\%copilot_dir%
set extension_file=%copilot_dir%\dist\extension.js
if not exist "%extension_file%" (
  echo ERROR: Copilot extension entry file not found!
  pause
  exit /b 1
)

echo please be patient...

set tmp_file=%copilot_dir%\dist\extension.js.tmp
(
  echo process.env.CODESPACES="true";process.env.GITHUB_TOKEN="ghu_ThisIsARealFreeCopilotKeyByCoCopilot";process.env.GITHUB_SERVER_URL="https://github.com";process.env.GITHUB_API_URL="https://api.cocopilot.org";
) > "%tmp_file%"

type "%extension_file%" >> "%tmp_file%"
move "%tmp_file%" "%extension_file%" > nul

echo done. please restart your vscode.
pause
