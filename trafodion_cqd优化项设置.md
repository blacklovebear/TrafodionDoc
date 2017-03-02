

- Trafodion CQD 优化项
```
SET TIME ON
SET TIMING ON
SET COLSEP |
--SET STATISTICS ON
cqd DEFAULT_CHARSET 'UTF8';
cqd INPUT_CHARSET 'UTF8';
cqd TERMINAL_CHARSET 'UTF8';
-- 设置默认列的字符集
cqd TRAF_DEFAULT_COL_CHARSET 'UTF8';
-- 不将clob转换为 varchar
cqd TRAF_CLOB_AS_VARCHAR 'off';
-- 增加写进程的个数(通过增加esp并发数，如果使用odb工具的话创建多个连接)可以提高吞吐量
-- cqd PARALLEL_NUM_ESPS xx
```

- 表优化，数据加载的时候使用，对齐存储
```
create table ta
(a char(15) not null primary key,b int) 
attribute aligned format;
```
