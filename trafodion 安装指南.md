## trafodion 安装指南

- [参考指引-中文](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=61324685)
- [参考指引-英文](http://trafodion.apache.org/install.html)


## 注意点

- 禁用requiretty
```
为了确保requiretty不被使用，在/etc/sudoers文件里注释掉“Defaults requiretty”。
```
- 各个节点依赖包安装
``` shell
sudo yum install alsa-lib-devel ant ant-nodeps boost-devel cmake
    device-mapper-multipath dhcp flex gcc-c++ gd git glibc-devel
    glibc-devel.i686 graphviz-perl gzip java-1.7.0-openjdk-devel
    libX11-devel libXau-devel libaio-devel libcurl-devel libibcm.i686 
    libibumad-devel libibumad-devel.i686 libiodbc libiodbc-devel 
    librdmacm-devel librdmacm-devel.i686 libxml2-devel log4cxx log4cxx-devel 
    lua-devel lzo-minilzo net-snmp-devel net-snmp-perl openldap-clients
    openldap-devel openldap-devel.i686 openmotif openssl-devel openssl
    -devel.i686 openssl-static perl-Config-IniFiles perl-Config-Tiny perl
    -DBD-SQLite perl-Expect perl-IO-Tty perl-Math-Calc-Units perl
    -Params-Validate perl-Parse-RecDescent perl-TermReadKey perl-Time-HiRes
    protobuf-compiler protobuf-devel python-qpid python-qpid-qmf
    qpid-cpp-client qpid-cpp-client-ssl qpid-cpp-server qpid-cpp-server-ssl
    qpid-qmf qpid-tools readline-devel saslwrapper sqlite-devel unixODBC
    unixODBC-devel uuid-perl wget xerces-c-devel xinetd
```
```
如果有包安装失败，当你自行安装的时候一定要采用rpm包安装的方式，
不然trafodion安装的时候检测不到依赖包已经安装(查看是否安装方式：rpm -qa | grep protobuf)。
例如protobuf 手工安装方式，先下载以下安装包，然后运行
sudo yum -y install protobuf-2.5.0-16.1.x86_64.rpm 
    protobuf-compiler-2.5.0-16.1.x86_64.rpm 
    protobuf-devel-2.5.0-16.1.x86_64.rpm
```

- 如果安装节点没有trafodion用户，需要手工创建
```
说明：一般不需要，最好在trafodion运行节点上安装（我当时没有在运行节点上安装，所以需要手工创建trafodion用户）
```
- trafodion可以在非运行节点上启动，但连接必须在运行节点
```
sqstart 启动 trafodion   (我是在 81节点上启动的，但是trafodion运行在84和85节点上)
sqcli 连接 trafodion    (在84上连接trafodion)
```

### 让 trafci命令行支持 readline 键盘操作
[参考](http://www.cnblogs.com/lanston/p/3787685.html)


