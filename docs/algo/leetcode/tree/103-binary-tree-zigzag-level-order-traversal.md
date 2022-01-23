---
title: "103. Binary Tree Zigzag Level Order Traversal"
tags:
  - Medium
  - Level Order Traversal
---

[103. Binary Tree Zigzag Level Order Traversal](https://leetcode.com/problems/binary-tree-zigzag-level-order-traversal/) - <span style="color: #f7a43e; font-weight: bold">Medium</span>

## Description

!!! abstract "103. Binary Tree Zigzag Level Order Traversal"

    Given the `root` of a binary tree, return the zigzag level order traversal of its nodes' values. (i.e., from left to right, then right to left for the next level and alternate between).

    **Example 1**:

    ![Ex1](./images/102-ex1.jpeg)

    > Input: root = [3,9,20,null,null,15,7]
    >
    > Output: [[3],[20,9],[15,7]]

还是一样的思路，层序遍历，加一个变量来控制方向就行。

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
    public List<List<Integer>> zigzagLevelOrder(TreeNode root) {
        if (root == null) return new ArrayList<>();
        Deque<TreeNode> q = new LinkedList<>();
        List<List<Integer>> ans = new ArrayList<>();
        q.offer(root);
        boolean f = true;
        while (!q.isEmpty()) {
            int size = q.size();
            LinkedList<Integer> list = new LinkedList();
            for (int i = 0; i < size; i++) {
                TreeNode node = q.poll();
                if (f) {
                    list.addLast(node.val);
                } else {
                    list.addFirst(node.val);
                }
                if (node.left != null) q.offer(node.left);
                if (node.right != null) q.offer(node.right);
            }
            f = !f;
            ans.add(list);
        }
        return ans;
    }
}
```