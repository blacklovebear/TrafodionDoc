## Trafodion访问Hive表中的数据
[参考地址](http://trafodion.apache.org/docs/sql_reference/index.html#ansi_names_for_hive_tables)
### 查看方式
```
set schema hive.hive;

CQD HIVE_MAX_STRING_LENGTH '1000'; -- creates a more readable display
select * from t; -- implicit table name

set schema trafodion.seabase;

select * from hive.hive.t; -- explicit table name
```
*注意trafodion 不支持 hive 中的 varchar(20+) 类型*

### Hive 字段与 Tradofion 对应关系
[参考](http://trafodion.apache.org/docs/sql_reference/index.html#type_mapping_from_hive_to_trafodion_sql)

| Hive Type | Trafodion SQL Type |
| ------| ------ |
| tinyint | smallint |
| smallint | smallint |
| int | int |
| bigint | largeint |
| string | varchar(n bytes) character set utf8 |
| float | real |
| double | float(54) |
| timestamp | timestamp(6) |

### 异常处理
```
SQL>select * from hive.hive.test1;

*** ERROR[1190] Failed to initialize Hive metadata. Call to HiveClient_JNI::init() returned error (5). Cause: 
java.lang.NoClassDefFoundError: org/apache/hadoop/hive/metastore/api/NoSuchObjectException
```
### 解决方案
[解决方案参考](https://mail-archive.com/issues@trafodion.incubator.apache.org/msg04042.html)

1.  将 /usr/hdp/2.4.2.0-258/hive/lib 下面多有的jar文件，加入到
$MY_SQROOT/etc/ms.env 文件中的CLASSPATH中，格式如下
```
CLASSPATH=$CLASSPATH:/usr/hdp/2.4.2.0-258/hive/lib/accumulo-core-1.7.0.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/accumulo-fate-1.7.0.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/accumulo-start-1.7.0.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/accumulo-trace-1.7.0.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/activation-1.1.jar:/usr/hdp/2.4.2.0-258/hive/lib/ant-1.9.1.jar:/usr/hdp/2.4.2.0-258/hive/lib/ant-launcher-1.9.1.jar:/usr/hdp/2.4.2.0-258/hive/lib/antlr-2.7.7.jar:/usr/hdp/2.4.2.0-258/hive/lib/antlr-runtime-3.4.jar:/usr/hdp/2.4.2.0-258/hive/lib/apache-log4j-extras-1.2.17.jar:/usr/hdp/2.4.2.0-258/hive/lib/asm-commons-3.1.jar:/usr/hdp/2.4.2.0-258/hive/lib/asm-tree-3.1.jar:/usr/hdp/2.4.2.0-258/hive/lib/avro-1.7.5.jar:/usr/hdp/2.4.2.0-258/hive/lib/bonecp-0.8.0.RELEASE.jar:/usr/hdp/2.4.2.0-258/hive/lib/calcite-avatica-1.2.0.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/calcite-core-1.2.0.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/calcite-linq4j-1.2.0.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/commons-cli-1.2.jar:/usr/hdp/2.4.2.0-258/hive/lib/commons-codec-1.4.jar:/usr/hdp/2.4.2.0-258/hive/lib/commons-collections-3.2.2.jar:/usr/hdp/2.4.2.0-258/hive/lib/commons-compiler-2.7.6.jar:/usr/hdp/2.4.2.0-258/hive/lib/commons-compress-1.4.1.jar:/usr/hdp/2.4.2.0-258/hive/lib/commons-dbcp-1.4.jar:/usr/hdp/2.4.2.0-258/hive/lib/commons-httpclient-3.0.1.jar:/usr/hdp/2.4.2.0-258/hive/lib/commons-io-2.4.jar:/usr/hdp/2.4.2.0-258/hive/lib/commons-lang-2.6.jar:/usr/hdp/2.4.2.0-258/hive/lib/commons-logging-1.1.3.jar:/usr/hdp/2.4.2.0-258/hive/lib/commons-math-2.1.jar:/usr/hdp/2.4.2.0-258/hive/lib/commons-pool-1.5.4.jar:/usr/hdp/2.4.2.0-258/hive/lib/commons-vfs2-2.0.jar:/usr/hdp/2.4.2.0-258/hive/lib/curator-client-2.6.0.jar:/usr/hdp/2.4.2.0-258/hive/lib/curator-framework-2.6.0.jar:/usr/hdp/2.4.2.0-258/hive/lib/curator-recipes-2.6.0.jar:/usr/hdp/2.4.2.0-258/hive/lib/datanucleus-api-jdo-3.2.6.jar:/usr/hdp/2.4.2.0-258/hive/lib/datanucleus-core-3.2.10.jar:/usr/hdp/2.4.2.0-258/hive/lib/datanucleus-rdbms-3.2.9.jar:/usr/hdp/2.4.2.0-258/hive/lib/derby-10.10.2.0.jar:/usr/hdp/2.4.2.0-258/hive/lib/eigenbase-properties-1.1.5.jar:/usr/hdp/2.4.2.0-258/hive/lib/geronimo-annotation_1.0_spec-1.1.1.jar:/usr/hdp/2.4.2.0-258/hive/lib/geronimo-jaspic_1.0_spec-1.0.jar:/usr/hdp/2.4.2.0-258/hive/lib/geronimo-jta_1.1_spec-1.1.1.jar:/usr/hdp/2.4.2.0-258/hive/lib/groovy-all-2.4.4.jar:/usr/hdp/2.4.2.0-258/hive/lib/guava-14.0.1.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-accumulo-handler-1.2.1000.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-accumulo-handler.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-ant-1.2.1000.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-ant.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-beeline-1.2.1000.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-beeline.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-cli-1.2.1000.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-cli.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-common-1.2.1000.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-common.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-contrib-1.2.1000.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-contrib.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-exec-1.2.1000.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-exec.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-hbase-handler-1.2.1000.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-hbase-handler.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-hwi-1.2.1000.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-hwi.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-jdbc-1.2.1000.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-jdbc-1.2.1000.2.4.2.0-258-standalone.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-jdbc.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-metastore-1.2.1000.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-metastore.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-serde-1.2.1000.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-serde.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-service-1.2.1000.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-service.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-shims-0.20S-1.2.1000.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-shims-0.23-1.2.1000.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-shims-1.2.1000.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-shims-common-1.2.1000.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-shims-common.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-shims.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-shims-scheduler-1.2.1000.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/hive-shims-scheduler.jar:/usr/hdp/2.4.2.0-258/hive/lib/htrace-core-3.1.0-incubating.jar:/usr/hdp/2.4.2.0-258/hive/lib/httpclient-4.4.jar:/usr/hdp/2.4.2.0-258/hive/lib/httpcore-4.4.jar:/usr/hdp/2.4.2.0-258/hive/lib/ivy-2.4.0.jar:/usr/hdp/2.4.2.0-258/hive/lib/janino-2.7.6.jar:/usr/hdp/2.4.2.0-258/hive/lib/jcommander-1.32.jar:/usr/hdp/2.4.2.0-258/hive/lib/jdo-api-3.0.1.jar:/usr/hdp/2.4.2.0-258/hive/lib/jetty-all-7.6.0.v20120127.jar:/usr/hdp/2.4.2.0-258/hive/lib/jetty-all-server-7.6.0.v20120127.jar:/usr/hdp/2.4.2.0-258/hive/lib/jline-2.12.jar:/usr/hdp/2.4.2.0-258/hive/lib/joda-time-2.5.jar:/usr/hdp/2.4.2.0-258/hive/lib/jpam-1.1.jar:/usr/hdp/2.4.2.0-258/hive/lib/json-20090211.jar:/usr/hdp/2.4.2.0-258/hive/lib/jsr305-3.0.0.jar:/usr/hdp/2.4.2.0-258/hive/lib/jta-1.1.jar:/usr/hdp/2.4.2.0-258/hive/lib/libfb303-0.9.2.jar:/usr/hdp/2.4.2.0-258/hive/lib/libthrift-0.9.2.jar:/usr/hdp/2.4.2.0-258/hive/lib/log4j-1.2.16.jar:/usr/hdp/2.4.2.0-258/hive/lib/mail-1.4.1.jar:/usr/hdp/2.4.2.0-258/hive/lib/maven-scm-api-1.4.jar:/usr/hdp/2.4.2.0-258/hive/lib/maven-scm-provider-svn-commons-1.4.jar:/usr/hdp/2.4.2.0-258/hive/lib/maven-scm-provider-svnexe-1.4.jar:/usr/hdp/2.4.2.0-258/hive/lib/mysql-connector-java.jar:/usr/hdp/2.4.2.0-258/hive/lib/netty-3.7.0.Final.jar:/usr/hdp/2.4.2.0-258/hive/lib/opencsv-2.3.jar:/usr/hdp/2.4.2.0-258/hive/lib/oro-2.0.8.jar:/usr/hdp/2.4.2.0-258/hive/lib/paranamer-2.3.jar:/usr/hdp/2.4.2.0-258/hive/lib/parquet-hadoop-bundle-1.6.0.jar:/usr/hdp/2.4.2.0-258/hive/lib/pentaho-aggdesigner-algorithm-5.1.5-jhyde.jar:/usr/hdp/2.4.2.0-258/hive/lib/plexus-utils-1.5.6.jar:/usr/hdp/2.4.2.0-258/hive/lib/protobuf-java-2.5.0.jar:/usr/hdp/2.4.2.0-258/hive/lib/ranger-hive-plugin-shim-0.5.0.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/ranger-plugin-classloader-0.5.0.2.4.2.0-258.jar:/usr/hdp/2.4.2.0-258/hive/lib/regexp-1.3.jar:/usr/hdp/2.4.2.0-258/hive/lib/servlet-api-2.5.jar:/usr/hdp/2.4.2.0-258/hive/lib/snappy-java-1.0.5.jar:/usr/hdp/2.4.2.0-258/hive/lib/ST4-4.0.4.jar:/usr/hdp/2.4.2.0-258/hive/lib/stax-api-1.0.1.jar:/usr/hdp/2.4.2.0-258/hive/lib/stringtemplate-3.2.1.jar:/usr/hdp/2.4.2.0-258/hive/lib/super-csv-2.2.0.jar:/usr/hdp/2.4.2.0-258/hive/lib/velocity-1.5.jar:/usr/hdp/2.4.2.0-258/hive/lib/xz-1.0.jar:/usr/hdp/2.4.2.0-258/hive/lib/zookeeper-3.4.6.2.4.2.0-258.jar
```
    2. 将配置文件拷贝到其他机器
```
pdcp $MY_NODES $MY_SQROOT/etc/ms.env $MY_SQROOT/etc/ms.env
```
    3. 重启服务
```
sqstop and sqstart
```
