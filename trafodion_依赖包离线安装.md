## 离线安装trafodion的依赖包

- 安装下载rpm包的组件
```
 sudo yum install yum-plugin-downloadonly

```
- 下载依赖包
```
yum install --downloadonly --downloaddir=/root/trafodion_downloads/depend_on_rpm pdsh
```