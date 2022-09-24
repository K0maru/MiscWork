#算法 #数论
# Biorhythms-中国剩余定理

```c
#include<iostream>
#include<cstdio>
#include<cmath>
using namespace std;
int p,e,i,d,times = 1;
const int pd = 23,ed = 28,id = 33;
int main()
{
    int day,n1,n2,n3,j=1,N,n;
    for ( j = 1; !((pd*ed*j)%id == 1); j++);n3 = pd*ed*j;
    for ( j = 1; !((pd*id*j)%ed == 1); j++);n2 = pd*id*j;
    for ( j = 1; !((id*ed*j)%pd == 1); j++);n1 = id*ed*j;
    while (1)
    {
        cin>>p>>e>>i>>d;
        day = 21252;
        if(p==-1&&e==-1&&i==-1&&d==-1) break;
        N = pd*ed*id;
        n = ((n1*p)+(n2*e)+(n3*i)-d+N)%N;//为什么有一个-d+N？
        if(n == 0) n = N;
        
        printf("Case %d: the next triple peak occurs in %d days.\n",times++,n);
    }
    
    return 0;    
}

```

复习看下文

https://www.cnblogs.com/MashiroSky/p/5918158.html