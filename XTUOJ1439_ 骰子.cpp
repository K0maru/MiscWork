#include<iostream>
#include<cmath>
using namespace std;
int a[8][6];
int b[8];
int c[10010];
long long gcd(long long x,long long  y)
 {
 	return !y?x:gcd(y,x%y);
 }
int main()
{
	int T;cin >> T;
	while(T --)
	{
		int n; cin >> n;
		//输入各个骰子点数 
		for(int i = 0;i < n;i ++)
		for(int j = 0;j < 6;j ++) 
		cin >> a[i][j];
		//初始化所有可能点数和值为0 
		for(int i = 0;i < 10010;i ++)
		c[i] = 0;
		int u,cnt; //炮灰变量 
		long long q = pow(6,n);
		//要遍历每个骰子的点数，遍历次数是pow(6,n) 
		for(int i = 0;i < q;i ++)
		{
			//遍历次数转化成六进制，位数为每个骰子的点数
			//这里初始化b数组，这个数组用来存放每个骰子的点数 
			for(int j = 0;j < 8;j ++)
			b[j] = 0;
			cnt = 0; 
			u = i;
			//十进制转化六进制 
			while(u)
		{
				int t = u % 6;
				b[cnt] = t;//存放在数组中 
				cnt ++;
				u/=6;
		} 
			int sum = 0;
			//每个骰子的点数和 
			for(int j = 0;j < n;j ++)
			{
				sum += a[j][b[j]];
			}
			c[sum] ++;
		}
		cnt = 0;
		//统计有多少种值 
		for(int i = 0;i < 10010;i ++)
		{
			if(c[i]) cnt ++;
		}
		cout << cnt << endl;
		//遍历c数组，有值的话得出答案 
		for(int i = 0;i < 10010;i ++)
		{
			if(c[i])
			{
				cout << i << ":" << ' ' << c[i]/gcd(c[i],q) << "/" << q/gcd(c[i],q) << endl;
			}
		}
	}
	return 0;
}
