---
title: "17. Letter Combinations of a Phone Number"
tags:
  - Medium
  - Bactrack
---

[17. Letter Combinations of a Phone Number](https://leetcode.com/problems/letter-combinations-of-a-phone-number/) - <span style="color: #f7a43e; font-weight: bold">Medium</span>

## Description

!!! abstract "17. Letter Combinations of a Phone Number"

    Given a string containing digits from `2-9` inclusive, return all possible letter combinations that the number could represent. Return the answer in **any order**.

    A mapping of digit to letters (just like on the telephone buttons) is given below. Note that 1 does not map to any letters.

    ![](./images/17-letter-combinations-of-a-phone-number.png)



这道题与[22. Generate Parentheses](./22-generate-parentheses.md)一样的思路。

## Solution

最近在学 Scala，这道题只用 Scala 写了。Java写也是一样的写法，语法不通而已。

```scala
import scala.collection.mutable.ListBuffer
object Solution {
    val mapping = Array("", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz")
    def letterCombinations(digits: String): List[String] = {
        if (digits.length == 0) return List.empty
        val ans = new ListBuffer[String]
        def backtrack(n: Int, sb: StringBuilder): Unit = {
            if (sb.length() == digits.length) {
                ans += sb.toString()
                return;
            }
            val digit = digits.charAt(n) - '0'
            for (c <- mapping(digit)) {
                sb.append(c)
                backtrack(n + 1, sb)
                sb.deleteCharAt(sb.length() - 1)
            }
        }
        backtrack(0, new StringBuilder)
        ans.toList
    }
}
```