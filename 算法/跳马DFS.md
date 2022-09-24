#算法 
# 跳马

一个8×8的棋盘上有一个马初始位置为(a,b)，他想跳到(c,d)，问是否可以？如果可以，最少要跳几步？

第一次尝试：超时，使用DFS

```c
#include<stdio.h>
#include<stdbool.h>
bool maze[9][9]={0};
int a,b,c,d;
int min_step = -1;
void DFS(int i,int j,int step){
    if(i==c&&j==d){
        min_step = step;
        return;
    }
    else if(min_step!=-1&&step>min_step){
        return;
    }
    else if(i>=1&&j>=1&&i<=8&&j<=8&&maze[i][j]==0){
        maze[i][j]=1;
        DFS(i+2,j-1,step+1);
        DFS(i-1,j+2,step+1);
        DFS(i+1,j+2,step+1);
        DFS(i-1,j-2,step+1);
        DFS(i+1,j-2,step+1);
        DFS(i-2,j-1,step+1);
        DFS(i-2,j+1,step+1);
       
        DFS(i+2,j+1,step+1);
        maze[i][j]=0;
    }
}
int main()
{
    scanf("%d %d %d %d",&a,&b,&c,&d);
    DFS(a,b,0);
    printf("%d\n",min_step);
    return 0;
}
```

可以算出结果，但是耗时过长。

