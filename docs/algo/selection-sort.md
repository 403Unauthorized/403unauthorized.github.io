---
title: "选择排序"
tags:
  - Sort
---

## Concept

首先找到数组中最小的元素，然后与数组中的第一个元素交换位置；然后在剩下的元素中找到最小的元素，再与第二个元素交换位置。。。如此往复，直到排序完整个数组。这种选择最小的元素交换位置的方法，就叫做**选择排序**。

## 实现

=== "伪代码"

    ``` java title="选择排序"
    public void selectionSort(Comparable[] a) {
        int n = a.length;
        for (int i = 0; i < n; i++) {
            int min = i; // 将最小元素的索引设置为当前索引
            // 找出最小元素
            for (int j = i + 1; j < n; j++) {
                min = less(a[j], a[min]) ? j : min; // less()方法返回true表示a[j]更小
            }
            exchange(a, i, min); // 将a[min]与a[i]交换
        }
    }
    ```

=== "Integer排序实现"

    ``` java title="选择排序"
    public void selectionSort(int[] a) {
        int n = a.length;
        for (int i = 0; i < n; i++) {
            int min = i;
            for (int j = i + 1; j < n; j++) {
                if (a[j] < a[min]) min = j;
            }
            exchange(a, i, min);
        }
    }

    private void exchange(int[] a, int i, int j) {
        int swap = a[i];
        a[i] = a[j];
        a[j] = swap;
    }
    ```

## 算法分析