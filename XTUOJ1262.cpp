/*
 * @k017maru@gmail.com
 * QQ:920052902
 * Author:K0maru3
 */

#include <algorithm>
#include <cstdio>
#include <cstring>
#include <iostream>
#include <queue>
#include <string.h>

using namespace std;
//之前直接用最大二叉堆，跑样例没问题但是wa,所以尝试优先队列
struct node
{
    int a;
    int b;
    friend bool operator<(node A, node B)
    {
        return A.a < B.a;
    }
};

priority_queue<node> fish_map;

int main()
{
    int T;
    scanf("%d", &T);
    while (T--)
    {
        int n, m;
        int result = 0;
        node temp;
        //清空
        while (!fish_map.empty())
        {
            fish_map.pop();
        }

        scanf("%d %d", &n, &m);
        while (n--)
        {
            scanf("%d %d", &temp.a, &temp.b);
            fish_map.push(temp);
        }
        //跳出条件：队列空或次数用完
        while (!fish_map.empty())
        {
            temp = fish_map.top();
            fish_map.pop();
            //特判，当bi = 0即钓鱼次数不影响条数
            if (temp.b == 0)
            {
                result += temp.a * m;
                break;
            }
            else
            {
                result += temp.a;
                temp.a = max(0, temp.a - temp.b);
                m--;
                fish_map.push(temp);
            }
            if (m <= 0)
            {
                break;
            }
        }
        printf("%d\n", result);
    }
}
