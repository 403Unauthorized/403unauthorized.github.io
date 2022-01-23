---
title: "22. Generate Parentheses"
tags:
  - Medium
  - Backtrack
---

[22. Generate Parentheses](https://leetcode.com/problems/generate-parentheses/) - <span style="color: #f7a43e; font-weight: bold">Medium</span>

## Description

!!! abstract "22. Generate Parentheses"

    Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.

    **Example 1**:
    
    > Input: n = 3
    >
    > Output: ["((()))","(()())","(())()","()(())","()()()"]

这道题就是一道很经典的回溯类型的题，应用回溯解法模版即可。

## Solution

因为是要生成有效的括号，所以`(`必须在第一个，而且`)`必须是跟在`(`的后面，这样我们加两个简单的判断就可以了。

> Scala 需要引入 `scala.collection.mutable.ListBuffer`

=== "Java"

    ```java
    class Solution {
        char[] chArr = new char[] {'(', ')'};
        int num;
        List<String> ans = new ArrayList<>();
        public List<String> generateParenthesis(int n) {
            if (n == 1) return List.of("()");
            num = n;
            backtrack(1, 0, new StringBuilder("("));
            return ans;
        }
        
        private void backtrack(int left, int right, StringBuilder sb) {
            if (sb.length() == 2 * num) {
                ans.add(sb.toString());
                return;
            }
            for (char c : chArr) {
                if (c == '(') {
                    if (left < num) {
                        sb.append(c);
                        backtrack(left + 1, right, sb);
                        sb.deleteCharAt(sb.length() - 1);
                    }
                } else {
                    if (right < left) {
                        sb.append(c);
                        backtrack(left, right + 1, sb);
                        sb.deleteCharAt(sb.length() - 1);
                    }
                }
            }
        }
    }
    ```

=== "Scala"

    ```scala
    import scala.collection.mutable.ListBuffer
    object Solution {
    def generateParenthesis(n: Int): List[String] = {
        val ans = new ListBuffer[String]
        def backtrack(left: Int, right: Int, str: StringBuilder): Unit = {
        if (str.length == 2 * n) {
            ans.addOne(str.toString())
            return
        }
        for (c <- Array('(', ')')) {
            if (c == '(') {
            if (left < n) {
                str.append(c)
                backtrack(left + 1, right, str)
                str.deleteCharAt(str.length() - 1)
            }
            } else {
            if (right < left) {
                str.append(c)
                backtrack(left, right + 1, str)
                str.deleteCharAt(str.length() - 1)
            }
            }
        }
        }
        backtrack(1, 0, new StringBuilder().append("("))
        ans.toList
    }
    }
    ```