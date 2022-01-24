---
title: "归并排序"
tags:
  - Sort
  - Merge Sort
---

## 概念

***归并排序***主要解决的问题就是将两个或者多个有序的数组归并成一个更大的有序数组，这个算法基于*归并*这个简单的操作。

## 实现

### 自顶向下的归并排序

```java
public void sort(int[] a, int lo, int hi) {
    if (hi <= lo) return;
    int mid = (lo + hi) >> 1;
    sort(a, lo, mid);
    sort(a, mid + 1, hi);
    merge(a, lo, mid, hi);
}

private void merge(int[] a, int lo, int mid, int hi) {
    int i = lo, j = mid + 1;
    int[] aux = new int[a.length];
    if (hi + 1 - lo >= 0) System.arraycopy(a, lo, aux, lo, hi + 1 - lo);
    for (int k = lo; k <= hi; k++) {
        if (i > mid) a[k] = aux[j++]; // 当左半边数组用完时
        else if (j > hi) a[k] = aux[i++]; // 当右半边数组用完时
        else if (aux[j] < aux[i]) a[k] = aux[j++]; // 两边的数组比较
        else a[k] = aux[i++];
    }
}
```

对于小规模的数组来说，插入排序可能效率比归并排序更高，因为插入排序（或者选择排序）更简单，所以在实际使用归并的过程中，可以使用`lo`和`hi`的差值来判断该子数组是否可以用插入排序来排序，排序好之后，在更大规模的数组排序时，就可以转回用归并排序。

**思考**：如何节省将数组元素复制到勇于归并的辅助数组所用到的时间？

### 自底向上的归并排序

```java
public void sort(int[] a) {
    // 进行lgN两两归并
    int N = a.length;
    for (int sz = 1; sz < N; sz += sz) {
        for (int lo = 0; lo < N - sz; lo += sz + sz) {
            merge(a, lo, lo + sz - 1, Math.min(lo + sz + sz - 1, N - 1)); // merge方法请参考上面的
        }
    }
}
```

