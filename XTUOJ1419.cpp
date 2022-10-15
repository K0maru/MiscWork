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


//双指针模拟
char balls[66];
int main()
{

    int T;
    int n, a;
    scanf("%d", &T);
    while (scanf("%s", balls) != EOF)
    {
        char *head;
        char *tail;

        scanf("%d", &n);
        while (n--)
        {
            int i, j;
            scanf("%d", &a);
            a--;
            swap(balls[a], balls[a + 1]);
            if (balls[a] == balls[a + 1])
            {
                for (i = a; i >= 0; i--)
                {
                    if (balls[i] != balls[a])
                    {

                        break;
                    }
                }
                i++;
                for (j = a + 1; balls[j] != '\000'; j++)
                {
                    if (balls[j] != balls[a + 1])
                    {

                        break;
                    }
                }
                j--;
                head = &balls[i];
                tail = &balls[j];
                if (j - i + 1 >= 3)
                {
                    tail++;
                    while (*head != '\000')
                    {
                        *head = *tail;
                        head++;
                        tail++;
                    }
                }
            }
            else
            {
                for (i = a; i >= 0; i--)
                {
                    if (balls[i] != balls[a])
                    {
                        break;
                    }
                }
                i++;
                for (j = a + 1; balls[j] != '\000'; j++)
                {
                    if (balls[j] != balls[a + 1])
                    {
                        break;
                    }
                }
                j--;
                if (a - i + 1 >= 3 && j - (a + 1) + 1 >= 3)
                {
                    head = &balls[a + 1];
                    tail = &balls[j];
                    tail++;
                    while (*head != '\000')
                    {
                        *head = *tail;

                        head++;
                        tail++;
                    }
                    head = &balls[i];
                    tail = &balls[a + 1];
                    while (*head != '\000')
                    {
                        *head = *tail;
                        head++;
                        tail++;
                    }
                }
                else if (a - i + 1 >= 3)
                {
                    head = &balls[i];
                    tail = &balls[a + 1];
                    while (*head != '\000')
                    {
                        *head = *tail;
                        head++;
                        tail++;
                    }
                }
                else if (j - (a + 1) + 1 >= 3)
                {
                    head = &balls[a + 1];
                    tail = &balls[j];
                    tail++;
                    while (*head != '\000')
                    {
                        *head = *tail;
                        head++;
                        tail++;
                    }
                }
            }
            if (balls[0] == '\000')
            {
                printf("Over\n");
                break;
            }
            else
            {
                printf("%s\n", balls);
            }
        }
        T--;
        printf("\n");
        if (T == 0)
        {
            break;
        }
    }
    return 0;
}