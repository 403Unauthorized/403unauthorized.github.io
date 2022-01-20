---
title: "188. Best Time to Buy and Sell Stock IV"
tags:
  - Hard
  - Dynamic Programming
---

[188. Best Time to Buy and Sell Stock IV](https://leetcode.com/problems/best-time-to-buy-and-sell-stock-iv/) - <span style="color: #dd544b; font-weight: bold">Hard</span>

这道题虽然说是一道 Hard 题，但是思想和它的前置题是一样的。详细可以参考：[123. Best Time to Buy and Sell Stock III](https://leetcode.com/problems/best-time-to-buy-and-sell-stock-iii/): [Solution](https://github.com/403Unauthorized/leetcode/blob/master/java/sell-stock-iii.java)。

## Description

!!! abstract "188. Best Time to Buy and Sell Stock IV"

    You are given an integer array `prices` where `prices[i]` is the price of a given stock on the `ith` day, and an integer `k`.

    Find the maximum profit you can achieve. You may complete at most `k` transactions.

    **Note**: You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).

## Solution

因为这道题和买卖股票III很像，就不做过多的说明，稍微讲一下重点。

**买卖股票III**中要求最多买卖两次，所以我们定义了`buy1`、`sell1`、`buy2`和`sell2`四个变量去存储第一次买卖和第二次买卖最大的收益，但是这道题中的买卖次数为`k`所以我们不能确定到底是多少次，所以就需要两个长度为`k`的数组（`buy[k]`和`sell[k]`），来存储买和卖时的最大收益。最后总共的最大收益就是`sell[k-1]`。

在代码实现中，不仅要遍历数组`prices`，还要遍历`k`来更改`buy`和`sell`数组。所以时间复杂度就是 `O(n * k)`，额外的空间复杂度就是 `O(k)`。

下面就来看看代码时怎么写的吧：

```java
class Solution {
    public int maxProfit(int k, int[] prices) {
        int n = prices.length;
        if (k == 0 || n == 0) return 0;
        int[] buy = new int[k];
        int[] sell = new int[k];
        for (int i = 0; i < k; i++) {
            buy[i] = -prices[0];
        }
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < k; j++) {
                if (j == 0) {
                    buy[j] = Math.max(buy[j], -prices[i]);
                    sell[j] = Math.max(sell[j], buy[j] + prices[i]);
                } else {
                    buy[j] = Math.max(buy[j], sell[j - 1] - prices[i]);
                    sell[j] = Math.max(sell[j], buy[j] + prices[i]);
                }
            }
        }
        return sell[k - 1];
    }
}
```