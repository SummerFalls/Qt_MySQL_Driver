echo off
@REM 切换 CMD 的代码页为 UTF-8 编码，与本 BAT 文件编码一致，否则以下中文乱码
chcp 65001

set "PRINT=powershell -Command Write-Host -ForegroundColor Red -BackgroundColor Yellow"

echo.
echo.
%PRINT% "运行本 BAT 文件前，请先解压好 qtbase-everywhere-src-5.15.2.zip"
echo.
echo.
%PRINT% "请确认以下环境已具备"
echo 1. 通过 Visual Studio 2022 安装了微软 C++ Desktop Toolkit 桌面开发套件（MSVC 编译器）
echo 2. 通过 Qt Maintenance Tool 安装了 CMake、Ninja、MSVC 2019 64-bit
echo.
echo.
%PRINT% "请确认以下目录或文件是否存在"
echo C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat
echo C:\Qt\Tools\CMake_64\bin
echo C:\Qt\Tools\Ninja
echo C:\Qt\5.15.2\msvc2019_64\bin
echo.
echo.
%PRINT% "编译开始前，请先打开目录 C:\Qt\5.15.2\msvc2019_64\plugins\sqldrivers 以便观察编译结束后是否出现编译好的数据库驱动 dll 文件"
echo.
echo.
%PRINT% "按回车键开始编译..."
pause

set PATH=%PATH%;C:\Qt\Tools\CMake_64\bin;C:\Qt\Tools\Ninja;C:\Qt\5.15.2\msvc2019_64\bin
set "CURRENT_DIR=%~dp0"
cd /D %CURRENT_DIR%\qtbase-everywhere-src-5.15.2\src\plugins\sqldrivers
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" x64
qmake -version
qmake -- MYSQL_INCDIR="%CURRENT_DIR%\..\MySQL Server 8.0\include" MYSQL_LIBDIR="%CURRENT_DIR%\..\MySQL Server 8.0\lib"
nmake sub-mysql
nmake install

echo.
echo.
echo.
%PRINT% "编译结束，请确认 C:\Qt\5.15.2\msvc2019_64\plugins\sqldrivers 目录下是否已出现编译好的数据库驱动 dll 文件"
pause