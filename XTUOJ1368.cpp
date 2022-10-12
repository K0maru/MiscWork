/*
 * @k017maru@gmail.com
 * QQ:920052902
 * Author:K0maru3
 */

#include <algorithm>
#include <cstdio>

#include <iostream>
#include <string.h>


using namespace std;


bool check(int *a2z);

int main()
{
    char ay[3000];
    int a2z[27];
    while (scanf("%s", ay) != EOF)
    {
        int result = 3999;
        memset(a2z, 0, sizeof(a2z));
        int L = strlen(ay);
        if (L < 26)
        {
            printf("0\n");
            continue;
        }
        for (int i = 0, j = 0; i <= L && j < L;)
        {
            if (!check(a2z))
            {

                a2z[ay[i] - 'a']++;
                i++;
            }
            else
            {
                result = min(i - j, result);
                a2z[ay[j] - 'a']--;
                j++;
            }
        }
        if (result == 3999)
        {
            result = 0;
        }
        printf("%d\n", result);
    }
}

bool check(int *a2z)
{

    for (int i = 0; i < 26; i++)
    {
        if (a2z[i] == 0)
        {
            return false;
        }
    }
    return true;
}