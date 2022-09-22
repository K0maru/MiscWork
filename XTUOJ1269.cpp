/*
 * @k017maru@gmail.com
 * QQ:920052902
 * Author:K0maru3
 */

//这是一个我觉得完全没有问题的代码，甚至不断与AC代码重合后依然WA，且AC代码与我的这个WA代码思路一样，我也确认过不会出现逻辑上的错误
//是OJ不支持%lld
//经验总结：与其怀疑自己，不如质疑OJ

#include <algorithm>
#include <iostream>
#include <string.h>
#include <cstdio>


using namespace std;

typedef long long LL;

LL need[1001];
LL have[1001];

LL result(LL n,LL k);



int main(){
	int T;
	
	scanf("%d",&T);
	while (T--) {
		LL n;LL k;
		memset(have, 0, sizeof(have));
		memset(need, 0, sizeof(need));
		scanf("%I64d %I64d",&n,&k);
		printf("%I64d\n",result(n, k));
	}
	return 0;
}

LL result(LL n,LL k){
	LL mid = 0;
	LL have_h = 0,have_L = 2e9+5;
	for (LL i = 0; i < n; i++) {
		scanf("%I64d",&need[i]);
	}
	for (LL i = 0; i < n; i++) {
		scanf("%I64d",&have[i]);
		
		have_h = max(have_h,(have[i]+k)/need[i]);
		have_L = min(have_L,have[i]/need[i]);

	}
	//当出现现有材料数低于所需材料数时，尽量用券补全，即满足能做一个，若不能补全则直接输出0
	//在不考虑券的情况下，最终结果应在{have[low]/need[low],have[high]/need[low]}之间
	//test1:可以二分吗？取mid尝试按比例补全
	//		tip1:这里的mid猜测应取比例
	//		tip2:尝试发现尽量在循环读数比较后再将L,H换成比值(error)
	//		tip3:注意类似have > need need*(have/need)<have的情况 
	//		tip4:即使循环中K == 0也不代表找到了最佳值
	//		tip5:单独计算K太麻烦了，直接加在初始右值里计算
	//		tip6:????怎么错的
	//		看了很多题解，发现我的方法和思路是没问题的，问题是为何WA?
	//		tip7:尝试搬一个人的题解里的函数过来测试
	//		tip8:尝试失败

	LL K1 = k;
	while (have_L < have_h) {
		mid = (have_h + have_L)>>1;
		K1 = k;
		for (LL i = 0; i < n; i++) {
			//if(have[i]/need[i] == mid&&need[i]*mid < have[i]){
			//	K-=(have[i]-mid*need[i]);
			//}
			if(mid*need[i] > have[i]){
				K1-=(mid*need[i]-have[i]);
			}
			if(K1<0) break;
		}
		//printf("%lld %lld %lld\n",mid,have_h,have_L);
		if(K1 < 0){
				have_h = mid-1;
		}
		else{
				have_L = mid+1;
		}
	
	}
	K1 = k;
	mid = have_L;
	for (LL i = 0; i < n; i++) {
			if(mid*need[i]-have[i] > 0){
				K1-=(mid*need[i]-have[i]);
			}
			if(K1<0){
				have_L--;
				break;
			}
		}
	return have_L;
}
