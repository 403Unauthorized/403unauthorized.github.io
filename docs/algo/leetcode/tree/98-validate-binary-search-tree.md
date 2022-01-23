---
title: "98. Validate Binary Search Tree"
tags:
  - Medium
  - BST
---

[98. Validate Binary Search Tree](https://leetcode.com/problems/validate-binary-search-tree/) - <span style="color: #f7a43e; font-weight: bold">Medium</span>

## Description

!!! abstract "98. Validate Binary Search Tree"

    Given the `root` of a binary tree, determine if it is a valid binary search tree (BST).

    A **valid BST** is defined as follows:

    * The left subtree of a node contains only nodes with keys **less than** the node's key.
    * The right subtree of a node contains only nodes with keys **greater than** the node's key.
    * Both the left and right subtrees must also be binary search trees.

    **Example 1**:

    ![Ex1](./images/98-ex1.jpeg)

    > **Input**: root = [2,1,3]
    > **Output**: true

这道题是要我们验证一棵树是否为[二叉搜索树](https://en.wikipedia.org/wiki/Binary_search_tree)。请查看二叉搜索树的第一，然后很快就能想出来怎么才能验证一棵树是否为二叉搜索树。

## Solution

我们需要一个变量来储存当前节点的父节点的值，因为需要与子节点比较。例如：一个二叉搜索树`[5,1,4,null,null,3,6]`，遍历到元素`4`时，需要去判断它的左子树节点(`3`)是否也大于它的父节点，这样才能完整的证明这个二叉搜索树是合法的。

所以我们需要一个最大值和一个最小值来约束二叉搜索树中各个节点的值，如果不符合，那说明不是二叉搜索树。

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
    public boolean isValidBST(TreeNode root) {
        return isValidBST(root, null, null);
    }
    
    private boolean isValidBST(TreeNode root, TreeNode min, TreeNode max) {
        if (root == null) return true;
        if (min != null && root.val <= min.val) return false;
        if (max != null && root.val >= max.val) return false;
        return isValidBST(root.left, min, root)
            && isValidBST(root.right, root, max);
    }
}
```

