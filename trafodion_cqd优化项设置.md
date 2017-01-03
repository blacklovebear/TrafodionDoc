
- 设置默认列的字符集
cqd traf_default_col_charset 'UTF8';

- 不将clob转换为 varchar
trafodion 支持类型clob，blob
cqd TRAF_CLOB_AS_VARCHAR 'off';