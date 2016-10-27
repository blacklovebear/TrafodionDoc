## 离线安装trafodion的依赖包

- 安装下载rpm包的组件
```
 sudo yum install yum-plugin-downloadonly

```
- 下载依赖包
```
package_list: epel pdsh apr apr-util sqlite expect perl-DBD-SQLite* protobuf xerces-c perl-Params-Validate perl-Time-HiRes gzip lzo lzop unzip

yum install --downloadonly --downloaddir=/root/trafodion_downloads/depend_on_rpm xxx
```

- 从本地安装rpm
```
yum --nogpgcheck localinstall xxx.rpm
```