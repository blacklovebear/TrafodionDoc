### Trafodion 表字段类型
```
data-type is:
    char[acter] [(length [characters])]
          [character set char-set-name]
          [upshift] [[not]casespecific]
  | char[acter] varying (length [characters])
          [character set char-set-name]
          [upshift] [[not]casespecific]
  | varchar (length) [character set char-set-name]
          [upshift] [[not]casespecific]
  | nchar (length) [characters] [upshift] [[not]casespecific]
  | nchar varying(length [characters]) [upshift] [[not] casespecific]
  | numeric [(precision [,scale])] [signed|unsigned]
  | smallint [signed|unsigned]
  | int[eger] [signed|unsigned]
  | largeint
  | dec[imal] [(precision [,scale])] [signed|unsigned]
  | float [(precision)]
  | real
  | double precision
  | date
  | time [(time-precision)]
  | timestamp [(timestamp-precision)]
  | interval { start-field to end-field | single-field }
  | clob
  | blob
```

### 创建 ID自增的表
```
create table test2(
aa  LARGEINT GENERATED ALWAYS AS IDENTITY,
bb  VARCHAR(10)
);
```