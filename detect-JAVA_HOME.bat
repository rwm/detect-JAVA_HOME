@ECHO OFF
REM *
REM * Copyright (c) 2012, Raphael W. Majeed
REM * All rights reserved.
REM * 
REM * Redistribution and use in source and binary forms, with or without
REM * modification, are permitted provided that the following conditions are met: 
REM * 
REM * 1. Redistributions of source code must retain the above copyright notice, this
REM *    list of conditions and the following disclaimer. 
REM * 2. Redistributions in binary form must reproduce the above copyright notice,
REM *    this list of conditions and the following disclaimer in the documentation
REM *    and/or other materials provided with the distribution. 
REM * 
REM * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
REM * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
REM * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
REM * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
REM * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
REM * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
REM * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
REM * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
REM * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
REM * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
REM * 
REM * The views and conclusions contained in the software and documentation are those
REM * of the authors and should not be interpreted as representing official policies, 
REM * either expressed or implied, of the FreeBSD Project.
REM * 

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


