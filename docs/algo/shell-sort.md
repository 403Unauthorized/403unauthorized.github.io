---
title: "Shell Sort"
tags:
  - Sort
  - Shell Sort
---

## Concept

**希儿排序**是一种基于**插入排序**的快速的排序算法，对于大规模的数据，插入排序会很慢，因为插入排序只会交换相邻的两个元素，如果最小的元素在数组的最后一个，那么则需要`N - 1`的交换才能将它挪到正确的位置上。希尔排序则为了加快速度，简单的改进了插入排序，交换不相邻的元素以对数组的局部进行排序，并最终用插入排序将局部有序的数组排序。

希尔排序的思想就是使数组中任意间隔为`h`的元素都是有序的，在进行排序时，如果`h`很大，我们就能将元素移动到很远的地方，为实现更小的*`h`有序*创造了方便。而实现希尔排序的一种方法是对于每个`h`，用插入排序将`h`个子数组独立排序，`h`是递减的，直到`h`递减为`1`时，就能将整个数组完整排序完毕。

## Implementation

```java
public void shellSort(int[] a) {
  int n = a.length;
  int h = 1;
  while (h < n / 3) h = 3 * h + 1;
  while (h >= 1) {
    for (int i = h; i < n; i++) {
      for (int j = i; j >= h && a[j] < a[j - h]; j -= h) {
        exchange(a, j, j - h);
      }
    }
    h /= 3;
  }
}

public void exchange(int[] a, int i, int j) {
  int swap = a[i];
  a[i] = a[j];
  a[j] = swap;
}
```