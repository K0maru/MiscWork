/*
 * @k017maru@gmail.com
 * QQ:920052902
 * Author:K0maru3
 */

#include <algorithm>
#include <cstdio>
#include <cstring>
#include <iostream>
#include <math.h>
#include <queue>
#include <string.h>
#include <vector>

using namespace std;

int main()
{
    int T, n;
    int edge[1010];
    scanf("%d", &T);
    while (T--)
    {
        int res = 0;
        memset(edge, 0, sizeof(edge));

        scanf("%d", &n);
        for (int i = 0; i < n; i++)
        {
            scanf("%d", &edge[i]);
        }
        sort(&edge[0], &edge[n]);

        for (int i = 0; i < n - 2; i++)
        {
            for (int j = i + 1; j < n - 1; j++)
            {
                int l = j + 1, r = n - 1;
                if (edge[l] >= edge[i] + edge[j])
                {
                    continue;
                }

                while (l < r)
                {
                    int mid = (l + r) >> 1;
                    if (edge[mid] >= edge[i] + edge[j])
                    {
                        r = mid - 1;
                        if (edge[r] < edge[i] + edge[j])
                        {
                            l = r;
                            break;
                        }
                    }
                    else
                    {
                        l = mid + 1;
                        if (edge[l] >= edge[i] + edge[j])
                        {
                            l--;
                            break;
                        }
                    }
                }
                res += (l - j);
            }
        }
        printf("%d\n", res);
    }

    return 0;
}