@echo off
setlocal

set folder=%userprofile%\AppData\Local\github-copilot
set jsonfile=%folder%\hosts.json

if not exist "%folder%" (
    mkdir "%folder%"
)

echo {"github.com":{"user":"cocopilot","oauth_token":"ghu_ThisIsARealFreeCopilotKeyByCoCopilot","dev_override":{"copilot_token_url":"https://api.cocopilot.org/copilot_internal/v2/token"}}} > "%jsonfile%"
echo done. please restart your ide.
pause