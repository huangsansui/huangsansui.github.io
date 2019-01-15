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

## 第 3 天 搜索插入位置
- 题号： 35 搜索插入位置 
- 问题描述：
 
![leetcode35](http://wx2.sinaimg.cn/large/006fuqy4gy1fz1uuafcjgj30x40msgnp.jpg)

- 解题思路：
- 本题采用二分查找法思想，唯一不同的是：此题需要的返回值为目标元素插入的下标位置，也就是说，如果数组中没有相同的元素，则插入比目标元素小且最最近接元素的后面，若存在相同元素，则插在第一个相同元素位置。该题在二分查找基础上，在循环时多循环了一次，这样则能满足需求。

![leetcode35](http://wx3.sinaimg.cn/large/006fuqy4gy1fz1v7hbncgj30w40oejuz.jpg)

- 心得体会：对于这样一道题，我花了还是比较长的时间去思考和反复debug，可能是自己练习太少，同时对建立模型不够熟练。不过结果还算满意，虽然是一到简单难度的题，但使我更熟悉二分查找法的运用。尴尬的是这道题我从头遍历（时间复杂度O(n)）比二分查找法（时间复杂度O(n logn))耗时要短。


## 第 4 天 最大子序和
- 题号： 53 最大子序和
- 问题描述：
 
![image](https://ws3.sinaimg.cn/mw690/006fuqy4gy1fz330ro7vqj30xi0e60un.jpg)
- 解题思路：
- 这道题主要思想动态规划算法(DP)，概念很难说清楚。对于本题，从头遍历数组，sum用来保存临时和，max则保存子序和最大值，当sum>max时给max赋值，当sum<0时重新计算子序和（因为sum<0时，不管下一个元素是正数还是负数，都有sum + num[i+1] < num[i+1] ）

![image](https://ws4.sinaimg.cn/mw690/006fuqy4gy1fz3315t8nlj30xm0qedjf.jpg)
- 心得体会：差点忘了要打卡的事情，很感谢群主的这个活动，让我接触到算法，让我忧愁又欢喜，或许努力只有坚持了才叫努力，对于动态规划，我粗略的看了一下，因为工作的原因没深入研究，有机会要好好去了解，来自老年人的打卡。

## 第 5 天 二叉树的层次遍历 II
- 题号： 108 二叉树的层次遍历 II
- 问题描述：
 
![image](https://wx4.sinaimg.cn/mw690/e3244c0fly1fz5d0ljh59j20xg0mugnj.jpg)- 解题思路：
这道题主要使用了队列先进先出特性和遍历，开始想用递归的方式进行发现行不通。先将元素加入队列,判断队列的长度得知需要遍历的次数，通过遍历拿到该元素下left,right元素并加入队列。

![image](https://ws2.sinaimg.cn/mw690/e3244c0fly1fz5d1012f6j210g11e0zn.jpg)

## 第 6 天 买卖股票的最佳时机
- 题号： 121 买卖股票的最佳时机
- 问题描述：
 
![image](https://wx1.sinaimg.cn/mw690/e3244c0fly1fz6efdphwdj20xg0n2jv3.jpg)

解题思路：
我的解法是，两次遍历，找出最大的子差，实现比较简单，但性能也不好，时间复杂度为O(n^2),之后看了大神的代码，这里讲到了Kadane's Algorithm算法，具体思想参考：
[Loading](https://zh.wikipedia.org/wiki/%E6%9C%80%E5%A4%A7%E5%AD%90%E6%95%B0%E5%88%97%E9%97%AE%E9%A2%98)

![image](https://ws4.sinaimg.cn/mw690/e3244c0fly1fz6ei7bf9vj20z20te78f.jpg)

![image](https://ws4.sinaimg.cn/mw690/e3244c0fly1fz6eik2pggj214o0jewhj.jpg)

## 第 7 天 只出现一次的数字
- 题号： 136 只出现一次的数字
- 问题描述：
 
![image](https://wx2.sinaimg.cn/mw690/006fuqy4ly1fz71ykcjqzj30gs09aq32.jpg)

解题思路：
解题思路：
第一种思路：一般就是我的思路，一般也是不好的思路。题目要求是线性计算，那么我们只能用一个for循环，题目描述中说明只有一个数出现一次，其他为两次。对于重复元素，我想到了 Set,利用 Set 不能保存相同元素的特性来做。

![image](https://wx3.sinaimg.cn/mw690/006fuqy4ly1fz71zlgqwdj31800lediv.jpg)

第二种思路：这种思路就比较有意思了，虽然上面用了set能够解决问题，但是这种以空间换时间的方式不可取，如果数量很大的时候，很可能造成内存泄漏的问题。这里用了异或运算（XOR），不太明白异或运算的同学可以参考：[Loading](https://www.cnblogs.com/JhSonD/p/6374397.html)。这里异或运算满足交换律、结合律。对于 1^2^...^n^...^n^...^1000，无论这两个n出现在什么位置，都可以转换成为1^2^...^1000^(n^n)的形式。其次，对于任何数x，都有x^x=0，x^0=x。

![image](https://wx3.sinaimg.cn/mw690/006fuqy4ly1fz720ybi0jj31f80pegpu.jpg)

心得体会：很开心完成了刷题打卡的基本任务，虽然我刷的全是easy难度的题目，而且还常常写不出来看大神的解法，但是我也能从这个过程中学习到不少东西，以前畏惧算法一直不敢接近，现在成为一种习惯，就跟玩游戏一样，慢慢积攒实力，打怪升级买装备，最后才能打败boss。希望自己能继续坚持刷题，明年换个不错的公司。