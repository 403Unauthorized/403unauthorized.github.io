---
title: "309. Best Time to Buy and Sell Stock with Cooldown"
tags:
  - Medium
  - DP
---

[309. Best Time to Buy and Sell Stock with Cooldown](https://leetcode.com/problems/best-time-to-buy-and-sell-stock-with-cooldown/) - <span style="color: #dd544b; font-weight: bold">Hard</span>

## Description

!!! abstract "309. Best Time to Buy and Sell Stock with Cooldown"

    You are given an array `prices` where `prices[i]` is the price of a given stock on the `ith` day.

    Find the maximum profit you can achieve. You may complete as many transactions as you like (i.e., buy one and sell one share of the stock multiple times) with the following restrictions:

    * After you sell your stock, you cannot buy stock on the next day (i.e., cooldown one day).

    **Note**: You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).

题意大致是你可以买卖任意次数的股票，但是买之前必须得卖掉上次买的股票，而且两次买卖之间有一天的冷冻期，求最大的收益。

买卖股票这道题都是通用的，就是看你这天是手上有无股票：

* 这天手上有股票
    * 前一天手上有股票今天不卖
    * 两天前手上的股票卖了，今天买入股票

* 这天手上无股票
    * 前一天手上没有股票切今天没有买入股票
    * 前一天手上有股票今天卖了

这样我们可以用一个数组`dp[n][2]`来表示每天的状态，其中`n`代表第几天，`2`代表了今天手上有股票和无股票的两个状态。这样我们就能写出状态方程了：

```java
dp[i][0] = Math.max(dp[i - 1][0], dp[i - 1][1] + prices[i]);
dp[i][1] = Math.max(dp[i - 1][1], dp[i - 2][0] - prices[i]);
```

上面的方程需要考虑两个情况，第一天和第二天，第一天没有前一天所以 `dp[0][0] = 0; dp[0][1] = -prices[0]`，第二天则是 `dp[1][0] = Math.max(dp[i - 1][0], dp[i - 1][1] + prices[1]; dp[1][1] = Math.max(dp[0][1], -prices[1])`。

换成状态转移方程则是：

```java
// 第一天
dp[i][0] = 0;
dp[i][1] = -prices[i];

// 第二天的情况
dp[i][0] = Math.max(dp[i - 1][0], dp[i - 1][1] + prices[i]);
dp[i][1] = Math.max(dp[i - 1][1], -prices[i]);
```

而最大收益就是最后一天手上不持股时的值也就是`dp[n - 1][0]`。

## Solution

经过上面的分析，我们就可以写出代码了。

```java
class Solution {
    public int maxProfit(int[] prices) {
        int n = prices.length;
        int[][] dp = new int[n][2];
        for (int i = 0; i < n; i++) {
            if (i == 0) {
                dp[i][0] = 0;
                dp[i][1] = -prices[i];
                continue;
            }
            if (i == 1) {
                dp[i][0] = Math.max(dp[i - 1][0], dp[i - 1][1] + prices[i]);
                dp[i][1] = Math.max(dp[i - 1][1], -prices[i]);
                continue;
            }
            dp[i][0] = Math.max(dp[i - 1][0], dp[i - 1][1] + prices[i]);
            dp[i][1] = Math.max(dp[i - 1][1], dp[i - 2][0] - prices[i]);
        }
        return dp[n - 1][0];
    }
}
```