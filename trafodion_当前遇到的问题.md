## 当前遇到的问题
- 将Hive表数据加载到trafodion，部分数据出现异常
```
*** ERROR[8413] The string argument contains characters that cannot be converted. [2016-10-19 16:45:37]
解决方法：

1.trafodin 中字符类型统一使用 varchar(n bytes) character set utf8 类型
2.CQD HIVE_MAX_STRING_LENGTH '1000'; -- 设置字符串最大长度
```

- 超过两个连接出现连接失败
Zookeeper配置最大客户端连接数
```
解决方法：

要在Hortonworks集群上的Zookeeper中配置最大客户端连接，请执行以下操作：
1.登录Ambari gui界面
2.点击左边的Zookeeper
3.选择顶部标签的"Configs"
4.滚动至底部并点击"Customer zoo.cfg"
5.选择"Add Property..."
maxClientCnxns   40

6.点击"Add"
7.重启Ambari
8.停止Trafodion （在终端运行sqstop）
9.启动Trafodion （在终端运行sqstart）
```

- 从trafodion查询带时间字段的hive表，失败报不兼容的时间类型
```
-- This setting is required if there are time-related column types in the target Trafodion table.
CQD ALLOW_INCOMPATIBLE_ASSIGNMENT 'on' ;
```