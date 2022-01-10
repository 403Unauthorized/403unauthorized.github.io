---
title: "200. 岛屿数量"
tags:
  - Medium
---

[200. 岛屿数量](https://leetcode-cn.com/problems/number-of-islands/) - <span style="color: #f7a43e; font-weight: bold">Medium</span>

## Description

!!! abstract ""

    给你一个由 `'1'`（陆地）和 `'0'`（水）组成的的二维网格，请你计算网格中岛屿的数量。

    岛屿总是被水包围，并且每座岛屿只能由水平方向和/或竖直方向上相邻的陆地连接形成。

    此外，你可以假设该网格的四条边均被水包围。

这里有三种解法，一种是 **BFS**，一种是 **DFS**，还有一种就是利用并查集的特性了。

## Solution

=== "BFS"

    **BFS** 解法就是在每个坐标优先向四个方向扩散。

    ```java
    class Solution {
        public int numIslands(char[][] grid) {
            int count = 0;
            for(int i = 0; i < grid.length; i++) {
                for(int j = 0; j < grid[0].length; j++) {
                    if(grid[i][j] == '1'){
                        bfs(grid, i, j);
                        count++;
                    }
                }
            }
            return count;
        }
        private void bfs(char[][] grid, int i, int j){
            Queue<int[]> list = new LinkedList<>();
            list.add(new int[] { i, j });
            while(!list.isEmpty()){
                int[] cur = list.remove();
                i = cur[0]; j = cur[1];
                if(0 <= i && i < grid.length && 0 <= j && j < grid[0].length && grid[i][j] == '1') {
                    grid[i][j] = '0';
                    list.add(new int[] { i + 1, j });
                    list.add(new int[] { i - 1, j });
                    list.add(new int[] { i, j + 1 });
                    list.add(new int[] { i, j - 1 });
                }
            }
        }
    }
    ```

=== "DFS"

    **DFS** 与 **BFS** 不同的就是一次向同一个方向遍历，直到遍历结束后，再向另一个方向遍历。

    ```java
    class Solution {
        private int rows;
        private int cols;
        private boolean[][] visited;
        int[][] directions = new int[][] {{-1, 0}, {0, 1}, {0, -1}, {1, 0}};
        public int numIslands(char[][] grid) {
            rows = grid.length;
            cols = grid[0].length;
            visited = new boolean[rows][cols];
            int ans = 0;
            for (int i = 0; i < rows; i++) {
                for (int j = 0; j < cols; j++){
                    if (visited[i][j] || grid[i][j] == '0') continue;
                    visited[i][j] = true;
                    dfs(i, j, grid);
                    ans++;
                }
            }
            return ans;
        }

        private void dfs(int x, int y, char[][] grid) {
            visited[x][y] = true;
            for (int[] d : directions) {
                int newX = x + d[0];
                int newY = y + d[1];
                if (newX >= 0 && newX < rows && newY >= 0 && newY < cols && !visited[newX][newY] && grid[newX][newY] == '1') {
                    dfs(newX, newY, grid);
                }
            }
        }
    }
    ```

=== "并查集"

    利用并查集连通分量的特性，首先可以将相邻的岛屿`'1'`都连接起来，因为并查集有传递性，所以只用关心两个方向，右和下，将右和下两个方向中的岛屿连接起来。如果遇到`'0'`的元素，需要记录下来数量。

    这样最后执行完毕后，岛屿的数量就是 `连通分量的数量 - '0'的数量`。

    ```java
    class Solution {
        private int rows;
        private int cols;
        public int numIslands(char[][] grid) {
            rows = grid.length;
            cols = grid[0].length;
            int zeroes = 0;
            UF uf = new UF(rows * cols);
            int[][] directions = new int[][] {{1,0}, {0,1}};
            for (int i = 0; i < rows; i++) {
                for (int j = 0; j < cols; j++){
                    if (grid[i][j] == '0') {
                        zeroes++;
                    } else {
                        for (int[] d : directions) {
                            int newR = i + d[0];
                            int newC = j + d[1];
                            if (newR < rows && newC < cols && grid[newR][newC] == '1') {
                                uf.union(i * cols + j, newR * cols + newC);
                            }
                        }
                    }
                }
            }
            return uf.count() - zeroes;
        }

        static class UF {
            private int[] parent;
            private int count;
            public UF (int n) {
                parent = new int[n];
                for (int i = 0; i < n; i++) {
                    parent[i] = i;
                }
                count = n;
            }

            public void union(int p, int q) {
                int rootP = find(p);
                int rootQ = find(q);

                if (rootP == rootQ) return;
                parent[rootQ] = rootP;
                this.count--;
            }

            public int find(int x) {
                while (x != parent[x]) {
                    parent[x] = parent[parent[x]];
                    x = parent[x];
                }
                return x;
            }

            public int count() {
                return this.count;
            }
        }
    }
    ```