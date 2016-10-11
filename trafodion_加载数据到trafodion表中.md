## 加载数据方法
[参考](https://cwiki.apache.org/confluence/display/TRAFODION/Data+Loading)

- 先将数据加载到Hive表中
- 建好trafodion表
- 将数据从hive表加载到trafodion表

*正确的创建trafodion表，添加一些参数配置*
```
create table trafodion.sch.demo
(
demo_sk int not null,
name varchar(100),
primary key (demo_sk)
)
hbase_options
(
DATA_BLOCK_ENCODING = 'FAST_DIFF',
COMPRESSION = 'SNAPPY',
MEMSTORE_FLUSH_SIZE = '1073741824'
)
salt using 8 partitions on (demo_sk);


create index demo_ix on sch.demo(name)
hbase_options
(
DATA_BLOCK_ENCODING = 'FAST_DIFF',
COMPRESSION = 'GZ'
)
salt like table;
```