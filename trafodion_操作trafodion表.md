## 操作 Trafodion 表
[参考连接](http://trafodion.apache.org/docs/sql_reference/index.html#accessing_trafodion_sql_tables)

[Trafodion SQL 的语法说明](http://trafodion.apache.org/docs/sql_reference/index.html#sql_statements)

### 创建表
```
CREATE SCHEMA trafodion.sales;
CREATE TABLE trafodion.sales.odetail
( ordernum NUMERIC (6) UNSIGNED NO DEFAULT NOT NULL
, partnum NUMERIC (4) UNSIGNED NO DEFAULT NOT NULL
, unit_price NUMERIC (8,2) NO DEFAULT NOT NULL
, qty_ordered NUMERIC (5) UNSIGNED NO DEFAULT NOT NULL
, PRIMARY KEY (ordernum, partnum)
);
```

### 插入数据
```
INSERT INTO trafodion.sales.odetail VALUES ( 900000, 7301, 425.00, 100 );

-- 利用 upsert
UPSERT [USING LOAD] INTO table [(target-col-list)] {query-expr | values-clause}
target-col-list is:
    column-name[, column-name]...
values-clause is:
    VALUES ( expression[, expression]... )
```

### 切换当前SCHEMA
```
SET SCHEMA trafodion.sales;
```

### 查询数据
```
select * from odetail;

ORDERNUM    PARTNUM  UNIT_PRICE    QTY_ORDERED
----------  -------  ------------  -----------

    900000     7301        425.00          100

```

### 更新统计信息
```
UPDATE STATISTICS FOR TABLE t ON EVERY COLUMN SAMPLE;
```

### 查看统计信息
```
showstats for table t on every column;
```