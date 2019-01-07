---
title: OSSClient导致内存泄漏：This is very likely to create a memory leak
date: 2018-08-15 20:48:44 
categories: "JVM" 
tags: JVM
description: 简单记录一次内存泄露排查
---

##问题描述
**环境**： Ubuntu_16， tomcat8
最近在使用tomcat发布项目到服务器上，最近两天前端的同志总是反馈，接口怎么调不通了。我心情也是很郁闷，为什么tomcat要跟我作对，竟然挂掉了。一开始不以为然，把tomcat重新启动，但是后来发现总会在我不经意的时候挂掉，这就相当尴尬了。
![呵呵](https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=147112016,3077867825&fm=27&gp=0.jpg)

<!--more-->

##报错信息
去查看了tomcat日志
<code>a thread named [idle_connection_reaper] but has failed to stop it. This is very likely to create a memory leak. Stack trace of thread:
 java.lang.Thread.sleep(Native Method)
 com.aliyun.oss.common.comm.IdleConnectionReaper.run(IdleConnectionReaper.java:77)

第一时间看到<code>memory leak</code>，内存怎么会泄漏呢，搜索了一下

网上有很多说法：
最多的说法是<font color=red>tomcatc内存划分不足</font> ，有以下几种情况：

1.OutOfMemoryError： Java heap space 
2.OutOfMemoryError： PermGen space 
3.OutOfMemoryError： unable to create new native thread. 

**Tomcat内存溢出解决方案**：
　　对于前两种情况，在应用本身没有内存泄露的情况下可以用设置tomcat jvm参数来解决。（-Xms -Xmx -XX：PermSize -XX：MaxPermSize） 
　　最后一种可能需要调整操作系统和tomcat jvm参数同时调整才能达到目的。 
　　第一种：**是堆溢出**。 
　　原因分析： 
JVM堆的设置是指java程序运行过程中JVM可以调配使用的内存空间的设置.JVM在启动的时候会自动设置Heap size的值，其初始空间(即-Xms)是物理内存的1/64，最大空间(-Xmx)是物理内存的1/4。可以利用JVM提供的-Xmn -Xms -Xmx等选项可进行设置。Heap size 的大小是Young Generation 和Tenured Generaion 之和。 
在JVM中如果98％的时间是用于GC且可用的Heap size 不足2％的时候将抛出此异常信息。 
Heap Size 最大不要超过可用物理内存的80％，一般的要将-Xms和-Xmx选项设置为相同，而-Xmn为1/4的-Xmx值。 
　　没有内存泄露的情况下，调整-Xms -Xmx参数可以解决。 
　　-Xms：初始堆大小 ，tomcat默认分配128m
　　-Xmx：最大堆大小 
　　-XX:PermSize  JVM初始分配的非堆内存
	   -XX:MaxPermSize  JVM最大允许分配的非堆内存，按需分配

在linux下，设置tomcat内存划分大小，配置设置在<code>tomcat目录下的 bin/catalina.sh</code>

添加：<code>JAVA_OPTS="-Xms1024m -Xmx1024m -XX:PermSize=128m -XX:MaxPermSize=256m"

##But 我碰到的并不是这个问题

![呸](https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1118582862,2504019671&fm=27&gp=0.jpg)

认真查看日志发现：

<code> com.aliyun.oss.common.comm.IdleConnectionReaper.run(IdleConnectionReaper.java:77)

发现是阿里云oss造成的问题

故查阅资料

**发现在使用阿里云OSS存储时，OSS客户端专门建立了一个线程来管理其所需要的HTTP连接。而在业务中每次都会创建一个新的OSS客户端对象，那么每次也都会往该List中添加新的连接。由于这些连接对象一直被持有，所占用的内存无法释放，越到后面所创建的对象越多，占用的内存越大，一直到内存被使用完为止。**

这下就知道了为什么会内存泄漏了~

这就跟我们在使用JDBC创建数据库连接一样，创建了connection，却不关闭一个道理。

知道了原因，寻找解决方案

既然connection都有close()方法，那阿里云不会没有这个方法的。

查看官方文档~

<font color=red>OSSClient有一个shutdown()方法关闭连接。
![这里写图片描述](http://image.mamicode.com/info/201805/20180508115743526577.png)

![这里写图片描述](http://image.mamicode.com/info/201805/20180508115743605682.png)
