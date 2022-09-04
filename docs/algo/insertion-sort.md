---
title: "插入排序"
tags:
  - sort
---

## Concept

假设数组`a`有`N`个元素，对于`1`到`N - 1`之间每一个`i`，将`a[i]`与`a[0]`到`a[i-1]`中比它小的所有元素依次有序地交换。在索引`i`从左到右变化的过程中，它左侧的元素始终是有序的，所以当`i`到达数组最右端的时候，整个数组就是有序的了。

## 实现

=== "Insertion Sort"

    ```java
    public void insertionSort(int[] a) {
        int n = a.length;
        for (int i = 1; i < n; i++) {
            for (int j = i; j > 0 && a[j] < a[j - 1]; j--) {
                exchange(a, j, j - 1);
            }
        }
    }

    private void exchange(int[] a, i, j) {
        int swap = a[i];
        a[i] = a[j];
        a[j] = swap;
    }
    ```

=== "优化"

    想要优化插入排序的速度，只需要在内循环中将较大的元素往右移动而不是每次都交换两个元素（访问数组的次数就能减半）。

    ```java
    public void insertionSort(int[] a) {
        int n = a.length;
        for (int i = 1; i < n; i++) {
            int v = a[i];
            int j = i - 1;
            while (j >= 0 && v < a[j] ) {
                a[j + 1] = a[j];
                j--;
            }
            a[j + 1] = v;
        }
        return a;
    }
    ```