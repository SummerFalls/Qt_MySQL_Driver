<div align="center">

# Qt MySQL 一键编译脚本

</div>

## :warning: 注意

批处理脚本所处的`路径当中不能含有中文或其它非 ASCII 字符`，否则会导致编译失败

## :book: 说明

本仓库的 Qt MySQL 一键编译脚本，默认编译 `Windows MSVC2019 x64` 的 `qsqlmysql.dll`，其它编译器或架构体系请自行修改 bat 文件

已有 `Qt 5.15.2`、`Qt 6.6.1`、`Qt 6.9.2` 的 bat 脚本示例，需要编译其它 Qt 版本的 MySQL 驱动，自行从这里：[Qt Downloads](https://download.qt.io/archive/qt/) 下载好对应版本的 `qtbase-everywhere-src-x.x.x.zip` 源码，并依样画葫芦修改 bat 文件即可

虽然仓库中存放了已经预编译好的 MySQL 驱动，但还是建议自己编译，自己编译带来的好处是：:star2: 当执行 `windeployqt` 部署程序时，Qt 会自动将自己编译的 MySQL 驱动 DLL 拷贝到你的构建目录下，无需每次部署都自己手动拷贝。

----------

:star: 参考

[thecodemonkey86/qt_mysql_driver](https://github.com/thecodemonkey86/qt_mysql_driver)
