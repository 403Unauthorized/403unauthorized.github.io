---
title: "142. Linked List Cycle II"
tags:
  - Medium
---

[142. Linked List Cycle II](https://leetcode.com/problems/linked-list-cycle-ii/) - <span style="color: #f7a43e; font-weight: bold">Medium</span>

在看这道题之前，首先可以去做一下[141. Linked List Cycle](https://leetcode.com/problems/linked-list-cycle/)（快慢指针就能解决），因为本文的题是这道题的 ***follow up***。



## Description

!!! abstract "142. Linked List Cycle II"

    Given the head of a linked list, return the node where the cycle begins. If there is no cycle, return null.

    There is a cycle in a linked list if there is some node in the list that can be reached again by continuously following the next pointer. Internally, pos is used to denote the index of the node that tail's next pointer is connected to (0-indexed). It is -1 if there is no cycle. Note that pos is not passed as a parameter.

    Do not modify the linked list.

    **Example 1**:

    ![Ex1](./images/circular-linked-list.png)

    > **Input**: head = [3,2,0,-4], pos = 1
    >
    > **Output**: tail connects to node index 1
    >
    > **Explanation**: There is a cycle in the linked list, where tail connects to the second node.

这道题的大致意思就是让你找出来链表中循环链表的第一个节点，也会使用到**快慢指针**的思想。但是这道题稍微有一些变化，只要了解[Cycle detection - Floyd’s Cycle Detection Algorithm](https://en.wikipedia.org/wiki/Cycle_detection)差不多就能知道怎么做了。

或者可以参考这篇文章：[Floyd’s Cycle Detection Algorithm](https://www.codingninjas.com/blog/2020/09/09/floyds-cycle-detection-algorithm/)，讲的算是比较清楚了。

## Solution

先用快慢指针循环，到两个指针到同一个位置的时候，将慢指针reset到head，然后两个指针同时以1的速度继续走，他们相遇的节点就是循环开始的节点。

```java
/**
 * Definition for singly-linked list.
 * class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) {
 *         val = x;
 *         next = null;
 *     }
 * }
 */
public class Solution {
    public ListNode detectCycle(ListNode head) {
        if (head == null) return null;
        ListNode slow = head, fast = head;
        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;
            if (slow == fast) {
                slow = head;
                while (slow != fast) {
                    slow = slow.next;
                    fast = fast.next;
                }
                return slow;
            }
        }
        return null;
    }
}
```
