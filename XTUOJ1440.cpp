/***
 * @k017maru@gmail.com
 * QQ:920052902
 * Author:K0maru3
 */

#include <cstdio>
#include <iostream>
#include <string.h>

using namespace std;

struct IneedParams{
    int Black_G;
    int White_G;
    int line;
};
IneedParams P;

char Board[15][15];
int  Check[15][15];

void Check_chess();

int main(){
    int T;
    
    cin>>T;
    //std::ios::sync_with_stdio(false);
    while (T--) {
        cin>>P.line;

        P.Black_G = P.White_G = 0;
        memset(Board, 0, sizeof(Board));
        memset(Check, 0, sizeof(Check));

        for (int i = 0; i<P.line; i++) {
            scanf("%s",&Board[i][0]);
            
        }//read chess
        Check_chess();
        cout<<P.Black_G<<" "<<P.White_G<<endl;
    }
    return 0;
}

void Check_chess(){
    
    int BB = 0x01;
    int WB = 0x10;
    //int begin = 0 , end = 0;
    /*
    横竖
    斜*4
    */
    for (int i = 0; i < P.line; i++) {
        for (int j = 0; j < P.line-2; j++) {
            //if(Board[i][j] == '.') continue;
            if (Board[i][j] ==  Board[i][j+1]&&Board[i][j] == Board[i][j+2]&&Board[i][j]=='W'){
                if(!(Check[i][j] & WB)) P.White_G++;
                
                Check[i][j] = Check[i][j+1] = Check[i][j+2] |= WB;
            }
            else if (Board[i][j] ==  Board[i][j+1]&&Board[i][j] == Board[i][j+2]&&Board[i][j]=='B') {
                if(!(Check[i][j] & BB)) P.Black_G++;
                Check[i][j] = Check[i][j+1] = Check[i][j+2] |= BB;
            }
        }
    }
    for (int j = 0; j < P.line; j++) {
        for (int i = 0; i < P.line-2; i++) {
            //if(Board[i][j] == '.') continue;
            if (Board[i][j] ==  Board[i+1][j] &&Board[i][j] == Board[i+2][j]&&Board[i][j] == 'W'){
                if(!(Check[i][j] & 0x100)) P.White_G++;
                Check[i][j] = Check[i+1][j] = Check[i+2][j] |= 0x100;
            }
            else if (Board[i][j] ==  Board[i+1][j] &&Board[i][j] == Board[i+2][j]&&Board[i][j] == 'B') {
                if(!(Check[i][j] & 0x1000)) P.Black_G++;
                Check[i][j] = Check[i+1][j] = Check[i+2][j] |= 0x1000;
            }
        }
    }
    /******/
    for (int i = 0; i < P.line-2; i++) {
        for (int j = 0; j < P.line-2; j++) {
            //if(Board[i][j] == '.') continue;
            if (Board[i][j] == Board[i+2][j+2]&&Board[i][j] == Board[i+1][j+1]&&Board[i][j] == 'W'){
                if(!(Check[i][j] & BB))   P.White_G++;
                Check[i][j] = Check[i+2][j+2] = Check[i+1][j+1] |= BB;
            }
            else if (Board[i][j] == Board[i+2][j+2]&&Board[i][j] == Board[i+1][j+1]&&Board[i][j] == 'B'){
                if(!(Check[i][j] & WB))   P.Black_G++;
                Check[i][j] = Check[i+2][j+2] = Check[i+1][j+1] |= WB;
            }
        }
    }
    for (int j = 0; j < P.line-2; j++) {
        for (int i = 0; i < P.line-2; i++) {
            //if(Board[i][j] == '.') continue;
            if (Board[i][j] == Board[i+2][j+2]&&Board[i][j] == Board[i+1][j+1]&&Board[i][j] == 'W'){
                if(!(Check[i][j] & BB))   P.White_G++;
                Check[i][j] = Check[i+2][j+2] = Check[i+1][j+1] |= BB;
            }
            else if (Board[i][j] == Board[i+2][j+2]&&Board[i][j] == Board[i+1][j+1]&&Board[i][j] == 'B'){
                if(!(Check[i][j] & WB))   P.Black_G++;
                Check[i][j] = Check[i+2][j+2] = Check[i+1][j+1] |= WB;
            }
        }
    }
    /******/
    for(int i = P.line-1; i >= 2; i--){
        for(int j = 0;j < i-2;j++){
            //if(Board[i][j] == '.') continue;
            if(Board[i][j] == Board[i-2][j+2] && Board[i][j] == Board[i-1][j+1]&&Board[i][j]  == 'W'){
                if(!(Check[i][j] & 0x1000)) P.White_G++;
                Check[i][j] = Check[i-2][j+2] = Check[i-1][j+1] |= 0x1000;
            }
            else if(Board[i][j] == Board[i-2][j+2] && Board[i][j] == Board[i-1][j+1]&&Board[i][j]  == 'B'){
                if(!(Check[i][j] & 0x100)) P.Black_G++;
                Check[i][j] = Check[i-2][j+2] = Check[i-1][j+1] |= 0x100;
            }
        }
    }
    for(int j = 0;j < P.line-2;j++) {
        for(int i = P.line-1; i >= 2; i--){
            //if(Board[i][j] == '.') continue;
            if(Board[i][j] == Board[i-2][j+2] && Board[i][j] == Board[i-1][j+1]&&Board[i][j]  == 'W'){
                if(!(Check[i][j] & 0x1000)) P.White_G++;
                Check[i][j] = Check[i-2][j+2] = Check[i-1][j+1] |= 0x1000;
            }
            else if(Board[i][j] == Board[i-2][j+2] && Board[i][j] == Board[i-1][j+1]&&Board[i][j]  == 'B'){
                if(!(Check[i][j] & 0x100)) P.Black_G++;
                Check[i][j] = Check[i-2][j+2] = Check[i-1][j+1] |= 0x100;
            }
        }
    }
        
        
}
