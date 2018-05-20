---
title: (转)Java开发必会的Linux命令
date: 2018-01-11 15:59:14
tags: [Linux,Java]
categories: Linux
copyright:
---
<p>作为一个Java开发人员，有些常用的Linux命令必须掌握。即时平时开发过程中不使用Linux（Unix）或者mac系统，也需要熟练掌握Linux命令。因为很多服务器上都是Linux系统。所以，要和服务器机器交互，就要通过shell命令。</p>
</blockquote>
<p>本文并不会对所有命令进行详细讲解，只给出常见用法和解释。具体用法可以使用<code>--help</code>查看帮助或者直接通过google搜索学习。</p>
<!--more-->
<h2>1&#46;查找文件</h2>
<p><code>find / -name filename.txt</code> 根据名称查找/目录下的filename.txt文件。</p>
<p><code>find . -name "*.xml"</code> 递归查找所有的xml文件</p>
<p><code>find .  -name "*.xml" |xargs grep  "hello world"</code> 递归查找所有文件内容中包含hello world的xml文件</p>
<p><code>grep -H  'spring' *.xml</code> 查找所以有的包含spring的xml文件</p>
<p><code>find ./ -size 0 | xargs rm -f &amp;</code> 删除文件大小为零的文件</p>
<p><code>ls -l | grep '.jar'</code> 查找当前目录中的所有jar文件</p>
<p><code>grep 'test' d*</code> 显示所有以d开头的文件中包含test的行。</p>
<p><code>grep 'test' aa bb cc</code> 显示在aa，bb，cc文件中匹配test的行。</p>
<p><code>grep '[a-z]\{5\}' aa</code> 显示所有包含每个字符串至少有5个连续小写字符的字符串的行。</p>
<h2>2&#46;查看一个程序是否运行</h2>
<p><code>ps –ef|grep tomcat</code> 查看所有有关tomcat的进程</p>
<p><code>ps -ef|grep --color java</code> 高亮要查询的关键字</p>
<h2>3&#46;终止线程</h2>
<p><code>kill -9 19979</code> 终止线程号位19979的进程</p>
<h2>4&#46;查看文件，包含隐藏文件</h2>
<p><code>ls -al</code></p>
<h2>5&#46;当前工作目录</h2>
<p><code>pwd</code></p>
<h2>6&#46;复制文件</h2>
<p><code>cp  source dest</code> 复制文件</p>
<p><code>cp -r  sourceFolder targetFolder</code> 递归复制整个文件夹</p>
<p><code>scp sourecFile romoteUserName@remoteIp:remoteAddr</code> 远程拷贝</p>
<h2>7&#46;创建目录</h2>
<p><code>mkdir newfolder</code></p>
<h2>8&#46;删除目录</h2>
<p><code>rmdir deleteEmptyFolder</code> 删除空目录 <code>rm -rf deleteFile</code> 递归删除目录中所有内容</p>
<h2>9&#46;移动文件</h2>
<p><code>mv /temp/movefile /targetFolder</code></p>
<h2>10&#46;重命令</h2>
<p><code>mv oldNameFile newNameFile</code></p>
<h2>11&#46;切换用户</h2>
<p><code>su -username</code></p>
<h2>12&#46;修改文件权限</h2>
<p><code>chmod 777 file.java</code> //file.java的权限-rwxrwxrwx，r表示读、w表示写、x表示可执行</p>
<h2>13&#46;压缩文件</h2>
<p><code>tar -czf test.tar.gz /test1 /test2</code></p>
<h2>14&#46;列出压缩文件列表</h2>
<p><code>tar -tzf test.tar.gz</code></p>
<h2>15&#46;解压文件</h2>
<p><code>tar -xvzf test.tar.gz</code></p>
<h2>16&#46;查看文件头10行</h2>
<p><code>head -n 10 example.txt</code></p>
<h2>17&#46;查看文件尾10行</h2>
<p><code>tail -n 10 example.txt</code></p>
<h2>18&#46;查看日志类型文件</h2>
<p><code>tail -f exmaple.log</code> //这个命令会自动显示新增内容，屏幕只显示10行内容的（可设置）。</p>
<h2>19&#46;使用超级管理员身份执行命令</h2>
<p><code>sudo rm a.txt</code> 使用管理员身份删除文件</p>
<h2>20&#46;查看端口占用情况</h2>
<p><code>netstat -tln | grep 8080</code> 查看端口8080的使用情况</p>
<h2>21&#46;查看端口属于哪个程序</h2>
<p><code>lsof -i :8080</code></p>
<h2>22&#46;查看进程</h2>
<p><code>ps aux|grep java</code> 查看java进程</p>
<p><code>ps aux</code> 查看所有进程</p>
<h2>23&#46;以树状图列出目录的内容</h2>
<p><code>tree a</code></p>
<p>ps:<a href="http://www.hollischuang.com/archives/546">Mac下使用tree命令</a></p>
<h2>24&#46; 文件下载</h2>
<p><code>wget http://file.tgz</code> <a href="http://www.hollischuang.com/archives/548">mac下安装wget命令</a></p>
<p><code>curl http://file.tgz</code></p>
<h2>25&#46; 网络检测</h2>
<p><code>ping www.just-ping.com</code></p>
<h2>26&#46;远程登录</h2>
<p><code>ssh userName@ip</code></p>
<h2>27&#46;打印信息</h2>
<p><code>echo $JAVA_HOME</code> 打印java home环境变量的值</p>
<h2>28&#46;java 常用命令</h2>
<p>java javac <a href="http://www.hollischuang.com/archives/105">jps</a> ,<a href="http://www.hollischuang.com/archives/481">jstat</a> ,<a href="http://www.hollischuang.com/archives/303">jmap</a>, <a href="http://www.hollischuang.com/archives/110">jstack</a></p>
<h2>29&#46;其他命令</h2>
<p>svn git maven</p>
<h2>28&#46;linux命令学习网站:</h2>
<p><a href="http://explainshell.com/">http://explainshell.com/</a></p>
<h2>参考资料：</h2>
<p><a href="http://www.hollischuang.com/archives/239">Linux端口被占用的解决(Error: JBoss port is in use. Please check)</a></p>
<p><a href="https://linux.cn/article-1672-1.html">linux 中强大且常用命令：find、grep</a></p>
<p><a href="http://blog.csdn.net/tianshijianbing1989/article/details/40780463">Linux命令</a></p>
<h2>欢迎补充！~</h2>
- 转载于[hollis blog](http://www.hollischuang.com/archives/800)