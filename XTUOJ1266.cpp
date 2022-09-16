/***
 * @k017maru@gmail.com
 * QQ:920052902
 * Author:K0maru3
 */

#include <iostream>
#include "string.h"
int R_G = 0,R_B = 0,G_R = 0 ,G_B=0,B_R=0,B_G=0;
int R,G,B;
using namespace std;
char colorball[10001];
void findballnum();
void switchball(int sum,int temp);
int main() {

    while (scanf("%s",colorball)!=EOF){
        int sum = 0,temp = 0;
        findballnum();
        switchball(sum,temp);
        memset(colorball,0,sizeof (colorball));
    }


    return 0;
}

void  findballnum(){
    R = G = B = 0;
    R_G = R_B = B_R = B_G =G_R = G_B = 0;
    for (int i = 0; i < strlen(colorball) ;i++) {
        if (colorball[i]=='R')  R++;
        else if(colorball[i]=='G')  G++;
        else if(colorball[i]=='B')  B++;
    }
    int now = 0;
    for (; now < R; now++) {
        if(colorball[now]=='G') R_G++;
        else if(colorball[now]=='B') R_B++;
    }
    for (; now < R+G; now++) {
        if(colorball[now]=='R') G_R++;
        else if(colorball[now]=='B')    G_B++;
    }
    for (; now < R+G+B; now++) {
        if(colorball[now]=='R') B_R++;
        else if(colorball[now]=='G')    B_G++;
    }

}
void switchball(int sum,int temp){

    if(R_G && G_R){
        temp = min(R_G,G_R);
        sum+=temp;
        R_G-=temp;
        G_R-=temp;
    }
    if(R_B && B_R){
        temp = min(R_B,B_R);
        sum+=temp;
        R_B-=temp;
        B_R-=temp;
    }
    if(G_B && B_G){
        temp = min(G_B,B_G);
        sum+=temp;
        G_B-=temp;
        B_G-=temp;
    }

    sum+=R_B+R_G+B_R+B_G;
    cout<<sum<<endl;
}