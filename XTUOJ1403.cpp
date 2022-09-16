#include <cstdio>
#include <iostream>
#include <string.h>

using namespace std;
/*
(1,5) 2 2-4 1_
[5,10) 3 5-9 2_
[10,17) 4 10-16 3_
[17,26) 5 17-25 4_
[26,37) 6 26-36 5_
[37,50) 7 37-49 6_
[50,65) 8 50-64 7_
[65,82) 9 65-81 8_
[82,100) 10 82-100 9_
*/
int kongge(int n);
void printuphalf(int kong_num , int n);
void printdownhalf(int kong_num , int n);

int main(){
    int n,kong_num;
    while (scanf("%d",&n)&&n!=0) {
        
        if(n==1){
            printf("/\\\n");
            printf("\\/\n");
            continue;
        }
        kong_num = kongge(n);
        printuphalf(kong_num,n);
        printdownhalf(kong_num , n);
    }
    return 0;
}

int kongge(int n){
    if(5>n)     return 1;
    else if(10>n&&n>=5)   return 2;
    else if(17>n&&n>=10)   return 3;
    else if(26>n&&n>=17)   return 4;
    else if(37>n&&n>=26)   return 5;
    else if(50>n&&n>=37)   return 6;
    else if(65>n&&n>=50)   return 7;
    else if(82>n&&n>=65)   return 8;
    else if(100>=n&&n>=82) return 9;
    return 0;
}
void printuphalf(int kong_num , int n){
    
    for (int i = kong_num+1; i>=1;i-- ) {
        for(int l = i-1;l>0;l--){
            printf(" ");
        }
        if(n>=(kong_num+1)*kong_num/2+kong_num+1){
            for (int j=kong_num+2-i;j>0;j--) {
                printf("/\\");
            }
        }
        else{
            if (i == 1) {
                for (int j=kong_num+2-i;j>1;j--) {
                printf("/\\");
                }
                printf("/");
            }
            else {
                for (int j=kong_num+2-i;j>0;j--) {
                printf("/\\");
                }
            }
        }
        printf("\n");
    }
    
}
void printdownhalf(int kong_num , int n){
    int need_num = n-(kong_num+1)*kong_num/2;
    for (int i = 1; i<=kong_num+1&&need_num>0;i++ ) {
        for(int l = 1;l<=i-1;l++){
            printf(" ");
        }
        if(n<(kong_num+1)*kong_num/2+kong_num+1&&i==1){
            for (int j = 0; j<kong_num&&need_num>0; j++) {
                printf("\\/");
                need_num--;
            }
        }
        else {
            for (int j = 0; j<kong_num+2-i&&need_num>0; j++) {
                printf("\\/");
                need_num--;
            }
        }
        printf("\n");
    }
    //printf("\n");
}