## 加载数据方法
[参考1](https://cwiki.apache.org/confluence/display/TRAFODION/Data+Loading)

[参考2](http://trafodion.apache.org/docs/2.0.0/load_transform/index.html)

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

- 例子
```
CQD HIVE_MAX_STRING_LENGTH '1000' ;

--This setting is required if there are time-related column types in the target Trafodion table.
CQD ALLOW_INCOMPATIBLE_ASSIGNMENT 'on' ;

LOAD WITH NO POPULATE INDEXES INTO trafodion.sch.demo SELECT * FROM hive.hive.demo ;
```



## Compression and Data Block Encoding In HBase
[参考](http://hbase.apache.org/book.html#compression)

### 数据编码
Fast Diff is the recommended codec to use if you have long keys or many columns.

- If you have long keys (compared to the values) or many columns, use a prefix encoder. FAST_DIFF is recommended, as more testing is needed for Prefix Tree encoding.

- If the values are large (and not precompressed, such as images), use a data block compressor.

- Use GZIP for cold data, which is accessed infrequently. GZIP compression uses more CPU resources than Snappy or LZO, but provides a higher compression ratio.

- Use Snappy or LZO for hot data, which is accessed frequently. Snappy and LZO use fewer CPU resources than GZIP, but do not provide as high of a compression ratio.

- In most cases, enabling Snappy or LZO by default is a good choice, because they have a low performance overhead and provide space savings.

- Before Snappy became available by Google in 2011, LZO was the default. Snappy has similar qualities as LZO but has been shown to perform better.

