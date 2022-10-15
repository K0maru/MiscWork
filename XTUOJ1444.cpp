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
    char order[20];
    int num = 0;
    bool rev_flag = 0;
    deque<int> List;
    while (scanf("%s", order) != EOF)
    {
        if (order[0] == 'p' && order[1] == 'u')
        {
            scanf("%d", &num);
            if (!rev_flag)
            {
                List.push_back(num);
            }
            else
            {
                List.push_front(num);
            }
        }
        else if (order[1] == 'o')
        {
            if (List.empty())
            {
                printf("empty\n");
                continue;
            }
            if (!rev_flag)
            {
                //未翻转
                num = List.front();
                printf("%d\n", num);
                List.pop_front();
            }
            else
            {
                num = List.back();
                printf("%d\n", num);
                List.pop_back();
            }
        }
        else if (order[0] == 'r')
        {
            rev_flag = !rev_flag;
        }
    }
}