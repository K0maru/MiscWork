#算法 
# kAc给糖果你吃

kAc有n堆糖果，每堆有A[i]个。
　　kAc说你只能拿m次糖果，聪明的你当然想要拿最多的糖果来吃啦啦啦~

```c
#include<stdio.h>
typedef long long LL;
LL A[1001];
void Quicksort(LL A[],int low,int high)
{
    int left = low;
    int right = high;
    LL key = A[left];
    if(left>right) return;
    while (left!=right)
    {
        while (A[right]<=key&&left<right)
        {
            right--;
        }
        A[left] = A[right];
        while (A[left]>=key&&left<right)
        {
            left++;
        }
        A[right] = A[left];
        
    }
    A[right] = key;
    Quicksort(A,low,left-1);
    Quicksort(A,left+1,high);
}
int main()
{
    int n,i,m;
    LL sum=0;
    scanf("%d %d",&n,&m);
    for ( i = 0; i < n; i++)
    {
        scanf("%d",&A[i]);
    }
    Quicksort(A,0,n-1);
    for ( i = 0; i < m; i++)
    {
        sum+=A[i];
    }
    printf("%I64d\n",sum);

    return 0;
}
```

快速排序，直接从大到小拿。