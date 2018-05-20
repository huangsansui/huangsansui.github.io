---
title: (转)不使用synchronized和lock，如何实现一个线程安全的单例？
date: 2018-01-11 15:12:20
tags: [Jave,线程安全,单例]
categories: Java 
copyright: false
---

<p>刚刚，在我的微信公众号（hollishcuang）上发了一条问题：不使用<code>synchronized</code>和<code>lock</code>，如何实现一个线程安全的单例？</p>

<!--more-->
<p>瞬间收到了数百条回复。回答最多的是静态内部类和枚举。很好，这两种确实可以实现。</p>
<h3>枚举</h3>
```java
public enum Singleton {  
    INSTANCE;  
    public void whateverMethod() {  
    }  
}  
```
<h3>静态内部类</h3>
```java
public class Singleton {  
    private static class SingletonHolder {  
    private static final Singleton INSTANCE = new Singleton();  
    }  
    private Singleton (){}  
    public static final Singleton getInstance() {  
    return SingletonHolder.INSTANCE;  
    }  
}  
```
<p>还有人回答的很简单：饿汉。很好，这个也是对的。</p>
<h3>饿汉</h3>
```java
public class Singleton {  
    private static Singleton instance = new Singleton();  
    private Singleton (){}  
    public static Singleton getInstance() {  
    return instance;  
    }  
}  
```
<h3>饿汉变种</h3>
```java
public class Singleton {  
    private static class SingletonHolder {  
    private static final Singleton INSTANCE = new Singleton();  
    }  
    private Singleton (){}  
    public static final Singleton getInstance() {  
    return SingletonHolder.INSTANCE;  
    }  
}  
```
<p>（更多单例实现方式见：<a href="http://www.hollischuang.com/archives/205">单例模式的七种写法</a>）</p>
<blockquote>
<p>问：这几种实现单例的方式的真正的原理是什么呢？</p>
<p>答：以上几种实现方式，都是借助了<code>ClassLoader</code>的线程安全机制。</p>
</blockquote>
<p>先解释清楚为什么说都是借助了<code>ClassLoader</code>。</p>
<p>从后往前说，先说两个<strong>饿汉</strong>，其实都是通过定义静态的成员变量，以保证<code>instance</code>可以在类初始化的时候被实例化。那为啥让<code>instance</code>在类初始化的时候被实例化就能保证线程安全了呢？因为类的初始化是由<code>ClassLoader</code>完成的，这其实就是利用了<code>ClassLoader</code>的线程安全机制啊。</p>
<p>再说<strong>静态内部类</strong>，这种方式和两种饿汉方式只有细微差别，只是做法上稍微优雅一点。这种方式是<code>Singleton</code>类被装载了，<code>instance</code>不一定被初始化。因为<code>SingletonHolder</code>类没有被主动使用，只有显示通过调用<code>getInstance</code>方法时，才会显示装载<code>SingletonHolder</code>类，从而实例化<code>instance</code>。。。但是，原理和饿汉一样。</p>
<p>最后说<strong>枚举</strong>，其实，如果把枚举类进行反序列化，你会发现他也是使用了<code>static</code> <code>final</code>来修饰每一个枚举项。（详情见：<a href="http://www.hollischuang.com/archives/197">深度分析Java的枚举类型—-枚举的线程安全性及序列化问题</a>）</p>
<p>至此，我们说清楚了，各位看官的回答都是利用了<code>ClassLoader</code>的线程安全机制。至于为什么<code>ClassLoader</code>加载类是线程安全的，这里可以先直接回答：<code>ClassLoader</code>的<code>loadClass</code>方法在加载类的时候使用了<code>synchronized</code>关键字。也正是因为这样， 除非被重写，这个方法默认在整个装载过程中都是同步的（线程安全的）。（详情见：<a href="http://www.hollischuang.com/archives/199">深度分析Java的ClassLoader机制（源码级别）</a>）</p>
<hr />
<p>哈哈哈哈！！！~所以呢，这里可以说，大家的回答都只答对了一半。虽然没有显示使用<code>synchronized</code>和<code>lock</code>，但是还是间接的用到了！！！！</p>
<p>那么，这里再问一句：不使用synchronized和lock，如何实现一个线程安全的单例？答案见：<a href="http://www.hollischuang.com/archives/1866">不使用synchronized和lock，如何实现一个线程安全的单例？（二）</a></p>

转载于：[hollis blog](http://www.hollischuang.com/archives/1860)