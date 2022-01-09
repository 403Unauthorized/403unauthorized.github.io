---
title: "Union Find - 并查集"
---

这篇文章主要讲讲 **Union Find[^1]** 算法， 也就是我们常说的**并查集**算法。主要用于图算法中的 ==动态连通性== 。

## 动态连通性

!!! note
    
    假设输入一连串的整数对，其中一对整数对`p`和`q`，它们分别代表不同类型的对象，这对整数对`p`和`q`是相连的。则这两个对象可以属于同一个连通分量，而再接收之后的整数对时，则可以判断整数对中的两个元素是否属于同一个连通分量，来过滤掉无意义的整数对，因为如果整数对中的两个元素在同一个连通分量中，则可以肯定的是它们一定是相连通的。

简单来说，这个动态连通性，可以想象成一个图结构，图中的节点有些互相连接，有些不互相连接，如果两个元素相连，则它们具有以下特性：

* Symmetric (对称性): 如果`p`与`q`连接，则`q`与`p`也相连
* Transitive (传递性): 如果`p`与`q`相连，`q`与`r`相连，则`p`与`r`也相连
* Reflexive (自反性): 自身与自身相连

而动态连通性的目标就是要找出无意义的**pair**，例如一个整数对`p`与`q`，如果之前的整数对已经表明他们是相连接的了，那我们就忽略这个整数对，继续处理下一个整数对。

而**Union Find**主要有以下几个实现：

``` title="Union Find Pseudo Code"
public class UF {
    UF(int n); // 初始化n个连接点(0 ~ n-1)
    void union(int p, int q); // 添加p与q的连接
    int find(int p); // 找到p的连通分量
    boolean connected(int p, int q); // 判断p与q是否连通
    int count(); //返回图中有多少个连通分量
}
```

## 慢查询实现

### 思路

如果想让两个节点连通，则可以使用树形结构来实现，在同一棵树上的节点都属于连通的节点，而这一棵树则是连通分量。如果想更加直观的观察到为什么使用树形结构比较方便，可以阅读一下普林斯顿大学的 **cos226**[^2] 中讲 Union Find 的 slides.

所以这意味着如果某两个节点相连，则让其中任一一个节点的根节点指向另一个节点的根节点上。

### 代码

```java
public class UF {
    int[] parent;
    int count;

    public UF(int n) {
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }
        count = n; // 初始化时有n个连通分量，因为节点互相不相连
    }

    public void union(int p, int q) {
        int rootP = find(p);
        int rootQ = find(q);
        if (rootP == rootQ) {
            // 说明两个节点已经相连，直接跳过此操作
            return;
        }
        parent[rootP] = rootQ; // 等价于 parent[rootQ] = rootP
        count--; // 因为两个连通分量合并了
    }

    private int find(int x) {
        while (parent[x] != x) {
            x = parent[x];
        }
        return x;
    }

    public int count() {
        return count;
    }

    public boolean connected(int p. int q) {
        int rootP = find(p);
        int rootQ = find(q);
        return rootP == rootQ; // 两个节点的根节点相同则在一个连通分量中，这两个节点相连
    }
}
```

可以参照下面的流程图：

![Union Find](./images/union_find.jpg)

### 算法分析

那么上面实现的这个算法的复杂度是多少呢？从代码上可以看到：`connected`和`union`的复杂度都和`find`函数有关，而`find`函数则是需要从该节点向上寻找到这个节点的根节点，虽然它是树形结构，但我们不能单纯的说它的时间复杂度是`logN`（平衡二叉树的高度），但这个可不是平衡二叉树，在极端情况下，这个树形结构可能就会退化成单链表，所以说最坏情况下的时间复杂度可能变成`N`。

所以说上面这种写法，

## 引用

* Union Find Slides 2[^3]


[^1]: [Princeton University - Union Find](https://algs4.cs.princeton.edu/15uf/)
[^2]: [Union Find Slides by Princeton University](https://www.cs.princeton.edu/courses/archive/fall06/cos226/lectures/union-find.pdf)
[^3]: http://www.sfs.uni-tuebingen.de/~dg/l1.html