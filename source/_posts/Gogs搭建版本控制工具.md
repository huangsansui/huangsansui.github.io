---
title: Gogs搭建
date: 2018-05-09 18:45:44 
categories: "Gogs" 
tags: 
     - Gogs
     - 版本控制
     - Git
description: 简单搭建Gogs做为团队项目控制工具
---

新入公司，要求用git做版本控制，之前公司用的gitlab，找资料过程中发现了gogs,相比gitlab性能要求不大，所以学习搭建Gogs。
<!--more-->
<h2>什么是Gogs</h2>
![gogs](http://p8urisuqw.bkt.clouddn.com/gogs.png)
Gogs 是一款极易搭建的自助 Git 服务。
Gogs 的目标是打造一个最简单、最快速和最轻松的方式搭建自助 Git 服务。使用 Go 语言开发使得 Gogs 能够通过独立的二进制分发，并且支持 Go 语言支持的 所有平台，包括 Linux、Mac OS X、Windows 以及 ARM 平台。
<h2>服务器环境</h2>
阿里云ECS服务器 Ubuntu 16.04.2
<h2>安装Gogs所需的其他环境</h2>
这里需要安装的依赖有NgNix,git,MySQL
1.安装NgNix
<code>sudo apt-get install nginx</code>
2.安装git
<code>sudo apt-get install git</code>
3.安装MySQL
<code>sudo apt-get install mysql-server</code>
4.进入MySQL
<code>mysql -u root -p</code>
这里如果已经安装过MySQL,用之前的密码登录就好。
5.创建gogs数据库
```mysql
//登录 MySQL 创建一个新用户 gogs，并将数据库 gogs的所有权限都赋予该用户。这里123456是密码
SET GLOBAL storage_engine = 'InnoDB';
CREATE DATABASE gogs CHARACTER SET utf8 COLLATE utf8_bin;
GRANT ALL PRIVILEGES ON gogs.* TO ‘root’@‘localhost’ IDENTIFIED BY '123456'; 
FLUSH PRIVILEGES;
QUIT；
```
<h2>为Gogs创建单独的用户</h2>
<code>sudo adduser git</code>
这里一样要设置密码，每次切换用户需要密码，不要忘了密码
<h2>下载安装Gogs</h2>
首先安装解压的工具
<code>sudo apt-get install unzip</code>
<code>
su git //这里是切换git用户
cd ~  //返回根目录
wget https://dl.gogs.io/0.11.4/linux_amd64.zip
unzip linux_amd64.zip
</code>
现在好像用二进制和源码安装的方法，这里不做讨论。
<h2>配置</h2>
1.修改Gogs service配置文件
<code>vim /home/git/gogs/scripts/init/debian/gogs</code>
```shell
PATH=/sbin:/usr/sbin:/bin:/usr/bin
DESC="Go Git Service"
NAME=gogs
SERVICEVERBOSE=yes
PIDFILE=/var/run/$NAME.pid
SCRIPTNAME=/etc/init.d/$NAME
WORKINGDIR=/home/git/gogs #这个根据自己的目录修改
DAEMON=$WORKINGDIR/$NAME
DAEMON_ARGS="web"
USER=git  #如果运行gogs不是用的这个用户，修改对应用户
//说明：
//1.如果是创建的git用户 则目录修改为/home/git/gogs.对应的USER修改为git
//2.如果是在root用户下安装在/usr/local/gogs/下 则对应的目录为：/usr/local/gogs/gogs.对应的USER修改为root
```
2.切换回root用户
<code>su root</code>
3.复制到/etc/init.d/
<code>sudo cp /home/git/gogs/scripts/init/debian/gogs /etc/init.d/</code>
4.赋予权限
<code>sudo chmod +x /etc/init.d/gogs</code>
5.复制service
<code>cp /home/git/gogs/scripts/systemd/gogs.service /etc/systemd/system/
</code>
<h2>启动Gogs</h2>
<code>
cd /home/git/gogs/
./gogs web
</code>
这个时候就是见证奇迹的时刻了
打开浏览器配置Gogs
<code>http://ip:3000/install</code>
这里ip就是服务器的ip地址
首次配置结束，访问 http://ip:3000 就能看到Gogs了。
首次配置后，会产生配置文件，在 /home/git/gogs/coustom/conf/app.ini
需要修改配置在里面可以修改，更多配置细节：[Gogs](https://gogs.io/docs/advanced/configuration_cheat_sheet)

<h2>搭建Gogs遇到的坑</h2>
1.安装一切顺利，打开浏览器输入 ip:3000/install 打不开
原因：
1.可能3000端口被占用，gogs未启动，解决方法查看端口，看看能不能杀掉进程，方法自行百度， gogs安装3000端口，应该不能改。
2.服务器防火墙，解决方法：关闭防火墙。
3.阿里云安全组配置（这是我出现的情况）
解决方法：[开放端口](https://jingyan.baidu.com/article/03b2f78c31bdea5ea237ae88.html)

2.启动Gogs后，不知道怎么关闭或者重启，我查进程，kill -9 一直杀不死，头一次遇到。

鸡汤：学习是一件难得的事，正因为难，得到的才更有价值。
