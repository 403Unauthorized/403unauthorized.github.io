---
title: "字符串转换整数 (atoi)"
tags:
  - Leetcode
  - Medium
  - String
---

[8. String to Integer (atoi)](https://leetcode.com/problems/string-to-integer-atoi/) - <span style="color: #f7a43e; font-weight: bold">Medium</span>

## Problem Description

!!! abstract "8. String to Integer (atoi)"

    Implement the myAtoi(string s) function, which converts a string to a 32-bit signed integer (similar to C/C++'s atoi function).

    The algorithm for myAtoi(string s) is as follows:

    1. Read in and ignore any leading whitespace.

    2. Check if the next character (if not already at the end of the string) is '-' or '+'. Read this character in if it is either. This determines if the final result is negative or positive respectively. Assume the result is positive if neither is present.

    3. Read in next the characters until the next non-digit character or the end of the input is reached. The rest of the string is ignored.

    4. Convert these digits into an integer (i.e. `"123" -> 123`, `"0032" -> 32`). If no digits were read, then the integer is 0. Change the sign as necessary (from step 2).

    5. If the integer is out of the 32-bit signed integer range `[-2^31, 2^31 - 1]`, then clamp the integer so that it remains in the range. Specifically, integers less than `-2^31` should be clamped to `-2^31`, and integers greater than `2^31 - 1` should be clamped to `2^31 - 1`.

    6. Return the integer as the final result.

    **Note:**

    * Only the space character `' '` is considered a whitespace character.
    * Do not ignore any characters other than the leading whitespace or the rest of the string after the digits.

## Solution

简单的字符串转数字，按照题目上的意思，先忽略空格，再判断空格之后的是不是加减号，然后开始遍历剩下的字符，条件是必须在 `0` 到 `9` 之间，否则直接跳出循环，返回答案。

在循环中，将 `Integer.MAX_VALUE / 10` 与每次算出来的值比较，判断值会不会溢出，如果有溢出，就根据情况返回`Integer.MAX_VALUE`或`Integer.MIN_VALUE`。

**Go**稍微有一些特殊，这里我们需要用到`int32`的最大值，而默认的`int`的最大值为`int64`的最大值。所以我们提前定义好这些需要用到的值为常量。

=== "Java"

    ```java
    class Solution {
        public int myAtoi(String s) {
            int n = s.length();
            if (n == 0) return 0;
            char[] charArr = s.toCharArray();
            int index = 0;
            // remove spaces
            while (index < n && charArr[index] == ' ') index++;
            boolean negative = false;
            int ans = 0;
            if (index < n) {
                if (charArr[index] == '-' || charArr[index] == '+') {
                    negative = charArr[index] == '-' ? true : false;
                    index++;
                }
                while (index < n && charArr[index] >= '0' && charArr[index] <= '9') {
                    int num = charArr[index] - '0';
                    int next = ans * 10 + num;
                    if (Integer.MAX_VALUE / 10 < ans || (Integer.MAX_VALUE / 10 == ans && Integer.MAX_VALUE % 10 < num)) {
                        return negative ? Integer.MIN_VALUE : Integer.MAX_VALUE;
                    }
                    ans = next;
                    index++;
                }
            }
            return negative ? -ans : ans;
        }
    }
    ```

=== "Golang"

    ```go
    const MaxUint = ^uint32(0) 
    const MinUint = 0 
    const MaxInt = int(MaxUint >> 1) 
    const MinInt = -MaxInt - 1

    func myAtoi(s string) int {
        n := len(s)
        idx := 0
        for idx < n && s[idx] == ' ' {
            idx++
        }
        if idx >= n {
            return 0
        }
        var neg bool = false
        if s[idx] == '+' || s[idx] == '-' {
            if s[idx] == '-' {
                neg = true
            }
            idx++
        }
        ans := 0
        for idx < n && s[idx] >= '0' && s[idx] <= '9' {
            num := int(s[idx] - '0')
            if MaxInt / 10 < ans || (MaxInt / 10 == ans && MaxInt % 10 < num) {
                if neg {
                    return MinInt
                } else {
                    return MaxInt
                }
            }
            ans = ans * 10 + num
            idx++
        }
        
        if neg {
            return -ans
        } else {
            return ans
        }
    }
    ```