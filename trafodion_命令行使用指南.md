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
