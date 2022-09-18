/***
 * @k017maru@gmail.com
 * QQ:920052902
 * Author:K0maru3
 */

#include <iostream>
#include <string.h>
#include <cstdio>


using namespace std;
typedef long long LL;
int S1[26];
int S2[26];
char re1[101];
char re2[101];

void Check(int N,LL P);

int main(){
    int T,N;
    LL P;
    cin>>T;
    while (T--) {
        cin>>N>>P;
        memset(re1, 0, sizeof(re1));
        memset(re2, 0, sizeof(re2));
        memset(S1,0,sizeof(S1));
        memset(S2,0,sizeof(S2));
        Check(N, P);
    }

    return 0;
}
void Check(int N,LL P){
    //cin>>re1;
    //cin>>re2;
    scanf("%s",re1);
    scanf("%s",re2);
    int max1 = 0,max2 = 0;
    for (int i = 0; i < N; i++) {
        S1[re1[i]-'a']++;
        S2[re2[i]-'a']++;
    }
    for (int i = 0; i < 26; i++) {
        if(S1[i] >= max1)   max1 = S1[i];
        if(S2[i] >= max2)   max2 = S2[i];
    }
    LL L1 = 0,L2 = 0;
    if(max1 == N){
        if(P == 1){
            L1 = N-1;
        }
        else{
            L1 = N;
        }
    }
    else if(P>N-max1){
        L1 = N;
    }
    else{
        L1 = P+max1;
    }

    if(max2 == N){
        if(P == 1){
            L2 = N-1;
        }
        else{
            L2 = N;
        }
    }
    else if(P>N-max2){
        L2 = N;
    }
    else{
        L2 = P+max2;
    }

    if(L1 == L2){
        printf("Draw\n");
    }
    else if(L1 > L2){
        printf("Alice\n");
    }
    else{
        printf("Bob\n");
    }
}