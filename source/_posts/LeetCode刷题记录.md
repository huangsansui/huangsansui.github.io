---
title: LeetCode刷题记录
date: 2019-01-09 01:15:41
categories: "leetcode"
tags: 
    -leetcode
    -算法
---

![image](https://wx3.sinaimg.cn/large/006fuqy4gy1fyzoigp2b4j31hc0u0tkx.jpg)

<!-- more -->
## 第一天 Valid Parentheses
- 题号： 20 有效的括号 （Valid Parentheses）
- 问题描述：
 
![image](https://ws3.sinaimg.cn/mw690/006fuqy4gy1fyzq1mf7o7j30xe08w0ty.jpg)

- 解题思路：
- 第一种解法：利用堆栈先进先出的思想（LIFO），判断如果为左括号则将右括号压入栈顶，相当于将正确的格式已经确定，当碰到右括号时则弹出栈顶，对比是否跟压入的相同。

![image](https://ws1.sinaimg.cn/mw690/006fuqy4gy1fyzqb50pnnj31180pe42o.jpg)

- 第二种解法：利用匹配的思想，利用head参数作为游标，左括号顺序存入，head++，碰到右括号时拿出下标为--head的值对比是否为对应的左括号。
心得体会：通过这道题，理解了堆栈的思想以及运用方式，对于这种题目算是有一个认识，遇到类似需要左右匹配的时候可以考虑堆栈的原理。

![image](https://wx3.sinaimg.cn/mw690/006fuqy4gy1fyzqbrebgtj310s13en2q.jpg)

- 心得体会：通过这道题，理解了堆栈的思想以及运用方式，对于这种题目算是有一个认识，遇到类似需要左右匹配的时候可以考虑堆栈的原理。