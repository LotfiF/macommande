@REM ----------------------------------------------------------------------------
@REM  Copyright 2001-2006 The Apache Software Foundation.
@REM
@REM  Licensed under the Apache License, Version 2.0 (the "License");
@REM  you may not use this file except in compliance with the License.
@REM  You may obtain a copy of the License at
@REM
@REM       http://www.apache.org/licenses/LICENSE-2.0
@REM
@REM  Unless required by applicable law or agreed to in writing, software
@REM  distributed under the License is distributed on an "AS IS" BASIS,
@REM  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@REM  See the License for the specific language governing permissions and
@REM  limitations under the License.
@REM ----------------------------------------------------------------------------
@REM
@REM   Copyright (c) 2001-2006 The Apache Software Foundation.  All rights
@REM   reserved.

@echo off

set ERROR_CODE=0

:init
@REM Decide how to startup depending on the version of windows

@REM -- Win98ME
if NOT "%OS%"=="Windows_NT" goto Win9xArg

@REM set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" @setlocal

@REM -- 4NT shell
if "%eval[2+2]" == "4" goto 4NTArgs

@REM -- Regular WinNT shell
set CMD_LINE_ARGS=%*
goto WinNTGetScriptDir

@REM The 4NT Shell from jp software
:4NTArgs
set CMD_LINE_ARGS=%$
goto WinNTGetScriptDir

:Win9xArg
@REM Slurp the command line arguments.  This loop allows for an unlimited number
@REM of arguments (up to the command line limit, anyway).
set CMD_LINE_ARGS=
:Win9xApp
if %1a==a goto Win9xGetScriptDir
set CMD_LINE_ARGS=%CMD_LINE_ARGS% %1
shift
goto Win9xApp

:Win9xGetScriptDir
set SAVEDIR=%CD%
%0\
cd %0\..\.. 
set BASEDIR=%CD%
cd %SAVEDIR%
set SAVE_DIR=
goto repoSetup

:WinNTGetScriptDir
for %%i in ("%~dp0..") do set "BASEDIR=%%~fi"

:repoSetup
set REPO=


if "%JAVACMD%"=="" set JAVACMD=java

if "%REPO%"=="" set REPO=%BASEDIR%\repo

set CLASSPATH="%BASEDIR%"\etc;"%REPO%"\javax\ejb\javax.ejb-api\3.2\javax.ejb-api-3.2.jar;"%REPO%"\javax\transaction\javax.transaction-api\1.2\javax.transaction-api-1.2.jar;"%REPO%"\org\eclipse\persistence\javax.persistence\2.1.1\javax.persistence-2.1.1.jar;"%REPO%"\joda-time\joda-time\2.4\joda-time-2.4.jar;"%REPO%"\commons-logging\commons-logging\1.1.1\commons-logging-1.1.1.jar;"%REPO%"\joda-time\joda-time-jsptags\1.1.1\joda-time-jsptags-1.1.1.jar;"%REPO%"\org\jasypt\jasypt\1.9.0\jasypt-1.9.0.jar;"%REPO%"\eu\medsea\mimeutil\mime-util\2.1.3\mime-util-2.1.3.jar;"%REPO%"\org\slf4j\slf4j-log4j12\1.5.6\slf4j-log4j12-1.5.6.jar;"%REPO%"\log4j\log4j\1.2.14\log4j-1.2.14.jar;"%REPO%"\mysql\mysql-connector-java\8.0.20\mysql-connector-java-8.0.20.jar;"%REPO%"\com\google\protobuf\protobuf-java\3.6.1\protobuf-java-3.6.1.jar;"%REPO%"\org\slf4j\slf4j-api\1.6.6\slf4j-api-1.6.6.jar;"%REPO%"\com\google\guava\guava\13.0.1\guava-13.0.1.jar;"%REPO%"\com\jolbox\bonecp\0.8.0.RELEASE\bonecp-0.8.0.RELEASE.jar;"%REPO%"\org\glassfish\main\extras\glassfish-embedded-all\5.1.0\glassfish-embedded-all-5.1.0.jar;"%REPO%"\com\sparkjava\spark-core\2.2\spark-core-2.2.jar;"%REPO%"\org\slf4j\slf4j-simple\1.7.7\slf4j-simple-1.7.7.jar;"%REPO%"\org\eclipse\jetty\jetty-server\9.0.2.v20130417\jetty-server-9.0.2.v20130417.jar;"%REPO%"\org\eclipse\jetty\orbit\javax.servlet\3.0.0.v201112011016\javax.servlet-3.0.0.v201112011016.jar;"%REPO%"\org\eclipse\jetty\jetty-http\9.0.2.v20130417\jetty-http-9.0.2.v20130417.jar;"%REPO%"\org\eclipse\jetty\jetty-util\9.0.2.v20130417\jetty-util-9.0.2.v20130417.jar;"%REPO%"\org\eclipse\jetty\jetty-io\9.0.2.v20130417\jetty-io-9.0.2.v20130417.jar;"%REPO%"\org\eclipse\jetty\jetty-webapp\9.0.2.v20130417\jetty-webapp-9.0.2.v20130417.jar;"%REPO%"\org\eclipse\jetty\jetty-xml\9.0.2.v20130417\jetty-xml-9.0.2.v20130417.jar;"%REPO%"\org\eclipse\jetty\jetty-servlet\9.0.2.v20130417\jetty-servlet-9.0.2.v20130417.jar;"%REPO%"\org\eclipse\jetty\jetty-security\9.0.2.v20130417\jetty-security-9.0.2.v20130417.jar;"%REPO%"\com\sparkjava\spark-template-freemarker\2.0.0\spark-template-freemarker-2.0.0.jar;"%REPO%"\org\freemarker\freemarker\2.3.19\freemarker-2.3.19.jar;"%REPO%"\com\heroku\sdk\heroku-jdbc\0.1.1\heroku-jdbc-0.1.1.jar;"%REPO%"\com\sdzee\tp\tp10\0.0.1-SNAPSHOT\tp10-0.0.1-SNAPSHOT.jar

set ENDORSED_DIR=
if NOT "%ENDORSED_DIR%" == "" set CLASSPATH="%BASEDIR%"\%ENDORSED_DIR%\*;%CLASSPATH%

if NOT "%CLASSPATH_PREFIX%" == "" set CLASSPATH=%CLASSPATH_PREFIX%;%CLASSPATH%

@REM Reaching here means variables are defined and arguments have been captured
:endInit

%JAVACMD% %JAVA_OPTS%  -classpath %CLASSPATH% -Dapp.name="startup" -Dapp.repo="%REPO%" -Dapp.home="%BASEDIR%" -Dbasedir="%BASEDIR%" com.sdzee.tp.startup.Main %CMD_LINE_ARGS%
if %ERRORLEVEL% NEQ 0 goto error
goto end

:error
if "%OS%"=="Windows_NT" @endlocal
set ERROR_CODE=%ERRORLEVEL%

:end
@REM set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" goto endNT

@REM For old DOS remove the set variables from ENV - we assume they were not set
@REM before we started - at least we don't leave any baggage around
set CMD_LINE_ARGS=
goto postExec

:endNT
@REM If error code is set to 1 then the endlocal was done already in :error.
if %ERROR_CODE% EQU 0 @endlocal


:postExec

if "%FORCE_EXIT_ON_ERROR%" == "on" (
  if %ERROR_CODE% NEQ 0 exit %ERROR_CODE%
)

exit /B %ERROR_CODE%