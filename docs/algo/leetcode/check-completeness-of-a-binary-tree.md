---
title: "958. Check Completeness of a Binary Tree"
tags:
  - Medium
  - BFS
  - Binary Tree
---

[958. Check Completeness of a Binary Tree](https://leetcode.com/problems/check-completeness-of-a-binary-tree/) - <span style="color: #f7a43e; font-weight: bold">Medium</span>

## Description

!!! abstract "958. Check Completeness of a Binary Tree"

    Given the `root` of a binary tree, determine if it is a complete binary tree.

    In a **complete binary tree**, every level, except possibly the last, is completely filled, and all nodes in the last level are as far left as possible. It can have between `1` and `2^h` nodes inclusive at the last level `h`.

中等的题，要求检查一个二叉树是否是完全二叉树。

完全二叉树的定义：[百度百科](https://baike.baidu.com/item/完全二叉树/7773232)，[Programiz - Complete Binary Tree](https://www.programiz.com/dsa/complete-binary-tree)

关于树问题，就逃不过这些范围：前序遍历，中序遍历，后序遍历，层序遍历。

而这道题的关键就是层序遍历，如果一个二叉树是完全二叉树，那么在做层序遍历的时候，就不会遇到`null`的节点，如果有`node`节点，那就说明这个二叉树不是完全二叉树。

## Solution

代码中会出现两种情况，一种情况就是二叉树是完全二叉树，那么可能最后一个右节点是`null`，这时候就要去掉这个`null`。还有一种情况就是在层序遍历中遇到了`null`节点，第一个循环就会退出，到第二个循环的时候，就会把队列末尾的`null`节点删除，这个时候的队列肯定不为空，所以它不是完全二叉树。

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

    public boolean isCompleteTree(TreeNode root) {
        Deque<TreeNode> q = new LinkedList<>();
        q.offer(root);
        while (q.peek() != null) {
            TreeNode node = q.poll();
            q.offer(node.left);
            q.offer(node.right);
        }
        while (!q.isEmpty() && q.peek() == null) {
            q.poll();
        }
        return q.isEmpty();
    }
        
}
```