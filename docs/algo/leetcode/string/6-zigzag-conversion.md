---
title: "6. Zigzag Conversion"
tags:
  - Medium
  - String
---

[6. Zigzag Conversion](https://leetcode.com/problems/zigzag-conversion/) - <span style="color: #f7a43e; font-weight: bold">Medium</span>

## Description

!!! abstract "6. Zigzag Conversion"

    The string `"PAYPALISHIRING"` is written in a zigzag pattern on a given number of rows like this: (you may want to display this pattern in a fixed font for better legibility)

    ```text
    P   A   H   N
    A P L S I I G
    Y   I   R
    ```

    And then read line by line: "PAHNAPLSIIGYIR"

    Write the code that will take a string and make this conversion given a number of rows:

    ```
    string convert(string s, int numRows);
    ```

这道题还是比较经典了，找到规律马上就解决了。

## Solution

首先当`numRows = 1`时，那么就不用处理，直接返回`s`就行了；

如果`numRows > 1`时，那我们就需要把字符串分成`numRows`行了