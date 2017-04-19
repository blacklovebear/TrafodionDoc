#!/bin/bash
# 设置环境变量
: ${HOST_LIST:="dc01,dc02,dc03,dc04"}
: ${JAR_PATH:="/x-data/X-Data"}


yum install pdsh

pdsh -w ${HOST_LIST} cat /etc/sudoers | grep requiretty
pdsh -w ${HOST_LIST} chmod 660 /etc/sudoers

# 为了确保requiretty不被使用，在/etc/sudoers文件里注释掉“Defaults requiretty”
# 注释 requiretty 行
# Defaults    requiretty

pdsh -w ${HOST_LIST} sed -i '/.*requiretty.*/ s/^/#/' /etc/sudoers
pdsh -w ${HOST_LIST} chmod 440 /etc/sudoers
pdsh -w ${HOST_LIST} cat /etc/sudoers | grep requiretty


# trafodion jars
mkdir $HOME/trafodion_downloads
cp ${JAR_PATH}/apache-trafodion_server-2.0.1-incubating.tar.gz $HOME/trafodion_downloads
cp ${JAR_PATH}/installer-2.0.1.tar.gz $HOME/trafodion_downloads
cd $HOME/trafodion_downloads
tar -xzf installer-2.0.1.tar.gz
cd installer



# starting install 
./trafodion_install




# when trafodion started success
yum instal rlwrap

su trafodion

# add rlwrap support cli
echo "alias trafci='rlwrap trafci'" >> ~/.bashrc
source ~/.bashrc


# add trafodion settings
echo "SET TIME ON
SET TIMING ON
SET COLSEP |
--SET STATISTICS ON
cqd DEFAULT_CHARSET 'UTF8';
cqd INPUT_CHARSET 'UTF8';
cqd TERMINAL_CHARSET 'UTF8';
cqd TRAF_DEFAULT_COL_CHARSET 'UTF8';
" > $MY_SQROOT/trafci/bin/settings.txt

sed -i '/.*trafci\.sh.*/ s/$/ \-s \$MY_SQROOT\/trafci\/bin\/settings.txt/' $MY_SQROOT/trafci/bin/trafci


