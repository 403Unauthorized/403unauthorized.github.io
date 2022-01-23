---
title: "102. Binary Tree Level Order Traversal"
tags:
  - Medium
  - Level Order Traversal
---

[102. Binary Tree Level Order Traversal](https://leetcode.com/problems/binary-tree-level-order-traversal/) - <span style="color: #f7a43e; font-weight: bold">Medium</span>

## Description

!!! abstract "102. Binary Tree Level Order Traversal"

    Given the `root` of a binary tree, return the *level order traversal* of its nodes' values. (i.e., from left to right, level by level).

    **Example 1**:

    ![Ex1](./images/102-ex1.jpeg)

    > **Input**: root = [3,9,20,null,null,15,7]
    > **Output**: [[3],[9,20],[15,7]]

这道题很经典的一道二叉树的层序遍历，套用BFS模版就行。

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
    public List<List<Integer>> levelOrder(TreeNode root) {
        if (root == null) return new ArrayList<>();
        Deque<TreeNode> q = new LinkedList<>();
        q.offer(root);
        List<List<Integer>> ans = new ArrayList<>();
        while (!q.isEmpty()) {
            int size = q.size();
            List<Integer> level = new ArrayList<>();
            for (int i = 0; i < size; i++) {
                TreeNode node = q.poll();
                level.add(node.val);
                if (node.left != null) q.offer(node.left);
                if (node.right != null) q.offer(node.right);
            }
            ans.add(level);
        }
        return ans;
    }
}
```