@ECHO OFF

REM unset variable
SET JAVA_VERSION=

REM try to lead JRE version from registry
SET JAVA_KEY=HKLM\Software\JavaSoft\Java Runtime Environment
REM SET JAVA_KEY=HKLM\Software\JavaSoft\Java Development Kit
SET cmd="REG QUERY "%JAVA_KEY%" /v CurrentVersion | FIND "CurrentVersion""
FOR /F "tokens=3" %%i IN ('%cmd%') DO @set JAVA_VERSION=%%i
IF DEFINED JAVA_VERSION (
	GOTO :SetJH
)
REM try to load JDK version from registry
SET JAVA_KEY=HKLM\Software\JavaSoft\Java Development Kit
SET cmd="REG QUERY "%JAVA_KEY%" /v CurrentVersion | FIND "CurrentVersion""
FOR /F "tokens=3" %%i IN ('%cmd%') DO @set JAVA_VERSION=%%i
IF DEFINED JAVA_VERSION (
	GOTO :SetJH
)
GOTO :NoJH

:SetJH
SET JH_PATH=
SET cmd="REG QUERY "%JAVA_KEY%\%JAVA_VERSION%" /v JavaHome | FIND "JavaHome""
FOR /F "tokens=2*" %%i IN ('%cmd%') DO set JH_PATH=%%j
IF NOT DEFINED JH_PATH (
	GOTO :NoJH
)
SET JAVA_HOME=%JH_PATH%
:SetJHEnd

ECHO Found Java home: %JAVA_HOME%
PAUSE
EXIT /B 0

:NoJH
ECHO Unable find JavaHome in Registry
PAUSE
EXIT /B 1


