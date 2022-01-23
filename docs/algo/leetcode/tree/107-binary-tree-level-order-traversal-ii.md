---
title: "107. Binary Tree Level Order Traversal II"
tags:
  - Medium
  - Level Order Traversal
---

[107. Binary Tree Level Order Traversal II](https://leetcode.com/problems/binary-tree-level-order-traversal-ii/) - <span style="color: #f7a43e; font-weight: bold">Medium</span>

[102. Binary Tree Level Order Traversal](./102-binary-tree-level-order-traversal.md) 的 follow up。对于层序遍历不太了解的同学可以点击前面链接看看题解哦。

## Description

!!! abstract "107. Binary Tree Level Order Traversal II"

    Given the root of a binary tree, return the bottom-up level order traversal of its nodes' values. (i.e., from left to right, level by level from leaf to root).

    **Example 1**:

    ![](./images/107-ex1.jpeg)

    > **Input**: root = [3,9,20,null,null,15,7]
    > **Output**: [[15,7],[9,20],[3]]

很简单，就是从后往前的层序遍历，用先进后出的一种数据结构就可以实现，比如说`Stack`。

## Solution

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public List<List<Integer>> levelOrderBottom(TreeNode root) {
        if (root == null) return new ArrayList<>();
        Stack<List<Integer>> stack = new Stack<>();
        Deque<TreeNode> q = new LinkedList<>();
        q.offer(root);
        while (!q.isEmpty()) {
            int size = q.size();
            List<Integer> l = new ArrayList<>();
            for (int i = 0; i < size; i++) {
                TreeNode node = q.poll();
                l.add(node.val);
                if (node.left != null) q.offer(node.left);
                if (node.right != null) q.offer(node.right);
            }
            stack.push(l);
        }
        List<List<Integer>> ans = new ArrayList<>();
        while (!stack.isEmpty()) {
            ans.add(stack.pop());
        }
        return ans;
    }
}
```