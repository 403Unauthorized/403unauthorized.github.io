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

## Quick Union 实现

在此之前有一个 **Quick Find** 算法，这个算法中`union`操作每次都会访问一次数组，所以当连通分量数量很小时，最终的算法时间是平方及的，所以不在这讨论了

### 思路

详细的过程可以阅读一下普林斯顿大学的 **cos226**[^2] 中讲 Union Find 的 slides，这里我们简单理解一下上面的API。

如果两个节点在不同的分量中，`union()`操作会将两个分量合并。`find()`操作会找到给定节点的连通分量标识（也可以理解为它的根节点），`connected()`操作会找到给定的两个节点的连通分量标识，如果两个连通分量标识相同，则说明两个节点是相连的。`count()`操作返回了当前连通分量的数量。初始化时，我们有`N`个连通分量，当操作`union()`的时候，连通分量的数量就会减一。

实际上，我们在算法中维护两个变量就可以实现：parent[]数组（代表连通分量标识，因为`union()`实际上是将一个节点的根节点设置为另一个节点根节点的字节点），还有一个是`count`，代表连通分量的数量，初始化时，`count`的数量为N。

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

所以说上面这种写法，时间复杂度是`O(N)`，这个复杂度是很不理想的。因为图论解决的都是数据规模很大的问题，对于`union`和`connected`的调用非常频繁，所以线性的时间复杂度效率是不可接受的。

现在的问题就在于如何去<span style="color: red">避免</span>**树的不平衡**。

## 加权 Quick Union 算法

我们只需要简单的修改一下 **Quick Union 算法** 就能保证这种情况不再出现，只要每次`union`操作时，总是把小的树合并到大的树上，就可以解决这样的问题。所以我们需要一个额外的数组，来记录每个连通分量的大小。

### 代码实现

```java hl_lines="4 10 21 22 23"
public class UF {
    int[] parent;
    int count;
    int[] size;

    public UF(int n) {
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }
        for (int i = 0; i < n; i++) size[i] = 1; // 初始化size都为1
        count = n; // 初始化时有n个连通分量，因为节点互相不相连
    }

    public void union(int p, int q) {
        int rootP = find(p);
        int rootQ = find(q);
        if (rootP == rootQ) {
            // 说明两个节点已经相连，直接跳过此操作
            return;
        }
        // 将小树的根节点连接到大树的根节点
        if (size[rootP] < size[rootQ]) { parent[rootP] = rootQ; size[rootQ] += size[rootP]; }
        else { parent[rootQ] = rootP; size[rootP] += size[rootQ]; }
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

我们通过加入了由节点索引的实例变量数组`size[]`，这样`union`操作就能将小树的根节点，连接到大树的根节点，这样算法就能处理数据规模较大的问题了。

我们来看看 Union Find 算法各种实现的性能：

| 算法 | 构造函数 | union() | find() |
|:----|:-------:|:-------:|:------:|
| quick-find 算法| N | N | 1 |
| quick-union 算法| N | 树的高度，最坏为 N | 树的高度，最坏为 N |
| 加权 quick-union 算法| N | lgN | lgN |
| 加权 quick-union 算法| N | 非常接近但没有到达1 |

### 思考

这样看来，加权 Quick Union 算法的时间复杂度为`lgN`，看起来是比较理想的状态了，那有没有比这个更好的呢？有没有能达到常数级别的算法呢？

## 路径压缩的加权 Quick Union 算法

路径压缩就是将一个连通分量中的所有节点，都**直接**连接到根节点上，使树的高度不超过2

```java title="changes in find()"
private int find(int x) {
    List<Integer> path = new ArrayList<>();
    while (parent[x] != x) {
        path.add(x);
        x = parent[x];
    }
    for (int node : path) {
        parent[node] = x;
    }
    return x;
}
```

## 引用

* Union Find Slides 2[^3]


[^1]: [Princeton University - Union Find](https://algs4.cs.princeton.edu/15uf/)
[^2]: [Union Find Slides by Princeton University](https://www.cs.princeton.edu/courses/archive/fall06/cos226/lectures/union-find.pdf)
[^3]: http://www.sfs.uni-tuebingen.de/~dg/l1.html