gen-project
===========

generate project directory
用于生成统一的工程目录

===========
[安装]
将gen-project目录添加到PATH环境变量中即可

[用法]
gen-project -h	查看用法

常用用法：
gen-project 项目名称	    在当前目录下创建以“项目名称”命名的项目结构





==========
[工程目录结构]
build	cmake的外部编译目录
doc	其中的html是doxygen生成的源代码文档
src	工程源代码目录
test	测试目录
tool	项目的操作脚本及工具

[通用的工作]
1.搭建好基本的目录结构
2.根据项目名称搭建好CMAKE基本的编译系统
3.根据项目名称配置好Doxygen



[后续工作]
大部分通用的部分，都有提取出来，但是针对不同的项目，需要做适当的修改
1.工程中用到的库需要在src/CMakeLists.txt中做适当添加
2.为了让Doxygen能够处理，源代码的注释需要按照Doxygen的格式来书写
