/*
 * @k017maru@gmail.com
 * QQ:920052902
 * Author:K0maru3
 */
#include <iostream>
#include <queue>
#include <string.h>
#include <string>
#include <vector>

using namespace std;
typedef long long LL;
priority_queue<int, vector<int>, greater<int>> List;

//int Cow[101][101];
int temp1[101];
int temp2[101];
int main()
{
    int T;
    scanf("%d", &T);
    while (T--)
    {
        int n, m, p, k;
        int x1, x2, y1, y2;
        int j = 0;
        //memset(Cow, 0, sizeof(Cow));
        memset(temp1, 0, sizeof(temp1));
        memset(temp2, 0, sizeof(temp2));
        while (!List.empty())
        {
            List.pop();
        }

        scanf("%d %d %d %d", &n, &m, &p, &k);
        for (int i = 0; i < p; i++)
        {
            scanf("%d %d %d %d", &x1, &y1, &x2, &y2);
            if (x1 == x2)
            {
                j = min(y1, y2);
                temp1[j]++;
            }
            else if (y1 == y2)
            {
                j = min(x1, x2);
                temp2[j]++;
            }
        }
        for (int i = 0; i < n; i++)
        {
            if (temp1[i] == 0)
            {
                continue;
            }
            else
            {
                List.push(temp1[i]);
            }
        }
        for (int i = 0; i < m; i++)
        {
            if (temp2[i] == 0)
            {
                continue;
            }
            else
            {
                List.push(temp2[i]);
            }
        }
        if (List.size() <= k)
        {
            printf("0 %d\n", List.size());
        }
        else
        {
            int sum = 0;
            int l = List.size();
            for (int i = 0; i < l - k; i++)
            {
                sum += List.top();
                List.pop();
            }
            printf("%d\n", sum);
        }
    }

    return 0;
}
