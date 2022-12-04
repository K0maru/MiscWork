#include <iostream>
#include <stdio.h>
#include <algorithm>
#include <queue>
#include <string.h>
#include <math.h>
#define MAXDATA 10001
#define MAXEdge 5001
#define MAXDOTS 200001
using namespace std;
/*采用链式向前星加边操作，由于是无向图所以要开两倍数组*/
struct Edge{
    int v;
    int w;
    int next;
}E[MAXEdge<<1];
/*head存储上一个同起点的边的编号*/
int head[MAXEdge],dis[MAXDOTS];
bool vis[MAXDOTS];
int n,m,cnt,ans,now = 1,t,x,y,z;
int k = 0;

void Add(int u,int v,int w){
    E[++cnt].v = v;
    E[cnt].w = w;
    E[cnt].next = head[u];
	head[u] = cnt;
}

int prim(){
    for (int i = 2; i <= n; i++)
	{
		dis[i] = MAXDATA;
	}
	
    
    for (int i = head[1];i; i = E[i].next)
    {
        dis[E[i].v] = min(E[i].w,dis[E[i].v]);
    }
    while (++t<n)
    {
        int minn = MAXDATA;
		k++;
        vis[now] = 1;

        for (int i = 1; i <= n; ++i)
        {
            if(!vis[i]&&minn>dis[i]){
                minn = dis[i];
                now = i;
            }
        }
        ans+=minn;
        for(int i = head[now];i;i=E[i].next){
			int v = E[i].v;
            if(!vis[v]&&dis[v]>E[i].w){
                dis[v] = E[i].w;
            }
        }
        
    }
    return ans;
    
}
int main(){

    //memset(head,0,sizeof(head));
    cin>>n>>m;
	
    for(int i = 0;i<m;i++){
		cin>>x>>y>>z;;
		Add(x,y,z);Add(y,x,z);
    }
	
	ans = prim();
	cout<<ans<<endl;
	
	return 0;
}


