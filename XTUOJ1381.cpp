/***
 * @k017maru@gmail.com
 * QQ:920052902
 * Author:K0maru3
 */

#include <iostream>
#include <string>
#include <vector>
#include <string.h>
#include <cstdio>


using namespace std;

char tp[11];
string nodename;

void putboard(int r,int c,vector<string> node);

int main(){
    int T;
    cin >> T;
    while (T--) {
        int r,c;
        cin>>r>>c;
        scanf("%s",tp);
        vector<string> node;
        for (int i = 0; i < r*c; i++) {
            cin>>nodename;
            node.push_back(nodename);
            //cout<<node[i].size()<<endl;
        }
        
        putboard( r, c,node);

    }
    return 0;
}
void putboard(int r,int c,vector<string> node){
    int upline[c];
    int up_num = 0;
    memset(upline, 0, sizeof(upline));
    for(int i = 0;i < c; i++){
        for (int j = 0; j < r; j++) {
            if(node[j*c+i].size() >= upline[i]) upline[i] = node[j*c+i].size();
        }
        upline[i]+=2;
    }
    for (int i = 0; i <= 2*r; i++) {
        for (int j = 0;j < c ; j++) {
            if(i%2 == 0){
                printf("+");
                for (int k =0; k < upline[j]; k++) {
                    cout<<'-';
                    //cout<<upline[j]<<endl;
                }
                if(j == c-1)    printf("+\n");
            }
            else{
                printf("|");
                if(tp[j] == 'l'){
                    printf(" ");
                    cout<<node[(i/2)*c+j];
                    for(int k = 0;k<upline[j]-1-node[(i/2)*c+j].size();k++){
                        printf(" ");
                    }
                }
                else if(tp[j] == 'r'){
                    for(int k = 0;k<upline[j]-1-node[(i/2)*c+j].size();k++){
                        printf(" ");
                    }
                    cout<<node[(i/2)*c+j];
                    printf(" ");
                }
                else if(tp[j] == 'c'){
                    if((upline[j]-node[(i/2)*c+j].size())%2 == 0){
                        for (int k = 0; k < (upline[j]-node[(i/2)*c+j].size())/2; k++) {
                            printf(" ");
                        }
                        cout<<node[(i/2)*c+j];
                        for (int k = 0; k < (upline[j]-node[(i/2)*c+j].size())/2; k++) {
                            printf(" ");
                        }
                    }
                    else{
                        for (int k = 0; k < (upline[j]-node[(i/2)*c+j].size())/2; k++) {
                            printf(" ");
                        }
                        cout<<node[(i/2)*c+j];
                        for (int k = 0; k < (upline[j]-node[(i/2)*c+j].size())/2+1; k++) {
                            printf(" ");
                        }
                    }
                }
                if(j == c-1)    printf("|\n");
            }
        }
        
    }
}