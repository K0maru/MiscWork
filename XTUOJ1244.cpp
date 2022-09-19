/*
 * @k017maru@gmail.com
 * QQ:920052902
 * Author:K0maru3
 */

/*本题考察二分*/
#include <iostream>
#include <string.h>
#include <algorithm>
#include <cstdio>
using namespace std;
typedef long long LL;

int EG[10001];
int Day[10001];
int Sum_EG(int N,int M);
int main(){
	int T;
	cin>>T;
	while(T--){
		memset(EG, 0, sizeof(EG));
		int N,M;
		scanf("%d %d",&N,&M);
		printf("%d\n",Sum_EG(N,M));

	}
	return 0;
 }

 int Sum_EG(int N,int M){
	int right = 0,left = 0;
	int sum = 0;
	int cnt = 1,mid = 0;
    /*由于巧克力不能分割，故结果存在于巧克力热量最大值到总和值之间，故采用二分*/
	for (int i = 0; i < N; i++) {
		scanf("%d",&EG[i]);
		right+=EG[i];
		left = max(left,EG[i]);
	}
	while (left <= right) {
		mid = (left+right)/2;
		sum = 0;
		cnt = 1;
		for (int i = 0; i < N; i++) {
			if(sum + EG[i] <= mid){
				sum += EG[i];
			}
			else{
				cnt++;
				sum = EG[i];
			}
		}
		if(cnt > M){
			left = mid+1;
		}
		else{
			right = mid-1;
		}
	}
	return left;
 }
