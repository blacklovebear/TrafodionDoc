## 利用 odbc 将mysql中的数据导入到trafodion表中
### 安装 trafodion 驱动
- 安装配置 trafodion 的 odbc连接
- 安装 trafodion 驱动，参考以下链接 [参考](http://blog.csdn.net/post_yuan/article/details/52667208)
- 配置文件内容如下
```
cat /etc/odbc.ini 

[traf]  
Description                 = Trafodion DSN  
Driver                      = Trafodion  
Catalog                     = TRAFODION  
Schema                      = AGENT_CLOUD  
DataLang                    = 0  
FetchBufferSize             = SYSTEM_DEFAULT  
Server                      = TCP:172.18.84.81:23400  
SQL_ATTR_CONNECTION_TIMEOUT = SYSTEM_DEFAULT  
SQL_LOGIN_TIMEOUT           = SYSTEM_DEFAULT  
SQL_QUERY_TIMEOUT           = NO_TIMEOUT  
ServiceName                 = TRAFODION_DEFAULT_SERVICE  


cat /etc/odbcinst.ini
[Trafodion]  
Description     = ODBC for Trafodion  
Driver64        = /usr/lib64/libtrafodbc_drvr64.so  
Setup64         = /usr/lib64/libtrafodbc_drvr64.so  
FileUsage       = 1 

```

### 安装mysql驱动
- 安装驱动
sudo yum install mysql-connector-odbc
- 配置
```
cat /etc/odbc.ini 
[mysql]
CHARSET      = utf8
Driver       = MySQL 
Description  = Connector/ODBC 3.51 Driver DSN
SERVER       = 172.18.84.244 
PORT         = 3306
USER         = admin
Password     = admin
Database     = agent_cloud
OPTION       = 3
Socket                = /var/lib/mysql/mysql.sock

cat /etc/odbcinst.ini
[MySQL]
Description = ODBC for MySQL
Driver      = /usr/lib/libmyodbc5.so
Setup       = /usr/lib/libodbcmyS.so
Driver64    = /usr/lib64/libmyodbc5.so
Setup64     = /usr/lib64/libodbcmyS.so
FileUsage   = 1
```

- 导入数据
```
odb64luo -casesens -u admin:zz -p admin:zz -d mysql:traf -cp src=house_product_question:tgt=trafodion.agent_cloud.house_product_question:splitby=question_id:parallel=4:loadcmd=UL
```