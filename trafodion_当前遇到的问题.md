## 当前遇到的问题
- 将Hive表数据加载到trafodion，部分数据出现异常
```
*** ERROR[8413] The string argument contains characters that cannot be converted. [2016-10-19 16:45:37]
解决方法：

1.trafodin 中字符类型统一使用 varchar(n bytes) character set utf8 类型
2.CQD HIVE_MAX_STRING_LENGTH '1000'; -- 设置字符串最大长度
3.或者时间格式：2016-01-01 00:00:00.0 出现在字符串中，这种格式的字符有问题
```


- 从trafodion查询带时间字段的hive表，失败报不兼容的时间类型
```
-- This setting is required if there are time-related column types in the target Trafodion table.
CQD ALLOW_INCOMPATIBLE_ASSIGNMENT 'on' ;
```

- 创建表，字段中默认值的字符编码默认是iso88591，用以下语句设置为utf8
```
create table test1(name varchar(10) default _UTF8'test');

```

- 删除表失败，并报错
[解决方案参考](https://cwiki.apache.org/confluence/display/TRAFODION/Metadata+Cleanup)
```
11:10:54 SQL>drop table EX_DC_SZPL_PROJECT_SUITE_INFO;

*** ERROR[2006] Internal error: assertion failure (keyColOffset == totalKeyLength) in file  at line -99999. [2016-12-02 11:11:26]
*** ERROR[8839] Transaction was aborted. [2016-12-02 11:11:26]

解决办法：
cleanup table EX_DC_SZPL_PROJECT_SUITE_INFO;
cleanup metadata, check, return details;
```

- 批量将hive中的数据load到trafodion中出现异常
```
load into excrawler.EX_DC_SZPL_PROJECT_SUITE_INFO 
+>select * from hive.hive.EX_DC_SZPL_PROJECT_SUITE_INFO;
                     
*** ERROR[8448] Unable to access Hbase interface. Call to ExpHbaseInterface::addToHFile returned error HBASE_ADD_TO_HFILE_ERROR(-713). Cause: 
java.lang.OutOfMemoryError: Direct buffer memory
java.nio.Bits.reserveMemory(Bits.java:658)
java.nio.DirectByteBuffer.<init>(DirectByteBuffer.java:123)
java.nio.ByteBuffer.allocateDirect(ByteBuffer.java:306)
org.apache.hadoop.hbase.util.ByteBufferArray.<init>(ByteBufferArray.java:65)
org.apache.hadoop.hbase.io.hfile.bucket.ByteBufferIOEngine.<init>(ByteBufferIOEngine.java:47)
org.apache.hadoop.hbase.io.hfile.bucket.BucketCache.getIOEngineFromName(BucketCache.java:307)
org.apache.hadoop.hbase.io.hfile.bucket.BucketCache.<init>(BucketCache.java:217)
org.apache.hadoop.hbase.io.hfile.CacheConfig.getBucketCache(CacheConfig.java:614)
org.apache.hadoop.hbase.io.hfile.CacheConfig.getL2(CacheConfig.java:553)
org.apache.hadoop.hbase.io.hfile.CacheConfig.instantiateBlockCache(CacheConfig.java:637)
org.apache.hadoop.hbase.io.hfile.CacheConfig.<init>(CacheConfig.java:231)
org.trafodion.sql.HBulkLoadClient.doCreateHFile(HBulkLoadClient.java:209)
org.trafodion.sql.HBulkLoadClient.addToHFile(HBulkLoadClient.java:245)
. [2016-12-02 17:55:40]

----------解决办法----------------
hbase.bucketcache.ioengine 设置为空
之前的默认值是 hbase.bucketcache.ioengine=offheap
```

- Trafodion JDBC连接栈溢出
解决办法
```
$SQ_ROOT/dcs-2.0.1/conf/dcs-env.sh
# 修改大一点，单位为MB
export DCS_HEAPSIZE=2048
```

- Trafodion Master挂掉问题
解决办法将master的内存调大：DCS_HEAPSIZE=4096
```
core 文件
#0  0x00000036ae0325e5 in raise () from /lib64/libc.so.6
#1  0x00000036ae033dc5 in abort () from /lib64/libc.so.6
#2  0x00007f7960440aef in sqInit () at ../cli/CliExtern.cpp:881
#3  0x00007f7960440b9d in CliNonPrivPrologue () at ../cli/CliExtern.cpp:921
#4  0x00007f7960444503 in SQL_EXEC_CreateContext (context_handle=0x2ec82f0, sqlAuthId=0x0, forFutureUse=0) at ../cli/CliExtern.cpp:1448
#5  0x00007f7962573866 in CONNECT (pSrvrConnect=0x2ec82f0) at native/SqlInterface.cpp:2841
#6  0x00007f796256ce30 in SRVR_CONNECT_HDL::sqlConnect (this=0x2ec82f0, uid=<value optimized out>, pwd=<value optimized out>) at native/CSrvrConnect.cpp:113
#7  0x00007f796257edbd in Java_org_trafodion_jdbc_t2_SQLMXConnection_connect (jenv=0x2cba9e8, jobj=0x7f7959053370, server=<value optimized out>, uid=0x0, pwd=0x0)
    at native/SQLMXConnection.cpp:210
```

- Hbase RegionServer 挂掉
```
将zookeeper的超时时间，调整为3分钟
将RegionServer的-Xmx最大内存调大
```

- Trafodion 启动失败
```
Exception in thread "main" java.lang.NoSuchMethodError: org.slf4j.spi.LocationAwareLogger.log(Lorg/slf4j/Marker;Ljava/lang/String;ILjava/lang/String;[Ljava/lang/Object;Ljava/lang/Throwable;)V
    at org.apache.commons.logging.impl.SLF4JLocationAwareLog.debug(SLF4JLocationAwareLog.java:133)
    at org.trafodion.dcs.zookeeper.ZkClient.init(ZkClient.java:124)
    at org.trafodion.dcs.zookeeper.ZkClient.<init>(ZkClient.java:133)
    at org.trafodion.dcs.zookeeper.ZkUtil.main(ZkUtil.java:86)

解决方法：
修改文件：dcs-2.0.1/conf/dcs-env.sh
export DCS_CLASSPATH=${DCS_CLASSPATH}:/usr/hdp/2.4.2.0-258/hbase/lib/slf4j-api-1.7.7.jar:

修改文件：./dcs-2.0.1/bin/dcs
# Add user-specified CLASSPATH last
if [ "$DCS_CLASSPATH" != "" ]; then
  CLASSPATH=${DCS_CLASSPATH}:${CLASSPATH}
fi


pdcp -r -w xdata[68-71] /home/trafodion/apache-trafodion_server/dcs-2.0.1/* /home/trafodion/apache-trafodion_server/dcs-2.0.1/
```