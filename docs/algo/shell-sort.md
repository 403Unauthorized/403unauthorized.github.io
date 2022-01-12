---
title: "Shell Sort"
tags:
  - Sort
  - Shell Sort
---

## Concept

**希儿排序**是一种基于**插入排序**的快速的排序算法，对于大规模的数据，插入排序会很慢，因为插入排序只会交换相邻的两个元素，如果最小的元素在数组的最后一个，那么则需要`N - 1`的交换才能将它挪到正确的位置上。希尔排序则为了加快速度，简单的改进了插入排序，交换不相邻的元素以对数组的局部进行排序，并最终用插入排序将局部有序的数组排序。

希尔排序的思想就是