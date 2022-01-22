---
title: "33. Search in Rotated Sorted Array"
tags:
  - Medium
  - Binary Search
---

[33. Search in Rotated Sorted Array](https://leetcode.com/problems/search-in-rotated-sorted-array/) - <span style="color: #f7a43e; font-weight: bold">Medium</span>

## Description

!!! abstract "33. Search in Rotated Sorted Array"

    There is an integer array `nums` sorted in ascending order (with **distinct** values).

    Prior to being passed to your function, nums is **possibly rotated** at an unknown pivot index `k` (`1 <= k < nums.length`) such that the resulting array is `[nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]]` (**0-indexed**). For example, `[0,1,2,4,5,6,7]` might be rotated at pivot index 3 and become `[4,5,6,7,0,1,2]`.

    Given the array `nums` **after** the possible rotation and an integer `target`, return the index of `target` if it is in `nums`, or `-1` if it is not in `nums`.

    You must write an algorithm with `O(log n)` runtime complexity.

题目的意思呢就是说一个已经排序好的没有重复元素的数组，可能在某个索引位置旋转了，例如`[0,1,2,4,5,6,7]`可能在索引是3的位置上旋转成了`[4,5,6,7,0,1,2]`，然后让我们在这样的数组中寻找是否含有`target`相等的元素。还有一个要求就是实现复杂度需要为`O(log n)`。

## Solution

这道题提供了一个排序的数组，然后要求时间复杂度是`O(log n)`，这样马上就能想出来是不是可以用二分查找来解题呢？答案是肯定的，每次我们只需要关心`target`到底是在哪一边。我绞尽脑汁的想啊，终于想出来了三个条件下，target是在左边的：

1. `target < nums[mid]` 且 `target >= nums[0]`：`nums = [4,5,6,7,0,1,2], target = 5`
2. `target < nums[mid]` 且 `nums[mid] < nums[0]`：`nums = [7,8,9,1,2,3,4,5,6], target = 1`
3. `nums[mid] < nums[0]` 且 `nums[0] <= target`：`nums = [7,8,9,0,1,2,3,4,5], target = 8`

只有上述三种情况出现时，`target`是在`mid`左边，其他情况target都在`mid`右边。这样我们就能用二分查找的模版直接写出来了：

```java
class Solution {
    public int search(int[] nums, int target) {
        int n = nums.length;
        int lo = 0, hi = n - 1;
        while (lo <= hi) {
            int mid = (lo + hi) >> 1;
            if (target == nums[mid]) return mid;
            if ((target < nums[mid] && target >= nums[0]) || (target < nums[mid] && nums[mid] < nums[0]) || 
               (nums[mid] < nums[0] && nums[0] <= target)) {
                hi = mid - 1;
            } else {
                lo = mid + 1;
            }
        }
        return -1;
    }
}
```