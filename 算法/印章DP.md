#算法 
# 印章DP

```c
#include<stdio.h>
#include<math.h>
double dp[21][21];//dp[n][m]

int main()
{
    int n,m,i,j;
    double p;
    scanf("%d %d",&n,&m);
    p=1.0/n;
    for ( j = 1; j < 21; j++)
    {
        for ( i = 1; i < 21; i++)
        {
            if(i>j) dp[i][j]=0;
            if(i==1) dp[i][j]=pow(p,j-1);
            else dp[i][j] = dp[i][j-1]*(p*i)+dp[i-1][j-1]*(p*(n-i+1));
        }
    }
    printf("%.4lf",dp[n][m]);
    return 0;
}
```

用二维数组储存i种凑齐j张的概率，则最终结果为dp(n,m)。

考虑初始dp状态，显然当i=1&&j=1时概率为1，当i>j时则为0。

则中间态dp的推导则要考虑两种不同情况：

一 前j-1张已经凑齐了i种dp（i，j-1），则第j张存在i种重复情况

二 无重复，及在前j-1张种仅凑齐i-1种dp（i-1，j-1），此时有n-（i+1）种情况

