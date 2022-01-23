---
title: "701. Insert into a Binary Search Tree"
tags:
  - Medium
  - BST
---

[701. Insert into a Binary Search Tree](https://leetcode.com/problems/insert-into-a-binary-search-tree/) - <span style="color: #f7a43e; font-weight: bold">Medium</span>

二叉搜索树的题目都大同小异，基本上一个模版就能搞定。

## Description

!!! abstract "701. Insert into a Binary Search Tree"

    You are given the `root` node of a binary search tree (BST) and a `value` to insert into the tree. Return the root node of the BST *after the insertion*. It is **guaranteed** that the new value does not exist in the original BST.

    **Notice** that there may exist multiple valid ways for the insertion, as long as the tree remains a BST after insertion. You can return **any of them**.

题意就是让我们将一个数插入到二叉搜索树中，因为二叉搜索树的特性，这道题就很简单了，直接上模版。一般递归就能解决

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
    public TreeNode insertIntoBST(TreeNode root, int val) {
        if (root == null) return new TreeNode(val);
        insert(root, val);
        return root;
    }
    
    private void insert(TreeNode node, int val) {
        if (node.val < val) {
            if (node.right != null) {
                insert(node.right, val);
            } else {
                node.right = new TreeNode(val);
            }
        } else {
            if (node.left != null) {
                insert(node.left, val);
            } else {
                node.left = new TreeNode(val);
            }
        }
    }
}
```