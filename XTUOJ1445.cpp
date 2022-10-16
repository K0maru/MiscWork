/*
 * @k017maru@gmail.com
 * QQ:920052902
 * Author:K0maru3
 */
#include <algorithm>
#include <iostream>
#include <queue>
#include <string.h>
#include <string>
#include <vector>

using namespace std;
typedef long long LL;

int num[1005];
int sum = 0;
void DFS(int L, int R, int D);
int main()
{
    int T;

    scanf("%d", &T);
    while (T--)
    {
        memset(num, 0, sizeof(num));
        int n;
        scanf("%d", &n);
        for (int i = 0; i < n; i++)
        {
            scanf("%d", &num[i]);
        }
        sum = 0;
        DFS(0, n, 1);
        printf("%d\n", sum);
    }
}

void DFS(int L, int R, int D)
{
    vector<int> que(num + L, num + R);
    sort(que.begin(), que.end());
    if (que.size() == 1)
    {
        sum += que[0] * D;
        return;
    }
    else
    {
        int mid = que[que.size() / 2];
        sum += mid * D;
        for (int i = L; i < R; i++)
        {
            if (num[i] == mid)
            {
                mid = i;
                break;
            }
        }

        if (mid > L)
        {
            DFS(L, mid, D + 1);
        }
        if (mid + 1 < R)
        {
            DFS(mid + 1, R, D + 1);
        }
        return;
    }
}