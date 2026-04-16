@echo off
setlocal

echo ========================================
echo College Event Project - Build ^& Deploy
echo ========================================

:: User can override this environment variable
if not defined TOMCAT_HOME (
    set "TOMCAT_HOME=C:\Program Files\Apache Software Foundation\Tomcat 10.1"
)

:: Validate Tomcat directory exists
if not exist "%TOMCAT_HOME%\bin\catalina.bat" (
    echo.
    echo ERROR: Tomcat not found at "%TOMCAT_HOME%".
    echo Please verify your Tomcat installation or set the TOMCAT_HOME environment variable correctly.
    pause
    exit /b 1
)

:: Ensure we are starting from the batch file's directory
cd /d "%~dp0"

echo.
echo 1. Building project with Maven...
cd /d "%~dp0CollegeEvents"
call mvn clean install

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: Maven build failed!
    pause
    exit /b 1
)

echo.
echo 2. Build successful!
set "WAR_FILE=%~dp0CollegeEvents\target\CollegeEvents.war"
echo WAR file: %WAR_FILE%

:: Check if the WAR file exists
if not exist "%WAR_FILE%" (
    echo.
    echo ERROR: WAR file not found after build!
    pause
    exit /b 1
)

echo.
echo 3. Copying WAR file to Tomcat webapps directory...
copy /Y "%WAR_FILE%" "%TOMCAT_HOME%\webapps\"

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: Failed to copy WAR file to Tomcat webapps directory!
    echo Ensure you have administrative privileges if copying to a protected directory.
    pause
    exit /b 1
)
echo WAR file copied successfully.

echo.
echo 4. Stopping Tomcat server if running...
call "%TOMCAT_HOME%\bin\shutdown.bat" >nul 2>&1
:: Wait briefly to allow Tomcat to gracefully shut down so port binds are released
timeout /t 3 /nobreak >nul 2>&1

echo.
echo 5. Starting Tomcat server...
call "%TOMCAT_HOME%\bin\startup.bat"

echo.
echo 6. Deployment complete!
pause

endlocal