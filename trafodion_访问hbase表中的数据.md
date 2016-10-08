## Trafodion访问Hbase表中的数据
[参考连接](http://trafodion.apache.org/docs/sql_reference/index.html#cell_per_row_access_to_hbase_tables)

### 在Hbase中新建测试表,并插入数据
```
create 'scores','grade', 'course'
put 'scores','Tom','grade:','5'
put 'scores','Tom','course:math','97'
put 'scores','Tom','course:art','87'
put 'scores','Jim','grade','4'
put 'scores','Jim','course:','89'
put 'scores','Jim','course:','80'

scan 'scores'
ROW                         COLUMN+CELL                                                                 
 Jim                        column=course:, timestamp=1475895544527, value=80                           
 Jim                        column=grade:, timestamp=1475895543628, value=4                             
 Tom                        column=course:art, timestamp=1475895543602, value=87                        
 Tom                        column=course:math, timestamp=1475895543561, value=97                       
 Tom                        column=grade:, timestamp=1475895543512, value=5 
```

### 在Trafodion中访问 Hbase表
先使用 sqlci 连接 Trafodion

- 按分列的模式访问( Cell-Per-Row Access to HBase Tables )
```
invoke hbase."_CELL_"."scores";
  (
  ROW_ID        VARCHAR(100)    ...
, COL_FAMILY    VARCHAR(100)    ...
, COL_NAME      VARCHAR(100)    ...
, COL_TIMESTAMP LARGEINT        ...
, COL_VALUE     VARCHAR(1000) ...
)
PRIMARY KEY (ROW_ID)

select * from hbase."_CELL_"."scores";
```


- 按将列合并为一行的模式访问( Rowwise Access to HBase Tables )
```
invoke hbase."_ROW_"."scores";
(
  ROW_ID VARCHAR(100) ...
, COLUMN_DETAILS VARCHAR(10000) ...
)
PRIMARY KEY (ROW_ID)

select * from hbase."_ROW_"."scores";
```
