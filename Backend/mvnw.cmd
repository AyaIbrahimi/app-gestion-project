@REM ----------------------------------------------------------------------------
@REM Licensed to the Apache Software Foundation (ASF) under one
@REM or more contributor license agreements.  See the NOTICE file
@REM distributed with this work for additional information
@REM regarding copyright ownership.  The ASF licenses this file
@to you under the Apache License, Version 2.0 (the
@REM "License"); you may not use this file except in compliance
@REM with the License.  You may obtain a copy of the License at
@REM
@REM    https://www.apache.org/licenses/LICENSE-2.0
@REM
@REM Unless required by applicable law or agreed to in writing,
@REM software distributed under the License is distributed on an
@REM "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
@REM KIND, either express or implied.  See the License for the
@REM specific language governing permissions and limitations
@REM under the License.
@REM ----------------------------------------------------------------------------

@REM ----------------------------------------------------------------------------
@REM Apache Maven Wrapper startup batch script, version 3.3.4
@REM ----------------------------------------------------------------------------

@echo off
@setlocal

set ERROR_CODE=0

@REM set %~dp0% to MAVEN_BASEDIR
set MAVEN_BASEDIR=%~dp0
if not "%MAVEN_BASEDIR%"=="" set MAVEN_BASEDIR=%MAVEN_BASEDIR:~0,-1%

set MAVEN_PROJECTBASEDIR=%MAVEN_BASEDIR%

@REM Find maven.config file
set MAVEN_CONFIG_FILE=%MAVEN_PROJECTBASEDIR%\.mvn\maven.config
if not exist "%MAVEN_CONFIG_FILE%" goto endMavenConfig
set MAVEN_CONFIG=
for /f "usebackq delims=" %%a in ("%MAVEN_CONFIG_FILE%") do set MAVEN_CONFIG=!MAVEN_CONFIG! %%a
:endMavenConfig

@REM Find maven-wrapper.properties file
set MAVEN_WRAPPER_PROPERTIES=%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.properties
if not exist "%MAVEN_WRAPPER_PROPERTIES%" (
  echo Error: Could not find %MAVEN_WRAPPER_PROPERTIES% 1>&2
  exit /b 1
)

@REM Execute Maven command
where mvn >nul 2>nul
if %ERRORLEVEL% equ 0 (
  mvn %*
  goto end
)

echo Error: Maven is not installed or not in PATH. Please install Apache Maven or use IntelliJ/Eclipse to run DxcPlatformApplication.java. 1>&2
exit /b 1

:end
cmd /c exit /b %ERROR_CODE%
