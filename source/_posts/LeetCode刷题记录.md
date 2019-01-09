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
## 第 1 天 有效的括号
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

## 第 2 天 删除排序数组中的重复项
- 题号： 26 删除排序数组中的重复项 
- 问题描述：
 
![image](https://wx4.sinaimg.cn/mw690/006fuqy4ly1fz0dnzpy5dj30gz0budg7.jpg)

- 解题思路：
- 第一种解法：暴力法，时间复杂度On^2),基本思路就是碰到相同的就把该元素移除,把后面的元素全都往前挪一位。

![image](https://ws4.sinaimg.cn/mw690/006fuqy4ly1fz0do9geoaj31800teadh.jpg)

- 第二种解法：时间复杂度O(n),用一个变量id标记无重复数组的下标位置，初始为1.循环当碰到nums[i] != nums[i-1]时，把nums[i]赋值给nums[id],再对id自增。

![image](https://wx1.sinaimg.cn/mw690/006fuqy4ly1fz0dof8swaj31800medil.jpg)

- 心得体会：对于一道题的不同解法，对程序带来的运算时间差别很大，前一种耗时106ms，第二种耗时13ms。可见时间复杂度对算法来说很重要，这道题主要是学会如何利用下标在同一个数组中操作，这种操作的种类是有限的，学一种少一种，多思考，以后再碰到就会了。


