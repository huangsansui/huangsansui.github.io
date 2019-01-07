---
title: Java中String理解
date: 2018-01-15 20:48:44 
categories: "java" 
tags: java
description: 
---

一、String类介绍
-----------
String在Java中是很常用的一个类，它在java.lang底下
要了解这个类，首先应该先去看它的源码：

<!--more-->

```java
public final class String
    implements java.io.Serializable, Comparable<String>, CharSequence {
    /** The value is used for character storage. */
	    private final char value[];

    /** Cache the hash code for the string */
    private int hash; // Default to 0

    /** use serialVersionUID from JDK 1.0.2 for interoperability */
    private static final long serialVersionUID = -6849794470754667710L;
    .....
}
```
由源码可看出：

> 1、String底层由char数组实现，为什么选择用char而不是byte，我们知道char是字符型，因为char可以表示中文字符，而byte不行。
> 2、String由final修饰，所以String类不可变，同时不能被继承，并且它的成员方法都默认为final方法。

接着我们看一下常见操作String类的方法
```java
public String substring(int beginIndex, int endIndex) {
        if (beginIndex < 0) {
            throw new StringIndexOutOfBoundsException(beginIndex);
        }
        if (endIndex > value.length) {
            throw new StringIndexOutOfBoundsException(endIndex);
        }
        int subLen = endIndex - beginIndex;
        if (subLen < 0) {
            throw new StringIndexOutOfBoundsException(subLen);
        }
        return ((beginIndex == 0) && (endIndex == value.length)) ? this
                : new String(value, beginIndex, subLen);
    }
 
public String replace(char oldChar, char newChar) {
        if (oldChar != newChar) {
            int len = value.length;
            int i = -1;
            char[] val = value; /* avoid getfield opcode */

            while (++i < len) {
                if (val[i] == oldChar) {
                    break;
                }
            }
            if (i < len) {
                char buf[] = new char[len];
                for (int j = 0; j < i; j++) {
                    buf[j] = val[j];
                }
                while (i < len) {
                    char c = val[i];
                    buf[i] = (c == oldChar) ? newChar : c;
                    i++;
                }
                return new String(buf, true);
            }
        }
        return this;
    }
```
我们可以得出结论：

> String类在进行substring和replace操作的时候，都是创建了一个新的字符串对象，原始的对象并没有改变。
> 结论：String对象一旦被创建就是固定不变的了，对String对象的任何改变都不影响到原对象，相关的任何change操作都会生成新的对象

二、字符串常量池

   我们知道字符串的分配和其他对象分配一样，是需要消耗高昂的时间和空间的，而且字符串我们使用的非常多。JVM为了提高性能和减少内存的开销，在实例化字符串的时候进行了一些优化：使用字符串常量池。每当我们创建字符串常量时，JVM会首先检查字符串常量池，如果该字符串已经存在常量池中，那么就直接返回常量池中的实例引用。如果字符串不存在常量池中，就会实例化该字符串并且将其放到常量池中。由于String字符串的不可变性我们可以十分肯定常量池中一定不存在两个相同的字符串（这点对理解上面至关重要）。

一个例子：

> String a = "abc"
> String b = "abc"
> String c = new String("abc")

在执行代码的时候，首先先检查字符串常量池里是否有"abc"字符串，如果没有则创建一个，如果有该常量则直接指向该常量。而new一个对象是一定会创建一个对象在堆的，所以会有一个String对象存在于堆中，指向字符串常量池中的"abc"

二、String面试常见问题
--------------

**1、创建对象个数问题**
> String a = "abc" 
> String b = new String("abc")
> 各创建了几个对象

分析：如果在a引用之前常量池中存在字符串常量"abc"则不创建对象，若无则创建一个对象。b因为已经创建了"abc"常量，所以只创建了一个对象。

**2、为什么String定义为final的，有什么优点？**

String是不可变类有以下几个优点：

> - 由于String是不可变类，所以在多线程中使用是安全的，我们不需要做任何其他同步操作。
> - String是不可变的，它的值也不能被改变，所以用来存储数据密码很安全。
> - String的不可变性使得对象的创建不会需要很大的内存空间，提升了内存空间的合理利用，同时由于创建字符串时，它的hashcode会被缓存下来，不需要再次计算，在查找位置时效率会高很多
> - 因为java字符串是不可变的，可以在java运行时节省大量java堆空间。因为不同的字符串变量可以引用池中的相同的字符串。如果字符串是可变得话，任何一个变量的值改变，就会反射到其他变量，那字符串池也就没有任何意义了。

那么定义成不可变是否有**缺点**？

我们通过一段代码进行分析：

```java
	/**
     *  String的操作耗时
     */
    public void stringTime(){
        long startTime = System.currentTimeMillis();
        String str = "a";
        for (int i=0;i<100000;i++){
            str += "a";
        }
        long endTime = System.currentTimeMillis();
        System.out.println("String操作耗时：" + (endTime - startTime) + "毫秒");
    }

    /**
     * StringBuffer的操作耗时
     */
    public void StringBufferTime(){
        long startTime = System.currentTimeMillis();
        StringBuffer sb = new StringBuffer("a");
        for (int i=0;i<100000;i++){
            sb = sb.append("a");
        }
        long endTime = System.currentTimeMillis();
        System.out.println("StringBuffer操作耗时：" + (endTime - startTime) + "毫秒");
    }

    /**
     * StringBuilder的操作耗时
     */
    public void StringBuilderTime(){
        long startTime = System.currentTimeMillis();
        StringBuilder sb = new StringBuilder("a");
        for (int i=0;i<100000;i++){
            sb = sb.append("a");
        }
        long endTime = System.currentTimeMillis();
        System.out.println("StringBuilder的操作耗时：" + (endTime - startTime) + "毫秒");
    }
```
执行结果：

String操作耗时：**5283**毫秒  
StringBuffer操作耗时：**3**毫秒  
StringBuilder的操作耗时：**2**毫秒

分析：由于String是不可变的，在Java中，对于一个final变量，如果是基本数据类型的变量，则其数值一旦在初始化之后便不能更改；如果是引用类型的变量，则在对其初始化之后便不能再让其指向另一个对象。所以在每次对String操作的时候，都会new一个新的对象。

**所以代码 str += "a"的实质是 str = new String(new StringBuff(str).append("a"))**

源代码
```java
public String(StringBuffer buffer) {
        synchronized(buffer) {
            this.value = Arrays.copyOf(buffer.getValue(), buffer.length());
        }
    }
```
由于String再进行N次操作时，会比StringBuffer操作创建的对象多N-1个，所以使得执行效率很慢。

> 结论：在进行多次操作字符串时，尽量避免使用String而选择StringBuffer，对应StringBuffer和StringBuilder的选择，则根据是否需要线程安全需求进行选择。StringBuffer是线程安全的，StringBuilder是非线程安全的。
**3、浅谈一下String, StringBuffer，StringBuilder的区别？**

>（1）可变与不可变：String是不可变字符串对象，StringBuilder和StringBuffer是可变字符串对象（其内部的字符数组长度可变）。
> （2）是否多线程安全：String中的对象是不可变的，也就可以理解为常量，显然线程安全。StringBuffer 与 StringBuilder 中的方法和功能完全是等价的，只是StringBuffer 中的方法大都采用了synchronized 关键字进行修饰，因此是线程安全的，而 StringBuilder 没有这个修饰，可以被认为是非线程安全的。
> （3）String、StringBuilder、StringBuffer三者的执行效率： StringBuilder >
> StringBuffer > String 当然这个是相对的，不一定在所有情况下都是这样。比如String str = "hello"+ "world"的效率就比 StringBuilder st  = new StringBuilder().append("hello").append("world")要高。因此，这三个类是各有利弊，应当根据不同的情况来进行选择使用：

**4、为什么我们在使用HashMap的时候总是用String做key？**

> 因为字符串是不可变的，当创建字符串时，它的它的hashcode被缓存下来，不需要再次计算。因为HashMap内部实现是通过key的hashcode来确定value的存储位置，所以相比于其他对象更快。这也是为什么我们平时都使用String作为HashMap对象。

**5、写一个方法来判断一个String是否是回文（顺读和倒读都一样的词）？**

回文就是正反都一样的词，如果需要判断是否是回文，只需要比较正反是否相等即可。String类并没有提供反转方法供我们使用，但StringBuffer和StringBuilder有reverse方法。

```java
private static boolean isPalindrome(String str) {
        if (str == null)
            return false;
        StringBuilder strBuilder = new StringBuilder(str);
        strBuilder.reverse();
        return strBuilder.toString().equals(str);
    }
```
假设面试官让你不使用任何其他类来实现的话，我们只需要首尾一一对比就知道是不是回文了。
```java
private static boolean isPalindromeString(String str) {
        if (str == null)
            return false;
        int length = str.length();
        System.out.println(length / 2);
        for (int i = 0; i < length / 2; i++) {

            if (str.charAt(i) != str.charAt(length - i - 1))
                return false;
        }
        return true;
    }
```
