#include <algorithm>
#include <stdio.h>
using namespace std;
typedef long long ll;
int main()
{
    ll t;
    scanf("%I64d", &t);
    while (t--)
    {
        ll n, c;
        ll a[10001];
        scanf("%I64d%I64ld", &n, &c);
        for (ll i = 0; i < n; i++)
        {
            scanf("%I64d", &a[i]);
        }
        sort(a, a + n);
        ll maxs = a[n - 1];
        ll res = 0, i = 0;
        for (i = 0; i < n; i++)
        {
            if (maxs <= c * a[i])
            { //找从左到临界值
                break;
            }
            else
            {
                res++;
            }
        }
        //printf("%d ",i);
        i--;
        int j = n - 1;
        ll sum = res;
        while (i >= 0)
        { //从右开始找最优值。
            if (a[j] <= c * a[i])
            {
                i--;
                res--;
            }
            else
            {
                j--;
                res++;
            }
            sum = min(sum, res);
        }
        printf("%I64d\n", sum);
    }
    return 0;
}