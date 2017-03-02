- 查看正在执行的sql
```
cd export/limited-support-tools/LSO/
./offender -s active

```

- 根据 qid查看统计信息
```
查询到qid之后，我们便可以通过qid的值来查看这条QUERY的运行时统计信息，如下，
get statistics for qid MXID11002008570212346814433077581000000000506U3333300_602_SQL_CUR_2 default;
```

- 取消正在执行的sql
```
control query cancel qid MXID11002010007212346654506930135000000001506U3333300_2936_SQL_CUR_2;
```

