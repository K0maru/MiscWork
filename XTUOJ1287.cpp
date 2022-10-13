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

struct node
{
    char ID[6];
    int s;
    int t;
    int d;
    int rd;
    bool res;
};
struct cmp
{
    bool operator()(node A, node B)
    {
        return A.s > B.s;
    }
};


priority_queue<node, vector<node>, cmp> VIP;
priority_queue<node, vector<node>, cmp> Norm;
priority_queue<node, vector<node>, cmp> result;
char record[50];

int main()
{
    node temp;

    //int test = 5;

    while (scanf("%s", temp.ID) != EOF)
    {
        getchar();
        int h, m;
        scanf("%d:%d %d %d", &h, &m, &temp.t, &temp.d);
        temp.s = (h - 9) * 60 + m;
        //printf("%s\n", temp.ID);
        //printf("%d %d %d\n", temp.s, temp.t, temp.d);

        if (temp.ID[0] == 'V')
        {
            VIP.push(temp);
        }
        else
        {
            Norm.push(temp);
        }
    }
    node temp1, temp2;
    int T = 0;
    temp1 = VIP.top();
    temp2 = Norm.top();
    while (!VIP.empty() && !Norm.empty())
    {
        if (T >= temp1.s && T <= temp1.d + temp1.s)
        {

            temp1.rd = T - temp1.s;
            temp1.res = 1;
            result.push(temp1);
            T += temp1.t;

            VIP.pop();
            temp1 = VIP.top();
        }
        else if (T > temp1.d + temp1.s)
        {
            temp1.rd = temp1.d;
            temp1.res = 0;
            result.push(temp1);

            VIP.pop();
            temp1 = VIP.top();
        }
        else if (T >= temp2.s && T <= temp2.d + temp2.s)
        {
            temp2.rd = T - temp2.s;
            temp2.res = 1;
            result.push(temp2);
            T += temp2.t;

            Norm.pop();
            temp2 = Norm.top();
        }
        else if (T > temp2.d + temp2.s)
        {
            temp2.rd = temp2.d;
            temp2.res = 0;
            result.push(temp2);

            Norm.pop();
            temp2 = Norm.top();
        }
        else if (T < temp1.s && T < temp2.s)
        {
            T++;
        }
    }
    while (!VIP.empty())
    {
        if (T >= temp1.s && T <= temp1.d + temp1.s)
        {
            temp1.rd = T - temp1.s;
            temp1.res = 1;
            result.push(temp1);
            T += temp1.t;

            VIP.pop();
            temp1 = VIP.top();
        }
        else if (T >= temp1.d + temp1.s)
        {
            temp1.rd = temp1.d;
            temp1.res = 0;
            result.push(temp1);

            VIP.pop();
            temp1 = VIP.top();
        }
        else if (T < temp1.s)
        {
            T++;
        }
    }
    while (!Norm.empty())
    {
        if (T >= temp2.s && T <= temp2.d + temp2.s)
        {
            temp2.rd = T - temp2.s;
            temp2.res = 1;
            result.push(temp2);
            T += temp2.t;

            Norm.pop();
            temp2 = Norm.top();
        }
        else if (T >= temp2.d + temp2.s)
        {
            temp2.rd = temp2.d;
            temp2.res = 0;
            result.push(temp2);

            Norm.pop();
            temp2 = Norm.top();
        }
        else if (T < temp2.s)
        {
            T++;
        }
    }

    /*输出*/
    while (!result.empty())
    {
        temp = result.top();
        result.pop();
        printf("%s ", temp.ID);
        printf("%d ", temp.rd);
        if (temp.res)
        {
            printf("Yes\n");
        }
        else
        {
            printf("No\n");
        }
    }
}