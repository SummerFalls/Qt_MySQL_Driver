<div align="center">

# Qt MySQL 一键编译脚本

</div>

## :warning: 注意

1. 批处理脚本所处的`路径当中不能含有中文或其它非 ASCII 字符`，否则会导致编译失败
2. 运行 BAT 批处理脚本之前，请先解压批处理脚本所在目录下的 qtbase-everywhere-src-`x.x.x`.zip

## :book: 说明

本仓库的 Qt MySQL 一键编译脚本，默认编译 `Windows MSVC2019 x64` 的 `qsqlmysql.dll`，其它编译器或架构体系请自行修改 bat 文件

已有 `Qt 5.15.2`、`Qt 6.6.1`、`Qt 6.9.2` 的 bat 脚本示例，需要编译其它 Qt 版本的 MySQL 驱动，自行从这里：[Qt Downloads](https://download.qt.io/archive/qt/) 下载好对应版本的 `qtbase-everywhere-src-x.x.x.zip` 源码，并依样画葫芦修改 bat 文件即可

虽然仓库中存放了已经预编译好的 MySQL 驱动，但还是建议自己编译，自己编译带来的好处是：当执行 `windeployqt` 部署程序时，Qt 会自动将自己编译的 MySQL 驱动 DLL 拷贝到你的构建目录下，无需每次部署都自己手动拷贝。

### 发布程序目录结构（MySQL 相关）

> `MySQL 8.0.34.0` 之后的版本，OpenSSL 需要使用 `3.X` 版本的 DLL

- 程序目录
  - :open_file_folder: sqldrivers
    - :gear: qsqlmysql.dll
  - :gear: libmysql.dll
  - :gear: libcrypto-3-x64.dll
  - :gear: libssl-3-x64.dll
  - <程序名>.exe
  - <其它文件>

> `MySQL 8.0.34.0` 之前的版本，OpenSSL 需要使用 `1.X.X` 版本的 DLL

- 程序目录
  - :open_file_folder: sqldrivers
    - :gear: qsqlmysql.dll
  - :gear: libmysql.dll
  - :gear: libcrypto-1_1-x64.dll
  - :gear: libssl-1_1-x64.dll
  - <程序名>.exe
  - <其它文件>

----------

<div align="center">

## :warning: 如果你想手动编译 MySQL 驱动，请看下文 :warning:

</div>

## :compass: Qt MySQL 驱动手动编译指南

### 概述

:warning: 以下示例以编译 64 位的 MySQL 驱动为例
:warning: 以下任何一项不匹配，都将可能导致 `QSqlDatabase: QMYSQL driver not loaded` 错误而无法连接数据库

1. :warning: Qt 编译器位宽必须与 MySQL 库位宽一致
2. :warning: 从 MySQL 8.0 开始官方只提供 64 位版本的库，故要求 Qt 同样使用 64 位版本的编译器进行编译
3. :warning: OpenSSL 库版本以及位宽也同样必须与 MySQL 库相匹配
   - > `MySQL 8.0.34.0` 之后的版本，OpenSSL 需要使用 `3.X` 版本的 DLL
     - :gear: libcrypto-3-x64.dll
     - :gear: libssl-3-x64.dll
   - > `MySQL 8.0.34.0` 之前的版本，OpenSSL 需要使用 `1.X.X` 版本的 DLL
     - :gear: libcrypto-1_1-x64.dll
     - :gear: libssl-1_1-x64.dll

### 文件准备

1. MySQL 下载：https://dev.mysql.com/downloads/windows/installer/
2. Qt 库源码下载（无需在 Qt Maintenance Tool 里面下载整个 Qt 库的源码，只需要在此站下载需要的单个包 `qtbase-everywhere-src-X.X.X.zip` 即可 ）：https://download.qt.io/official_releases/qt/
   1. 5.15.2：https://download.qt.io/official_releases/qt/5.15/5.15.2/submodules/qtbase-everywhere-src-5.15.2.zip
   2. 6.6.1：https://download.qt.io/official_releases/qt/6.6/6.6.1/submodules/qtbase-everywhere-src-6.6.1.zip
3. OpenSSL 库下载（由第三方构建，OpenSSL 官方组织只发布源码，但不构建编译好的库）：https://www.firedaemon.com/download-firedaemon-openssl

### 编译 MySQL qsqlmysql.dll

1. :warning: 按以下步骤编译完成后，会自动将 `qsqlmysql.dll` 和 `qsqlmysqld.dll` 拷贝到编译器相应目录，例如：`C:\Qt\5.15.2\msvc2019_64\plugins\sqldrivers`，之后在发布工程二进制程序时使用 `windeployqt` 命令，会自动将 MySQL 驱动拷贝到工程 Build 目录下
2. :warning: Qt 5 和 Qt 6 的编译命令有所不同，请将以下代码复制后另存为 `.bat` 批处理文件，修改当中的 `参数` 和 `目录` 以对应你的实际环境和存放目录，之后再双击运行即可开始编译：

#### Qt 5

```bat
@REM Qt5 qmake 编译 MySQL qsqlmysql.dll
@REM 1. Install MSVC Compiler (C++ Desktop Toolkit from Visual Studio 2022 Setup)
@REM 2. Install Qt include Sources, CMake and Ninja from Maintenance Tool
@REM 3. Install MySQL library by using Oracle's Installer
set PATH=%PATH%;C:\Qt\Tools\CMake_64\bin;C:\Qt\Tools\Ninja;C:\Qt\5.15.2\msvc2019_64\bin
cd /D C:\qtbase-everywhere-src-5.15.2\src\plugins\sqldrivers
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" x64
qmake -version
qmake -- MYSQL_INCDIR="C:\Program Files\MySQL\MySQL Server 8.0\include" MYSQL_LIBDIR="C:\Program Files\MySQL\MySQL Server 8.0\lib"
nmake sub-mysql
nmake install
pause
```

#### Qt 6

```bat
@REM Qt6 cmake 编译 MySQL qsqlmysql.dll
@REM Building from source (Qt6/CMake)
@REM 1. Install MSVC Compiler (C++ Desktop Toolkit from Visual Studio 2022 Setup)
@REM 2. Install Qt include Sources, CMake and Ninja from Maintenance Tool
@REM 3. Install MySQL library by using Oracle's Installer
set PATH=%PATH%;C:\Qt\Tools\CMake_64\bin;C:\Qt\Tools\Ninja;C:\Qt\6.6.1\msvc2019_64\bin
cd /D C:\qtbase-everywhere-src-6.6.1\src\plugins\sqldrivers
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" x64
call C:\Qt\6.6.1\msvc2019_64\bin\qt-cmake.bat -G "Ninja Multi-Config" . -DMySQL_INCLUDE_DIR="C:\Program Files\MySQL\MySQL Server 8.0\include" -DMySQL_LIBRARY="C:\Program Files\MySQL\MySQL Server 8.0\lib\libmysql.lib" -DCMAKE_INSTALL_PREFIX="C:\Qt\6.6.1\msvc2019_64" -DCMAKE_CONFIGURATION_TYPES=Release;Debug
ninja
ninja install
pause
```

----------

:star: 参考

[thecodemonkey86/qt_mysql_driver](https://github.com/thecodemonkey86/qt_mysql_driver)
