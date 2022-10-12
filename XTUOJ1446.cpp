/*
 * @k017maru@gmail.com
 * QQ:920052902
 * Author:K0maru3
 */

#include <algorithm>
#include <cstdio>
#include <cstring>
#include <iostream>
#include <string.h>
#include <vector>


using namespace std;

bool num[10] = {
    1,
};
int main()
{
    int T;
    scanf("%d", &T);
    while (T--)
    {
        int k, n;
        //int kind = -1, sum0 = 0;
        char arrynum[1005];

        memset(num, 0, sizeof(num));
        num[0] = 1;
        scanf("%d %d", &n, &k);
        getchar();
        scanf("%s", arrynum);

        if (strlen(arrynum) == 1)
        {
            printf("0\n");
            continue;
        }

        int j = 1;
        //当第一位为1时，往后依次将不重复的k个数字更改为0,遇到1和0直接跳过
        if (arrynum[0] == '1')
        {
            while (k)
            {
                if (j >= n)
                    break;

                char s = arrynum[j];

                if (s == '0' || s == '1')
                {
                    j++;
                    continue;
                }
                for (int i = j; i < n; i++)
                {

                    if (arrynum[i] == '0' || arrynum[i] == '1')
                    {
                        continue;
                    }
                    if (arrynum[i] == s)
                    {
                        arrynum[i] = '0';
                    }
                }
                k--;
                j++;
            }
        }
        else
        {
            //当第一位不为1时，先改后面k-1个不重复数字，最后再改第一个
            char s1 = arrynum[0];
            k = k - 1;

            while (k)
            {
                if (j >= n)
                    break;

                char s = arrynum[j];

                if (arrynum[j] == s1 || s == '0')
                {
                    j++;
                    continue;
                }
                for (int i = j; i < n; i++)
                {

                    if (arrynum[i] == '0')
                    {
                        continue;
                    }
                    if (arrynum[i] == s)
                    {
                        arrynum[i] = '0';
                    }
                }
                k--;
                j++;
            }
            for (int i = 0; i < n; i++)
            {
                if (arrynum[i] == s1)
                {
                    arrynum[i] = '1';
                }
            }
        }
        printf("%s\n", arrynum);
    }


    return 0;
}
