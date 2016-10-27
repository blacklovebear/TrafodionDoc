## Trafodion命令行使用指南

### 连接方式
到 Trafodion 安装服务器的 trafodion 用户下执行以下命令
```
trafci
```

### 常用命令
[官方文档](http://trafodion.apache.org/docs/command_interface/index.html#commands)

```
查看任何命令的帮助信息
help [command];    eg: help show;

查看所有表
show tables;

查看表结构
showddl [test1]

参看所有Schema
show schemas;

查看历史命令
history;

查看当前的所有环境变量
env;

查看表结构
invoke [table_name]


...
```

### 有用命令
```
让命令行显示时间
SET TIME ON

显示SQL执行耗费时间
SET TIMING ON

设置当前schema
SET SCHEMA xxx.xxx;

查看当前schema
SHOW SCHEMA

重复执行上一条sql命令
/, RUN, or REPEAT

查看上条sql语句的 statistics 分析信息
GET STATISTICS

格式化查询结果，使结果更美观
SET COLSEP |

展示每次sql操作的 STATISTICS 分析信息
SET STATISTICS ON
```
